# api_client.api.NotificationDevicesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**registerDevice**](NotificationDevicesApi.md#registerdevice) | **POST** /api/v1/notifications/devices | Register or refresh a device push token
[**unregisterDevice**](NotificationDevicesApi.md#unregisterdevice) | **DELETE** /api/v1/notifications/devices/{token} | Unregister a device push token


# **registerDevice**
> registerDevice(registerDeviceRequest)

Register or refresh a device push token

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationDevicesApi();
final RegisterDeviceRequest registerDeviceRequest = ; // RegisterDeviceRequest | 

try {
    api.registerDevice(registerDeviceRequest);
} on DioException catch (e) {
    print('Exception when calling NotificationDevicesApi->registerDevice: $e\n');
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

# **unregisterDevice**
> unregisterDevice(token)

Unregister a device push token

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationDevicesApi();
final String token = token_example; // String | 

try {
    api.unregisterDevice(token);
} on DioException catch (e) {
    print('Exception when calling NotificationDevicesApi->unregisterDevice: $e\n');
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

