import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/mboa_score_bloc.dart';
import '../data/mboa_score_repository.dart';
import '../models/mboa_score.dart';

/// The Mboa Score (CDC M09), read as a bank statement rather than a game:
/// one ring that never closes, then every line the server counted, raises
/// and drops alike (RM-M09-06). Nothing is added up here.
///
/// The same screen serves two readers. The tenant reads their own, with a
/// word on each line about how it moves (RM-M09-03). A prestataire reads a
/// tenant's in a sheet from the thread — compact, third person, no coaching
/// (RM-M09-04).
class MboaScoreView extends StatelessWidget {
  const MboaScoreView({super.key, required this.source});

  final ScoreSource source;

  @override
  Widget build(BuildContext context) => BlocProvider<MboaScoreBloc>(
        create: (_) => GetIt.I<MboaScoreBloc>(param1: source)..add(const MboaScoreRequested()),
        child: MboaScoreContent(isOwn: source is OwnScore),
      );
}

/// RM-M09-04 — a tenant's score, for the prestataire they contacted.
Future<void> showTenantScoreSheet(BuildContext context, {required String userAccountId, String? name}) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _Sheet(source: TenantScore(userAccountId), name: name),
    );

/// The view under its bloc, public so it can be pumped with a mock one.
class MboaScoreContent extends StatelessWidget {
  const MboaScoreContent({super.key, required this.isOwn});

  /// The tenant's own score (a page) or someone else's (a sheet).
  final bool isOwn;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocBuilder<MboaScoreBloc, MboaScoreState>(
      builder: (context, state) => switch (state) {
        MboaScoreLoading() => const _MinHeight(child: Center(child: Loader())),
        MboaScoreFailure() => _Panel(
            icon: LucideIcons.cloudAlert,
            title: l10n.scoreLoadFailedTitle,
            body: l10n.scoreLoadFailedBody,
            onRetry: () => context.read<MboaScoreBloc>().add(const MboaScoreRequested()),
          ),
        MboaScoreUnavailable(reason: ScoreRefusal.notContacted) => _Panel(
            icon: LucideIcons.lockKeyhole,
            title: l10n.scoreNotContactedTitle,
            body: l10n.scoreNotContactedBody,
          ),
        MboaScoreUnavailable(reason: ScoreRefusal.noScore) => _Panel(
            icon: LucideIcons.userRoundX,
            title: l10n.scoreNoneTitle,
            body: l10n.scoreNoneBody,
          ),
        MboaScoreReady(:final score) => isOwn ? _OwnScore(score: score) : _TenantScore(score: score),
      },
    );
  }
}

// ── The tenant's own (a page) ────────────────────────────────────────────

class _OwnScore extends StatelessWidget {
  const _OwnScore({required this.score});

  final MboaScore score;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final text = context.mboaText;

    return ListView(
      padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
      children: [
        _Card(
          padding: const EdgeInsets.all(Dimens.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: _Ring(score: score, size: 168, stroke: 12)),
              const SizedBox(height: Dimens.spacing),
              Text(l10n.scoreIntroSelf, style: text.body.copyWith(color: colors.ink)),
              const SizedBox(height: Dimens.spacingSm),
              _IconLine(icon: LucideIcons.lockKeyhole, text: l10n.scorePrivateSelf),
              const SizedBox(height: Dimens.spacingSm),
              // "Le point parfait n'existe pas" — said once, where the ring's
              // gap makes it visible.
              _IconLine(icon: LucideIcons.info, text: l10n.scoreMaxNote(score.maxScore)),
            ],
          ),
        ),
        const SizedBox(height: Dimens.spacingLg),
        Text(l10n.scoreSectionSelf, style: text.h3.copyWith(color: colors.ink)),
        const SizedBox(height: Dimens.spacingMd),
        _Card(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing, vertical: Dimens.spacingSm),
          child: _Signals(signals: score.signals, withHints: true),
        ),
        const SizedBox(height: Dimens.spacing),
        _IconLine(icon: LucideIcons.info, text: l10n.scoreFooterSelf),
      ],
    );
  }
}

// ── A tenant's, for a prestataire (a sheet) ──────────────────────────────

class _Sheet extends StatelessWidget {
  const _Sheet({required this.source, this.name});

  final ScoreSource source;

  /// Whose score — the thread's peer name, when there is one.
  final String? name;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
      ),
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            Dimens.screenMargin,
            Dimens.spacingLg,
            Dimens.screenMargin,
            Dimens.spacingLg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.scoreTitle, style: context.mboaText.h3.copyWith(color: colors.ink)),
                        if (name case final name? when name.isNotEmpty)
                          Text(name, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.scoreClose,
                    icon: Icon(LucideIcons.x, color: colors.textSecondary),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: Dimens.spacing),
              MboaScoreView(source: source),
            ],
          ),
        ),
      ),
    );
  }
}

class _TenantScore extends StatelessWidget {
  const _TenantScore({required this.score});

