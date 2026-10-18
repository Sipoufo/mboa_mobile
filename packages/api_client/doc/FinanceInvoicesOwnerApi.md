# api_client.api.FinanceInvoicesOwnerApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**cancelInvoice**](FinanceInvoicesOwnerApi.md#cancelinvoice) | **POST** /api/v1/finance/invoices/{id}/cancel | Cancel an open invoice
[**createInvoice**](FinanceInvoicesOwnerApi.md#createinvoice) | **POST** /api/v1/finance/invoices | Bill the tenant of a running Mboa contract — water, electricity or another charge (RM-M24-02)
[**getOwnerInvoice**](FinanceInvoicesOwnerApi.md#getownerinvoice) | **GET** /api/v1/finance/invoices/{id} | One of my invoices
[**listOwnerInvoices**](FinanceInvoicesOwnerApi.md#listownerinvoices) | **GET** /api/v1/finance/invoices | My invoices, latest due first, optionally on one contract
[**markInvoicePaid**](FinanceInvoicesOwnerApi.md#markinvoicepaid) | **POST** /api/v1/finance/invoices/{id}/mark-paid | Declare an invoice paid — unchecked by Mboa, in force at once (RM-M24-05)
[**reopenInvoice**](FinanceInvoicesOwnerApi.md#reopeninvoice) | **POST** /api/v1/finance/invoices/{id}/reopen | Withdraw a payment you declared by mistake
[**updateInvoice**](FinanceInvoicesOwnerApi.md#updateinvoice) | **PATCH** /api/v1/finance/invoices/{id} | Correct an open invoice; a new due date re-arms the reminders


# **cancelInvoice**
> InvoiceResponse cancelInvoice(id)

Cancel an open invoice

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceInvoicesOwnerApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.cancelInvoice(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceInvoicesOwnerApi->cancelInvoice: $e\n');
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

# **createInvoice**
> InvoiceResponse createInvoice(createInvoiceRequest)

Bill the tenant of a running Mboa contract — water, electricity or another charge (RM-M24-02)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceInvoicesOwnerApi();
final CreateInvoiceRequest createInvoiceRequest = ; // CreateInvoiceRequest | 

try {
    final response = api.createInvoice(createInvoiceRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceInvoicesOwnerApi->createInvoice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createInvoiceRequest** | [**CreateInvoiceRequest**](CreateInvoiceRequest.md)|  | 

### Return type

[**InvoiceResponse**](InvoiceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOwnerInvoice**
> InvoiceResponse getOwnerInvoice(id)

One of my invoices

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceInvoicesOwnerApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getOwnerInvoice(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceInvoicesOwnerApi->getOwnerInvoice: $e\n');
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

# **listOwnerInvoices**
> PageResponseInvoiceResponse listOwnerInvoices(pageable, contractId)

My invoices, latest due first, optionally on one contract

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceInvoicesOwnerApi();
final Pageable pageable = ; // Pageable | 
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listOwnerInvoices(pageable, contractId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceInvoicesOwnerApi->listOwnerInvoices: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **contractId** | **String**|  | [optional] 

### Return type

[**PageResponseInvoiceResponse**](PageResponseInvoiceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markInvoicePaid**
> InvoiceResponse markInvoicePaid(id, markInvoicePaidRequest)

Declare an invoice paid — unchecked by Mboa, in force at once (RM-M24-05)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceInvoicesOwnerApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final MarkInvoicePaidRequest markInvoicePaidRequest = ; // MarkInvoicePaidRequest | 

try {
    final response = api.markInvoicePaid(id, markInvoicePaidRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceInvoicesOwnerApi->markInvoicePaid: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **markInvoicePaidRequest** | [**MarkInvoicePaidRequest**](MarkInvoicePaidRequest.md)|  | [optional] 

### Return type

[**InvoiceResponse**](InvoiceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reopenInvoice**
> InvoiceResponse reopenInvoice(id)

Withdraw a payment you declared by mistake

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceInvoicesOwnerApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.reopenInvoice(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceInvoicesOwnerApi->reopenInvoice: $e\n');
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

# **updateInvoice**
> InvoiceResponse updateInvoice(id, updateInvoiceRequest)

Correct an open invoice; a new due date re-arms the reminders

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceInvoicesOwnerApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateInvoiceRequest updateInvoiceRequest = ; // UpdateInvoiceRequest | 

try {
    final response = api.updateInvoice(id, updateInvoiceRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceInvoicesOwnerApi->updateInvoice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateInvoiceRequest** | [**UpdateInvoiceRequest**](UpdateInvoiceRequest.md)|  | 

### Return type

[**InvoiceResponse**](InvoiceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

