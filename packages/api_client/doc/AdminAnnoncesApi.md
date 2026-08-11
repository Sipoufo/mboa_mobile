# api_client.api.AdminAnnoncesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listAdminAnnonces**](AdminAnnoncesApi.md#listadminannonces) | **GET** /api/v1/admin/annonces | Search listings by title or owner phone/email, filtered by status
[**suspendAnnonce**](AdminAnnoncesApi.md#suspendannonce) | **POST** /api/v1/admin/annonces/{id}/suspend | Suspend a listing with a reason; its owner is told (RM-M19-02, CA-M19-02)
[**updateAnnonceAsAdmin**](AdminAnnoncesApi.md#updateannonceasadmin) | **PATCH** /api/v1/admin/annonces/{id} | Edit a listing&#39;s content directly; its owner is told what changed (RM-M19-05)


# **listAdminAnnonces**
> PageResponseAnnonceResponse listAdminAnnonces(pageable, query, status)

Search listings by title or owner phone/email, filtered by status

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminAnnoncesApi();
final Pageable pageable = ; // Pageable | 
final String query = query_example; // String | 
final String status = status_example; // String | 

try {
    final response = api.listAdminAnnonces(pageable, query, status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminAnnoncesApi->listAdminAnnonces: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **query** | **String**|  | [optional] 
 **status** | **String**|  | [optional] 

### Return type

[**PageResponseAnnonceResponse**](PageResponseAnnonceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **suspendAnnonce**
> suspendAnnonce(id, suspendAnnonceRequest)

Suspend a listing with a reason; its owner is told (RM-M19-02, CA-M19-02)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final SuspendAnnonceRequest suspendAnnonceRequest = ; // SuspendAnnonceRequest | 

try {
    api.suspendAnnonce(id, suspendAnnonceRequest);
} on DioException catch (e) {
    print('Exception when calling AdminAnnoncesApi->suspendAnnonce: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **suspendAnnonceRequest** | [**SuspendAnnonceRequest**](SuspendAnnonceRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateAnnonceAsAdmin**
> AnnonceResponse updateAnnonceAsAdmin(id, updateAnnonceRequest)

Edit a listing's content directly; its owner is told what changed (RM-M19-05)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminAnnoncesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateAnnonceRequest updateAnnonceRequest = ; // UpdateAnnonceRequest | 

try {
    final response = api.updateAnnonceAsAdmin(id, updateAnnonceRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminAnnoncesApi->updateAnnonceAsAdmin: $e\n');
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

