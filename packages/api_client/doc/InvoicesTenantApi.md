# api_client.api.InvoicesTenantApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getMyInvoice**](InvoicesTenantApi.md#getmyinvoice) | **GET** /api/v1/invoices/{id} | One of my invoices
[**listMyInvoices**](InvoicesTenantApi.md#listmyinvoices) | **GET** /api/v1/invoices | My invoices, current and past, latest due first (RM-M24-06)
[**payInvoice**](InvoicesTenantApi.md#payinvoice) | **POST** /api/v1/invoices/{id}/pay | Pay an invoice in the app — same flow as a subscription payment (RM-M24-04)


# **getMyInvoice**
> InvoiceResponse getMyInvoice(id)

One of my invoices

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getInvoicesTenantApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getMyInvoice(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling InvoicesTenantApi->getMyInvoice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**InvoiceResponse**](InvoiceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyInvoices**
> PageResponseInvoiceResponse listMyInvoices(pageable)

My invoices, current and past, latest due first (RM-M24-06)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getInvoicesTenantApi();
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listMyInvoices(pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling InvoicesTenantApi->listMyInvoices: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseInvoiceResponse**](PageResponseInvoiceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **payInvoice**
> PaymentInitiatedResponse payInvoice(id, payInvoiceRequest, idempotencyKey)

Pay an invoice in the app — same flow as a subscription payment (RM-M24-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getInvoicesTenantApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final PayInvoiceRequest payInvoiceRequest = ; // PayInvoiceRequest | 
final String idempotencyKey = idempotencyKey_example; // String | 

try {
    final response = api.payInvoice(id, payInvoiceRequest, idempotencyKey);
    print(response);
} on DioException catch (e) {
    print('Exception when calling InvoicesTenantApi->payInvoice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **payInvoiceRequest** | [**PayInvoiceRequest**](PayInvoiceRequest.md)|  | 
 **idempotencyKey** | **String**|  | [optional] 

### Return type

[**PaymentInitiatedResponse**](PaymentInitiatedResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

