import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

void main() {
  group('VisitCancellationReason.fromResponse', () {
    test('reads every published value', () {
      expect(
        VisitCancellationReason.fromResponse(VisiteResponseCancellationReasonEnum.BY_USER),
        VisitCancellationReason.byClient,
      );
      // BY_AGENT predates owner-visitors: it means whoever showed the property.
      expect(
        VisitCancellationReason.fromResponse(VisiteResponseCancellationReasonEnum.BY_AGENT),
        VisitCancellationReason.byVisitor,
      );
      expect(
        VisitCancellationReason.fromResponse(VisiteResponseCancellationReasonEnum.AGENT_UNAVAILABLE),
        VisitCancellationReason.agentUnavailable,
      );
      expect(
        VisitCancellationReason.fromResponse(VisiteResponseCancellationReasonEnum.AGENT_REMOVED),
        VisitCancellationReason.agentRemoved,
      );
      expect(
        VisitCancellationReason.fromResponse(VisiteResponseCancellationReasonEnum.LISTING_UNAVAILABLE),
        VisitCancellationReason.listingUnavailable,
      );
    });

    test('no reason stays no reason — a visit cancelled before they were kept', () {
      expect(VisitCancellationReason.fromResponse(null), isNull);
    });
  });

  test('Visit.fromResponse carries the reason through', () {
    final visit = Visit.fromResponse(
      VisiteResponse(
        (b) => b
          ..id = 'v-1'
          ..status = VisiteResponseStatusEnum.CANCELLED
          ..cancellationReason = VisiteResponseCancellationReasonEnum.LISTING_UNAVAILABLE,
      ),
    );

    expect(visit.cancellationReason, VisitCancellationReason.listingUnavailable);
  });
}
