# api_client.api.PrestataireProfileApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getMyPrestataireProfile**](PrestataireProfileApi.md#getmyprestataireprofile) | **GET** /api/v1/prestataires/me | Get the authenticated prestataire&#39;s profile
[**requestPrestataireTypeChange**](PrestataireProfileApi.md#requestprestatairetypechange) | **POST** /api/v1/prestataires/me/type-change | Change the provider type — applied directly if eligible, else opens an admin request
[**updateMyPrestataireProfile**](PrestataireProfileApi.md#updatemyprestataireprofile) | **PATCH** /api/v1/prestataires/me | Partially update the authenticated prestataire&#39;s profile


# **getMyPrestataireProfile**
> PrestataireProfileResponse getMyPrestataireProfile()

Get the authenticated prestataire's profile

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPrestataireProfileApi();

try {
    final response = api.getMyPrestataireProfile();
    print(response);
} on DioException catch (e) {
    print('Exception when calling PrestataireProfileApi->getMyPrestataireProfile: $e\n');
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

# **requestPrestataireTypeChange**
> TypeChangeResult requestPrestataireTypeChange(requestTypeChangeRequest)

Change the provider type — applied directly if eligible, else opens an admin request

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPrestataireProfileApi();
final RequestTypeChangeRequest requestTypeChangeRequest = ; // RequestTypeChangeRequest | 

try {
    final response = api.requestPrestataireTypeChange(requestTypeChangeRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PrestataireProfileApi->requestPrestataireTypeChange: $e\n');
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

# **updateMyPrestataireProfile**
> PrestataireProfileResponse updateMyPrestataireProfile(updatePrestataireProfileRequest)

Partially update the authenticated prestataire's profile

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPrestataireProfileApi();
final UpdatePrestataireProfileRequest updatePrestataireProfileRequest = ; // UpdatePrestataireProfileRequest | 

try {
    final response = api.updateMyPrestataireProfile(updatePrestataireProfileRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PrestataireProfileApi->updateMyPrestataireProfile: $e\n');
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

