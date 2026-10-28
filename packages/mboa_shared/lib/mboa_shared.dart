/// Features shared identically by both Mboa apps.
library;

// API error parsing — the spec documents no error schema, so this is defensive.
export 'src/api/api_error.dart';
export 'src/api/otp_guard.dart';

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
export 'src/features/notifications/bloc/inbox_bloc.dart';
export 'src/features/notifications/data/inbox_repository.dart';
export 'src/features/notifications/data/notifications_repository.dart';
export 'src/features/notifications/models/inbox_item.dart';
export 'src/features/notifications/models/push_message.dart';
export 'src/features/notifications/notifications_background.dart';
export 'src/features/notifications/ui/notification_bell.dart';
export 'src/features/notifications/ui/notifications_view.dart';

// Contracts (M08) — the same endpoints serve both parties, so the model and
// the repository are shared; each app builds its own screens on top.
export 'src/features/contracts/bloc/contract_detail_bloc.dart';
export 'src/features/moderation/bloc/report_cubit.dart';
export 'src/features/moderation/data/report_repository.dart';
export 'src/features/moderation/models/report_target.dart';
export 'src/features/moderation/ui/report_sheet.dart';
export 'src/features/contracts/bloc/resident_reply_bloc.dart';
export 'src/features/contracts/bloc/resident_review_bloc.dart';
export 'src/features/contracts/bloc/contracts_bloc.dart';
export 'src/features/contracts/data/contract_repository.dart';
export 'src/features/contracts/data/resident_review_repository.dart';
export 'src/features/contracts/ui/contract_detail_view.dart';
export 'src/features/contracts/ui/resident_reply_view.dart';
export 'src/features/contracts/ui/resident_review_view.dart';
export 'src/features/contracts/ui/contracts_list_view.dart';
export 'src/features/contracts/ui/widgets/contract_bits.dart';
export 'src/features/contracts/ui/widgets/tenant_rating_bits.dart';
export 'src/features/contracts/ui/widgets/termination_bits.dart';
export 'src/features/contracts/models/contract.dart';

// Messaging (M12) — both apps call the same endpoints; only the entry points
// differ, since the tenant has the first word (RM-M12-01).
export 'src/features/messaging/bloc/conversations_bloc.dart';
export 'src/features/messaging/bloc/thread_bloc.dart';
export 'src/features/messaging/data/messaging_repository.dart';
export 'src/features/messaging/models/conversation.dart';
export 'src/features/messaging/ui/conversations_view.dart';
export 'src/features/messaging/ui/thread_view.dart';

// Listings — the rent's period (RM-M10-09), read by the listing form, the
// contract (RM-M08-08) and, later, the client app's search brackets.
export 'src/features/listings/models/amenity.dart';
export 'src/features/listings/models/listing_detail.dart';
export 'src/features/listings/models/property_review.dart';
export 'src/features/listings/models/property_type.dart';
export 'src/features/listings/models/rental_period.dart';
export 'src/features/listings/models/search_hit.dart';
export 'src/features/listings/models/search_query.dart';

// Visits (M07 / M16) — the list model both apps read; the client, the agent and
// the prestataire visiting his own property are served the same DTO.
export 'src/features/visits/bloc/visits_agenda_bloc.dart';
export 'src/features/visits/data/review_pdf_exporter.dart';
export 'src/features/visits/data/visit_review_repository.dart';
export 'src/features/visits/data/visits_source.dart';
export 'src/features/visits/models/visit.dart';
export 'src/features/visits/models/visit_review.dart';
export 'src/features/visits/ui/visits_agenda_view.dart';

// Session resolution — shared startup auth check used by each app's splash.
export 'src/features/session/data/session_repository.dart';
export 'src/features/session/models/session_result.dart';
export 'src/features/session/session_module.dart';

// Settings / account — language, deletion (phone & password changes to follow).
export 'src/features/homes/bloc/declaration_bloc.dart';
export 'src/features/homes/bloc/evidence_bloc.dart';
export 'src/features/homes/bloc/home_request_bloc.dart';
export 'src/features/homes/bloc/home_requests_bloc.dart';
export 'src/features/homes/bloc/home_space_bloc.dart';
export 'src/features/homes/bloc/evidence_compare_bloc.dart';
export 'src/features/homes/data/contacts_repository.dart';
export 'src/features/homes/data/evidence_repository.dart';
export 'src/features/homes/data/home_requests_repository.dart';
export 'src/features/homes/data/homes_repository.dart';
export 'src/features/homes/data/past_homes_repository.dart';
export 'src/features/homes/models/home.dart';
export 'src/features/homes/models/evidence.dart';
export 'src/features/homes/models/home_request.dart';
export 'src/features/homes/models/past_home.dart';
export 'src/features/homes/models/useful_contact.dart';
export 'src/features/homes/ui/declaration_view.dart';
export 'src/features/homes/ui/evidence_compare_view.dart';
export 'src/features/homes/ui/home_bits.dart';
export 'src/features/homes/ui/invoice_bits.dart';
export 'src/features/homes/ui/evidence_view.dart';
export 'src/features/homes/ui/home_card.dart';
export 'src/features/homes/ui/home_requests_view.dart';
export 'src/features/homes/ui/home_space_view.dart';
export 'src/features/reservations/models/reservation.dart';
export 'src/features/reservations/ui/reservation_bits.dart';
export 'src/features/score/bloc/mboa_score_bloc.dart';
export 'src/features/score/data/mboa_score_repository.dart';
export 'src/features/score/models/mboa_score.dart';
export 'src/features/score/ui/mboa_score_view.dart';
export 'src/features/settings/data/account_repository.dart';
export 'src/features/settings/data/app_settings_repository.dart';
export 'src/features/settings/logic/change_password_cubit.dart';
export 'src/features/settings/logic/change_phone_bloc.dart';
export 'src/features/settings/logic/delete_account_cubit.dart';
export 'src/features/settings/logic/locale_controller.dart';
export 'src/features/settings/logic/notification_preferences_bloc.dart';
export 'src/features/settings/models/notification_preference.dart';
export 'src/features/settings/ui/change_password_view.dart';
export 'src/features/settings/ui/change_phone_view.dart';
export 'src/features/settings/ui/delete_account_view.dart';
export 'src/features/settings/ui/notification_preferences_view.dart';
export 'src/features/settings/ui/settings_menu_view.dart';

// Locations — cities catalogue + city picker (shared).
export 'src/features/kyc/data/kyc_repository.dart';
export 'src/features/kyc/logic/kyc_cubit.dart';
export 'src/features/kyc/models/document_identity.dart';
export 'src/features/kyc/models/kyc_draft.dart';
export 'src/features/kyc/models/kyc_status.dart';
export 'src/features/kyc/ui/certifications_view.dart';
export 'src/features/kyc/ui/document_identity_fields.dart';
export 'src/features/kyc/ui/id_document_view.dart';
export 'src/features/kyc/ui/kyc_declarations.dart';
export 'src/features/location/data/location_repository.dart';
export 'src/features/location/models/city_option.dart';
export 'src/features/location/ui/city_picker_sheet.dart';
export 'src/features/location/ui/option_picker_sheet.dart';

// Media — image capture/compression + R2 presigned upload (shared).
export 'src/features/media/capture_source_sheet.dart';
export 'src/features/media/media_uploader.dart';
export 'src/features/media/pdf_sharer.dart';
export 'src/features/media/photo_preparer.dart';

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
