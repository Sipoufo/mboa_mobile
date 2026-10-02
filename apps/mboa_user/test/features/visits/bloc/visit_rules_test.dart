import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/visits/models/visit_rules.dart';

/// The clock rules of M07, tenant side.
void main() {
  final now = DateTime(2026, 10, 1, 12);

  Visit visit({
    VisitStatus status = VisitStatus.scheduled,
    DateTime? at,
    VisitorKind kind = VisitorKind.agent,
    DateTime? clientConfirmedAt,
    DateTime? visitorConfirmedAt,
  }) =>
      Visit(
        id: 'v-1',
        status: status,
        scheduledAt: at,
        visitorKind: kind,
        clientConfirmedAt: clientConfirmedAt,
        visitorConfirmedAt: visitorConfirmedAt,
      );

  group('RM-M07-04 — cancelling, up to four hours before', () {
    test('five hours out, the tenant can still cancel', () {
      expect(
        VisitRules.canCancel(visit(at: DateTime(2026, 10, 1, 17)), now: now),
        isTrue,
      );
    });

    test('three hours out, it is too late', () {
      final soon = visit(at: DateTime(2026, 10, 1, 15));

      // CE-M07-03 — the visitor may already be on their way, so the screen
      // says to reach them directly instead of offering a refusal.
      expect(VisitRules.canCancel(soon, now: now), isFalse);
      expect(VisitRules.isTooLateToCancel(soon, now: now), isTrue);
    });

    test('a cancelled visit is neither cancellable nor "too late"', () {
      final gone = visit(
        status: VisitStatus.cancelled,
        at: DateTime(2026, 10, 1, 15),
      );

      expect(VisitRules.canCancel(gone, now: now), isFalse);
      // Telling someone it is too late to cancel what is already cancelled
      // would read as a refusal.
      expect(VisitRules.isTooLateToCancel(gone, now: now), isFalse);
    });
  });

  group('RM-M07-05 — I am here', () {
    test('around the hour, the button is live', () {
      expect(
        VisitRules.canConfirmPresence(
          visit(at: DateTime(2026, 10, 1, 12, 30)),
          now: now,
        ),
        isTrue,
      );
    });

    test('the day before, it is not', () {
      expect(
        VisitRules.canConfirmPresence(visit(at: DateTime(2026, 10, 2, 12)),
            now: now),
        isFalse,
      );
    });

    test('confirming twice is not a thing', () {
      expect(
        VisitRules.canConfirmPresence(
          visit(at: now, clientConfirmedAt: now),
          now: now,
        ),
        isFalse,
      );
    });

    test('one half in, the screen says who is awaited', () {
      expect(
        VisitRules.isWaitingForVisitor(visit(at: now, clientConfirmedAt: now)),
        isTrue,
      );
      expect(
        VisitRules.isWaitingForVisitor(
          visit(at: now, clientConfirmedAt: now, visitorConfirmedAt: now),
        ),
        isFalse,
      );
    });
  });

  group('RM-M07-07 — rating the visitor', () {
    test('an agent, after a visit that happened', () {
      expect(
        VisitRules.canRateVisitor(visit(status: VisitStatus.completed)),
        isTrue,
      );
    });

    test('never a prestataire showing their own property', () {
      // Nothing to rate: the service being rated is an agent's.
      expect(
        VisitRules.canRateVisitor(
          visit(status: VisitStatus.completed, kind: VisitorKind.owner),
        ),
        isFalse,
      );
    });

    test('never a visit nobody confirmed', () {
      expect(
        VisitRules.canRateVisitor(visit(status: VisitStatus.notFulfilled)),
        isFalse,
      );
    });
  });
}
