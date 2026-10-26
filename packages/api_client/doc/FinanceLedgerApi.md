# api_client.api.FinanceLedgerApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createLedgerEntry**](FinanceLedgerApi.md#createledgerentry) | **POST** /api/v1/finance/ledger | Record an income or an expense; needs the add-on running
[**deleteLedgerEntry**](FinanceLedgerApi.md#deleteledgerentry) | **DELETE** /api/v1/finance/ledger/{id} | Remove an entry and its attachment; needs the add-on running
[**exportLedger**](FinanceLedgerApi.md#exportledger) | **GET** /api/v1/finance/ledger/export | The same entries as CSV, for any period (RM-M25-05)
[**getLedgerAttachment**](FinanceLedgerApi.md#getledgerattachment) | **GET** /api/v1/finance/ledger/{id}/attachment | A short-lived link to an entry&#39;s attachment
[**getLedgerSummary**](FinanceLedgerApi.md#getledgersummary) | **GET** /api/v1/finance/ledger/summary | Totals in, out and net, and per category, over the same filters (RM-M25-03)
[**listLedgerEntries**](FinanceLedgerApi.md#listledgerentries) | **GET** /api/v1/finance/ledger | My ledger, newest first — filter by period and by one listing, one residence or the unassigned
[**updateLedgerEntry**](FinanceLedgerApi.md#updateledgerentry) | **PUT** /api/v1/finance/ledger/{id} | Replace an entry; needs the add-on running


# **createLedgerEntry**
> LedgerEntryResponse createLedgerEntry(ledgerEntryRequest)

Record an income or an expense; needs the add-on running

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceLedgerApi();
final LedgerEntryRequest ledgerEntryRequest = ; // LedgerEntryRequest | 

try {
    final response = api.createLedgerEntry(ledgerEntryRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceLedgerApi->createLedgerEntry: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ledgerEntryRequest** | [**LedgerEntryRequest**](LedgerEntryRequest.md)|  | 

### Return type

[**LedgerEntryResponse**](LedgerEntryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteLedgerEntry**
> deleteLedgerEntry(id)

Remove an entry and its attachment; needs the add-on running

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceLedgerApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.deleteLedgerEntry(id);
} on DioException catch (e) {
    print('Exception when calling FinanceLedgerApi->deleteLedgerEntry: $e\n');
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

# **exportLedger**
> String exportLedger(from, to, annonceId, residenceId, unassigned)

The same entries as CSV, for any period (RM-M25-05)

`;`-separated with a UTF-8 BOM so Excel in French opens it as is.

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceLedgerApi();
final Date from = 2013-10-20; // Date | 
final Date to = 2013-10-20; // Date | 
final String annonceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final bool unassigned = true; // bool | 

try {
    final response = api.exportLedger(from, to, annonceId, residenceId, unassigned);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceLedgerApi->exportLedger: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **Date**|  | [optional] 
 **to** | **Date**|  | [optional] 
 **annonceId** | **String**|  | [optional] 
 **residenceId** | **String**|  | [optional] 
 **unassigned** | **bool**|  | [optional] [default to false]

### Return type

**String**

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/csv, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLedgerAttachment**
> PresignedDownload getLedgerAttachment(id)

A short-lived link to an entry's attachment

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceLedgerApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getLedgerAttachment(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceLedgerApi->getLedgerAttachment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**PresignedDownload**](PresignedDownload.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLedgerSummary**
> LedgerSummaryResponse getLedgerSummary(from, to, annonceId, residenceId, unassigned)

Totals in, out and net, and per category, over the same filters (RM-M25-03)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceLedgerApi();
final Date from = 2013-10-20; // Date | 
final Date to = 2013-10-20; // Date | 
final String annonceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final bool unassigned = true; // bool | 

try {
    final response = api.getLedgerSummary(from, to, annonceId, residenceId, unassigned);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceLedgerApi->getLedgerSummary: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **Date**|  | [optional] 
 **to** | **Date**|  | [optional] 
 **annonceId** | **String**|  | [optional] 
 **residenceId** | **String**|  | [optional] 
 **unassigned** | **bool**|  | [optional] [default to false]

### Return type

[**LedgerSummaryResponse**](LedgerSummaryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listLedgerEntries**
> PageResponseLedgerEntryResponse listLedgerEntries(pageable, from, to, annonceId, residenceId, unassigned)

My ledger, newest first — filter by period and by one listing, one residence or the unassigned

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceLedgerApi();
final Pageable pageable = ; // Pageable | 
final Date from = 2013-10-20; // Date | 
final Date to = 2013-10-20; // Date | 
final String annonceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final bool unassigned = true; // bool | 

try {
    final response = api.listLedgerEntries(pageable, from, to, annonceId, residenceId, unassigned);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceLedgerApi->listLedgerEntries: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **from** | **Date**|  | [optional] 
 **to** | **Date**|  | [optional] 
 **annonceId** | **String**|  | [optional] 
 **residenceId** | **String**|  | [optional] 
 **unassigned** | **bool**|  | [optional] [default to false]

### Return type

[**PageResponseLedgerEntryResponse**](PageResponseLedgerEntryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateLedgerEntry**
> LedgerEntryResponse updateLedgerEntry(id, ledgerEntryRequest)

Replace an entry; needs the add-on running

Every field is replaced but the attachment: `attachmentKey` absent or null keeps it, \"\" removes it, a new FINANCE_ATTACHMENT key replaces it (mobile §34). A removed or replaced file is deleted from storage.

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceLedgerApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final LedgerEntryRequest ledgerEntryRequest = ; // LedgerEntryRequest | 

try {
    final response = api.updateLedgerEntry(id, ledgerEntryRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceLedgerApi->updateLedgerEntry: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **ledgerEntryRequest** | [**LedgerEntryRequest**](LedgerEntryRequest.md)|  | 

### Return type

[**LedgerEntryResponse**](LedgerEntryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

