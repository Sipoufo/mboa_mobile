# api_client.api.AgentVisitesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**cancelAgentVisite**](AgentVisitesApi.md#cancelagentvisite) | **POST** /api/v1/agents/me/visites/{id}/cancel | Cancel a visit, up to one hour before the slot (RM-M16-04)
[**getMyAgentVisite**](AgentVisitesApi.md#getmyagentvisite) | **GET** /api/v1/agents/me/visites/{id} | One visit in full: exact address, both contacts, whether it can start (RM-M16-01)
[**listMyAgentVisites**](AgentVisitesApi.md#listmyagentvisites) | **GET** /api/v1/agents/me/visites | Visits assigned to the authenticated agent
[**listMyAgentVisitesToday**](AgentVisitesApi.md#listmyagentvisitestoday) | **GET** /api/v1/agents/me/visites/today | The agent&#39;s round for today, soonest first


# **cancelAgentVisite**
> cancelAgentVisite(id)

Cancel a visit, up to one hour before the slot (RM-M16-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentVisitesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.cancelAgentVisite(id);
} on DioException catch (e) {
    print('Exception when calling AgentVisitesApi->cancelAgentVisite: $e\n');
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

# **getMyAgentVisite**
> AgentVisiteDetail getMyAgentVisite(id)

One visit in full: exact address, both contacts, whether it can start (RM-M16-01)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentVisitesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getMyAgentVisite(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentVisitesApi->getMyAgentVisite: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AgentVisiteDetail**](AgentVisiteDetail.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyAgentVisites**
> PageResponseVisiteResponse listMyAgentVisites(pageable, status, from, to)

Visits assigned to the authenticated agent

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentVisitesApi();
final Pageable pageable = ; // Pageable | 
final BuiltList<String> status = ; // BuiltList<String> | 
final DateTime from = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime to = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final response = api.listMyAgentVisites(pageable, status, from, to);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentVisitesApi->listMyAgentVisites: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **status** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 
 **from** | **DateTime**|  | [optional] 
 **to** | **DateTime**|  | [optional] 

### Return type

[**PageResponseVisiteResponse**](PageResponseVisiteResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyAgentVisitesToday**
> BuiltList<VisiteResponse> listMyAgentVisitesToday()

The agent's round for today, soonest first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentVisitesApi();

try {
    final response = api.listMyAgentVisitesToday();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentVisitesApi->listMyAgentVisitesToday: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;VisiteResponse&gt;**](VisiteResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

