# api_client.api.AdminQuittancesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminListFailedReceipts**](AdminQuittancesApi.md#adminlistfailedreceipts) | **GET** /api/v1/admin/receipts/failed | Receipts still without their PDF after the three attempts, oldest first
[**adminRegenerateReceiptPdf**](AdminQuittancesApi.md#adminregeneratereceiptpdf) | **POST** /api/v1/admin/receipts/{id}/pdf | Try again to produce a receipt&#39;s PDF (CE-M08-02)


# **adminListFailedReceipts**
> PageResponseFailedReceipt adminListFailedReceipts(pageable)

Receipts still without their PDF after the three attempts, oldest first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminQuittancesApi();
final Pageable pageable = ; // Pageable | 

try {
    final response = api.adminListFailedReceipts(pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminQuittancesApi->adminListFailedReceipts: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseFailedReceipt**](PageResponseFailedReceipt.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminRegenerateReceiptPdf**
> ReceiptRegeneration adminRegenerateReceiptPdf(id)

Try again to produce a receipt's PDF (CE-M08-02)

Gives the receipt three attempts again and makes the first one now. `ready: false` means it failed again; the sweep makes the next two. 409 PDF_ALREADY_GENERATED if its PDF is in storage — a receipt marked ready whose file is gone is retried too (mobile §35).

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminQuittancesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.adminRegenerateReceiptPdf(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminQuittancesApi->adminRegenerateReceiptPdf: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ReceiptRegeneration**](ReceiptRegeneration.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

