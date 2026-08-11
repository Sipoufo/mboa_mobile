# api_client.api.AnnoncesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**archiveAnnonce**](AnnoncesApi.md#archiveannonce) | **POST** /api/v1/annonces/{id}/archive | Archive a listing
[**createAnnonce**](AnnoncesApi.md#createannonce) | **POST** /api/v1/annonces | Create a listing (draft)
[**deleteAnnonce**](AnnoncesApi.md#deleteannonce) | **DELETE** /api/v1/annonces/{id} | Delete one of the authenticated prestataire&#39;s listings
[**getMyAnnonce**](AnnoncesApi.md#getmyannonce) | **GET** /api/v1/annonces/{id} | Get one of the authenticated prestataire&#39;s listings
[**listMyAnnonces**](AnnoncesApi.md#listmyannonces) | **GET** /api/v1/annonces | The prestataire&#39;s standalone listings; residence units are managed under /residences
[**markAnnonceRented**](AnnoncesApi.md#markannoncerented) | **POST** /api/v1/annonces/{id}/rented | Mark a published or reserved listing as rented
[**publishAnnonce**](AnnoncesApi.md#publishannonce) | **POST** /api/v1/annonces/{id}/publish | Publish a draft listing (profile complete + ≥3 photos + tier limit)
[**reserveAnnonce**](AnnoncesApi.md#reserveannonce) | **POST** /api/v1/annonces/{id}/reserve | Reserve a published listing (temporary hold)
[**unarchiveAnnonce**](AnnoncesApi.md#unarchiveannonce) | **POST** /api/v1/annonces/{id}/unarchive | Return an archived listing to draft so it can be published again (RM-M10-08)
[**updateAnnonce**](AnnoncesApi.md#updateannonce) | **PATCH** /api/v1/annonces/{id} | Partially update one of the authenticated prestataire&#39;s listings


# **archiveAnnonce**
> AnnonceResponse archiveAnnonce(id)

Archive a listing

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.archiveAnnonce(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->archiveAnnonce: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AnnonceResponse**](AnnonceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createAnnonce**
> AnnonceResponse createAnnonce(createAnnonceRequest)

Create a listing (draft)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final CreateAnnonceRequest createAnnonceRequest = ; // CreateAnnonceRequest | 

try {
    final response = api.createAnnonce(createAnnonceRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->createAnnonce: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createAnnonceRequest** | [**CreateAnnonceRequest**](CreateAnnonceRequest.md)|  | 

### Return type

[**AnnonceResponse**](AnnonceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteAnnonce**
> deleteAnnonce(id)

Delete one of the authenticated prestataire's listings

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.deleteAnnonce(id);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->deleteAnnonce: $e\n');
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

# **getMyAnnonce**
> AnnonceResponse getMyAnnonce(id)

Get one of the authenticated prestataire's listings

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getMyAnnonce(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->getMyAnnonce: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AnnonceResponse**](AnnonceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyAnnonces**
> PageResponseAnnonceResponse listMyAnnonces(pageable, includeResidenceUnits, residenceId)

The prestataire's standalone listings; residence units are managed under /residences

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final Pageable pageable = ; // Pageable | 
final bool includeResidenceUnits = true; // bool | 
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listMyAnnonces(pageable, includeResidenceUnits, residenceId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->listMyAnnonces: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **includeResidenceUnits** | **bool**|  | [optional] [default to false]
 **residenceId** | **String**|  | [optional] 

### Return type

[**PageResponseAnnonceResponse**](PageResponseAnnonceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markAnnonceRented**
> AnnonceResponse markAnnonceRented(id)

Mark a published or reserved listing as rented

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.markAnnonceRented(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->markAnnonceRented: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AnnonceResponse**](AnnonceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publishAnnonce**
> AnnonceResponse publishAnnonce(id)

Publish a draft listing (profile complete + ≥3 photos + tier limit)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.publishAnnonce(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->publishAnnonce: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AnnonceResponse**](AnnonceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reserveAnnonce**
> AnnonceResponse reserveAnnonce(id)

Reserve a published listing (temporary hold)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.reserveAnnonce(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->reserveAnnonce: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AnnonceResponse**](AnnonceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unarchiveAnnonce**
> AnnonceResponse unarchiveAnnonce(id)

Return an archived listing to draft so it can be published again (RM-M10-08)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.unarchiveAnnonce(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->unarchiveAnnonce: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AnnonceResponse**](AnnonceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateAnnonce**
> AnnonceResponse updateAnnonce(id, updateAnnonceRequest)

Partially update one of the authenticated prestataire's listings

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateAnnonceRequest updateAnnonceRequest = ; // UpdateAnnonceRequest | 

try {
    final response = api.updateAnnonce(id, updateAnnonceRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->updateAnnonce: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateAnnonceRequest** | [**UpdateAnnonceRequest**](UpdateAnnonceRequest.md)|  | 

### Return type

[**AnnonceResponse**](AnnonceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