  final MboaScore score;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final text = context.mboaText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            _Ring(score: score, size: 96, stroke: 8, compact: true),
            const SizedBox(width: Dimens.spacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.scoreIntroTenant, style: text.body.copyWith(color: colors.textSecondary)),
                  const SizedBox(height: Dimens.spacingXs),
                  _IconLine(icon: LucideIcons.lockKeyhole, text: l10n.scorePrivateTenant),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.spacingLg),
        _Signals(signals: score.signals, withHints: false),
        const SizedBox(height: Dimens.spacing),
        Text(l10n.scoreFooterTenant, style: text.caption.copyWith(color: colors.textTertiary)),
      ],
    );
  }
}

// ── Shared parts ─────────────────────────────────────────────────────────

class _Ring extends StatelessWidget {
  const _Ring({required this.score, required this.size, required this.stroke, this.compact = false});

  final MboaScore score;
  final double size;
  final double stroke;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    return MboaScoreRing(
      score: score.score,
      max: score.maxScore,
      size: size,
      stroke: stroke,
      compact: compact,
      caption: l10n.scoreOutOf(score.maxScore),
      semanticsLabel: l10n.scoreA11y(score.score, score.maxScore),
    );
  }
}

class _Signals extends StatelessWidget {
  const _Signals({required this.signals, required this.withHints});

  final List<MboaScoreSignal> signals;
  final bool withHints;

  @override
  Widget build(BuildContext context) {
    final border = context.mboaColors.border;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (i, signal) in signals.indexed) ...[
          if (i > 0) Divider(height: 1, color: border),
          SignalRow(signal: signal, withHint: withHints),
        ],
      ],
    );
  }
}

/// One line of the breakdown: what it is, how much it counted, and — for the
/// tenant — how it moves. Public so it can be pumped on its own.
class SignalRow extends StatelessWidget {
  const SignalRow({super.key, required this.signal, this.withHint = false});

  final MboaScoreSignal signal;
  final bool withHint;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final text = context.mboaText;

    final (chipBg, glyph) = switch (signal) {
      MboaScoreSignal(available: false) => (colors.border, colors.textTertiary),
      MboaScoreSignal(isPenalty: true) => (colors.warning.withValues(alpha: 0.12), colors.warning),
      MboaScoreSignal(points: > 0) => (colors.primaryPale, colors.primary),
      _ => (colors.border, colors.textSecondary),
    };
    final subtitle = _subtitle(l10n);
    final hint = withHint ? _hint(l10n) : null;
    // At a large text size the figure moves under the words rather than
    // squeezing them (the "Row with a Spacer" invariant, the other way round).
    final stacked = MediaQuery.textScalerOf(context).scale(14) > 21;
    final value = signal.available ? _Value(signal: signal) : null;

