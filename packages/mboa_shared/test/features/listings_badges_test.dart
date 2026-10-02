import 'package:api_client/api_client.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';

ProviderCard card(List<ProviderCardBadgesEnum> badges) => ProviderCard(
      (b) => b
        ..displayName = 'Agence Deido'
        ..badges = ListBuilder<ProviderCardBadgesEnum>(badges),
    );

/// Trust badges (CDC M05).
///
/// The wire values are the backend's `BadgeCode`, typed since 2026-09-30. This
/// app had guessed them — `TRUSTED_PROVIDER`, `VERIFIED_IDENTITY` — and every
/// badge was silently dropped on the fiche, which is what a wrong wire value
/// looks like: an empty list, never an error.
void main() {
  test('RM-M05-03 — badges come out in prestige order, not wire order', () {
    final provider = ProviderSummary.fromResponse(
      card([
        ProviderCardBadgesEnum.PHOTOS_VERIFIED,
        ProviderCardBadgesEnum.TRUSTED,
        ProviderCardBadgesEnum.IDENTITY_VERIFIED,
      ]),
    );

    // The server sorts them too; the fiche's rule stays where it is applied.
    expect(provider.badges, [
      TrustBadge.trustedProvider,
      TrustBadge.verifiedIdentity,
      TrustBadge.verifiedPhotos,
    ]);
  });

  test('a code this build does not know is dropped, not drawn blank', () {
    final provider = ProviderSummary.fromResponse(
      card([
        ProviderCardBadgesEnum.unknownDefaultOpenApi,
        ProviderCardBadgesEnum.RECERTIFIED,
      ]),
    );

    // `enumUnknownDefaultCase` turns a code added after this build into the
    // fallback constant; it must not render as an empty chip.
    expect(provider.badges, [TrustBadge.recertified]);
  });

  test('the same badge twice counts once', () {
    final provider = ProviderSummary.fromResponse(
      card([
        ProviderCardBadgesEnum.RECERTIFIED,
        ProviderCardBadgesEnum.RECERTIFIED,
      ]),
    );

    expect(provider.badges, hasLength(1));
  });

  test('RM-M05-08 — no review means no rating to show', () {
    const none = PropertyRatingSummary();
    const rated = PropertyRatingSummary(average: 4.2, reviewCount: 7);

    // A "0/5" would read as a bad property rather than an unrated one.
    expect(none.hasRating, isFalse);
    expect(rated.hasRating, isTrue);
  });
}
