import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// How a residence's fiche lists its units (M10bis).
void main() {
  ListingUnit unit(
    String id,
    PropertyType type, {
    int? price,
    RentalPeriod period = RentalPeriod.month,
  }) =>
      ListingUnit(id: id, title: id, propertyType: type, price: price, rentalPeriod: period);

  test('the units by type, in the catalogue order, each in the server order', () {
    final residence = ResidenceDetail(
      id: 'r-1',
      units: [
        unit('Chambre 1', PropertyType.room),
        unit('Studio A', PropertyType.studio),
        unit('Chambre 2', PropertyType.room),
        unit('Appartement 1', PropertyType.apartment),
        unit('Chambre 3', PropertyType.room),
      ],
    );

    final groups = residence.groups;

    expect(groups.map((g) => g.type), [PropertyType.apartment, PropertyType.studio, PropertyType.room]);
    expect(groups.last.units.map((u) => u.id), ['Chambre 1', 'Chambre 2', 'Chambre 3']);
  });

  test('no unit, no group', () {
    expect(const ResidenceDetail(id: 'r-1').groups, isEmpty);
    expect(const ResidenceDetail(id: 'r-1').from, isNull);
  });

  test('the lowest rent, among the units that have one', () {
    final from = ResidenceDetail.lowestRent([
      unit('a', PropertyType.room, price: 40000),
      unit('b', PropertyType.room),
      unit('c', PropertyType.room, price: 35000),
    ]);

    expect(from, (35000, RentalPeriod.month));
  });

  test('a night is not a month — the lowest rent is in the period most units use', () {
    final from = ResidenceDetail.lowestRent([
      unit('a', PropertyType.room, price: 8000, period: RentalPeriod.day),
      unit('b', PropertyType.studio, price: 90000),
      unit('c', PropertyType.studio, price: 75000),
    ]);

    expect(from, (75000, RentalPeriod.month));
  });

  test('a unit with only a monthly rent still counts', () {
    final from = ResidenceDetail.lowestRent([
      const ListingUnit(id: 'a', monthlyRent: 50000, rentalPeriod: RentalPeriod.month),
    ]);

    expect(from, (50000, RentalPeriod.month));
  });
}