    final words = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _title(l10n),
          style: text.label.copyWith(color: signal.available ? colors.ink : colors.textSecondary),
        ),
        if (subtitle != null) Text(subtitle, style: text.caption.copyWith(color: colors.textSecondary)),
        if (hint != null) ...[
          const SizedBox(height: 2),
          Text(hint, style: text.caption.copyWith(color: colors.textTertiary)),
        ],
        if (!signal.available) ...[
          const SizedBox(height: Dimens.spacingXs),
          _Pill(label: l10n.scoreSoon),
        ],
        if (stacked && value != null) ...[const SizedBox(height: Dimens.spacingXs), value],
      ],
    );

    Widget row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Dimens.iconLg,
          height: Dimens.iconLg,
          decoration: BoxDecoration(color: chipBg, shape: BoxShape.circle),
          child: Icon(_icon, size: Dimens.iconSm, color: glyph),
        ),
        const SizedBox(width: Dimens.spacingMd),
        Expanded(child: words),
        if (!stacked && value != null) ...[const SizedBox(width: Dimens.spacingSm), value],
      ],
    );

    // RM-M09-06 — what lowered the score is set apart, not buried.
    if (signal.isPenalty) {
      row = Container(
        padding: const EdgeInsets.all(Dimens.spacingSm),
        decoration: BoxDecoration(
          color: colors.warning.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(Dimens.radius),
          border: Border.all(color: colors.warning.withValues(alpha: 0.3)),
        ),
        child: row,
      );
    }

    return MergeSemantics(
      child: Semantics(
        // Everything the row says, in words: the figure read as "moins 15
        // points", and the count and the hint kept — they are the point.
        label: [_title(l10n), ?subtitle, _spoken(l10n), ?hint].join(', '),
        excludeSemantics: true,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: withHint ? Dimens.spacingMd : Dimens.spacingSm),
          child: row,
        ),
      ),
    );
  }

  IconData get _icon => switch (signal.kind) {
        ScoreSignalKind.profileComplete => LucideIcons.userRoundCheck,
        ScoreSignalKind.identityVerified => LucideIcons.idCard,
        ScoreSignalKind.accountSeniority => LucideIcons.calendarClock,
        ScoreSignalKind.signedContracts => LucideIcons.fileSignature,
        ScoreSignalKind.providerRating => LucideIcons.star,
        ScoreSignalKind.validatedReports => LucideIcons.flag,
        ScoreSignalKind.adminAdjustment || ScoreSignalKind.unknown => LucideIcons.scale,
      };

  String _title(I18n l10n) => switch (signal.kind) {
        ScoreSignalKind.profileComplete => l10n.scoreSignalProfile,
        ScoreSignalKind.identityVerified => l10n.scoreSignalIdentity,
        ScoreSignalKind.accountSeniority => l10n.scoreSignalSeniority,
        ScoreSignalKind.signedContracts => l10n.scoreSignalContracts,
        ScoreSignalKind.providerRating => l10n.scoreSignalRating,
        ScoreSignalKind.validatedReports => l10n.scoreSignalReports,
        ScoreSignalKind.adminAdjustment => l10n.scoreSignalAdjustment,
        ScoreSignalKind.unknown => l10n.scoreSignalOther,
      };

  String? _subtitle(I18n l10n) => switch (signal.kind) {
        ScoreSignalKind.signedContracts => l10n.scoreContractsCount(signal.count ?? 0),
        ScoreSignalKind.validatedReports => l10n.scoreReportsCount(signal.count ?? 0),
        // §37 A — real since 2026-10-27: how many landlords rated, never who.
        ScoreSignalKind.providerRating when signal.available => l10n.scoreRatingCount(signal.count ?? 0),
        _ => null,
      };

  String? _hint(I18n l10n) => switch (signal.kind) {
        ScoreSignalKind.profileComplete => l10n.scoreHintProfile,
        ScoreSignalKind.identityVerified => l10n.scoreHintIdentity,
        ScoreSignalKind.accountSeniority => l10n.scoreHintSeniority,
        ScoreSignalKind.signedContracts => l10n.scoreHintContracts(signal.maxPoints ?? 0),
        ScoreSignalKind.providerRating => l10n.scoreHintRating,
        ScoreSignalKind.validatedReports => l10n.scoreHintReports,
        ScoreSignalKind.adminAdjustment || ScoreSignalKind.unknown => null,
      };

  /// What a screen reader says — "moins 15 points", not "dash fifteen".
  String _spoken(I18n l10n) {
    if (!signal.available) return l10n.scoreA11ySoon;
    final points = signal.points;
    final max = signal.maxPoints;
    if (points < 0) return l10n.scoreA11yPenalty(points.abs());
    if (max != null && max > 0) return points > 0 ? l10n.scoreA11yEarned(points, max) : l10n.scoreA11yZero(max);
    return l10n.scoreA11yPoints(points);
  }
}

/// "+10 / 30", "0 / 20", "−15" — a true minus sign, figures that line up.
class _Value extends StatelessWidget {
  const _Value({required this.signal});

  final MboaScoreSignal signal;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final text = context.mboaText;
    const figures = [FontFeature.tabularFigures()];
    final points = signal.points;
    final max = signal.maxPoints;
    final shown = points > 0
        ? '+$points'
        : points < 0
            ? '−${points.abs()}'
            : '0';

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: shown,
            style: text.label.copyWith(
              color: points > 0 ? colors.primary : colors.ink,
              fontWeight: FontWeight.w700,
              fontFeatures: figures,
            ),
          ),
          if (max != null && max > 0)
            TextSpan(
              text: ' / $max',
              style: text.caption.copyWith(color: colors.textTertiary, fontFeatures: figures),
            ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: 2),
      decoration: BoxDecoration(color: colors.border, borderRadius: BorderRadius.circular(Dimens.radiusFull)),
      child: Text(label, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child, required this.padding});

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        decoration: BoxDecoration(
          color: context.mboaColors.surface,
          borderRadius: BorderRadius.circular(Dimens.radiusMd),
          boxShadow: MboaShadows.card,
        ),
        child: child,
      );
}

class _IconLine extends StatelessWidget {
  const _IconLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: Dimens.iconSm, color: colors.textTertiary),
        const SizedBox(width: Dimens.spacingSm),
        Expanded(child: Text(text, style: context.mboaText.caption.copyWith(color: colors.textSecondary))),
      ],
    );
  }
}

/// Loading and refusals keep the sheet from jumping in height.
class _MinHeight extends StatelessWidget {
  const _MinHeight({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => ConstrainedBox(constraints: const BoxConstraints(minHeight: 240), child: child);
}

class _Panel extends StatelessWidget {
  const _Panel({required this.icon, required this.title, required this.body, this.onRetry});

  final IconData icon;
  final String title;
  final String body;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    return _MinHeight(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: Dimens.iconLg, color: colors.textTertiary),
              const SizedBox(height: Dimens.spacing),
              Text(title, textAlign: TextAlign.center, style: context.mboaText.label.copyWith(color: colors.ink)),
              const SizedBox(height: Dimens.spacingXs),
              Text(
                body,
                textAlign: TextAlign.center,
                style: context.mboaText.body.copyWith(color: colors.textSecondary),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: Dimens.spacingSm),
                TextButton(onPressed: onRetry, child: Text(l10n.commonRetry)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
