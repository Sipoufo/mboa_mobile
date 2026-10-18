import 'package:equatable/equatable.dart';

/// Who is reading the notification settings — each app passes its own.
///
/// The server returns the **whole** catalogue to everyone, admin alerts
/// included, so what a person is shown has to be decided here.
enum NotificationAudience { tenant, prestataire, agent }

/// One notification type and whether this account receives it (RM-M03-01).
///
/// [code] is the wire value (`N01`…`N26`), kept as a string: the catalogue is
/// append-only and a type this build does not know must survive a save
/// untouched rather than be dropped from the opt-out set.
class NotificationPreference extends Equatable {
  const NotificationPreference({
    required this.code,
    required this.enabled,
    this.mandatory = false,
  });

  final String code;
  final bool enabled;

  /// Cannot be switched off — the server answers `NOTIFICATION_MANDATORY`.
  final bool mandatory;

  NotificationPreference copyWith({bool? enabled}) =>
      NotificationPreference(code: code, enabled: enabled ?? this.enabled, mandatory: mandatory);

  /// The opt-out types each audience can actually receive.
  ///
  /// Read from what the backend **sends**, not only from Doc 10's table:
  /// N-04 also carries "Nouvelle demande de visite" to an owner and "Nouvelle
  /// visite" to an agent; N-06 and N-09 are never sent; N-13 goes to admins.
  /// A switch for a notification that cannot arrive is a switch that lies.
  /// Mandatory types are left out — there is nothing to choose.
  static const Map<NotificationAudience, List<String>> optOuts = {
    NotificationAudience.tenant: ['N01', 'N03', 'N05', 'N18', 'N21', 'N23'],
    NotificationAudience.prestataire: ['N02', 'N03', 'N04', 'N05', 'N10', 'N15', 'N25', 'N26'],
    NotificationAudience.agent: ['N04', 'N05', 'N15'],
  };

  /// What [audience] is offered to switch, in the order above.
  static List<NotificationPreference> visibleTo(
    NotificationAudience audience,
    List<NotificationPreference> all,
  ) {
    final byCode = {for (final p in all) p.code: p};
    return [
      for (final code in optOuts[audience]!) ?byCode[code],
    ].where((p) => !p.mandatory).toList();
  }

  @override
  List<Object?> get props => [code, enabled, mandatory];
}
