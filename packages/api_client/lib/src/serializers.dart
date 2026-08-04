//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:api_client/src/date_serializer.dart';
import 'package:api_client/src/model/date.dart';

import 'package:api_client/src/model/annonce_response.dart';
import 'package:api_client/src/model/auth_tokens.dart';
import 'package:api_client/src/model/change_password_request.dart';
import 'package:api_client/src/model/confirm_phone_change_request.dart';
import 'package:api_client/src/model/country_response.dart';
import 'package:api_client/src/model/create_annonce_request.dart';
import 'package:api_client/src/model/create_residence_request.dart';
import 'package:api_client/src/model/create_upload_request.dart';
import 'package:api_client/src/model/forgot_password_request.dart';
import 'package:api_client/src/model/kyc_review_item.dart';
import 'package:api_client/src/model/kyc_status_response.dart';
import 'package:api_client/src/model/location_option.dart';
import 'package:api_client/src/model/login_otp_request.dart';
import 'package:api_client/src/model/login_request.dart';
import 'package:api_client/src/model/logout_request.dart';
import 'package:api_client/src/model/me_response.dart';
import 'package:api_client/src/model/notification_setting.dart';
import 'package:api_client/src/model/page_response_annonce_response.dart';
import 'package:api_client/src/model/page_response_kyc_review_item.dart';
import 'package:api_client/src/model/page_response_residence_response.dart';
import 'package:api_client/src/model/page_response_search_result.dart';
import 'package:api_client/src/model/page_response_type_change_review_item.dart';
import 'package:api_client/src/model/pageable.dart';
import 'package:api_client/src/model/phone_change_response.dart';
import 'package:api_client/src/model/presigned_upload.dart';
import 'package:api_client/src/model/prestataire_profile_response.dart';
import 'package:api_client/src/model/refresh_token_request.dart';
import 'package:api_client/src/model/register_device_request.dart';
import 'package:api_client/src/model/register_professional_request.dart';
import 'package:api_client/src/model/reject_kyc_request.dart';
import 'package:api_client/src/model/reject_type_change_request.dart';
import 'package:api_client/src/model/request_phone_change_request.dart';
import 'package:api_client/src/model/request_type_change_request.dart';
import 'package:api_client/src/model/reset_password_request.dart';
import 'package:api_client/src/model/residence_detail_response.dart';
import 'package:api_client/src/model/residence_response.dart';
import 'package:api_client/src/model/residence_search_card.dart';
import 'package:api_client/src/model/search_result.dart';
import 'package:api_client/src/model/search_result_item.dart';
import 'package:api_client/src/model/send_otp_request.dart';
import 'package:api_client/src/model/social_login_request.dart';
import 'package:api_client/src/model/submit_kyc_request.dart';
import 'package:api_client/src/model/type_change_result.dart';
import 'package:api_client/src/model/type_change_review_item.dart';
import 'package:api_client/src/model/type_change_review_result.dart';
import 'package:api_client/src/model/type_count.dart';
import 'package:api_client/src/model/unit_group.dart';
import 'package:api_client/src/model/unit_summary.dart';
import 'package:api_client/src/model/update_annonce_request.dart';
import 'package:api_client/src/model/update_prestataire_profile_request.dart';
import 'package:api_client/src/model/update_residence_request.dart';
import 'package:api_client/src/model/update_user_profile_request.dart';
import 'package:api_client/src/model/update_user_settings_request.dart';
import 'package:api_client/src/model/user_profile_response.dart';
import 'package:api_client/src/model/user_settings_response.dart';
import 'package:api_client/src/model/verify_otp_request.dart';

part 'serializers.g.dart';

@SerializersFor([
  AnnonceResponse,
  AuthTokens,
  ChangePasswordRequest,
  ConfirmPhoneChangeRequest,
  CountryResponse,
  CreateAnnonceRequest,
  CreateResidenceRequest,
  CreateUploadRequest,
  ForgotPasswordRequest,
  KycReviewItem,
  KycStatusResponse,
  LocationOption,
  LoginOtpRequest,
  LoginRequest,
  LogoutRequest,
  MeResponse,
  NotificationSetting,
  PageResponseAnnonceResponse,
  PageResponseKycReviewItem,
  PageResponseResidenceResponse,
  PageResponseSearchResult,
  PageResponseTypeChangeReviewItem,
  Pageable,
  PhoneChangeResponse,
  PresignedUpload,
  PrestataireProfileResponse,
  RefreshTokenRequest,
  RegisterDeviceRequest,
  RegisterProfessionalRequest,
  RejectKycRequest,
  RejectTypeChangeRequest,
  RequestPhoneChangeRequest,
  RequestTypeChangeRequest,
  ResetPasswordRequest,
  ResidenceDetailResponse,
  ResidenceResponse,
  ResidenceSearchCard,
  SearchResult,
  SearchResultItem,
  SendOtpRequest,
  SocialLoginRequest,
  SubmitKycRequest,
  TypeChangeResult,
  TypeChangeReviewItem,
  TypeChangeReviewResult,
  TypeCount,
  UnitGroup,
  UnitSummary,
  UpdateAnnonceRequest,
  UpdatePrestataireProfileRequest,
  UpdateResidenceRequest,
  UpdateUserProfileRequest,
  UpdateUserSettingsRequest,
  UserProfileResponse,
  UserSettingsResponse,
  VerifyOtpRequest,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(UnitGroup)]),
        () => ListBuilder<UnitGroup>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltSet, [FullType(String)]),
        () => SetBuilder<String>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(NotificationSetting)]),
        () => ListBuilder<NotificationSetting>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(UnitSummary)]),
        () => ListBuilder<UnitSummary>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(KycReviewItem)]),
        () => ListBuilder<KycReviewItem>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(SearchResult)]),
        () => ListBuilder<SearchResult>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AnnonceResponse)]),
        () => ListBuilder<AnnonceResponse>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(LocationOption)]),
        () => ListBuilder<LocationOption>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TypeChangeReviewItem)]),
        () => ListBuilder<TypeChangeReviewItem>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TypeCount)]),
        () => ListBuilder<TypeCount>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(CountryResponse)]),
        () => ListBuilder<CountryResponse>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(SearchResultItem)]),
        () => ListBuilder<SearchResultItem>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ResidenceResponse)]),
        () => ListBuilder<ResidenceResponse>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(String)]),
        () => ListBuilder<String>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
