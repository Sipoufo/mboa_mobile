/// Features shared identically by both Mboa apps.
library;

// Session resolution — shared startup auth check used by each app's splash.
export 'src/features/session/data/session_repository.dart';
export 'src/features/session/models/session_result.dart';
export 'src/features/session/session_module.dart';

// Login flow (SMS OTP) — shared by App Mboa and App Mboa Pro.
export 'src/features/login/bloc/login_bloc.dart';
export 'src/features/login/data/login_repository.dart';
export 'src/features/login/login_flow_controller.dart';
export 'src/features/login/login_module.dart';
export 'src/features/login/models/otp_session.dart';
export 'src/features/login/ui/login_view.dart';
export 'src/features/login/ui/otp_view.dart';
