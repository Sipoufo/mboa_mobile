import '../models/visit.dart';

/// Where an agenda gets its visits.
///
/// The three personas read three different endpoints — `/agents/me/visites`,
/// `/prestataires/me/visites`, `/visites` — and all three answer with the same
/// `VisiteResponse`. The agenda takes this interface so it never learns which
/// one it is showing; each app's repository implements it.
abstract interface class VisitsSource {
  /// Every visit in `[from, to)`, whatever its status.
  ///
  /// The range is what the agenda has on screen. Filtering by status belongs to
  /// the view: a cancelled visit still has to appear on its day, or the agenda
  /// answers "nothing that day" for a day something was planned.
  Future<List<Visit>> range({required DateTime from, required DateTime to});
}
