import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockReportRepository extends Mock implements ReportRepository {}

/// Reporting to moderation (CDC M23), and RM-M27-06's addition of reviews.
void main() {
  group('the wire values', () {
    // Written out literally, against the generated client. A guessed one
    // looks exactly like an empty list — which is how every trust badge on
    // the fiche silently vanished for a month.
    test('targets', () {
      expect(
        ReportTargetKind.annonce.wire,
        CreateSignalementRequestTargetTypeEnum.ANNONCE,
      );
      expect(
        ReportTargetKind.message.wire,
        CreateSignalementRequestTargetTypeEnum.MESSAGE,
      );
      expect(
        ReportTargetKind.review.wire,
        CreateSignalementRequestTargetTypeEnum.REVIEW,
      );
    });

    test('reasons', () {
      expect(
        ReportReason.fraudulentListing.wire,
        CreateSignalementRequestReasonEnum.FRAUDULENT_LISTING,
      );
      expect(
        ReportReason.abnormalPrice.wire,
        CreateSignalementRequestReasonEnum.ABNORMAL_PRICE,
      );
      expect(
        ReportReason.inappropriateContent.wire,
        CreateSignalementRequestReasonEnum.INAPPROPRIATE_CONTENT,
      );
      expect(
        ReportReason.harassment.wire,
        CreateSignalementRequestReasonEnum.HARASSMENT,
      );
    });
  });

  group('which reasons fit which target', () {
    test('a listing can be fraudulent or overpriced', () {
      expect(
        const ReportTarget.annonce('a-1').reasons,
        containsAll(const [
          ReportReason.fraudulentListing,
          ReportReason.abnormalPrice,
        ]),
      );
    });

    test('a review cannot be overpriced', () {
      // The API's reason list was drawn for listings. Offering "prix anormal"
      // against somebody's account of living somewhere would be absurd, so
      // the app declines to ask the question (docs/backend-requests.md §25).
      final reasons = const ReportTarget.review('r-1').reasons;
      expect(reasons, isNot(contains(ReportReason.abnormalPrice)));
      expect(reasons, isNot(contains(ReportReason.fraudulentListing)));
      expect(
        reasons,
        containsAll(const [
          ReportReason.inappropriateContent,
          ReportReason.harassment,
        ]),
      );
    });

    test('every target offers at least one reason', () {
      // RM-M23-01 records a reason on every report, so a target with none
      // would be a button that cannot be used.
      for (final kind in ReportTargetKind.values) {
        expect(ReportTarget(kind: kind, id: 'x').reasons, isNotEmpty);
      }
    });
  });

  group('sending one', () {
    late MockReportRepository repository;

    setUp(() {
      repository = MockReportRepository();
      registerFallbackValue(const ReportTarget.annonce('x'));
      registerFallbackValue(ReportReason.inappropriateContent);
    });

    blocTest<ReportCubit, ReportState>(
      'RM-M23-05 — it is received, and that is all the reporter is told',
      setUp: () => when(
        () => repository.report(
          any(),
          reason: any(named: 'reason'),
          comment: any(named: 'comment'),
        ),
      ).thenAnswer((_) async {}),
      build: () => ReportCubit(repository: repository),
      act: (cubit) => cubit.send(
        const ReportTarget.review('r-1'),
        reason: ReportReason.harassment,
        comment: '  insultes  ',
      ),
      expect: () => const [ReportSending(), ReportSent()],
      verify: (_) => verify(
        () => repository.report(
          const ReportTarget.review('r-1'),
          reason: ReportReason.harassment,
          comment: '  insultes  ',
        ),
      ).called(1),
    );

    blocTest<ReportCubit, ReportState>(
      'a refused report says so rather than claiming it landed',
      setUp: () => when(
        () => repository.report(
          any(),
          reason: any(named: 'reason'),
          comment: any(named: 'comment'),
        ),
      ).thenThrow(Exception('500')),
      build: () => ReportCubit(repository: repository),
      act: (cubit) => cubit.send(
        const ReportTarget.annonce('a-1'),
        reason: ReportReason.fraudulentListing,
      ),
      expect: () => const [ReportSending(), ReportFailed()],
    );

    blocTest<ReportCubit, ReportState>(
      'a double tap does not send it twice',
      setUp: () => when(
        () => repository.report(
          any(),
          reason: any(named: 'reason'),
          comment: any(named: 'comment'),
        ),
      ).thenAnswer((_) async => Future<void>.delayed(
            const Duration(milliseconds: 40),
          )),
      build: () => ReportCubit(repository: repository),
      act: (cubit) {
        cubit
          ..send(
            const ReportTarget.annonce('a-1'),
            reason: ReportReason.fraudulentListing,
          )
          ..send(
            const ReportTarget.annonce('a-1'),
            reason: ReportReason.fraudulentListing,
          );
      },
      wait: const Duration(milliseconds: 80),
      verify: (_) => verify(
        () => repository.report(
          any(),
          reason: any(named: 'reason'),
          comment: any(named: 'comment'),
        ),
      ).called(1),
    );
  });
}
