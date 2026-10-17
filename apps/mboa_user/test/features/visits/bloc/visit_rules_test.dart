import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
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

  group('§19 — withdrawing a request', () {
    test('a request is withdrawn at any time, even inside four hours', () {
      // Nobody is on their way to a time the owner has not accepted, so the
      // four-hour rule that protects a visitor does not apply. It used to:
      // a request an hour away could neither be withdrawn nor answered.
      final soon = visit(
        status: VisitStatus.requested,
        at: DateTime(2026, 10, 1, 13),
      );
      expect(VisitRules.canCancel(soon, now: now), isTrue);
      expect(VisitRules.isTooLateToCancel(soon, now: now), isFalse);
    });

    test('and it is called a withdrawal, not a cancellation', () {
      expect(
        VisitRules.isWithdrawal(visit(status: VisitStatus.requested)),
        isTrue,
      );
      expect(VisitRules.isWithdrawal(visit()), isFalse);
    });

    test('a confirmed visit is still bound by the four hours', () {
      final soon = visit(at: DateTime(2026, 10, 1, 13));
      expect(VisitRules.canCancel(soon, now: now), isFalse);
      expect(VisitRules.isTooLateToCancel(soon, now: now), isTrue);
    });
  });

  group('§22 — a rating survives a restart', () {
    test('the server record says it is done', () {
      expect(const Visit(id: 'v', status: VisitStatus.completed, agentRating: 4)
          .isRated, isTrue);
      expect(const Visit(id: 'v', status: VisitStatus.completed).isRated,
          isFalse);
    });

    test('a blank phone is no phone', () {
      // CA-M12-02 — the number is either there to call, or absent.
      expect(
        Visit.fromResponse(
          VisiteResponse((b) => b
            ..id = 'v'
            ..visitorPhone = '   '),
        ).visitorPhone,
        isNull,
      );
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
