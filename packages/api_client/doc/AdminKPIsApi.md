# api_client.api.AdminKPIsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**exportAdminKpis**](AdminKPIsApi.md#exportadminkpis) | **GET** /api/v1/admin/kpis/export | The daily series as CSV for any period up to 366 days (RM-M22-02)
[**getAdminKpis**](AdminKPIsApi.md#getadminkpis) | **GET** /api/v1/admin/kpis | The KPI dashboard as of now: each figure with its 7/30-day windows and its target
[**listAdminKpiDays**](AdminKPIsApi.md#listadminkpidays) | **GET** /api/v1/admin/kpis/days | One row per day (Africa/Douala), oldest first; at most 366 days, today provisional


# **exportAdminKpis**
> String exportAdminKpis(from, to)

The daily series as CSV for any period up to 366 days (RM-M22-02)

`;`-separated with a UTF-8 BOM so Excel in French opens it as is; an empty cell is a figure that was not recorded that day.

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminKPIsApi();
final Date from = 2013-10-20; // Date | 
final Date to = 2013-10-20; // Date | 

try {
    final response = api.exportAdminKpis(from, to);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminKPIsApi->exportAdminKpis: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **Date**|  | [optional] 
 **to** | **Date**|  | [optional] 

### Return type

**String**

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/csv, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAdminKpis**
> KpiDashboardResponse getAdminKpis()

The KPI dashboard as of now: each figure with its 7/30-day windows and its target

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminKPIsApi();

try {
    final response = api.getAdminKpis();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminKPIsApi->getAdminKpis: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**KpiDashboardResponse**](KpiDashboardResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAdminKpiDays**
> BuiltList<KpiDayResponse> listAdminKpiDays(from, to)

One row per day (Africa/Douala), oldest first; at most 366 days, today provisional

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminKPIsApi();
final Date from = 2013-10-20; // Date | First day, ISO date; default 29 days before `to`
final Date to = 2013-10-20; // Date | Last day, ISO date; default today

try {
    final response = api.listAdminKpiDays(from, to);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminKPIsApi->listAdminKpiDays: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **Date**| First day, ISO date; default 29 days before `to` | [optional] 
 **to** | **Date**| Last day, ISO date; default today | [optional] 

### Return type

[**BuiltList&lt;KpiDayResponse&gt;**](KpiDayResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

