# api_client.api.PrestataireProfileApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**changeType**](PrestataireProfileApi.md#changetype) | **POST** /api/v1/prestataires/me/type-change | Change the provider type — applied directly if eligible, else opens an admin request
[**myProfile1**](PrestataireProfileApi.md#myprofile1) | **GET** /api/v1/prestataires/me | Get the authenticated prestataire&#39;s profile
[**updateMyProfile1**](PrestataireProfileApi.md#updatemyprofile1) | **PATCH** /api/v1/prestataires/me | Partially update the authenticated prestataire&#39;s profile


# **changeType**
> TypeChangeResult changeType(requestTypeChangeRequest)

Change the provider type — applied directly if eligible, else opens an admin request

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPrestataireProfileApi();
final RequestTypeChangeRequest requestTypeChangeRequest = ; // RequestTypeChangeRequest | 

try {
    final response = api.changeType(requestTypeChangeRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PrestataireProfileApi->changeType: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestTypeChangeRequest** | [**RequestTypeChangeRequest**](RequestTypeChangeRequest.md)|  | 

### Return type

[**TypeChangeResult**](TypeChangeResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **myProfile1**
> PrestataireProfileResponse myProfile1()

Get the authenticated prestataire's profile

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPrestataireProfileApi();

try {
    final response = api.myProfile1();
    print(response);
} on DioException catch (e) {
    print('Exception when calling PrestataireProfileApi->myProfile1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**PrestataireProfileResponse**](PrestataireProfileResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMyProfile1**
> PrestataireProfileResponse updateMyProfile1(updatePrestataireProfileRequest)

Partially update the authenticated prestataire's profile

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPrestataireProfileApi();
final UpdatePrestataireProfileRequest updatePrestataireProfileRequest = ; // UpdatePrestataireProfileRequest | 

try {
    final response = api.updateMyProfile1(updatePrestataireProfileRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PrestataireProfileApi->updateMyProfile1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updatePrestataireProfileRequest** | [**UpdatePrestataireProfileRequest**](UpdatePrestataireProfileRequest.md)|  | 

### Return type

[**PrestataireProfileResponse**](PrestataireProfileResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

