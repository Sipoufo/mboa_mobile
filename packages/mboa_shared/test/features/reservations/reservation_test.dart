import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// CDC M29 — a reservation request, read the same by both apps.
void main() {
  group('Reservation.fromResponse', () {
    test('reads the request, where it stands, and what the reader may do', () {
      final reservation = Reservation.fromResponse(
        ReservationResponse(
          (b) => b
            ..id = 'r-1'
            ..annonceId = 'a-1'
            ..annonceTitle = 'Studio Akwa'
            ..userAccountId = 'u-1'
            ..desiredStartDate = Date(2026, 11, 1)
            ..durationUnits = 6
            ..rentalPeriod = ReservationResponseRentalPeriodEnum.MONTH
            ..message = '  '
            ..status = ReservationResponseStatusEnum.PENDING
            ..ownerReason = ReservationResponseOwnerReasonEnum.DATES_INCOMPATIBLE
            ..cancelledBy = ReservationResponseCancelledByEnum.SYSTEM
            ..conversationId = 'c-1'
            ..canAccept = true
            ..canRefuse = true,
        ),
      );

      expect(reservation.status, ReservationStatus.pending);
      expect(reservation.rentalPeriod, RentalPeriod.month);
      expect(reservation.userAccountId, 'u-1');
      // A blank message is no message.
      expect(reservation.message, isNull);
      expect(reservation.ownerReason, RefusalReason.datesIncompatible);
      expect(reservation.cancelledBy, CancelledBy.system);
      expect(reservation.conversationId, 'c-1');
      expect(reservation.canAccept, isTrue);
      expect(reservation.canDraftContract, isFalse);
    });

    test('a status this build does not know is unknown, not a crash', () {
      expect(ReservationStatus.fromWire('ON_HOLD'), ReservationStatus.unknown);
    });
  });

  group('the stay\'s last day (indicative)', () {
    test('six months from 1 November ends on 30 April', () {
      const r = Reservation(id: 'r', status: ReservationStatus.pending, durationUnits: 6);
      final withStart = Reservation(
        id: r.id,
        status: r.status,
        desiredStartDate: DateTime(2026, 11, 1),
        durationUnits: 6,
      );

      expect(withStart.lastDay, DateTime(2027, 4, 30));
    });

    test('by the day and by the week', () {
      expect(RentalPeriod.day.lastDay(DateTime(2026, 11, 1), 3), DateTime(2026, 11, 3));
      expect(RentalPeriod.week.lastDay(DateTime(2026, 11, 1), 2), DateTime(2026, 11, 14));
    });

    test('a start on the 31st is clamped to a shorter month', () {
      expect(RentalPeriod.month.lastDay(DateTime(2027, 1, 31), 1), DateTime(2027, 2, 27));
    });
  });

  test('the offline copy keeps what a list row draws', () {
    final reservation = Reservation(
      id: 'r-1',
      status: ReservationStatus.accepted,
      annonceTitle: 'Studio Akwa',
      desiredStartDate: DateTime(2026, 11, 1),
      durationUnits: 6,
      reservedUntil: DateTime(2026, 10, 26),
    );

    final back = Reservation.fromCache(reservation.toCache());

    expect(back?.status, ReservationStatus.accepted);
    expect(back?.annonceTitle, 'Studio Akwa');
    expect(back?.reservedUntil, DateTime(2026, 10, 26));
    expect(back?.lastDay, reservation.lastDay);
  });

  test('RM-M29-09 — money asked before signing can be reported on a listing and a message, not a review', () {
    expect(const ReportTarget.annonce('a').reasons, contains(ReportReason.askedForMoney));
    expect(const ReportTarget.message('m').reasons, contains(ReportReason.askedForMoney));
    expect(const ReportTarget.review('v').reasons, isNot(contains(ReportReason.askedForMoney)));
  });

  test('the RESERVATION push target is read', () {
    expect(PushType.parse('RESERVATION'), PushType.reservation);
  });

  test('a system message is read as such, with its request', () {
    final message = Message.fromResponse(
      MessageResponse(
        (b) => b
          ..id = 's-1'
          ..kind = MessageResponseKindEnum.SYSTEM
          ..reservation.reservationRequestId = 'r-1'
          ..reservation.desiredStartDate = Date(2026, 11, 1)
          ..reservation.durationUnits = 6
          ..reservation.rentalPeriod = ReservationRequestSnapshotRentalPeriodEnum.MONTH,
      ),
    );

    expect(message.isSystem, isTrue);
    expect(message.reservation?.reservationId, 'r-1');
    expect(message.reservation?.desiredStartDate, DateTime(2026, 11, 1));
  });
}
