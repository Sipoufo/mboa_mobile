// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers =
    (Serializers().toBuilder()
          ..add(AuthTokens.serializer)
          ..add(CreateUploadRequest.serializer)
          ..add(CreateUploadRequestCategoryEnum.serializer)
          ..add(KycReviewItem.serializer)
          ..add(KycStatusResponse.serializer)
          ..add(LoginOtpRequest.serializer)
          ..add(LoginRequest.serializer)
          ..add(LogoutRequest.serializer)
          ..add(MeResponse.serializer)
          ..add(MeResponseAuthProviderEnum.serializer)
          ..add(MeResponseRoleEnum.serializer)
          ..add(MeResponseStatusEnum.serializer)
          ..add(PageResponseKycReviewItem.serializer)
          ..add(Pageable.serializer)
          ..add(PresignedUpload.serializer)
          ..add(RefreshTokenRequest.serializer)
          ..add(RegisterProfessionalRequest.serializer)
          ..add(RegisterProfessionalRequestRoleEnum.serializer)
          ..add(RejectKycRequest.serializer)
          ..add(SendOtpRequest.serializer)
          ..add(SocialLoginRequest.serializer)
          ..add(SocialLoginRequestProviderEnum.serializer)
          ..add(SubmitKycRequest.serializer)
          ..add(VerifyOtpRequest.serializer)
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(KycReviewItem)]),
            () => ListBuilder<KycReviewItem>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          ))
        .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
