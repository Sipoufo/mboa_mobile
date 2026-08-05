# api_client.api.NotificationDevicesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**register**](NotificationDevicesApi.md#register) | **POST** /api/v1/notifications/devices | Register or refresh a device push token
[**unregister**](NotificationDevicesApi.md#unregister) | **DELETE** /api/v1/notifications/devices/{token} | Unregister a device push token


# **register**
> register(registerDeviceRequest)

Register or refresh a device push token

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationDevicesApi();
final RegisterDeviceRequest registerDeviceRequest = ; // RegisterDeviceRequest | 

try {
    api.register(registerDeviceRequest);
} on DioException catch (e) {
    print('Exception when calling NotificationDevicesApi->register: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerDeviceRequest** | [**RegisterDeviceRequest**](RegisterDeviceRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unregister**
> unregister(token)

Unregister a device push token

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationDevicesApi();
final String token = token_example; // String | 

try {
    api.unregister(token);
} on DioException catch (e) {
    print('Exception when calling NotificationDevicesApi->unregister: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

