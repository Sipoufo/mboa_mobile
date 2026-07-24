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

import 'package:api_client/src/model/auth_tokens.dart';
import 'package:api_client/src/model/create_upload_request.dart';
import 'package:api_client/src/model/kyc_review_item.dart';
import 'package:api_client/src/model/kyc_status_response.dart';
import 'package:api_client/src/model/login_otp_request.dart';
import 'package:api_client/src/model/login_request.dart';
import 'package:api_client/src/model/logout_request.dart';
import 'package:api_client/src/model/me_response.dart';
import 'package:api_client/src/model/page_response_kyc_review_item.dart';
import 'package:api_client/src/model/pageable.dart';
import 'package:api_client/src/model/presigned_upload.dart';
import 'package:api_client/src/model/refresh_token_request.dart';
import 'package:api_client/src/model/register_professional_request.dart';
import 'package:api_client/src/model/reject_kyc_request.dart';
import 'package:api_client/src/model/send_otp_request.dart';
import 'package:api_client/src/model/social_login_request.dart';
import 'package:api_client/src/model/submit_kyc_request.dart';
import 'package:api_client/src/model/verify_otp_request.dart';

part 'serializers.g.dart';

@SerializersFor([
  AuthTokens,
  CreateUploadRequest,
  KycReviewItem,
  KycStatusResponse,
  LoginOtpRequest,
  LoginRequest,
  LogoutRequest,
  MeResponse,
  PageResponseKycReviewItem,
  Pageable,
  PresignedUpload,
  RefreshTokenRequest,
  RegisterProfessionalRequest,
  RejectKycRequest,
  SendOtpRequest,
  SocialLoginRequest,
  SubmitKycRequest,
  VerifyOtpRequest,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(KycReviewItem)]),
        () => ListBuilder<KycReviewItem>(),
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
