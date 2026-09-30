import 'package:api_client/api_client.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';

ProviderCard card(List<String> badges) => ProviderCard(
      (b) => b
        ..displayName = 'Agence Deido'
        ..badges = ListBuilder<String>(badges),
    );

/// Trust badges (CDC M05).
///
/// `ProviderCard.badges` is an untyped `string[]` — the wire values are not
/// documented (`docs/backend-requests.md` §16) — so this pins both halves of
/// the defence: what we accept, and the order we draw it in.
void main() {
  test('RM-M05-03 — badges come out in prestige order, not wire order', () {
    final provider = ProviderSummary.fromResponse(
      card(['VERIFIED_PHOTOS', 'TRUSTED_PROVIDER', 'VERIFIED_IDENTITY']),
    );

    // The server has never promised an order; the fiche's rule is ours.
    expect(provider.badges, [
      TrustBadge.trustedProvider,
      TrustBadge.verifiedIdentity,
      TrustBadge.verifiedPhotos,
    ]);
  });

  test('an unknown badge is dropped, not drawn blank', () {
    final provider =
        ProviderSummary.fromResponse(card(['SUPER_HOST', 'RECERTIFIED']));

    // A value a later backend adds must not render as an empty chip.
    expect(provider.badges, [TrustBadge.recertified]);
  });

  test('the same badge twice counts once', () {
    final provider = ProviderSummary.fromResponse(
      card(['RECERTIFIED', 'recertified']),
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
