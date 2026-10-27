import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_draft.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/annonces/ui/widgets/rent_conditions_fields.dart';

/// §37 C — the advance and the deposit, as typed.
void main() {
  test('empty is « not said », more than 24 months is 24 (the server refuses 25)', () {
    expect(RentConditionsFields.parse(''), isNull);
    expect(RentConditionsFields.parse('0'), 0);
    expect(RentConditionsFields.parse('3'), 3);
    expect(RentConditionsFields.parse('99'), 24);
  });

  test('editing a listing starts from its conditions, and can empty them', () {
    const annonce = Annonce(
      id: 'a1',
      title: 'Studio Akwa',
      status: AnnonceStatus.draft,
      propertyType: PropertyType.studio,
      advanceMonths: 3,
      depositMonths: 2,
    );

    final draft = AnnonceDraft.fromAnnonce(annonce);
    expect((draft.advanceMonths, draft.depositMonths), (3, 2));

    final emptied = draft.copyWith(clearDeposit: true);
    expect((emptied.advanceMonths, emptied.depositMonths), (3, null));
  });
}
