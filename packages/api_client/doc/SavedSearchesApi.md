# api_client.api.SavedSearchesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteSavedSearch**](SavedSearchesApi.md#deletesavedsearch) | **DELETE** /api/v1/saved-searches/{id} | Forget a saved search
[**getSavedSearchResults**](SavedSearchesApi.md#getsavedsearchresults) | **GET** /api/v1/saved-searches/{id}/results | Run a saved search — the same cards as /search; resets its count of new results
[**listSavedSearches**](SavedSearchesApi.md#listsavedsearches) | **GET** /api/v1/saved-searches | My saved searches, each with its count of new results
[**saveSearch**](SavedSearchesApi.md#savesearch) | **POST** /api/v1/saved-searches | Keep a search — three at most; N-01 when new listings match (RM-M04-07)
[**updateSavedSearch**](SavedSearchesApi.md#updatesavedsearch) | **PATCH** /api/v1/saved-searches/{id} | Rename a saved search or switch its alerts


# **deleteSavedSearch**
> deleteSavedSearch(id)

Forget a saved search

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSavedSearchesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.deleteSavedSearch(id);
} on DioException catch (e) {
    print('Exception when calling SavedSearchesApi->deleteSavedSearch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSavedSearchResults**
> PageResponseSearchResult getSavedSearchResults(id, page, size)

Run a saved search — the same cards as /search; resets its count of new results

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSavedSearchesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getSavedSearchResults(id, page, size);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SavedSearchesApi->getSavedSearchResults: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
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

# **listSavedSearches**
> BuiltList<SavedSearchResponse> listSavedSearches()

My saved searches, each with its count of new results

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSavedSearchesApi();

try {
    final response = api.listSavedSearches();
    print(response);
} on DioException catch (e) {
    print('Exception when calling SavedSearchesApi->listSavedSearches: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;SavedSearchResponse&gt;**](SavedSearchResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **saveSearch**
> SavedSearchResponse saveSearch(saveSearchRequest)

Keep a search — three at most; N-01 when new listings match (RM-M04-07)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSavedSearchesApi();
final SaveSearchRequest saveSearchRequest = ; // SaveSearchRequest | 

try {
    final response = api.saveSearch(saveSearchRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SavedSearchesApi->saveSearch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **saveSearchRequest** | [**SaveSearchRequest**](SaveSearchRequest.md)|  | 

### Return type

[**SavedSearchResponse**](SavedSearchResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSavedSearch**
> SavedSearchResponse updateSavedSearch(id, updateSavedSearchRequest)

Rename a saved search or switch its alerts

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSavedSearchesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateSavedSearchRequest updateSavedSearchRequest = ; // UpdateSavedSearchRequest | 

try {
    final response = api.updateSavedSearch(id, updateSavedSearchRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SavedSearchesApi->updateSavedSearch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateSavedSearchRequest** | [**UpdateSavedSearchRequest**](UpdateSavedSearchRequest.md)|  | 

### Return type

[**SavedSearchResponse**](SavedSearchResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

