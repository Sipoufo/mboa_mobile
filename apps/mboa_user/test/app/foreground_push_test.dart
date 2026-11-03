import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/app/notifications_bootstrap.dart';
import 'package:mboa_user/app/router/app_router.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationsRepository extends Mock implements NotificationsRepository {}

class MockAppRouter extends Mock implements AppRouter {}

class MockKycCubit extends MockCubit<KycState> implements KycCubit {}

/// §40 E — a KYC decision that arrives with the app open: said in its colour,
/// and the KYC read again so the banner and the gates follow at once.
void main() {
  late MockNotificationsRepository notifications;
  late MockKycCubit kyc;
  late void Function(PushMessage) onForeground;

  setUp(() {
    notifications = MockNotificationsRepository();
    kyc = MockKycCubit();
    when(kyc.load).thenAnswer((_) async {});
    when(() => notifications.start(
          onForeground: any(named: 'onForeground'),
          onOpened: any(named: 'onOpened'),
        )).thenAnswer((call) async {
      onForeground = call.namedArguments[#onForeground] as void Function(PushMessage);
    });
    getIt
      ..registerSingleton<NotificationsRepository>(notifications)
      ..registerSingleton<KycCubit>(kyc);
  });

  tearDown(getIt.reset);

  testWidgets('« Compte refusé »: red, and the KYC read again', (tester) async {
    await tester.pumpWidget(MaterialApp(theme: MboaTheme.light(), home: const Scaffold(body: SizedBox())));
    final context = tester.element(find.byType(SizedBox));
    await startNotifications(router: MockAppRouter(), context: () => context);

    onForeground(const PushMessage(
      type: PushType.kyc,
      title: 'Compte refusé',
      code: 'N-12',
      outcome: NotificationOutcome.negative,
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    verify(kyc.load).called(1);
    expect(find.text('Compte refusé'), findsOneWidget);
    expect(find.byIcon(LucideIcons.circleX), findsOneWidget);

    await tester.pump(const Duration(seconds: 10));
    await tester.pumpAndSettle();
  });

  testWidgets('another notification leaves the KYC alone', (tester) async {
    await tester.pumpWidget(MaterialApp(theme: MboaTheme.light(), home: const Scaffold(body: SizedBox())));
    final context = tester.element(find.byType(SizedBox));
    await startNotifications(router: MockAppRouter(), context: () => context);

    onForeground(const PushMessage(type: PushType.message));
    await tester.pump();

    verifyNever(kyc.load);
  });
}
