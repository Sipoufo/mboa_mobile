import 'package:bloc/bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// A global [BlocObserver] that leaves Sentry breadcrumbs for every state
/// transition and reports uncaught BLoC errors. Wire it in `main()` via
/// `Bloc.observer = SentryBlocObserver();`.
class SentryBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    Sentry.addBreadcrumb(
      Breadcrumb(
        category: 'bloc',
        type: 'state',
        message: '${bloc.runtimeType}: '
            '${transition.currentState.runtimeType} → ${transition.nextState.runtimeType}',
        level: SentryLevel.info,
      ),
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    Sentry.captureException(
      error,
      stackTrace: stackTrace,
      withScope: (scope) => scope.setTag('bloc', bloc.runtimeType.toString()),
    );
    super.onError(bloc, error, stackTrace);
  }
}
