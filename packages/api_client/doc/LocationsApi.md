# api_client.api.LocationsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listCities**](LocationsApi.md#listcities) | **GET** /api/v1/locations/cities | List cities (optionally filtered by region)
[**listCountries**](LocationsApi.md#listcountries) | **GET** /api/v1/locations/countries | List countries
[**listDistricts**](LocationsApi.md#listdistricts) | **GET** /api/v1/locations/cities/{cityId}/districts | List a city&#39;s districts (quartiers)
[**listRegions**](LocationsApi.md#listregions) | **GET** /api/v1/locations/regions | List regions (optionally filtered by country)


# **listCities**
> BuiltList<LocationOption> listCities(regionId)

List cities (optionally filtered by region)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getLocationsApi();
final String regionId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listCities(regionId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LocationsApi->listCities: $e\n');
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
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listCountries**
> BuiltList<CountryResponse> listCountries()

List countries

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getLocationsApi();

try {
    final response = api.listCountries();
    print(response);
} on DioException catch (e) {
    print('Exception when calling LocationsApi->listCountries: $e\n');
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
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listDistricts**
> BuiltList<LocationOption> listDistricts(cityId)

List a city's districts (quartiers)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getLocationsApi();
final String cityId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listDistricts(cityId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LocationsApi->listDistricts: $e\n');
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
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listRegions**
> BuiltList<LocationOption> listRegions(countryId)

List regions (optionally filtered by country)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getLocationsApi();
final String countryId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listRegions(countryId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LocationsApi->listRegions: $e\n');
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
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

