# api_client.api.AnnoncesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**archive**](AnnoncesApi.md#archive) | **POST** /api/v1/annonces/{id}/archive | Archive a listing
[**create1**](AnnoncesApi.md#create1) | **POST** /api/v1/annonces | Create a listing (draft)
[**delete1**](AnnoncesApi.md#delete1) | **DELETE** /api/v1/annonces/{id} | Delete one of the authenticated prestataire&#39;s listings
[**getOne1**](AnnoncesApi.md#getone1) | **GET** /api/v1/annonces/{id} | Get one of the authenticated prestataire&#39;s listings
[**listMine2**](AnnoncesApi.md#listmine2) | **GET** /api/v1/annonces | List the authenticated prestataire&#39;s listings
[**markRented**](AnnoncesApi.md#markrented) | **POST** /api/v1/annonces/{id}/rented | Mark a published or reserved listing as rented
[**publish**](AnnoncesApi.md#publish) | **POST** /api/v1/annonces/{id}/publish | Publish a draft listing (profile complete + ≥3 photos + tier limit)
[**reserve**](AnnoncesApi.md#reserve) | **POST** /api/v1/annonces/{id}/reserve | Reserve a published listing (temporary hold)
[**update1**](AnnoncesApi.md#update1) | **PATCH** /api/v1/annonces/{id} | Partially update one of the authenticated prestataire&#39;s listings


# **archive**
> AnnonceResponse archive(id)

Archive a listing

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.archive(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->archive: $e\n');
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
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **create1**
> AnnonceResponse create1(createAnnonceRequest)

Create a listing (draft)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final CreateAnnonceRequest createAnnonceRequest = ; // CreateAnnonceRequest | 

try {
    final response = api.create1(createAnnonceRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->create1: $e\n');
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
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **delete1**
> delete1(id)

Delete one of the authenticated prestataire's listings

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.delete1(id);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->delete1: $e\n');
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
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOne1**
> AnnonceResponse getOne1(id)

Get one of the authenticated prestataire's listings

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getOne1(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->getOne1: $e\n');
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
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMine2**
> PageResponseAnnonceResponse listMine2(pageable)

List the authenticated prestataire's listings

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listMine2(pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->listMine2: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseAnnonceResponse**](PageResponseAnnonceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markRented**
> AnnonceResponse markRented(id)

Mark a published or reserved listing as rented

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.markRented(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->markRented: $e\n');
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
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publish**
> AnnonceResponse publish(id)

Publish a draft listing (profile complete + ≥3 photos + tier limit)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.publish(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->publish: $e\n');
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
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reserve**
> AnnonceResponse reserve(id)

Reserve a published listing (temporary hold)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.reserve(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->reserve: $e\n');
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
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **update1**
> AnnonceResponse update1(id, updateAnnonceRequest)

Partially update one of the authenticated prestataire's listings

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateAnnonceRequest updateAnnonceRequest = ; // UpdateAnnonceRequest | 

try {
    final response = api.update1(id, updateAnnonceRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AnnoncesApi->update1: $e\n');
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
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

