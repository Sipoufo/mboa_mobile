import 'package:flutter/widgets.dart';

import 'models/otp_session.dart';

/// Bridges the shared login screens to each app's own navigation and session
/// handling. auto_route route tables live in the apps, so the shared UI must
/// not reference app routes directly — it delegates through this interface.
///
/// Each app provides an implementation and registers it in `get_it`; the shared
/// screens resolve it via `getIt<LoginFlowController>()`.
abstract class LoginFlowController {
  /// Advance from the phone screen to the OTP screen for [session].
  void openOtp(BuildContext context, OtpSession session);

  /// Tokens are persisted — promote the session and leave the login flow
  /// (typically: dispatch a session event on the app's AuthBloc / go home).
  void onLoginSuccess(BuildContext context);
}
