# api_client.api.ResidencesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**archiveResidenceUnits**](ResidencesApi.md#archiveresidenceunits) | **POST** /api/v1/residences/{id}/archive | Archive all units at once
[**createResidence**](ResidencesApi.md#createresidence) | **POST** /api/v1/residences | Bulk-create a residence and its units (drafts)
[**deleteResidence**](ResidencesApi.md#deleteresidence) | **DELETE** /api/v1/residences/{id} | Delete a residence and all its units
[**getMyResidence**](ResidencesApi.md#getmyresidence) | **GET** /api/v1/residences/{id} | Get a residence with its units
[**listMyResidences**](ResidencesApi.md#listmyresidences) | **GET** /api/v1/residences | List the authenticated prestataire&#39;s residences
[**publishResidenceUnits**](ResidencesApi.md#publishresidenceunits) | **POST** /api/v1/residences/{id}/publish | Publish all draft units at once
[**rentResidenceUnits**](ResidencesApi.md#rentresidenceunits) | **POST** /api/v1/residences/{id}/rented | Mark all live units (published or reserved) as rented at once
[**reserveResidenceUnits**](ResidencesApi.md#reserveresidenceunits) | **POST** /api/v1/residences/{id}/reserve | Reserve all published units at once
[**unarchiveResidenceUnits**](ResidencesApi.md#unarchiveresidenceunits) | **POST** /api/v1/residences/{id}/unarchive | Return all archived units to draft so the residence can be published again (RM-M10-08)
[**updateResidence**](ResidencesApi.md#updateresidence) | **PATCH** /api/v1/residences/{id} | Update the residence&#39;s shared attributes (cascades to units)


# **archiveResidenceUnits**
> ResidenceResponse archiveResidenceUnits(id)

Archive all units at once

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.archiveResidenceUnits(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->archiveResidenceUnits: $e\n');
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

# **createResidence**
> ResidenceResponse createResidence(createResidenceRequest)

Bulk-create a residence and its units (drafts)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final CreateResidenceRequest createResidenceRequest = ; // CreateResidenceRequest | 

try {
    final response = api.createResidence(createResidenceRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->createResidence: $e\n');
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

# **deleteResidence**
> deleteResidence(id)

Delete a residence and all its units

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.deleteResidence(id);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->deleteResidence: $e\n');
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

# **getMyResidence**
> ResidenceResponse getMyResidence(id)

Get a residence with its units

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getMyResidence(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->getMyResidence: $e\n');
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

# **listMyResidences**
> PageResponseResidenceResponse listMyResidences(pageable)

List the authenticated prestataire's residences

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listMyResidences(pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->listMyResidences: $e\n');
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

# **publishResidenceUnits**
> ResidenceResponse publishResidenceUnits(id)

Publish all draft units at once

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.publishResidenceUnits(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->publishResidenceUnits: $e\n');
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

# **rentResidenceUnits**
> ResidenceResponse rentResidenceUnits(id)

Mark all live units (published or reserved) as rented at once

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.rentResidenceUnits(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->rentResidenceUnits: $e\n');
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

# **reserveResidenceUnits**
> ResidenceResponse reserveResidenceUnits(id)

Reserve all published units at once

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.reserveResidenceUnits(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->reserveResidenceUnits: $e\n');
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

# **unarchiveResidenceUnits**
> ResidenceResponse unarchiveResidenceUnits(id)

Return all archived units to draft so the residence can be published again (RM-M10-08)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.unarchiveResidenceUnits(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->unarchiveResidenceUnits: $e\n');
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

# **updateResidence**
> ResidenceResponse updateResidence(id, updateResidenceRequest)

Update the residence's shared attributes (cascades to units)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getResidencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateResidenceRequest updateResidenceRequest = ; // UpdateResidenceRequest | 

try {
    final response = api.updateResidence(id, updateResidenceRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResidencesApi->updateResidence: $e\n');
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

