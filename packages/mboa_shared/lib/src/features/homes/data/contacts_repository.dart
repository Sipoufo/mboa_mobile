import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../../api/api_error.dart';
import '../models/useful_contact.dart';
import 'homes_repository.dart';

/// Why the server turned a contact down — said in words by the screen.
enum ContactRefusal {
  /// Fifteen already.
  limitReached,

  /// The number, most likely.
  invalid,
}

class ContactRefused implements Exception {
  const ContactRefused(this.reason);

  final ContactRefusal reason;
}

/// What the landlord saves.
class ContactDraft {
  const ContactDraft({
    required this.name,
    required this.role,
    required this.phone,
    this.shared = false,
    this.annonceIds = const {},
  });

  final String name;
  final String role;

  /// E.164.
  final String phone;
  final bool shared;
  final Set<String> annonceIds;
}

/// Useful contacts (CDC M30 lot 3, RM-M30-13): the landlord's notes about
/// third parties, his alone to keep — and the ones he shares, read by the
/// tenant of a property they are shared on. No add-on.
class ContactsRepository {
  ContactsRepository({required DioClient dioClient, required HiveCache cache})
      : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  MonLogementApi get _api => _dioClient.api.getMonLogementApi();

  /// The server's cap.
  static const int max = 15;

  /// The landlord's, by role then name. Offline, the last list.
  Future<Cached<List<UsefulContact>>> mine() =>
      _cachedList('contacts:mine', () async => (await _api.listMyUsefulContacts()).data);

  /// Those shared on the tenant's property — nothing once read only.
  Future<Cached<List<UsefulContact>>> ofHome(String contractId) =>
      _cachedList('contacts:$contractId', () async => (await _api.listHomeContacts(contractId: contractId)).data);

  Future<UsefulContact> create(ContactDraft draft) =>
      _guard(() async => _read((await _api.createUsefulContact(usefulContactRequest: _request(draft))).data));

  Future<UsefulContact> update(String contactId, ContactDraft draft) => _guard(
        () async =>
            _read((await _api.updateUsefulContact(contactId: contactId, usefulContactRequest: _request(draft))).data),
      );

  Future<void> delete(String contactId) => _api.deleteUsefulContact(contactId: contactId);

  UsefulContactRequest _request(ContactDraft draft) => UsefulContactRequest(
        (b) => b
          ..name = draft.name.trim()
          ..role = draft.role.trim()
          ..phone = draft.phone.trim()
          ..shared = draft.shared
          ..annonceIds = SetBuilder<String>(draft.shared ? draft.annonceIds : const <String>{}),
      );

  Future<Cached<List<UsefulContact>>> _cachedList(
    String key,
    Future<BuiltList<UsefulContactResponse>?> Function() read,
  ) async {
    try {
      final items = (await read())?.map(UsefulContact.fromResponse).toList() ?? const <UsefulContact>[];
      await _cache.put(StorageKeys.homesBox, key, {'items': [for (final c in items) c.toCache()]});
      return Cached(items);
    } catch (error) {
      final raw = _cache.get(StorageKeys.homesBox, key)?['items'];
      if (raw is! List) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached([for (final c in raw) ?UsefulContact.fromCache(c)], fromCache: true);
    }
  }

  Future<UsefulContact> _guard(Future<UsefulContact> Function() call) async {
    try {
      return await call();
    } on DioException catch (error) {
      final api = ApiError.from(error);
      if (api.hasCode('CONTACT_LIMIT_REACHED')) throw const ContactRefused(ContactRefusal.limitReached);
      if (api.hasCode('VALIDATION_ERROR')) throw const ContactRefused(ContactRefusal.invalid);
      rethrow;
    }
  }

  UsefulContact _read(UsefulContactResponse? data) {
    if (data == null) throw StateError('empty contact response');
    return UsefulContact.fromResponse(data);
  }
}
