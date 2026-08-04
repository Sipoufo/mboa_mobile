# api_client.api.AdminTypeChangeApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**approve**](AdminTypeChangeApi.md#approve) | **POST** /api/v1/admin/type-change-requests/{id}/approve | Approve a type-change request and apply the new type
[**listPending**](AdminTypeChangeApi.md#listpending) | **GET** /api/v1/admin/type-change-requests | List pending type-change requests
[**reject**](AdminTypeChangeApi.md#reject) | **POST** /api/v1/admin/type-change-requests/{id}/reject | Reject a type-change request with a reason


# **approve**
> TypeChangeReviewResult approve(id)

Approve a type-change request and apply the new type

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminTypeChangeApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.approve(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminTypeChangeApi->approve: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**TypeChangeReviewResult**](TypeChangeReviewResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listPending**
> PageResponseTypeChangeReviewItem listPending(pageable)

List pending type-change requests

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminTypeChangeApi();
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listPending(pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminTypeChangeApi->listPending: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseTypeChangeReviewItem**](PageResponseTypeChangeReviewItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reject**
> TypeChangeReviewResult reject(id, rejectTypeChangeRequest)

Reject a type-change request with a reason

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminTypeChangeApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RejectTypeChangeRequest rejectTypeChangeRequest = ; // RejectTypeChangeRequest | 

try {
    final response = api.reject(id, rejectTypeChangeRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminTypeChangeApi->reject: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **rejectTypeChangeRequest** | [**RejectTypeChangeRequest**](RejectTypeChangeRequest.md)|  | 

### Return type

[**TypeChangeReviewResult**](TypeChangeReviewResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

