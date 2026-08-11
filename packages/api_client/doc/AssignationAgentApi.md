# api_client.api.AssignationAgentApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**acceptAnnonceApplication**](AssignationAgentApi.md#acceptannonceapplication) | **POST** /api/v1/annonces/{annonceId}/agent/applications/{applicationId}/accept | Accept an application; the other applicants are declined automatically
[**assignAgent**](AssignationAgentApi.md#assignagent) | **POST** /api/v1/annonces/{annonceId}/agent | Offer the listing to an agent (RM-M11-04)
[**declineAnnonceApplication**](AssignationAgentApi.md#declineannonceapplication) | **POST** /api/v1/annonces/{annonceId}/agent/applications/{applicationId}/decline | Turn an application down
[**listAgentCandidates**](AssignationAgentApi.md#listagentcandidates) | **GET** /api/v1/annonces/{annonceId}/agent/candidates | Agents who cover this listing&#39;s area; query matches a name or phone (RM-M11-03)
[**listAnnonceApplications**](AssignationAgentApi.md#listannonceapplications) | **GET** /api/v1/annonces/{annonceId}/agent/applications | Agents who applied to this listing, oldest first
[**listMyAnnonceAssignments**](AssignationAgentApi.md#listmyannonceassignments) | **GET** /api/v1/annonces/agent/assignments | Every assignment across the prestataire&#39;s listings, newest first
[**withdrawAgentAssignment**](AssignationAgentApi.md#withdrawagentassignment) | **DELETE** /api/v1/annonces/{annonceId}/agent | Remove the listing&#39;s agent; visits already planned are cancelled (RM-M11-06)


# **acceptAnnonceApplication**
> AssignmentResponse acceptAnnonceApplication(annonceId, applicationId)

Accept an application; the other applicants are declined automatically

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAssignationAgentApi();
final String annonceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String applicationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.acceptAnnonceApplication(annonceId, applicationId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AssignationAgentApi->acceptAnnonceApplication: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **annonceId** | **String**|  | 
 **applicationId** | **String**|  | 

### Return type

[**AssignmentResponse**](AssignmentResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **assignAgent**
> AssignmentResponse assignAgent(annonceId, assignAgentRequest)

Offer the listing to an agent (RM-M11-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAssignationAgentApi();
final String annonceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final AssignAgentRequest assignAgentRequest = ; // AssignAgentRequest | 

try {
    final response = api.assignAgent(annonceId, assignAgentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AssignationAgentApi->assignAgent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **annonceId** | **String**|  | 
 **assignAgentRequest** | [**AssignAgentRequest**](AssignAgentRequest.md)|  | 

### Return type

[**AssignmentResponse**](AssignmentResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **declineAnnonceApplication**
> AssignmentResponse declineAnnonceApplication(annonceId, applicationId)

Turn an application down

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAssignationAgentApi();
final String annonceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String applicationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.declineAnnonceApplication(annonceId, applicationId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AssignationAgentApi->declineAnnonceApplication: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **annonceId** | **String**|  | 
 **applicationId** | **String**|  | 

### Return type

[**AssignmentResponse**](AssignmentResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAgentCandidates**
> BuiltList<AgentCandidate> listAgentCandidates(annonceId, query)

Agents who cover this listing's area; query matches a name or phone (RM-M11-03)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAssignationAgentApi();
final String annonceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String query = query_example; // String | 

try {
    final response = api.listAgentCandidates(annonceId, query);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AssignationAgentApi->listAgentCandidates: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **annonceId** | **String**|  | 
 **query** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;AgentCandidate&gt;**](AgentCandidate.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAnnonceApplications**
> BuiltList<AssignmentResponse> listAnnonceApplications(annonceId)

Agents who applied to this listing, oldest first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAssignationAgentApi();
final String annonceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listAnnonceApplications(annonceId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AssignationAgentApi->listAnnonceApplications: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **annonceId** | **String**|  | 

### Return type

[**BuiltList&lt;AssignmentResponse&gt;**](AssignmentResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyAnnonceAssignments**
> PageResponseAssignmentItem listMyAnnonceAssignments(pageable, status)

Every assignment across the prestataire's listings, newest first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAssignationAgentApi();
final Pageable pageable = ; // Pageable | 
final BuiltList<String> status = ; // BuiltList<String> | 

try {
    final response = api.listMyAnnonceAssignments(pageable, status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AssignationAgentApi->listMyAnnonceAssignments: $e\n');
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

# **withdrawAgentAssignment**
> withdrawAgentAssignment(annonceId)

Remove the listing's agent; visits already planned are cancelled (RM-M11-06)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAssignationAgentApi();
final String annonceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.withdrawAgentAssignment(annonceId);
} on DioException catch (e) {
    print('Exception when calling AssignationAgentApi->withdrawAgentAssignment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **annonceId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

