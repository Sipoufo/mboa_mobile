# api_client.api.QuittancesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getReceiptPdf**](QuittancesApi.md#getreceiptpdf) | **GET** /api/v1/receipts/{receiptId}/pdf | A short-lived link to a receipt&#39;s PDF — 409 RECEIPT_NOT_READY while it is prepared (CA-M30-02)
[**verifyReceipt**](QuittancesApi.md#verifyreceipt) | **GET** /api/v1/receipts/verify/{receiptId} | Public: check a receipt with its number and code — amount and period, no names (RM-M30-05)


# **getReceiptPdf**
> ReceiptPdfResponse getReceiptPdf(receiptId)

A short-lived link to a receipt's PDF — 409 RECEIPT_NOT_READY while it is prepared (CA-M30-02)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getQuittancesApi();
final String receiptId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getReceiptPdf(receiptId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling QuittancesApi->getReceiptPdf: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **receiptId** | **String**|  | 

### Return type

[**ReceiptPdfResponse**](ReceiptPdfResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **verifyReceipt**
> ReceiptVerification verifyReceipt(receiptId, code)

Public: check a receipt with its number and code — amount and period, no names (RM-M30-05)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getQuittancesApi();
final String receiptId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String code = code_example; // String | 

try {
    final response = api.verifyReceipt(receiptId, code);
    print(response);
} on DioException catch (e) {
    print('Exception when calling QuittancesApi->verifyReceipt: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **receiptId** | **String**|  | 
 **code** | **String**|  | 

### Return type

[**ReceiptVerification**](ReceiptVerification.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

