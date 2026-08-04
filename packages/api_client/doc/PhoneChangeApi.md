# api_client.api.PhoneChangeApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**confirmChange**](PhoneChangeApi.md#confirmchange) | **POST** /api/v1/account/phone/verify | Step 2: verify both codes and switch the number
[**requestChange**](PhoneChangeApi.md#requestchange) | **POST** /api/v1/account/phone/change | Step 1: request OTPs on the current and the new number


# **confirmChange**
> PhoneChangeResponse confirmChange(confirmPhoneChangeRequest)

Step 2: verify both codes and switch the number

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPhoneChangeApi();
final ConfirmPhoneChangeRequest confirmPhoneChangeRequest = ; // ConfirmPhoneChangeRequest | 

try {
    final response = api.confirmChange(confirmPhoneChangeRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PhoneChangeApi->confirmChange: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **confirmPhoneChangeRequest** | [**ConfirmPhoneChangeRequest**](ConfirmPhoneChangeRequest.md)|  | 

### Return type

[**PhoneChangeResponse**](PhoneChangeResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **requestChange**
> requestChange(requestPhoneChangeRequest)

Step 1: request OTPs on the current and the new number

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPhoneChangeApi();
final RequestPhoneChangeRequest requestPhoneChangeRequest = ; // RequestPhoneChangeRequest | 

try {
    api.requestChange(requestPhoneChangeRequest);
} on DioException catch (e) {
    print('Exception when calling PhoneChangeApi->requestChange: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestPhoneChangeRequest** | [**RequestPhoneChangeRequest**](RequestPhoneChangeRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

