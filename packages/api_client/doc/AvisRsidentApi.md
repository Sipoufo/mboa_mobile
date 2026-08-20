# api_client.api.AvisRsidentApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getResidentReview**](AvisRsidentApi.md#getresidentreview) | **GET** /api/v1/contracts/{contractId}/review | The review published for this tenancy
[**replyToResidentReview**](AvisRsidentApi.md#replytoresidentreview) | **POST** /api/v1/contracts/{contractId}/review/reply | Answer it publicly, once — you cannot change or remove it (RM-M27-03)
[**submitResidentReview**](AvisRsidentApi.md#submitresidentreview) | **POST** /api/v1/contracts/{contractId}/review | Review living in this property — needs a signed contract of at least a month
[**updateResidentReview**](AvisRsidentApi.md#updateresidentreview) | **PUT** /api/v1/contracts/{contractId}/review | Revise it — open while the tenancy runs and 30 days after it ends (RM-M27-02)


# **getResidentReview**
> PropertyReview getResidentReview(contractId)

The review published for this tenancy

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAvisRsidentApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getResidentReview(contractId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AvisRsidentApi->getResidentReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 

### Return type

[**PropertyReview**](PropertyReview.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **replyToResidentReview**
> PropertyReview replyToResidentReview(contractId, replyRequest)

Answer it publicly, once — you cannot change or remove it (RM-M27-03)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAvisRsidentApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ReplyRequest replyRequest = ; // ReplyRequest | 

try {
    final response = api.replyToResidentReview(contractId, replyRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AvisRsidentApi->replyToResidentReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **replyRequest** | [**ReplyRequest**](ReplyRequest.md)|  | 

### Return type

[**PropertyReview**](PropertyReview.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **submitResidentReview**
> PropertyReview submitResidentReview(contractId, submitResidentReviewRequest)

Review living in this property — needs a signed contract of at least a month

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAvisRsidentApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final SubmitResidentReviewRequest submitResidentReviewRequest = ; // SubmitResidentReviewRequest | 

try {
    final response = api.submitResidentReview(contractId, submitResidentReviewRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AvisRsidentApi->submitResidentReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **submitResidentReviewRequest** | [**SubmitResidentReviewRequest**](SubmitResidentReviewRequest.md)|  | 

### Return type

[**PropertyReview**](PropertyReview.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateResidentReview**
> PropertyReview updateResidentReview(contractId, submitResidentReviewRequest)

Revise it — open while the tenancy runs and 30 days after it ends (RM-M27-02)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAvisRsidentApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final SubmitResidentReviewRequest submitResidentReviewRequest = ; // SubmitResidentReviewRequest | 

try {
    final response = api.updateResidentReview(contractId, submitResidentReviewRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AvisRsidentApi->updateResidentReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **submitResidentReviewRequest** | [**SubmitResidentReviewRequest**](SubmitResidentReviewRequest.md)|  | 

### Return type

[**PropertyReview**](PropertyReview.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

