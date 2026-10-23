import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../models/finance_refusal.dart';
import '../models/ledger.dart';
import '../models/service_provider.dart';

/// An intervenant as the landlord writes it. Linked to a contact, the name
/// is the account's — kept up to date by the server.
class ProviderDraft {
  const ProviderDraft({required this.kind, this.name, this.kindLabel, this.note, this.linkedAccountId});

  final ProviderKind kind;
  final String? name;

  /// Required for [ProviderKind.other].
  final String? kindLabel;
  final String? note;
  final String? linkedAccountId;
}

/// A payment the landlord declares he made — never made through Mboa
/// (RM-M26-02).
class ProviderPaymentDraft {
  const ProviderPaymentDraft({
    required this.amount,
    required this.paidOn,
    this.note,
    this.property = const UnassignedProperty(),
  });

  final int amount;
  final DateTime paidOn;
  final String? note;
  final LedgerProperty property;
}

/// The landlord's intervenants and what he paid them (CDC M26). Each
/// payment writes its line in the register (RM-M26-04). Private, his own.
class ProvidersRepository {
  ProvidersRepository({required DioClient dioClient, required HiveCache cache, required MessagingRepository messaging})
      : _dioClient = dioClient,
        _cache = cache,
        _messaging = messaging;

  final DioClient _dioClient;
  final HiveCache _cache;
  final MessagingRepository _messaging;

  FinanceServiceProvidersApi get _api => _dioClient.api.getFinanceServiceProvidersApi();

  /// By name, with what each was paid. Offline, the last list.
  Future<Cached<List<ServiceProvider>>> list({bool includeArchived = false}) async {
    final key = 'providers:$includeArchived';
    try {
      final data = (await _api.listServiceProviders(includeArchived: includeArchived)).data;
      final items = data?.map(ServiceProvider.fromResponse).toList() ?? const <ServiceProvider>[];
      await _cache.put(StorageKeys.financeBox, key, {'items': [for (final p in items) p.toCache()]});
      return Cached(items);
    } catch (error) {
      final raw = _cache.get(StorageKeys.financeBox, key)?['items'];
      if (raw is! List) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached([for (final p in raw) ?ServiceProvider.fromCache(p)], fromCache: true);
    }
  }

  /// One intervenant and his payments, latest first. Offline, the last read.
  Future<Cached<(ServiceProvider, List<ProviderPayment>)>> provider(String id) async {
    final key = 'provider:$id';
    try {
      final (provider, payments) =
          await (_api.getServiceProvider(id: id), _api.listServiceProviderPayments(id: id)).wait;
      final read = (
        _read(provider.data),
        payments.data?.map(ProviderPayment.fromResponse).toList() ?? const <ProviderPayment>[],
      );
      await _cache.put(StorageKeys.financeBox, key, {
        'provider': read.$1.toCache(),
        'payments': [for (final p in read.$2) p.toCache()],
      });
      return Cached(read);
    } catch (error) {
      final raw = _cache.get(StorageKeys.financeBox, key);
      final provider = ServiceProvider.fromCache(raw?['provider']);
      if (provider == null) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached(
        (provider, [for (final p in (raw?['payments'] as List? ?? const [])) ?ProviderPayment.fromCache(p)]),
        fromCache: true,
      );
    }
  }

  /// Who he has a thread with — the accounts an intervenant can be linked
  /// to (M26 précisions). Each once.
  Future<List<ProviderContact>> contacts() async {
    final seen = <String>{};
    return [
      for (final c in await _messaging.conversations())
        if (c.peerAccountId case final id? when seen.add(id)) ProviderContact(accountId: id, name: c.peerName ?? ''),
    ];
  }

  Future<ServiceProvider> create(ProviderDraft draft) => guardFinance(
        () async => _read(
          (await _api.createServiceProvider(
            serviceProviderRequest: ServiceProviderRequest(
              (b) => b
                ..kind = ServiceProviderRequestKindEnum.valueOf(draft.kind.wire)
                // Linked, the name is the account's.
                ..name = draft.linkedAccountId == null ? _blank(draft.name) : null
                ..kindLabel = draft.kind == ProviderKind.other ? _blank(draft.kindLabel) : null
                ..note = _blank(draft.note)
                ..linkedAccountId = draft.linkedAccountId,
            ),
          ))
              .data,
        ),
      );

  Future<ServiceProvider> update(String id, ProviderDraft draft) => guardFinance(
        () async => _read(
          (await _api.updateServiceProvider(
            id: id,
            updateServiceProviderRequest: UpdateServiceProviderRequest(
              (b) => b
                ..kind = UpdateServiceProviderRequestKindEnum.valueOf(draft.kind.wire)
                ..name = draft.linkedAccountId == null ? _blank(draft.name) : null
                ..kindLabel = draft.kind == ProviderKind.other ? _blank(draft.kindLabel) : null
                ..note = _blank(draft.note),
            ),
          ))
              .data,
        ),
      );

  /// Without payments only (`SERVICE_PROVIDER_HAS_PAYMENTS`): archive the
  /// others.
  Future<void> delete(String id) => guardFinance(() => _api.deleteServiceProvider(id: id));

  /// Hidden from the pickers; the history stays.
  Future<ServiceProvider> archive(String id) =>
      guardFinance(() async => _read((await _api.archiveServiceProvider(id: id)).data));

  Future<ServiceProvider> restore(String id) =>
      guardFinance(() async => _read((await _api.restoreServiceProvider(id: id)).data));

  Future<ProviderPayment> addPayment(String providerId, ProviderPaymentDraft draft) => guardFinance(
        () async => _readPayment(
          (await _api.addServiceProviderPayment(id: providerId, serviceProviderPaymentRequest: _payment(draft))).data,
        ),
      );

  Future<ProviderPayment> updatePayment(String providerId, String paymentId, ProviderPaymentDraft draft) => guardFinance(
        () async => _readPayment(
          (await _api.updateServiceProviderPayment(
            id: providerId,
            paymentId: paymentId,
            serviceProviderPaymentRequest: _payment(draft),
          ))
              .data,
        ),
      );

  /// The payment and its register line go.
  Future<void> deletePayment(String providerId, String paymentId) =>
      guardFinance(() => _api.deleteServiceProviderPayment(id: providerId, paymentId: paymentId));

  ServiceProviderPaymentRequest _payment(ProviderPaymentDraft draft) => ServiceProviderPaymentRequest(
        (b) => b
          ..amount = draft.amount
          ..paidOn = draft.paidOn.toDate()
          ..note = _blank(draft.note)
          ..annonceId = switch (draft.property) {
            ListingProperty(:final id) => id,
            _ => null,
          }
          ..residenceId = switch (draft.property) {
            ResidenceProperty(:final id) => id,
            _ => null,
          },
      );

  ServiceProvider _read(ServiceProviderResponse? data) {
    if (data == null) throw StateError('empty provider response');
    return ServiceProvider.fromResponse(data);
  }

  ProviderPayment _readPayment(ServiceProviderPaymentResponse? data) {
    if (data == null) throw StateError('empty payment response');
    return ProviderPayment.fromResponse(data);
  }

  static String? _blank(String? value) => (value == null || value.trim().isEmpty) ? null : value.trim();
}
