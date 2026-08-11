# api_client.api.AssignationAgentRsidenceApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**acceptResidenceApplication**](AssignationAgentRsidenceApi.md#acceptresidenceapplication) | **POST** /api/v1/residences/{residenceId}/agent/applications/{agentAccountId}/accept | Choose this agent for the residence; rival applications on those units are declined
[**assignAgentToResidence**](AssignationAgentRsidenceApi.md#assignagenttoresidence) | **POST** /api/v1/residences/{residenceId}/agent | Offer every published unit to one agent; units that already have one are skipped
[**declineResidenceApplication**](AssignationAgentRsidenceApi.md#declineresidenceapplication) | **POST** /api/v1/residences/{residenceId}/agent/applications/{agentAccountId}/decline | Turn one agent&#39;s residence application down
[**listResidenceAgentCandidates**](AssignationAgentRsidenceApi.md#listresidenceagentcandidates) | **GET** /api/v1/residences/{residenceId}/agent/candidates | Agents who cover this residence&#39;s area; query matches a name or phone
[**listResidenceApplications**](AssignationAgentRsidenceApi.md#listresidenceapplications) | **GET** /api/v1/residences/{residenceId}/agent/applications | Agents who applied, one entry each with their unit count (RM-M10bis-09)
[**listResidenceAssignments**](AssignationAgentRsidenceApi.md#listresidenceassignments) | **GET** /api/v1/residences/{residenceId}/agent | The residence&#39;s assignments unit by unit — which room has whom
[**withdrawResidenceAgentAssignment**](AssignationAgentRsidenceApi.md#withdrawresidenceagentassignment) | **DELETE** /api/v1/residences/{residenceId}/agent | Take the whole residence back; each unit&#39;s planned visits are cancelled


# **acceptResidenceApplication**
> ResidenceAssignmentResult acceptResidenceApplication(residenceId, agentAccountId)

Choose this agent for the residence; rival applications on those units are declined

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAssignationAgentRsidenceApi();
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String agentAccountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.acceptResidenceApplication(residenceId, agentAccountId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AssignationAgentRsidenceApi->acceptResidenceApplication: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **residenceId** | **String**|  | 
 **agentAccountId** | **String**|  | 

### Return type

[**ResidenceAssignmentResult**](ResidenceAssignmentResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **assignAgentToResidence**
> ResidenceAssignmentResult assignAgentToResidence(residenceId, assignAgentRequest)

Offer every published unit to one agent; units that already have one are skipped

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAssignationAgentRsidenceApi();
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final AssignAgentRequest assignAgentRequest = ; // AssignAgentRequest | 

try {
    final response = api.assignAgentToResidence(residenceId, assignAgentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AssignationAgentRsidenceApi->assignAgentToResidence: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **residenceId** | **String**|  | 
 **assignAgentRequest** | [**AssignAgentRequest**](AssignAgentRequest.md)|  | 

### Return type

[**ResidenceAssignmentResult**](ResidenceAssignmentResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **declineResidenceApplication**
> BatchResult declineResidenceApplication(residenceId, agentAccountId)

Turn one agent's residence application down

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAssignationAgentRsidenceApi();
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String agentAccountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.declineResidenceApplication(residenceId, agentAccountId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AssignationAgentRsidenceApi->declineResidenceApplication: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **residenceId** | **String**|  | 
 **agentAccountId** | **String**|  | 

### Return type

[**BatchResult**](BatchResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listResidenceAgentCandidates**
> BuiltList<AgentCandidate> listResidenceAgentCandidates(residenceId, query)

Agents who cover this residence's area; query matches a name or phone

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAssignationAgentRsidenceApi();
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String query = query_example; // String | 

try {
    final response = api.listResidenceAgentCandidates(residenceId, query);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AssignationAgentRsidenceApi->listResidenceAgentCandidates: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **residenceId** | **String**|  | 
 **query** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;AgentCandidate&gt;**](AgentCandidate.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listResidenceApplications**
> BuiltList<ResidenceApplicationSummary> listResidenceApplications(residenceId)

Agents who applied, one entry each with their unit count (RM-M10bis-09)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAssignationAgentRsidenceApi();
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listResidenceApplications(residenceId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AssignationAgentRsidenceApi->listResidenceApplications: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **residenceId** | **String**|  | 

### Return type

[**BuiltList&lt;ResidenceApplicationSummary&gt;**](ResidenceApplicationSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listResidenceAssignments**
> BuiltList<AssignmentResponse> listResidenceAssignments(residenceId, status)

The residence's assignments unit by unit — which room has whom

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAssignationAgentRsidenceApi();
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BuiltList<String> status = ; // BuiltList<String> | 

try {
    final response = api.listResidenceAssignments(residenceId, status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AssignationAgentRsidenceApi->listResidenceAssignments: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **residenceId** | **String**|  | 
 **status** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 

### Return type

[**BuiltList&lt;AssignmentResponse&gt;**](AssignmentResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **withdrawResidenceAgentAssignment**
> BatchResult withdrawResidenceAgentAssignment(residenceId)

Take the whole residence back; each unit's planned visits are cancelled

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAssignationAgentRsidenceApi();
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.withdrawResidenceAgentAssignment(residenceId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AssignationAgentRsidenceApi->withdrawResidenceAgentAssignment: $e\n');
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

