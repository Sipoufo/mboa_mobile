# api_client.api.UserSettingsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**mySettings**](UserSettingsApi.md#mysettings) | **GET** /api/v1/users/me/settings | Get the authenticated account&#39;s settings
[**updateMySettings**](UserSettingsApi.md#updatemysettings) | **PATCH** /api/v1/users/me/settings | Partially update the authenticated account&#39;s settings


# **mySettings**
> UserSettingsResponse mySettings()

Get the authenticated account's settings

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserSettingsApi();

try {
    final response = api.mySettings();
    print(response);
} on DioException catch (e) {
    print('Exception when calling UserSettingsApi->mySettings: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**UserSettingsResponse**](UserSettingsResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMySettings**
> UserSettingsResponse updateMySettings(updateUserSettingsRequest)

Partially update the authenticated account's settings

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserSettingsApi();
final UpdateUserSettingsRequest updateUserSettingsRequest = ; // UpdateUserSettingsRequest | 

try {
    final response = api.updateMySettings(updateUserSettingsRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UserSettingsApi->updateMySettings: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateUserSettingsRequest** | [**UpdateUserSettingsRequest**](UpdateUserSettingsRequest.md)|  | 

### Return type

[**UserSettingsResponse**](UserSettingsResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

