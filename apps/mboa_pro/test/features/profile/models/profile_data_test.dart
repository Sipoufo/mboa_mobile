import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/profile/models/prestataire_type.dart';
import 'package:mboa_pro/features/profile/models/profile_data.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// A prestataire's identity is their business, so the avatar is the logo from
/// `/prestataires/me` — not the personal photo on `/users/me`, which is what
/// every Pro screen used to render while `logoObjectKey` sat unused.
void main() {
  group('avatarUrl', () {
    test('prefers the logo over the personal photo', () {
      const profile = ProfileData(
        role: AccountRole.prestataire,
        photoObjectKey: 'photo.jpg',
        logoObjectKey: 'logo.jpg',
      );

      expect(profile.avatarUrl, endsWith('/logo.jpg'));
      // The personal photo is still readable — only the avatar changes.
      expect(profile.photoUrl, endsWith('/photo.jpg'));
    });

    test('falls back to the personal photo when no logo is set', () {
      const profile = ProfileData(
        role: AccountRole.prestataire,
        photoObjectKey: 'photo.jpg',
      );

      expect(profile.avatarUrl, endsWith('/photo.jpg'));
    });

    test('an agent has no business profile and keeps their photo', () {
      const profile = ProfileData(
        role: AccountRole.agent,
        photoObjectKey: 'photo.jpg',
      );

      expect(profile.avatarUrl, endsWith('/photo.jpg'));
    });

    test('is null when neither is set', () {
      expect(const ProfileData().avatarUrl, isNull);
    });
  });

  group('isProfileComplete (RM-M10-01)', () {
    const incompleteLocally = ProfileData(role: AccountRole.prestataire);

    test('takes the server flag when it is present, even against our guess', () {
      expect(
        const ProfileData(role: AccountRole.prestataire, profileComplete: true)
            .isProfileComplete,
        isTrue,
      );
      // Everything we check locally is set, and the server still says no.
      expect(
        const ProfileData(
          role: AccountRole.prestataire,
          logoObjectKey: 'logo.jpg',
          type: PrestataireType.agence,
          mainCityId: 'c-1',
          profileComplete: false,
        ).isProfileComplete,
        isFalse,
      );
    });

    test('falls back to the local check when the flag is absent', () {
      // A missing flag must not read as "incomplete": that would block every
      // publish in the app on any backend that does not send it.
      expect(
        const ProfileData(
          role: AccountRole.prestataire,
          logoObjectKey: 'logo.jpg',
          type: PrestataireType.agence,
          mainCityId: 'c-1',
        ).isProfileComplete,
        isTrue,
      );
      expect(incompleteLocally.isProfileComplete, isFalse);
    });

    test('the local fallback accepts a logo or a photo as the image', () {
      const withPhotoOnly = ProfileData(
        role: AccountRole.prestataire,
        photoObjectKey: 'photo.jpg',
        type: PrestataireType.particulier,
        mainCityId: 'c-1',
      );
      const withLogoOnly = ProfileData(
        role: AccountRole.prestataire,
        logoObjectKey: 'logo.jpg',
        type: PrestataireType.particulier,
        mainCityId: 'c-1',
      );

      expect(withPhotoOnly.isProfileComplete, isTrue);
      expect(withLogoOnly.isProfileComplete, isTrue);
    });

    test('the local fallback accepts the search city when there is no main city', () {
      expect(
        const ProfileData(
          role: AccountRole.prestataire,
          logoObjectKey: 'logo.jpg',
          type: PrestataireType.agence,
          searchCityId: 'c-2',
        ).isProfileComplete,
        isTrue,
      );
    });
  });

  test('props cover profileComplete, so an emission is not dropped', () {
    expect(
      const ProfileData(role: AccountRole.prestataire, profileComplete: true),
      isNot(const ProfileData(role: AccountRole.prestataire, profileComplete: false)),
    );
    expect(
      const ProfileData(logoObjectKey: 'a'),
      isNot(const ProfileData(logoObjectKey: 'b')),
    );
  });
}
