# api_client.api.LocationsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**cities**](LocationsApi.md#cities) | **GET** /api/v1/locations/cities | List cities (optionally filtered by region)
[**countries**](LocationsApi.md#countries) | **GET** /api/v1/locations/countries | List countries
[**districts**](LocationsApi.md#districts) | **GET** /api/v1/locations/cities/{cityId}/districts | List a city&#39;s districts (quartiers)
[**regions**](LocationsApi.md#regions) | **GET** /api/v1/locations/regions | List regions (optionally filtered by country)


# **cities**
> BuiltList<LocationOption> cities(regionId)

List cities (optionally filtered by region)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getLocationsApi();
final String regionId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.cities(regionId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LocationsApi->cities: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **regionId** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;LocationOption&gt;**](LocationOption.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **countries**
> BuiltList<CountryResponse> countries()

List countries

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getLocationsApi();

try {
    final response = api.countries();
    print(response);
} on DioException catch (e) {
    print('Exception when calling LocationsApi->countries: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;CountryResponse&gt;**](CountryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **districts**
> BuiltList<LocationOption> districts(cityId)

List a city's districts (quartiers)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getLocationsApi();
final String cityId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.districts(cityId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LocationsApi->districts: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cityId** | **String**|  | 

### Return type

[**BuiltList&lt;LocationOption&gt;**](LocationOption.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **regions**
> BuiltList<LocationOption> regions(countryId)

List regions (optionally filtered by country)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getLocationsApi();
final String countryId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.regions(countryId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LocationsApi->regions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **countryId** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;LocationOption&gt;**](LocationOption.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

