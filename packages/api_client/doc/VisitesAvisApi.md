# api_client.api.VisitesAvisApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**commentVisiteReview**](VisitesAvisApi.md#commentvisitereview) | **POST** /api/v1/visites/{visiteId}/review/comments | Answer a review; it adds beside the client&#39;s words, never into them (RM-M07bis-04)
[**exportVisiteReviewPdf**](VisitesAvisApi.md#exportvisitereviewpdf) | **GET** /api/v1/visites/{visiteId}/review/pdf | The review as a printable PDF; no contractual value (RM-M07bis-06)
[**getVisiteReview**](VisitesAvisApi.md#getvisitereview) | **GET** /api/v1/visites/{visiteId}/review | The review published for this visit
[**submitVisiteReview**](VisitesAvisApi.md#submitvisitereview) | **POST** /api/v1/visites/{visiteId}/review | Publish your review of the property; needs a visit you both confirmed (RM-M07bis-01)


# **commentVisiteReview**
> ReviewResponse commentVisiteReview(visiteId, reviewCommentRequest)

Answer a review; it adds beside the client's words, never into them (RM-M07bis-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVisitesAvisApi();
final String visiteId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ReviewCommentRequest reviewCommentRequest = ; // ReviewCommentRequest | 

try {
    final response = api.commentVisiteReview(visiteId, reviewCommentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling VisitesAvisApi->commentVisiteReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **visiteId** | **String**|  | 
 **reviewCommentRequest** | [**ReviewCommentRequest**](ReviewCommentRequest.md)|  | 

### Return type

[**ReviewResponse**](ReviewResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **exportVisiteReviewPdf**
> String exportVisiteReviewPdf(visiteId)

The review as a printable PDF; no contractual value (RM-M07bis-06)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVisitesAvisApi();
final String visiteId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.exportVisiteReviewPdf(visiteId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling VisitesAvisApi->exportVisiteReviewPdf: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **visiteId** | **String**|  | 

### Return type

**String**

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/pdf, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getVisiteReview**
> ReviewResponse getVisiteReview(visiteId)

The review published for this visit

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVisitesAvisApi();
final String visiteId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getVisiteReview(visiteId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling VisitesAvisApi->getVisiteReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **visiteId** | **String**|  | 

### Return type

[**ReviewResponse**](ReviewResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **submitVisiteReview**
> ReviewResponse submitVisiteReview(visiteId, submitReviewRequest)

Publish your review of the property; needs a visit you both confirmed (RM-M07bis-01)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVisitesAvisApi();
final String visiteId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final SubmitReviewRequest submitReviewRequest = ; // SubmitReviewRequest | 

try {
    final response = api.submitVisiteReview(visiteId, submitReviewRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling VisitesAvisApi->submitVisiteReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **visiteId** | **String**|  | 
 **submitReviewRequest** | [**SubmitReviewRequest**](SubmitReviewRequest.md)|  | 

### Return type

[**ReviewResponse**](ReviewResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

