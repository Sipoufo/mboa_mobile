# api_client.api.PasswordApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**changePassword**](PasswordApi.md#changepassword) | **POST** /api/v1/account/password | Change the password (revokes other sessions)


# **changePassword**
> changePassword(changePasswordRequest)

Change the password (revokes other sessions)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPasswordApi();
final ChangePasswordRequest changePasswordRequest = ; // ChangePasswordRequest | 

try {
    api.changePassword(changePasswordRequest);
} on DioException catch (e) {
    print('Exception when calling PasswordApi->changePassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changePasswordRequest** | [**ChangePasswordRequest**](ChangePasswordRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

