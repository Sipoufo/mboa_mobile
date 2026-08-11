# api_client.api.AdminUtilisateursApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listAdminUsers**](AdminUtilisateursApi.md#listadminusers) | **GET** /api/v1/admin/users | Search accounts by phone or email, with their subscription (RM-M18-01)
[**reactivateAccount**](AdminUtilisateursApi.md#reactivateaccount) | **POST** /api/v1/admin/users/{id}/reactivate | Lift a suspension
[**suspendAccount**](AdminUtilisateursApi.md#suspendaccount) | **POST** /api/v1/admin/users/{id}/suspend | Suspend an account; sessions are revoked at once (RM-M18-02)


# **listAdminUsers**
> PageResponseAdminUserSummary listAdminUsers(pageable, query, role, status)

Search accounts by phone or email, with their subscription (RM-M18-01)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminUtilisateursApi();
final Pageable pageable = ; // Pageable | 
final String query = query_example; // String | 
final String role = role_example; // String | 
final String status = status_example; // String | 

try {
    final response = api.listAdminUsers(pageable, query, role, status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminUtilisateursApi->listAdminUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **query** | **String**|  | [optional] 
 **role** | **String**|  | [optional] 
 **status** | **String**|  | [optional] 

### Return type

[**PageResponseAdminUserSummary**](PageResponseAdminUserSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reactivateAccount**
> reactivateAccount(id)

Lift a suspension

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminUtilisateursApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.reactivateAccount(id);
} on DioException catch (e) {
    print('Exception when calling AdminUtilisateursApi->reactivateAccount: $e\n');
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

# **suspendAccount**
> suspendAccount(id, suspendAccountRequest)

Suspend an account; sessions are revoked at once (RM-M18-02)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminUtilisateursApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final SuspendAccountRequest suspendAccountRequest = ; // SuspendAccountRequest | 

try {
    api.suspendAccount(id, suspendAccountRequest);
} on DioException catch (e) {
    print('Exception when calling AdminUtilisateursApi->suspendAccount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **suspendAccountRequest** | [**SuspendAccountRequest**](SuspendAccountRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

