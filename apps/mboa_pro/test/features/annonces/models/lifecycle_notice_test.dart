import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/annonces/ui/widgets/lifecycle_notice.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// RM-M10-04 — Free listings expire at J+30, and an archive says why.
void main() {
  final now = DateTime(2026, 10, 18, 23);

  Annonce annonce({
    AnnonceStatus status = AnnonceStatus.published,
    DateTime? expiresAt,
    ArchivedReason? reason,
  }) =>
      Annonce(
        id: 'a-1',
        title: 'Studio Akwa',
        status: status,
        propertyType: PropertyType.studio,
        expiresAt: expiresAt,
        archivedReason: reason,
      );

  group('daysUntilExpiry', () {
    test('counts calendar days: tomorrow 08:00 is tomorrow, even at 23:00', () {
      final a = annonce(expiresAt: DateTime(2026, 10, 19, 8));

      expect(a.daysUntilExpiry(now: now), 1);
    });

    test('a deadline the hourly sweep has not caught yet reads today', () {
      final a = annonce(expiresAt: DateTime(2026, 10, 17, 10));

      expect(a.daysUntilExpiry(now: now), 0);
    });

    test('a paid tier has no deadline, so no countdown', () {
      expect(annonce().daysUntilExpiry(now: now), isNull);
    });

    test('only a live listing counts down — a draft is not on the market', () {
      final a = annonce(
        status: AnnonceStatus.draft,
        expiresAt: DateTime(2026, 10, 25),
      );

      expect(a.daysUntilExpiry(now: now), isNull);
    });
  });

  group('ArchivedReason.fromResponse', () {
    test('reads every published value, and keeps "no reason" as null', () {
      expect(
        ArchivedReason.fromResponse(AnnonceResponseArchivedReasonEnum.OWNER),
        ArchivedReason.owner,
      );
      expect(
        ArchivedReason.fromResponse(AnnonceResponseArchivedReasonEnum.EXPIRED),
        ArchivedReason.expired,
      );
      expect(
        ArchivedReason.fromResponse(AnnonceResponseArchivedReasonEnum.PLAN_LIMIT),
        ArchivedReason.planLimit,
      );
      expect(ArchivedReason.fromResponse(null), isNull);
    });

    test('Annonce.fromResponse carries it through', () {
      final a = Annonce.fromResponse(
        AnnonceResponse(
          (b) => b
            ..id = 'a-1'
            ..status = AnnonceResponseStatusEnum.ARCHIVED
            ..archivedReason = AnnonceResponseArchivedReasonEnum.EXPIRED,
        ),
      );

      expect(a.archivedReason, ArchivedReason.expired);
    });
  });

  group('LifecycleNotice.of', () {
    test('an expired archive is told how to come back', () {
      final notice = LifecycleNotice.of(
        annonce(status: AnnonceStatus.archived, reason: ArchivedReason.expired),
        now: now,
      );

      expect(notice?.kind, LifecycleNoticeKind.expired);
    });

    test('a plan-limit archive is told it needs room or a plan', () {
      final notice = LifecycleNotice.of(
        annonce(status: AnnonceStatus.archived, reason: ArchivedReason.planLimit),
        now: now,
      );

      expect(notice?.kind, LifecycleNoticeKind.planLimit);
    });

    test('an archive the owner made needs no explaining', () {
      expect(
        LifecycleNotice.of(
          annonce(status: AnnonceStatus.archived, reason: ArchivedReason.owner),
          now: now,
        ),
        isNull,
      );
      // Archived before the server kept reasons.
      expect(
        LifecycleNotice.of(annonce(status: AnnonceStatus.archived), now: now),
        isNull,
      );
    });

    test('N-10 — urgent from five days out, not before', () {
      final six = LifecycleNotice.of(
        annonce(expiresAt: DateTime(2026, 10, 24, 12)),
        now: now,
      );
      final five = LifecycleNotice.of(
        annonce(expiresAt: DateTime(2026, 10, 23, 12)),
        now: now,
      );

      expect(six?.kind, LifecycleNoticeKind.expiring);
      expect(six?.days, 6);
      expect(six?.isUrgent, isFalse);
      expect(five?.days, 5);
      expect(five?.isUrgent, isTrue);
    });
  });
}
