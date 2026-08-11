# api_client.api.SearchApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAgentPublicProfile**](SearchApi.md#getagentpublicprofile) | **GET** /api/v1/search/agents/{id} | Public profile of an Agent Mboa (M15)
[**getAnnonceDetail**](SearchApi.md#getannoncedetail) | **GET** /api/v1/search/annonces/{id} | Public fiche of a listing (M05)
[**getResidenceDetail**](SearchApi.md#getresidencedetail) | **GET** /api/v1/search/residences/{id} | Public detail of a residence with its live units
[**searchListings**](SearchApi.md#searchlistings) | **GET** /api/v1/search | Search listings and residences (city/district required; other filters cumulative)


# **getAgentPublicProfile**
> AgentPublicProfile getAgentPublicProfile(id)

Public profile of an Agent Mboa (M15)

Readable without an account, like a listing's fiche. Carries no phone number, no email and nothing from KYC. A suspended agent still resolves — they are named on every visit they carried out; only a deleted account is withheld.

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSearchApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getAgentPublicProfile(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SearchApi->getAgentPublicProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AgentPublicProfile**](AgentPublicProfile.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAnnonceDetail**
> AnnonceDetailResponse getAnnonceDetail(id, xDeviceId)

Public fiche of a listing (M05)

Readable without an account. The exact address is never returned and the coordinates are fuzzed by ~200m. Send X-Device-Id so anonymous views are counted once per device per 24h; signed-in views are counted by account.

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSearchApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String xDeviceId = xDeviceId_example; // String | 

try {
    final response = api.getAnnonceDetail(id, xDeviceId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SearchApi->getAnnonceDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xDeviceId** | **String**|  | [optional] 

### Return type

[**AnnonceDetailResponse**](AnnonceDetailResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getResidenceDetail**
> ResidenceDetailResponse getResidenceDetail(id)

Public detail of a residence with its live units

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSearchApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getResidenceDetail(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SearchApi->getResidenceDetail: $e\n');
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
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchListings**
> PageResponseSearchResult searchListings(cityId, districtIds, propertyTypes, rentalPeriods, rentMin, rentMax, roomsMin, surfaceMin, surfaceMax, furnished, availableNow, page, size)

Search listings and residences (city/district required; other filters cumulative)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSearchApi();
final String cityId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BuiltList<String> districtIds = ; // BuiltList<String> | 
final BuiltList<String> propertyTypes = ; // BuiltList<String> | 
final BuiltList<String> rentalPeriods = ; // BuiltList<String> | 
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
    final response = api.searchListings(cityId, districtIds, propertyTypes, rentalPeriods, rentMin, rentMax, roomsMin, surfaceMin, surfaceMax, furnished, availableNow, page, size);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SearchApi->searchListings: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cityId** | **String**|  | [optional] 
 **districtIds** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 
 **propertyTypes** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 
 **rentalPeriods** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 
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
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

