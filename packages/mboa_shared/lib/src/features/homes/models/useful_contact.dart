import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

/// A useful contact the landlord keeps (CDC M30 lot 3, RM-M30-13) — the
/// caretaker, the plumber — and may share with his tenants: on every
/// property ([annonceIds] empty) or on some. The tenant only ever sees a
/// name, a role and a number.
class UsefulContact extends Equatable {
  const UsefulContact({
    required this.id,
    required this.name,
    required this.role,
    required this.phone,
    this.shared = false,
    this.annonceIds = const {},
  });

  final String id;
  final String name;

  /// Free text: « Gardien », « Plombier »…
  final String role;

  /// E.164, as the landlord typed it.
  final String phone;
  final bool shared;

  /// Empty: shared on all his properties.
  final Set<String> annonceIds;

  static UsefulContact fromResponse(UsefulContactResponse response) => UsefulContact(
        id: response.id ?? '',
        name: response.name ?? '',
        role: response.role ?? '',
        phone: response.phone ?? '',
        shared: response.shared ?? false,
        annonceIds: response.annonceIds?.toSet() ?? const {},
      );

  Map<String, dynamic> toCache() => {
        'id': id,
        'name': name,
        'role': role,
        'phone': phone,
        'shared': shared,
        'annonceIds': annonceIds.toList(),
      };

  static UsefulContact? fromCache(Object? raw) {
    if (raw is! Map) return null;
    final json = Map<String, dynamic>.from(raw);
    final id = json['id'];
    if (id is! String) return null;
    return UsefulContact(
      id: id,
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      shared: json['shared'] as bool? ?? false,
      annonceIds: {for (final a in (json['annonceIds'] as List? ?? const [])) if (a is String) a},
    );
  }

  @override
  List<Object?> get props => [id, name, role, phone, shared, annonceIds];
}
