# api_client.api.VisitesRapportApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getVisiteReport**](VisitesRapportApi.md#getvisitereport) | **GET** /api/v1/visites/{id}/report | The agent&#39;s report on a visit — user, agent and prestataire only


# **getVisiteReport**
> VisiteReportResponse getVisiteReport(id)

The agent's report on a visit — user, agent and prestataire only

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVisitesRapportApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getVisiteReport(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling VisitesRapportApi->getVisiteReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**VisiteReportResponse**](VisiteReportResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

