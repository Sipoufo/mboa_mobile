# api_client.api.PrestataireDashboardApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getMyDashboard**](PrestataireDashboardApi.md#getmydashboard) | **GET** /api/v1/prestataires/me/dashboard | Portfolio totals, gated by the current tier
[**listMyDashboardEntries**](PrestataireDashboardApi.md#listmydashboardentries) | **GET** /api/v1/prestataires/me/dashboard/annonces | Per-listing figures, residences grouped with their units, newest first


# **getMyDashboard**
> DashboardSummaryResponse getMyDashboard()

Portfolio totals, gated by the current tier

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPrestataireDashboardApi();

try {
    final response = api.getMyDashboard();
    print(response);
} on DioException catch (e) {
    print('Exception when calling PrestataireDashboardApi->getMyDashboard: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**DashboardSummaryResponse**](DashboardSummaryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyDashboardEntries**
> PageResponseDashboardItem listMyDashboardEntries(pageable)

Per-listing figures, residences grouped with their units, newest first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPrestataireDashboardApi();
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listMyDashboardEntries(pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PrestataireDashboardApi->listMyDashboardEntries: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseDashboardItem**](PageResponseDashboardItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

