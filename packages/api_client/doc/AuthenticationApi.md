# api_client.api.AuthenticationApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**login**](AuthenticationApi.md#login) | **POST** /api/v1/auth/login | Credential login step 1: verify email + password, sends an OTP second factor
[**logout**](AuthenticationApi.md#logout) | **POST** /api/v1/auth/logout | Revoke a refresh token (logout)
[**refresh**](AuthenticationApi.md#refresh) | **POST** /api/v1/auth/token/refresh | Exchange a refresh token for a new token pair
[**registerProfessional**](AuthenticationApi.md#registerprofessional) | **POST** /api/v1/auth/register/professional | Register a professional (AGENT or PRESTATAIRE); sends an OTP to verify the phone
[**requestOtp**](AuthenticationApi.md#requestotp) | **POST** /api/v1/auth/otp/request | Request an OTP for a phone number
[**socialLogin**](AuthenticationApi.md#sociallogin) | **POST** /api/v1/auth/social/login | Log in with a Google or Apple ID token
[**verifyLoginOtp**](AuthenticationApi.md#verifyloginotp) | **POST** /api/v1/auth/login/verify | Credential login step 2: verify the OTP and obtain access + refresh tokens
[**verifyOtp**](AuthenticationApi.md#verifyotp) | **POST** /api/v1/auth/otp/verify | Verify an OTP and obtain access + refresh tokens


# **login**
> login(loginRequest)

Credential login step 1: verify email + password, sends an OTP second factor

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthenticationApi();
final LoginRequest loginRequest = ; // LoginRequest | 

try {
    api.login(loginRequest);
} on DioException catch (e) {
    print('Exception when calling AuthenticationApi->login: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginRequest** | [**LoginRequest**](LoginRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **logout**
> logout(logoutRequest)

Revoke a refresh token (logout)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthenticationApi();
final LogoutRequest logoutRequest = ; // LogoutRequest | 

try {
    api.logout(logoutRequest);
} on DioException catch (e) {
    print('Exception when calling AuthenticationApi->logout: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **logoutRequest** | [**LogoutRequest**](LogoutRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refresh**
> AuthTokens refresh(refreshTokenRequest)

Exchange a refresh token for a new token pair

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthenticationApi();
final RefreshTokenRequest refreshTokenRequest = ; // RefreshTokenRequest | 

try {
    final response = api.refresh(refreshTokenRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthenticationApi->refresh: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshTokenRequest** | [**RefreshTokenRequest**](RefreshTokenRequest.md)|  | 

### Return type

[**AuthTokens**](AuthTokens.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **registerProfessional**
> registerProfessional(registerProfessionalRequest)

Register a professional (AGENT or PRESTATAIRE); sends an OTP to verify the phone

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthenticationApi();
final RegisterProfessionalRequest registerProfessionalRequest = ; // RegisterProfessionalRequest | 

try {
    api.registerProfessional(registerProfessionalRequest);
} on DioException catch (e) {
    print('Exception when calling AuthenticationApi->registerProfessional: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerProfessionalRequest** | [**RegisterProfessionalRequest**](RegisterProfessionalRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **requestOtp**
> requestOtp(sendOtpRequest)

Request an OTP for a phone number

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthenticationApi();
final SendOtpRequest sendOtpRequest = ; // SendOtpRequest | 

try {
    api.requestOtp(sendOtpRequest);
} on DioException catch (e) {
    print('Exception when calling AuthenticationApi->requestOtp: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendOtpRequest** | [**SendOtpRequest**](SendOtpRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **socialLogin**
> AuthTokens socialLogin(socialLoginRequest)

Log in with a Google or Apple ID token

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthenticationApi();
final SocialLoginRequest socialLoginRequest = ; // SocialLoginRequest | 

try {
    final response = api.socialLogin(socialLoginRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthenticationApi->socialLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **socialLoginRequest** | [**SocialLoginRequest**](SocialLoginRequest.md)|  | 

### Return type

[**AuthTokens**](AuthTokens.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **verifyLoginOtp**
> AuthTokens verifyLoginOtp(loginOtpRequest)

Credential login step 2: verify the OTP and obtain access + refresh tokens

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthenticationApi();
final LoginOtpRequest loginOtpRequest = ; // LoginOtpRequest | 

try {
    final response = api.verifyLoginOtp(loginOtpRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthenticationApi->verifyLoginOtp: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginOtpRequest** | [**LoginOtpRequest**](LoginOtpRequest.md)|  | 

### Return type

[**AuthTokens**](AuthTokens.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **verifyOtp**
> AuthTokens verifyOtp(verifyOtpRequest)

Verify an OTP and obtain access + refresh tokens

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthenticationApi();
final VerifyOtpRequest verifyOtpRequest = ; // VerifyOtpRequest | 

try {
    final response = api.verifyOtp(verifyOtpRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthenticationApi->verifyOtp: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **verifyOtpRequest** | [**VerifyOtpRequest**](VerifyOtpRequest.md)|  | 

### Return type

[**AuthTokens**](AuthTokens.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

