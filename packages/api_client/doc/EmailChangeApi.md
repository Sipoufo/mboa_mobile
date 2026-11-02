# api_client.api.EmailChangeApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**confirmEmailChange**](EmailChangeApi.md#confirmemailchange) | **POST** /api/v1/account/email/verify | Step 2: verify the codes and switch the email
[**requestEmailChange**](EmailChangeApi.md#requestemailchange) | **POST** /api/v1/account/email/change | Step 1: codes to the new address and to the phone


# **confirmEmailChange**
> EmailChangeResponse confirmEmailChange(confirmEmailChangeRequest)

Step 2: verify the codes and switch the email

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmailChangeApi();
final ConfirmEmailChangeRequest confirmEmailChangeRequest = ; // ConfirmEmailChangeRequest | 

try {
    final response = api.confirmEmailChange(confirmEmailChangeRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EmailChangeApi->confirmEmailChange: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **confirmEmailChangeRequest** | [**ConfirmEmailChangeRequest**](ConfirmEmailChangeRequest.md)|  | 

### Return type

[**EmailChangeResponse**](EmailChangeResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **requestEmailChange**
> requestEmailChange(requestEmailChangeRequest)

Step 1: codes to the new address and to the phone

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmailChangeApi();
final RequestEmailChangeRequest requestEmailChangeRequest = ; // RequestEmailChangeRequest | 

try {
    api.requestEmailChange(requestEmailChangeRequest);
} on DioException catch (e) {
    print('Exception when calling EmailChangeApi->requestEmailChange: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestEmailChangeRequest** | [**RequestEmailChangeRequest**](RequestEmailChangeRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

