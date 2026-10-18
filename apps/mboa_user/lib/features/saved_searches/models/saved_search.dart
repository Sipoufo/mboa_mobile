import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

/// A search the tenant kept, to be told when it has something new
/// (RM-M04-07, N-01).
///
/// Its filters are not here: the server holds them, runs them and cannot
/// change them — "to change them, save a new search". What the app shows is
/// the server's [name], whether it alerts, and how much is new.
class SavedSearch extends Equatable {
  const SavedSearch({
    required this.id,
    required this.name,
    this.alertsEnabled = true,
    this.newMatchCount = 0,
  });

  final String id;

  /// Given by the tenant, or built by the server from the criteria
  /// ("Appartement · Akwa · ≤ 500 000 FCFA") — shown as is.
  final String name;
  final bool alertsEnabled;

  /// Results published since it was last opened. Opening its results resets
  /// it, server-side.
  final int newMatchCount;

  SavedSearch copyWith({String? name, bool? alertsEnabled, int? newMatchCount}) => SavedSearch(
        id: id,
        name: name ?? this.name,
        alertsEnabled: alertsEnabled ?? this.alertsEnabled,
        newMatchCount: newMatchCount ?? this.newMatchCount,
      );

  static SavedSearch? fromResponse(SavedSearchResponse response) {
    final id = response.id;
    if (id == null) return null;
    return SavedSearch(
      id: id,
      name: response.name ?? '',
      alertsEnabled: response.alertsEnabled ?? true,
      newMatchCount: response.newMatchCount ?? 0,
    );
  }

  Map<String, dynamic> toCache() => {
        'id': id,
        'name': name,
        'alerts': alertsEnabled,
        'new': newMatchCount,
      };

  static SavedSearch? fromCache(Map<String, dynamic> json) {
    final id = json['id'];
    if (id is! String) return null;
    return SavedSearch(
      id: id,
      name: json['name'] as String? ?? '',
      alertsEnabled: json['alerts'] as bool? ?? true,
      newMatchCount: json['new'] as int? ?? 0,
    );
  }

  @override
  List<Object?> get props => [id, name, alertsEnabled, newMatchCount];
}
