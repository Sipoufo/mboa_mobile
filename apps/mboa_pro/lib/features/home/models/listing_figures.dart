import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

import 'dashboard_stats.dart';

/// One listing's M14 figures, as the dashboard counts them (CDC M14): locked
/// or not as the server says (CA-M14-02), like the portfolio's.
class ListingFigures extends Equatable {
  const ListingFigures({
    this.views,
    this.viewsLast7Days,
    this.contacts,
    this.conversionRate,
    this.averagePosition,
  });

  final DashboardFigure? views;
  final DashboardFigure? viewsLast7Days;
  final DashboardFigure? contacts;
  final DashboardFigure? conversionRate;

  /// Where search showed it, on average over 30 days. 1.0 is the top.
  final DashboardFigure? averagePosition;

  static ListingFigures fromResponse(ListingStats stats) => ListingFigures(
        views: DashboardFigure.fromResponse(stats.figures?.views),
        viewsLast7Days: DashboardFigure.fromResponse(stats.figures?.viewsLast7Days),
        contacts: DashboardFigure.fromResponse(stats.figures?.contacts),
        conversionRate: DashboardFigure.fromResponse(stats.figures?.conversionRate),
        averagePosition: DashboardFigure.fromResponse(stats.averagePosition),
      );

  Map<String, dynamic> toCache() => {
        'views': views?.toCache(),
        'views7': viewsLast7Days?.toCache(),
        'contacts': contacts?.toCache(),
        'conversion': conversionRate?.toCache(),
        'position': averagePosition?.toCache(),
      };

  static ListingFigures? fromCache(Object? raw) {
    if (raw is! Map) return null;
    return ListingFigures(
      views: DashboardFigure.fromCache(raw['views']),
      viewsLast7Days: DashboardFigure.fromCache(raw['views7']),
      contacts: DashboardFigure.fromCache(raw['contacts']),
      conversionRate: DashboardFigure.fromCache(raw['conversion']),
      averagePosition: DashboardFigure.fromCache(raw['position']),
    );
  }

  @override
  List<Object?> get props => [views, viewsLast7Days, contacts, conversionRate, averagePosition];
}
