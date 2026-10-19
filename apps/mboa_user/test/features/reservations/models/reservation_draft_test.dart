import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/reservations/models/reservation_draft.dart';

/// CDC M29 — the stay asked for, and what follows from it.
void main() {
  const listing = ReservationListing(id: 'a-1', price: 110000, rentalPeriod: RentalPeriod.month);

  test('no start, no end — and not ready to send', () {
    const draft = ReservationDraft(listing: listing);

    expect(draft.lastDay, isNull);
    expect(draft.isComplete, isFalse);
  });

  test('the end is the day before the last period runs out', () {
    final draft = ReservationDraft(listing: listing, start: DateTime(2026, 11, 1), units: 6);

    expect(draft.lastDay, DateTime(2027, 4, 30));
    expect(draft.isComplete, isTrue);
  });

  test('CA-M29-04 — the total is rent times periods, nothing more', () {
    const draft = ReservationDraft(listing: listing, units: 6);

    expect(draft.indicativeTotal, 660000);
    expect(const ReservationDraft(listing: ReservationListing(id: 'a-2')).indicativeTotal, isNull);
  });

  test('a start may be from today to twelve months ahead', () {
    final now = DateTime(2026, 10, 19, 17, 45);

    expect(ReservationDraft.firstDay(now), DateTime(2026, 10, 19));
    expect(ReservationDraft.lastStartDay(now), DateTime(2027, 10, 19));
  });

  test('the duration stays within the API\'s bounds', () {
    final start = DateTime(2026, 11, 1);

    expect(ReservationDraft(listing: listing, start: start, units: 0).isComplete, isFalse);
    expect(ReservationDraft(listing: listing, start: start, units: 601).isComplete, isFalse);
    expect(ReservationDraft(listing: listing, start: start, units: 600).isComplete, isTrue);
  });

  test('the fiche\'s listing carries its first photo and its periodicity', () {
    const detail = ListingDetail(
      id: 'a-1',
      title: 'Studio',
      price: 30000,
      rentalPeriod: RentalPeriod.week,
      district: 'Deido',
      city: 'Douala',
    );

    final carried = ReservationListing.fromDetail(detail);

    expect(carried.price, 30000);
    expect(carried.rentalPeriod, RentalPeriod.week);
    expect(carried.district, 'Deido');
    expect(carried.photoUrl, isNull);
  });
}
