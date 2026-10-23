import '../../annonces/data/annonce_repository.dart';
import '../../annonces/data/residence_repository.dart';
import '../models/ledger.dart';

/// The properties a register line or a payment can be put on (RM-M25-02):
/// the landlord's standalone listings and his residences — a unit counts in
/// its residence. Without a line, none: « non affecté » still works.
class FinanceProperties {
  FinanceProperties({required AnnonceRepository annonces, required ResidenceRepository residences})
      : _annonces = annonces,
        _residences = residences;

  final AnnonceRepository _annonces;
  final ResidenceRepository _residences;

  Future<List<LedgerProperty>> choices() async {
    try {
      final (listings, residences) = await (_annonces.list(), _residences.list()).wait;
      return [
        for (final r in residences) ResidenceProperty(r.id, r.name),
        for (final a in listings) ListingProperty(a.id, a.title),
      ];
    } catch (_) {
      return const [];
    }
  }
}
