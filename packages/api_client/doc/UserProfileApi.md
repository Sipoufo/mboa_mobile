# api_client.api.UserProfileApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**myProfile**](UserProfileApi.md#myprofile) | **GET** /api/v1/users/me | Get the authenticated user&#39;s profile
[**updateMyProfile**](UserProfileApi.md#updatemyprofile) | **PATCH** /api/v1/users/me | Partially update the authenticated user&#39;s profile


# **myProfile**
> UserProfileResponse myProfile()

Get the authenticated user's profile

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserProfileApi();

try {
    final response = api.myProfile();
    print(response);
} on DioException catch (e) {
    print('Exception when calling UserProfileApi->myProfile: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**UserProfileResponse**](UserProfileResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMyProfile**
> UserProfileResponse updateMyProfile(updateUserProfileRequest)

Partially update the authenticated user's profile

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserProfileApi();
final UpdateUserProfileRequest updateUserProfileRequest = ; // UpdateUserProfileRequest | 

try {
    final response = api.updateMyProfile(updateUserProfileRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UserProfileApi->updateMyProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateUserProfileRequest** | [**UpdateUserProfileRequest**](UpdateUserProfileRequest.md)|  | 

### Return type

[**UserProfileResponse**](UserProfileResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

