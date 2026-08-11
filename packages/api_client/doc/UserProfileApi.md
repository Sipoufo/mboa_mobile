# api_client.api.UserProfileApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getMyUserProfile**](UserProfileApi.md#getmyuserprofile) | **GET** /api/v1/users/me | Get the authenticated user&#39;s profile
[**updateMyUserProfile**](UserProfileApi.md#updatemyuserprofile) | **PATCH** /api/v1/users/me | Partially update the authenticated user&#39;s profile


# **getMyUserProfile**
> UserProfileResponse getMyUserProfile()

Get the authenticated user's profile

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserProfileApi();

try {
    final response = api.getMyUserProfile();
    print(response);
} on DioException catch (e) {
    print('Exception when calling UserProfileApi->getMyUserProfile: $e\n');
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

# **updateMyUserProfile**
> UserProfileResponse updateMyUserProfile(updateUserProfileRequest)

Partially update the authenticated user's profile

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserProfileApi();
final UpdateUserProfileRequest updateUserProfileRequest = ; // UpdateUserProfileRequest | 

try {
    final response = api.updateMyUserProfile(updateUserProfileRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UserProfileApi->updateMyUserProfile: $e\n');
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

