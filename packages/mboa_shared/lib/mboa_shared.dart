/// Features shared identically by both Mboa apps.
library;

// Routing — guards + feature-access policy. The route tables stay app-local
// (the generated route classes live in each app's `app_router.gr.dart`).
export 'src/routing/access/access_context.dart';
export 'src/routing/access/access_decision.dart';
export 'src/routing/access/access_policy.dart';
export 'src/routing/access/feature_key.dart';
export 'src/routing/access/subscription_tier.dart';
export 'src/routing/guards/guest_guard.dart';
export 'src/routing/guards/session_guard.dart';
export 'src/routing/session_snapshot.dart';

// Notifications (M03) — FCM registration + payload intake, shared by both apps.
export 'src/features/notifications/data/notifications_repository.dart';
export 'src/features/notifications/models/push_message.dart';
export 'src/features/notifications/notifications_background.dart';

// Session resolution — shared startup auth check used by each app's splash.
export 'src/features/session/data/session_repository.dart';
export 'src/features/session/models/session_result.dart';
export 'src/features/session/session_module.dart';

// Settings / account — language, deletion (phone & password changes to follow).
export 'src/features/settings/data/account_repository.dart';
export 'src/features/settings/data/app_settings_repository.dart';
export 'src/features/settings/logic/change_password_cubit.dart';
export 'src/features/settings/logic/change_phone_bloc.dart';
export 'src/features/settings/logic/delete_account_cubit.dart';
export 'src/features/settings/logic/locale_controller.dart';
export 'src/features/settings/ui/change_password_view.dart';
export 'src/features/settings/ui/change_phone_view.dart';
export 'src/features/settings/ui/delete_account_view.dart';
export 'src/features/settings/ui/settings_menu_view.dart';

// Locations — cities catalogue + city picker (shared).
export 'src/features/location/data/location_repository.dart';
export 'src/features/location/models/city_option.dart';
export 'src/features/location/ui/city_picker_sheet.dart';

// Media — image capture/compression + R2 presigned upload (shared).
export 'src/features/media/capture_source_sheet.dart';
export 'src/features/media/media_uploader.dart';

// Profile / Settings base (M02) — shared base model, repository and bloc.
export 'src/features/profile/bloc/profile_bloc.dart';
export 'src/features/profile/data/base_profile_repository.dart';
export 'src/features/profile/data/profile_repository.dart';
export 'src/features/profile/models/account_role.dart';
export 'src/features/profile/models/base_profile.dart';

// Login flow (SMS OTP) — shared by App Mboa and App Mboa Pro.
export 'src/features/login/bloc/login_bloc.dart';
export 'src/features/login/data/login_repository.dart';
export 'src/features/login/login_flow_controller.dart';
export 'src/features/login/login_module.dart';
export 'src/features/login/models/otp_session.dart';
export 'src/features/welcome/ui/welcome_view.dart';
export 'src/features/login/ui/login_view.dart';
export 'src/features/login/ui/otp_view.dart';
