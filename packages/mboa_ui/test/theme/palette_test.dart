import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// Brandbook v2 §21 (Variantes et neutres) and §22 (couleurs système) as a
/// test — the companion to `mboa_l10n`'s `voice_test.dart`.
///
/// §48's pre-publication checklist asks for "couleurs de la palette
/// officielle", and the brandbook lists that palette in full, so it is a
/// closed set: 14 brand and neutral colours plus 4 system colours. Two
/// off-palette values had drifted in — a pale green `#D8F3DC` next to the
/// official `#E8F4F0`, and a page canvas `#FBFBFB` measured off a design,
/// 1.5% from white and so giving a white card no visible edge at all.
///
/// This locks the set, so the next addition has to be argued for.
void main() {
  group('§21 — the palette is what the brandbook lists', () {
    test('Vert Forêt and its variants', () {
      expect(MboaPalette.forest, const Color(0xFF1A5C45));
      expect(MboaPalette.forestLight, const Color(0xFF2D8A67));
      expect(MboaPalette.forestPale, const Color(0xFFE8F4F0));
      expect(MboaPalette.forestDark, const Color(0xFF0F3829));
    });

    test('Corail Chaud and its variants', () {
      expect(MboaPalette.coral, const Color(0xFFE8735A));
      expect(MboaPalette.coralLight, const Color(0xFFF5A08C));
      expect(MboaPalette.coralPale, const Color(0xFFFDF0EC));
      expect(MboaPalette.coralDark, const Color(0xFFC4503A));
    });

    test('the neutrals', () {
      expect(MboaPalette.white, const Color(0xFFFFFFFF));
      expect(MboaPalette.warmWhite, const Color(0xFFF9F7F4));
      expect(MboaPalette.greyLight, const Color(0xFFF0EFED));
      expect(MboaPalette.greyMedium, const Color(0xFF9CA3AF));
      expect(MboaPalette.greyDark, const Color(0xFF6B7280));
      expect(MboaPalette.ink, const Color(0xFF1A1A1A));
    });

    test('§22 — the system colours', () {
      expect(MboaPalette.success, const Color(0xFF22C55E));
      expect(MboaPalette.error, const Color(0xFFEF4444));
      expect(MboaPalette.warning, const Color(0xFFF59E0B));
      expect(MboaPalette.info, const Color(0xFF3B82F6));
    });
  });

  group('§28 / §29 — the measurements the brandbook gives', () {
    test('buttons: radius 12, heights 52 / 44 / 36', () {
      expect(Dimens.radius, 12);
      expect(Dimens.buttonHeight, 52);
      expect(Dimens.buttonHeightSm, 44);
      expect(Dimens.buttonHeightXs, 36);
    });

    test('cards: radius 16, and the §6.2 shadow', () {
      expect(Dimens.radiusMd, 16);
      expect(MboaShadows.card, hasLength(1));
      expect(MboaShadows.card.single.offset, const Offset(0, 2));
      expect(MboaShadows.card.single.blurRadius, 12);
      // rgba(0, 0, 0, 0.08) — 0.08 × 255 ≈ 20 = 0x14.
      expect(MboaShadows.card.single.color, const Color(0x14000000));
    });

    test('the mobile grid: 390 base, 20 px margins, 12 px gutter', () {
      expect(Dimens.screenMargin, 20);
      expect(Dimens.spacingMd, 12);
    });

    test('the 8 px spacing system', () {
      expect(
        [
          Dimens.spacingXs,
          Dimens.spacingSm,
          Dimens.spacingMd,
          Dimens.spacing,
          Dimens.screenMargin,
          Dimens.spacingLg,
          Dimens.spacingXl,
          Dimens.spacingXxl,
        ],
        [4, 8, 12, 16, 20, 24, 32, 48],
      );
    });
  });
}
