import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

/// RM-M03-01 — every non-mandatory type can be switched off on its own.
void main() {
  late MockAppSettingsRepository repository;

  // The server's catalogue: one tenant opt-out already off, one of another
  // audience off too, a mandatory type and an admin alert.
  const catalogue = [
    NotificationPreference(code: 'N01', enabled: true),
    NotificationPreference(code: 'N05', enabled: false),
    NotificationPreference(code: 'N07', enabled: true, mandatory: true),
    NotificationPreference(code: 'N10', enabled: false),
    NotificationPreference(code: 'N13', enabled: true),
    NotificationPreference(code: 'N21', enabled: true),
  ];
  const tenantSees = [
    NotificationPreference(code: 'N01', enabled: true),
    NotificationPreference(code: 'N05', enabled: false),
    NotificationPreference(code: 'N21', enabled: true),
  ];

  NotificationPreferencesBloc build() =>
      NotificationPreferencesBloc(repository: repository, audience: NotificationAudience.tenant);

  DioException refused(String code) => DioException(
        requestOptions: RequestOptions(path: '/users/me/settings'),
        response: Response(
          requestOptions: RequestOptions(path: '/users/me/settings'),
          statusCode: 409,
          data: {'error': code},
        ),
      );

  setUp(() => repository = MockAppSettingsRepository());

  blocTest<NotificationPreferencesBloc, NotificationPreferencesState>(
    'a tenant is shown only what can reach a tenant, and can be switched off',
    setUp: () => when(() => repository.fetchNotifications()).thenAnswer((_) async => catalogue),
    build: build,
    act: (bloc) => bloc.add(const NotificationPreferencesRequested()),
    expect: () => [
      const NotificationPreferencesLoading(),
      const NotificationPreferencesReady(all: catalogue, visible: tenantSees),
    ],
  );

  blocTest<NotificationPreferencesBloc, NotificationPreferencesState>(
    'offline, it fails to a retry rather than to an empty list',
    setUp: () => when(() => repository.fetchNotifications()).thenThrow(Exception('offline')),
    build: build,
    act: (bloc) => bloc.add(const NotificationPreferencesRequested()),
    expect: () => [
      const NotificationPreferencesLoading(),
      const NotificationPreferencesFailure(),
    ],
  );

  group('switching one off', () {
    const afterSave = [
      NotificationPreference(code: 'N01', enabled: true),
      NotificationPreference(code: 'N05', enabled: false),
      NotificationPreference(code: 'N07', enabled: true, mandatory: true),
      NotificationPreference(code: 'N10', enabled: false),
      NotificationPreference(code: 'N13', enabled: true),
      NotificationPreference(code: 'N21', enabled: false),
    ];

    blocTest<NotificationPreferencesBloc, NotificationPreferencesState>(
      'moves at once, and keeps every other opt-out — shown here or not',
      setUp: () => when(() => repository.saveDisabledNotifications(any())).thenAnswer((_) async => afterSave),
      build: build,
      seed: () => const NotificationPreferencesReady(all: catalogue, visible: tenantSees),
      act: (bloc) => bloc.add(const NotificationPreferenceToggled('N21', enabled: false)),
      expect: () => [
        const NotificationPreferencesReady(
          all: afterSave,
          visible: [
            NotificationPreference(code: 'N01', enabled: true),
            NotificationPreference(code: 'N05', enabled: false),
            NotificationPreference(code: 'N21', enabled: false),
          ],
          savingCode: 'N21',
        ),
        const NotificationPreferencesReady(
          all: afterSave,
          visible: [
            NotificationPreference(code: 'N01', enabled: true),
            NotificationPreference(code: 'N05', enabled: false),
            NotificationPreference(code: 'N21', enabled: false),
          ],
        ),
      ],
      // N10 is a prestataire's and hidden here, but it is in the set: the set
      // replaces the stored one, and leaving it out would turn it back on.
      verify: (_) => verify(() => repository.saveDisabledNotifications({'N05', 'N10', 'N21'})).called(1),
    );

    blocTest<NotificationPreferencesBloc, NotificationPreferencesState>(
      'goes back, and says so, when the save fails',
      setUp: () => when(() => repository.saveDisabledNotifications(any())).thenThrow(Exception('offline')),
      build: build,
      seed: () => const NotificationPreferencesReady(all: catalogue, visible: tenantSees),
      act: (bloc) => bloc.add(const NotificationPreferenceToggled('N01', enabled: false)),
      skip: 1,
      expect: () => [
        const NotificationPreferencesReady(
          all: catalogue,
          visible: tenantSees,
          error: NotificationPreferencesError.saveFailed,
        ),
      ],
    );

    blocTest<NotificationPreferencesBloc, NotificationPreferencesState>(
      'a mandatory refusal is told apart from a failure',
      setUp: () => when(() => repository.saveDisabledNotifications(any()))
          .thenThrow(refused('NOTIFICATION_MANDATORY')),
      build: build,
      seed: () => const NotificationPreferencesReady(all: catalogue, visible: tenantSees),
      act: (bloc) => bloc.add(const NotificationPreferenceToggled('N01', enabled: false)),
      skip: 1,
      expect: () => [
        const NotificationPreferencesReady(
          all: catalogue,
          visible: tenantSees,
          error: NotificationPreferencesError.mandatory,
        ),
      ],
    );

    blocTest<NotificationPreferencesBloc, NotificationPreferencesState>(
      'one save at a time — a second flip while one is in flight is ignored',
      build: build,
      seed: () => const NotificationPreferencesReady(all: catalogue, visible: tenantSees, savingCode: 'N01'),
      act: (bloc) => bloc.add(const NotificationPreferenceToggled('N21', enabled: false)),
      expect: () => const <NotificationPreferencesState>[],
      verify: (_) => verifyNever(() => repository.saveDisabledNotifications(any())),
    );
  });

  test('each audience is shown its own switches, never a mandatory one', () {
    const all = [
      NotificationPreference(code: 'N02', enabled: true),
      NotificationPreference(code: 'N04', enabled: true),
      NotificationPreference(code: 'N10', enabled: true),
      NotificationPreference(code: 'N15', enabled: true),
      NotificationPreference(code: 'N16', enabled: true, mandatory: true),
    ];

    expect(
      NotificationPreference.visibleTo(NotificationAudience.agent, all).map((p) => p.code),
      ['N04', 'N15'],
    );
    expect(
      NotificationPreference.visibleTo(NotificationAudience.prestataire, all).map((p) => p.code),
      ['N02', 'N04', 'N10', 'N15'],
    );
    expect(NotificationPreference.visibleTo(NotificationAudience.tenant, all), isEmpty);
  });

  test('N-41 — the invitation to rate a tenant is the prestataire\'s to turn off', () {
    const all = [NotificationPreference(code: 'N41', enabled: true)];

    expect(NotificationPreference.visibleTo(NotificationAudience.prestataire, all).map((p) => p.code), ['N41']);
    expect(NotificationPreference.visibleTo(NotificationAudience.tenant, all), isEmpty);
  });
}
