# api_client.api.SearchApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**residenceDetail**](SearchApi.md#residencedetail) | **GET** /api/v1/search/residences/{id} | Public detail of a residence with its live units
[**search**](SearchApi.md#search) | **GET** /api/v1/search | Search listings and residences (city/district required; other filters cumulative)


# **residenceDetail**
> ResidenceDetailResponse residenceDetail(id)

Public detail of a residence with its live units

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSearchApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.residenceDetail(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SearchApi->residenceDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ResidenceDetailResponse**](ResidenceDetailResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **search**
> PageResponseSearchResult search(cityId, districtIds, propertyTypes, rentMin, rentMax, roomsMin, surfaceMin, surfaceMax, furnished, availableNow, page, size)

Search listings and residences (city/district required; other filters cumulative)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSearchApi();
final String cityId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BuiltList<String> districtIds = ; // BuiltList<String> | 
final BuiltList<String> propertyTypes = ; // BuiltList<String> | 
final int rentMin = 56; // int | 
final int rentMax = 56; // int | 
final int roomsMin = 56; // int | 
final int surfaceMin = 56; // int | 
final int surfaceMax = 56; // int | 
final bool furnished = true; // bool | 
final bool availableNow = true; // bool | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.search(cityId, districtIds, propertyTypes, rentMin, rentMax, roomsMin, surfaceMin, surfaceMax, furnished, availableNow, page, size);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SearchApi->search: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cityId** | **String**|  | [optional] 
 **districtIds** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 
 **propertyTypes** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 
 **rentMin** | **int**|  | [optional] 
 **rentMax** | **int**|  | [optional] 
 **roomsMin** | **int**|  | [optional] 
 **surfaceMin** | **int**|  | [optional] 
 **surfaceMax** | **int**|  | [optional] 
 **furnished** | **bool**|  | [optional] 
 **availableNow** | **bool**|  | [optional] 
 **page** | **int**|  | [optional] [default to 0]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**PageResponseSearchResult**](PageResponseSearchResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

