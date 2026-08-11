# api_client.api.AgentCandidaturesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listMyAgentApplications**](AgentCandidaturesApi.md#listmyagentapplications) | **GET** /api/v1/agents/me/applications | Applications the agent has sent, newest first
[**withdrawMyAgentApplication**](AgentCandidaturesApi.md#withdrawmyagentapplication) | **DELETE** /api/v1/agents/me/applications/{id} | Withdraw an application nobody has answered
[**withdrawResidenceApplication**](AgentCandidaturesApi.md#withdrawresidenceapplication) | **DELETE** /api/v1/agents/me/applications/residence/{residenceId} | Withdraw a whole residence application at once (RM-M10bis-10)


# **listMyAgentApplications**
> PageResponseAssignmentItem listMyAgentApplications(pageable, status)

Applications the agent has sent, newest first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentCandidaturesApi();
final Pageable pageable = ; // Pageable | 
final BuiltList<String> status = ; // BuiltList<String> | 

try {
    final response = api.listMyAgentApplications(pageable, status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentCandidaturesApi->listMyAgentApplications: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **status** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 

### Return type

[**PageResponseAssignmentItem**](PageResponseAssignmentItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **withdrawMyAgentApplication**
> withdrawMyAgentApplication(id)

Withdraw an application nobody has answered

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentCandidaturesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.withdrawMyAgentApplication(id);
} on DioException catch (e) {
    print('Exception when calling AgentCandidaturesApi->withdrawMyAgentApplication: $e\n');
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

# **withdrawResidenceApplication**
> BatchResult withdrawResidenceApplication(residenceId)

Withdraw a whole residence application at once (RM-M10bis-10)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentCandidaturesApi();
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.withdrawResidenceApplication(residenceId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentCandidaturesApi->withdrawResidenceApplication: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **residenceId** | **String**|  | 

### Return type

[**BatchResult**](BatchResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

