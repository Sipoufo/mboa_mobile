# api_client.api.AdminKYCApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**approve1**](AdminKYCApi.md#approve1) | **POST** /api/v1/admin/kyc/{id}/approve | Approve a KYC submission and activate the account
[**listPending1**](AdminKYCApi.md#listpending1) | **GET** /api/v1/admin/kyc | List pending KYC submissions (with pre-signed document URLs)
[**reject1**](AdminKYCApi.md#reject1) | **POST** /api/v1/admin/kyc/{id}/reject | Reject a KYC submission with a reason


# **approve1**
> KycStatusResponse approve1(id)

Approve a KYC submission and activate the account

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminKYCApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.approve1(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminKYCApi->approve1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**KycStatusResponse**](KycStatusResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listPending1**
> PageResponseKycReviewItem listPending1(pageable)

List pending KYC submissions (with pre-signed document URLs)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminKYCApi();
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listPending1(pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminKYCApi->listPending1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseKycReviewItem**](PageResponseKycReviewItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reject1**
> KycStatusResponse reject1(id, rejectKycRequest)

Reject a KYC submission with a reason

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminKYCApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RejectKycRequest rejectKycRequest = ; // RejectKycRequest | 

try {
    final response = api.reject1(id, rejectKycRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminKYCApi->reject1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **rejectKycRequest** | [**RejectKycRequest**](RejectKycRequest.md)|  | 

### Return type

[**KycStatusResponse**](KycStatusResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

