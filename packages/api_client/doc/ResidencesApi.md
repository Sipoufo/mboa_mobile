# api_client.api.ResidencesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**archiveAll**](ResidencesApi.md#archiveall) | **POST** /api/v1/residences/{id}/archive | Archive all units at once
[**create**](ResidencesApi.md#create) | **POST** /api/v1/residences | Bulk-create a residence and its units (drafts)
[**delete**](ResidencesApi.md#delete) | **DELETE** /api/v1/residences/{id} | Delete a residence and all its units
[**getOne**](ResidencesApi.md#getone) | **GET** /api/v1/residences/{id} | Get a residence with its units
[**listMine**](ResidencesApi.md#listmine) | **GET** /api/v1/residences | List the authenticated prestataire&#39;s residences
[**publishAll**](ResidencesApi.md#publishall) | **POST** /api/v1/residences/{id}/publish | Publish all draft units at once
[**rentAll**](ResidencesApi.md#rentall) | **POST** /api/v1/residences/{id}/rented | Mark all live units (published or reserved) as rented at once
[**reserveAll**](ResidencesApi.md#reserveall) | **POST** /api/v1/residences/{id}/reserve | Reserve all published units at once
[**unarchiveAll**](ResidencesApi.md#unarchiveall) | **POST** /api/v1/residences/{id}/unarchive | Return all archived units to draft so the residence can be published again (RM-M10-08)
[**update**](ResidencesApi.md#update) | **PATCH** /api/v1/residences/{id} | Update the residence&#39;s shared attributes (cascades to units)


# **archiveAll**
> ResidenceResponse archiveAll(id)

Archive all units at once

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.archiveAll(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->archiveAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ResidenceResponse**](ResidenceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **create**
> ResidenceResponse create(createResidenceRequest)

Bulk-create a residence and its units (drafts)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final CreateResidenceRequest createResidenceRequest = ; // CreateResidenceRequest | 

try {
    final response = api.create(createResidenceRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->create: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createResidenceRequest** | [**CreateResidenceRequest**](CreateResidenceRequest.md)|  | 

### Return type

[**ResidenceResponse**](ResidenceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **delete**
> delete(id)

Delete a residence and all its units

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.delete(id);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->delete: $e\n');
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

# **getOne**
> ResidenceResponse getOne(id)

Get a residence with its units

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getOne(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->getOne: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ResidenceResponse**](ResidenceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMine**
> PageResponseResidenceResponse listMine(pageable)

List the authenticated prestataire's residences

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listMine(pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->listMine: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseResidenceResponse**](PageResponseResidenceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publishAll**
> ResidenceResponse publishAll(id)

Publish all draft units at once

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.publishAll(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->publishAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ResidenceResponse**](ResidenceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rentAll**
> ResidenceResponse rentAll(id)

Mark all live units (published or reserved) as rented at once

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.rentAll(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->rentAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ResidenceResponse**](ResidenceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reserveAll**
> ResidenceResponse reserveAll(id)

Reserve all published units at once

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.reserveAll(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->reserveAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ResidenceResponse**](ResidenceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unarchiveAll**
> ResidenceResponse unarchiveAll(id)

Return all archived units to draft so the residence can be published again (RM-M10-08)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.unarchiveAll(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->unarchiveAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ResidenceResponse**](ResidenceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **update**
> ResidenceResponse update(id, updateResidenceRequest)

Update the residence's shared attributes (cascades to units)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateResidenceRequest updateResidenceRequest = ; // UpdateResidenceRequest | 

try {
    final response = api.update(id, updateResidenceRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->update: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateResidenceRequest** | [**UpdateResidenceRequest**](UpdateResidenceRequest.md)|  | 

### Return type

[**ResidenceResponse**](ResidenceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

