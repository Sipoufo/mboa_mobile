# api_client.api.AgentAssignationsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**acceptAgentAssignment**](AgentAssignationsApi.md#acceptagentassignment) | **POST** /api/v1/agents/me/assignments/{id}/accept | Accept an offer; the listing can then offer visits (RM-M05-07)
[**acceptResidenceAssignment**](AgentAssignationsApi.md#acceptresidenceassignment) | **POST** /api/v1/agents/me/assignments/residence/{residenceId}/accept | Accept a whole residence batch; answering unit by unit is the same tedium in reverse
[**applyToAnnonce**](AgentAssignationsApi.md#applytoannonce) | **POST** /api/v1/agents/me/assignments/apply/{annonceId} | Apply to a listing; the prestataire still decides (RM-M11-04)
[**applyToResidence**](AgentAssignationsApi.md#applytoresidence) | **POST** /api/v1/agents/me/assignments/apply/residence/{residenceId} | Apply to every open unit of a residence in one act (M11)
[**declineAgentAssignment**](AgentAssignationsApi.md#declineagentassignment) | **POST** /api/v1/agents/me/assignments/{id}/decline | Decline an offer; the prestataire is told so they can ask someone else
[**declineResidenceAssignment**](AgentAssignationsApi.md#declineresidenceassignment) | **POST** /api/v1/agents/me/assignments/residence/{residenceId}/decline | Decline a whole residence batch
[**listAgentOpportunities**](AgentAssignationsApi.md#listagentopportunities) | **GET** /api/v1/agents/me/assignments/opportunities | What the agent may apply to: standalone listings and whole residences, in their zones
[**listMyAgentAssignments**](AgentAssignationsApi.md#listmyagentassignments) | **GET** /api/v1/agents/me/assignments | Everything the agent holds, newest first — offers and accepted applications alike
[**resignAgentAssignment**](AgentAssignationsApi.md#resignagentassignment) | **POST** /api/v1/agents/me/assignments/{id}/resign | Step down from an assignment already accepted; booked visits are cancelled
[**resignResidenceAssignment**](AgentAssignationsApi.md#resignresidenceassignment) | **POST** /api/v1/agents/me/assignments/residence/{residenceId}/resign | Step down from a whole residence at once (RM-M10bis-10)
[**withdrawAgentApplication**](AgentAssignationsApi.md#withdrawagentapplication) | **DELETE** /api/v1/agents/me/assignments/{id} | Withdraw an unanswered application (superseded by DELETE /agents/me/applications/{id})


# **acceptAgentAssignment**
> AssignmentResponse acceptAgentAssignment(id)

Accept an offer; the listing can then offer visits (RM-M05-07)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentAssignationsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.acceptAgentAssignment(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentAssignationsApi->acceptAgentAssignment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AssignmentResponse**](AssignmentResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **acceptResidenceAssignment**
> BatchResult acceptResidenceAssignment(residenceId)

Accept a whole residence batch; answering unit by unit is the same tedium in reverse

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentAssignationsApi();
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.acceptResidenceAssignment(residenceId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentAssignationsApi->acceptResidenceAssignment: $e\n');
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

# **applyToAnnonce**
> AssignmentResponse applyToAnnonce(annonceId)

Apply to a listing; the prestataire still decides (RM-M11-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentAssignationsApi();
final String annonceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.applyToAnnonce(annonceId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentAssignationsApi->applyToAnnonce: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **annonceId** | **String**|  | 

### Return type

[**AssignmentResponse**](AssignmentResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **applyToResidence**
> ResidenceAssignmentResult applyToResidence(residenceId)

Apply to every open unit of a residence in one act (M11)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentAssignationsApi();
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.applyToResidence(residenceId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentAssignationsApi->applyToResidence: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **residenceId** | **String**|  | 

### Return type

[**ResidenceAssignmentResult**](ResidenceAssignmentResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **declineAgentAssignment**
> AssignmentResponse declineAgentAssignment(id)

Decline an offer; the prestataire is told so they can ask someone else

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentAssignationsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.declineAgentAssignment(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentAssignationsApi->declineAgentAssignment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AssignmentResponse**](AssignmentResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **declineResidenceAssignment**
> BatchResult declineResidenceAssignment(residenceId)

Decline a whole residence batch

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentAssignationsApi();
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.declineResidenceAssignment(residenceId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentAssignationsApi->declineResidenceAssignment: $e\n');
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

# **listAgentOpportunities**
> BuiltList<OpportunityItem> listAgentOpportunities()

What the agent may apply to: standalone listings and whole residences, in their zones

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentAssignationsApi();

try {
    final response = api.listAgentOpportunities();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentAssignationsApi->listAgentOpportunities: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;OpportunityItem&gt;**](OpportunityItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyAgentAssignments**
> PageResponseAssignmentItem listMyAgentAssignments(pageable, status, initiatedBy)

Everything the agent holds, newest first — offers and accepted applications alike

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentAssignationsApi();
final Pageable pageable = ; // Pageable | 
final BuiltList<String> status = ; // BuiltList<String> | 
final BuiltList<String> initiatedBy = ; // BuiltList<String> | 

try {
    final response = api.listMyAgentAssignments(pageable, status, initiatedBy);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentAssignationsApi->listMyAgentAssignments: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **status** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 
 **initiatedBy** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 

### Return type

[**PageResponseAssignmentItem**](PageResponseAssignmentItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resignAgentAssignment**
> AssignmentResponse resignAgentAssignment(id)

Step down from an assignment already accepted; booked visits are cancelled

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentAssignationsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.resignAgentAssignment(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentAssignationsApi->resignAgentAssignment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AssignmentResponse**](AssignmentResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resignResidenceAssignment**
> BatchResult resignResidenceAssignment(residenceId)

Step down from a whole residence at once (RM-M10bis-10)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentAssignationsApi();
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.resignResidenceAssignment(residenceId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentAssignationsApi->resignResidenceAssignment: $e\n');
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

# **withdrawAgentApplication**
> withdrawAgentApplication(id)

Withdraw an unanswered application (superseded by DELETE /agents/me/applications/{id})

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentAssignationsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.withdrawAgentApplication(id);
} on DioException catch (e) {
    print('Exception when calling AgentAssignationsApi->withdrawAgentApplication: $e\n');
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

