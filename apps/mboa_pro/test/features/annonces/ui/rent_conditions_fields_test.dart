import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_draft.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/annonces/ui/widgets/rent_conditions_fields.dart';

/// §37 C — the advance and the deposit, as typed.
void main() {
  test('empty is « not said », more than 24 periods is 24 (the server refuses 25)', () {
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
      advancePeriods: 3,
      depositPeriods: 2,
    );

    final draft = AnnonceDraft.fromAnnonce(annonce);
    expect((draft.advancePeriods, draft.depositPeriods), (3, 2));

    final emptied = draft.copyWith(clearDeposit: true);
    expect((emptied.advancePeriods, emptied.depositPeriods), (3, null));
  });

  // §40 G — counted in the listing's period: the unit beside each count
  // follows it, where it said « mois » whatever the period.
  for (final (period, advance, deposit) in [
    (RentalPeriod.week, 'semaine', 'semaines'),
    (RentalPeriod.month, 'mois', 'mois'),
    (RentalPeriod.day, 'jour', 'jours'),
    (RentalPeriod.year, 'an', 'ans'),
  ]) {
    testWidgets('${period.name}: « 1 $advance », « 3 $deposit »', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: Scaffold(
            body: RentConditionsFields(
              advancePeriods: 1,
              depositPeriods: 3,
              period: period,
              onAdvanceChanged: (_) {},
              onDepositChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text(advance), findsWidgets);
      expect(find.text(deposit), findsWidgets);
      if (period != RentalPeriod.month) expect(find.text('mois'), findsNothing);
    });
  }
}
