import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/app/di/app_module.dart';
import 'package:mboa_user/features/favorites/bloc/favorites_bloc.dart';
import 'package:mboa_user/features/history/bloc/history_bloc.dart';
import 'package:mboa_user/features/my_home/bloc/my_homes_bloc.dart';
import 'package:mboa_user/features/profile/profile_types.dart';
import 'package:mboa_user/features/saved_searches/bloc/saved_searches_bloc.dart';
import 'package:mboa_user/features/shell/ui/user_shell_page.dart';
import 'package:mboa_user/features/visits/bloc/my_visits_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState> implements FavoritesBloc {}

class MockConversationsBloc extends MockBloc<ConversationsEvent, ConversationsState> implements ConversationsBloc {}

class MockSavedSearchesBloc extends MockBloc<SavedSearchesEvent, SavedSearchesState>
    implements SavedSearchesBloc {}

class MockMyVisitsBloc extends Mock implements MyVisitsBloc {}

class MockMyHomesBloc extends Mock implements MyHomesBloc {}

class MockHistoryBloc extends Mock implements HistoryBloc {}

class MockUserProfileBloc extends Mock implements UserProfileBloc {}

class MockInboxBloc extends Mock implements InboxBloc {}

class MockKycCubit extends Mock implements KycCubit {}

/// **Signing in or out lands on the same shell — it has to start over.**
///
/// The shell route is reused across the transition, so nothing redrew it: its
/// providers kept handing down the blocs the sign-out had just closed, and each
/// tab kept what it had read once — the greeting and its avatar, the rent
/// banner, the results of a search made as someone else.
void main() {
  /// A fresh mock per creation, closable, the way get_it's lazy singletons
  /// are rebuilt after a reset.
  T fresh<T extends Object>(T Function() make) {
    final bloc = make();
    when(() => (bloc as dynamic).close()).thenAnswer((_) async {});
    return bloc;
  }

  setUp(() {
    getIt
      ..registerSingleton<SessionSnapshot>(SessionSnapshot()..markAuthenticated())
      ..registerLazySingleton<FavoritesBloc>(() => fresh(MockFavoritesBloc.new))
      ..registerLazySingleton<ConversationsBloc>(() => fresh(MockConversationsBloc.new))
      ..registerLazySingleton<SavedSearchesBloc>(() => fresh(MockSavedSearchesBloc.new))
      ..registerLazySingleton<MyVisitsBloc>(() => fresh(MockMyVisitsBloc.new))
      ..registerLazySingleton<MyHomesBloc>(() => fresh(MockMyHomesBloc.new))
      ..registerLazySingleton<HistoryBloc>(() => fresh(MockHistoryBloc.new))
      ..registerLazySingleton<UserProfileBloc>(() => fresh(MockUserProfileBloc.new))
      ..registerLazySingleton<InboxBloc>(() => fresh(MockInboxBloc.new))
      ..registerLazySingleton<KycCubit>(() => fresh(MockKycCubit.new));
  });

  tearDown(getIt.reset);

  group('SessionScope', () {
    testWidgets('a session change starts the tabs over, on the blocs get_it holds now', (tester) async {
      final seen = <FavoritesBloc>[];
      var starts = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: SessionScope(
            child: _Probe(onStart: (context) {
              starts++;
              seen.add(context.read<FavoritesBloc>());
            }),
          ),
        ),
      );
      expect(starts, 1);

      await endSession();
      await tester.pump();

      // Started again — a tab that only read the session in initState now
      // reads it afresh — and handed the new account's bloc, not the closed one.
      expect(starts, 2);
      expect(seen.last, isNot(same(seen.first)));
      expect(seen.last, same(getIt<FavoritesBloc>()));
    });
  });

  group('endSession', () {
    test('drops every account bloc, and only then flips the session', () async {
      final before = {
        'favourites': getIt<FavoritesBloc>(),
        'profile': getIt<UserProfileBloc>(),
        'homes': getIt<MyHomesBloc>(),
      };
      final atFlip = <String, Object>{};
      getIt<SessionSnapshot>().addListener(() {
        atFlip['favourites'] = getIt<FavoritesBloc>();
        atFlip['profile'] = getIt<UserProfileBloc>();
        atFlip['homes'] = getIt<MyHomesBloc>();
      });

      await endSession();

      expect(getIt<SessionSnapshot>().hasSession, isFalse);
      // Whatever rebuilds on the flip reads fresh instances: the last
      // account's rent, hearts and name are gone by then.
      for (final name in before.keys) {
        expect(atFlip[name], isNot(same(before[name])), reason: name);
      }
      verify(() => (before['favourites']! as FavoritesBloc).close()).called(1);
      verify(() => (before['profile']! as UserProfileBloc).close()).called(1);
    });
  });
}

class _Probe extends StatefulWidget {
  const _Probe({required this.onStart});

  final void Function(BuildContext context) onStart;

  @override
  State<_Probe> createState() => _ProbeState();
}

class _ProbeState extends State<_Probe> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_started) {
      _started = true;
      widget.onStart(context);
    }
  }

  bool _started = false;

  @override
  Widget build(BuildContext context) => const SizedBox();
}
