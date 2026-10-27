# api_client.api.AdminContratsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminGetContract**](AdminContratsApi.md#admingetcontract) | **GET** /api/v1/admin/contracts/{id} | One archived contract, in full
[**adminGetContractPdf**](AdminContratsApi.md#admingetcontractpdf) | **GET** /api/v1/admin/contracts/{id}/pdf | A short-lived URL to download its PDF
[**adminGetTenantRating**](AdminContratsApi.md#admingettenantrating) | **GET** /api/v1/admin/contracts/{id}/tenant-rating | The landlord&#39;s rating of the tenant on this contract, with the comment only the admin reads (mobile §37 A); 404 RATING_NOT_FOUND when none was sent
[**adminListContracts**](AdminContratsApi.md#adminlistcontracts) | **GET** /api/v1/admin/contracts | The contract archive, filterable by status
[**adminRegenerateContractPdf**](AdminContratsApi.md#adminregeneratecontractpdf) | **POST** /api/v1/admin/contracts/{id}/pdf | Try again to produce a document that never arrived (CE-M08-02)


# **adminGetContract**
> ContractResponse adminGetContract(id)

One archived contract, in full

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.adminGetContract(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminContratsApi->adminGetContract: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ContractResponse**](ContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminGetContractPdf**
> ContractPdfResponse adminGetContractPdf(id)

A short-lived URL to download its PDF

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.adminGetContractPdf(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminContratsApi->adminGetContractPdf: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ContractPdfResponse**](ContractPdfResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminGetTenantRating**
> AdminTenantRatingResponse adminGetTenantRating(id)

The landlord's rating of the tenant on this contract, with the comment only the admin reads (mobile §37 A); 404 RATING_NOT_FOUND when none was sent

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.adminGetTenantRating(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminContratsApi->adminGetTenantRating: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AdminTenantRatingResponse**](AdminTenantRatingResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminListContracts**
> PageResponseContractResponse adminListContracts(pageable, status)

The contract archive, filterable by status

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminContratsApi();
final Pageable pageable = ; // Pageable | 
final BuiltList<String> status = ; // BuiltList<String> | 

try {
    final response = api.adminListContracts(pageable, status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminContratsApi->adminListContracts: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **status** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 

### Return type

[**PageResponseContractResponse**](PageResponseContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminRegenerateContractPdf**
> adminRegenerateContractPdf(id)

Try again to produce a document that never arrived (CE-M08-02)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.adminRegenerateContractPdf(id);
} on DioException catch (e) {
    print('Exception when calling AdminContratsApi->adminRegenerateContractPdf: $e\n');
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

