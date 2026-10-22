# api_client.api.MesAnciensLogementsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getMyPastHome**](MesAnciensLogementsApi.md#getmypasthome) | **GET** /api/v1/past-homes/{contractId} | One past home: property as signed, contract code, confirmed expenses, requests, current note, my review (RM-M31-02 to 05)
[**getMyPastHomeExpensesPdf**](MesAnciensLogementsApi.md#getmypasthomeexpensespdf) | **GET** /api/v1/past-homes/{contractId}/expenses.pdf | My expenses for a past home as a PDF: confirmed rents and charges with receipts and totals, the rest apart
[**listMyPastHomes**](MesAnciensLogementsApi.md#listmypasthomes) | **GET** /api/v1/past-homes | My tenancies that are over, latest first (RM-M31-01)


# **getMyPastHome**
> PastHomeResponse getMyPastHome(contractId)

One past home: property as signed, contract code, confirmed expenses, requests, current note, my review (RM-M31-02 to 05)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMesAnciensLogementsApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getMyPastHome(contractId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MesAnciensLogementsApi->getMyPastHome: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 

### Return type

[**PastHomeResponse**](PastHomeResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyPastHomeExpensesPdf**
> String getMyPastHomeExpensesPdf(contractId)

My expenses for a past home as a PDF: confirmed rents and charges with receipts and totals, the rest apart

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMesAnciensLogementsApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getMyPastHomeExpensesPdf(contractId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MesAnciensLogementsApi->getMyPastHomeExpensesPdf: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 

### Return type

**String**

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/pdf, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyPastHomes**
> PageResponseHomeSummary listMyPastHomes(pageable)

My tenancies that are over, latest first (RM-M31-01)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMesAnciensLogementsApi();
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listMyPastHomes(pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MesAnciensLogementsApi->listMyPastHomes: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseHomeSummary**](PageResponseHomeSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

