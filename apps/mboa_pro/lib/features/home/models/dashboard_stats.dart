import 'package:equatable/equatable.dart';

/// Lifecycle state of a listing, mirrored from `AnnonceResponseStatusEnum`.
enum AnnonceStatus { draft, published, reserved, rented, archived, unknown }

/// The prestataire dashboard figures (CDC M14).
///
/// **Only the counts derived from the listings endpoint are real.** The M14
/// metrics table also calls for views, contacts, conversion, agent visits,
/// signed contracts and average ranking — none of which exist in the API today
/// (`AnnonceResponse` carries no view or contact field, and there is no stats
/// endpoint). Those are modelled as nullable and render as unavailable rather
/// than being invented; wire them up when the backend ships them.
class DashboardStats extends Equatable {
  const DashboardStats({
    required this.totalBiens,
    this.byStatus = const {},
    this.views,
    this.contacts,
    this.conversionRate,
    this.agentVisits,
    this.signedContracts,
    this.averageRank,
  });

  const DashboardStats.empty() : this(totalBiens: 0);

  /// Total listings owned by the prestataire — `totalElements` from the
  /// paginated listings response.
  final int totalBiens;

  /// Listing count per lifecycle status.
  final Map<AnnonceStatus, int> byStatus;

  // --- No backing endpoint yet. Null means "unknown", not "zero". ---
  final int? views;
  final int? contacts;
  final double? conversionRate;
  final int? agentVisits;
  final int? signedContracts;
  final double? averageRank;

  int countOf(AnnonceStatus status) => byStatus[status] ?? 0;

  /// Listings currently visible to the public.
  int get publishedCount => countOf(AnnonceStatus.published);

  Map<String, dynamic> toCache() => {
        'totalBiens': totalBiens,
        'byStatus': byStatus.map((k, v) => MapEntry(k.name, v)),
      };

  static DashboardStats fromCache(Map<String, dynamic> json) {
    final raw = Map<String, dynamic>.from(
      (json['byStatus'] as Map?) ?? const {},
    );
    return DashboardStats(
      totalBiens: (json['totalBiens'] as num?)?.toInt() ?? 0,
      byStatus: {
        for (final entry in raw.entries)
          AnnonceStatus.values.firstWhere(
            (s) => s.name == entry.key,
            orElse: () => AnnonceStatus.unknown,
          ): (entry.value as num?)?.toInt() ?? 0,
      },
    );
  }

  @override
  List<Object?> get props => [
        totalBiens,
        byStatus,
        views,
        contacts,
        conversionRate,
        agentVisits,
        signedContracts,
        averageRank,
      ];
}
