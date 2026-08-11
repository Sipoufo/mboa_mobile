# api_client.api.AgentApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**blockMyAgentDay**](AgentApi.md#blockmyagentday) | **POST** /api/v1/agents/me/days-off | Block a whole day off (congés — RM-M15-03)
[**getMyAgentAvailability**](AgentApi.md#getmyagentavailability) | **GET** /api/v1/agents/me/availability | The agent&#39;s weekly working pattern, visit length and days off
[**getMyAgentProfile**](AgentApi.md#getmyagentprofile) | **GET** /api/v1/agents/me | Get the authenticated agent&#39;s profile
[**listMyAgentDaysOff**](AgentApi.md#listmyagentdaysoff) | **GET** /api/v1/agents/me/days-off | Days the agent has blocked off
[**unblockMyAgentDay**](AgentApi.md#unblockmyagentday) | **DELETE** /api/v1/agents/me/days-off/{day} | Reopen a blocked day
[**updateMyAgentAvailability**](AgentApi.md#updatemyagentavailability) | **PUT** /api/v1/agents/me/availability | Replace the weekly pattern, e.g. Mon-Sat 08:00-18:00 (RM-M15-01)
[**updateMyAgentProfile**](AgentApi.md#updatemyagentprofile) | **PATCH** /api/v1/agents/me | Update the agent&#39;s profile; acceptingAssignments&#x3D;false is \&quot;Inactif\&quot; (RM-M15-05)
[**updateMyAgentZones**](AgentApi.md#updatemyagentzones) | **PUT** /api/v1/agents/me/zones | Replace the agent&#39;s intervention zones — cities and/or districts (RM-M15-04)


# **blockMyAgentDay**
> blockMyAgentDay(blockDayRequest)

Block a whole day off (congés — RM-M15-03)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentApi();
final BlockDayRequest blockDayRequest = ; // BlockDayRequest | 

try {
    api.blockMyAgentDay(blockDayRequest);
} on DioException catch (e) {
    print('Exception when calling AgentApi->blockMyAgentDay: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **blockDayRequest** | [**BlockDayRequest**](BlockDayRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyAgentAvailability**
> AvailabilityResponse getMyAgentAvailability()

The agent's weekly working pattern, visit length and days off

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentApi();

try {
    final response = api.getMyAgentAvailability();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentApi->getMyAgentAvailability: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AvailabilityResponse**](AvailabilityResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyAgentProfile**
> AgentProfileResponse getMyAgentProfile()

Get the authenticated agent's profile

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentApi();

try {
    final response = api.getMyAgentProfile();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentApi->getMyAgentProfile: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AgentProfileResponse**](AgentProfileResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyAgentDaysOff**
> BuiltList<Date> listMyAgentDaysOff()

Days the agent has blocked off

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentApi();

try {
    final response = api.listMyAgentDaysOff();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentApi->listMyAgentDaysOff: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Date&gt;**](Date.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unblockMyAgentDay**
> unblockMyAgentDay(day)

Reopen a blocked day

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentApi();
final Date day = 2013-10-20; // Date | 

try {
    api.unblockMyAgentDay(day);
} on DioException catch (e) {
    print('Exception when calling AgentApi->unblockMyAgentDay: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **day** | **Date**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMyAgentAvailability**
> AvailabilityResponse updateMyAgentAvailability(updateAvailabilityRequest)

Replace the weekly pattern, e.g. Mon-Sat 08:00-18:00 (RM-M15-01)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentApi();
final UpdateAvailabilityRequest updateAvailabilityRequest = ; // UpdateAvailabilityRequest | 

try {
    final response = api.updateMyAgentAvailability(updateAvailabilityRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentApi->updateMyAgentAvailability: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateAvailabilityRequest** | [**UpdateAvailabilityRequest**](UpdateAvailabilityRequest.md)|  | 

### Return type

[**AvailabilityResponse**](AvailabilityResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMyAgentProfile**
> AgentProfileResponse updateMyAgentProfile(updateAgentProfileRequest)

Update the agent's profile; acceptingAssignments=false is \"Inactif\" (RM-M15-05)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentApi();
final UpdateAgentProfileRequest updateAgentProfileRequest = ; // UpdateAgentProfileRequest | 

try {
    final response = api.updateMyAgentProfile(updateAgentProfileRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentApi->updateMyAgentProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateAgentProfileRequest** | [**UpdateAgentProfileRequest**](UpdateAgentProfileRequest.md)|  | 

### Return type

[**AgentProfileResponse**](AgentProfileResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMyAgentZones**
> AgentProfileResponse updateMyAgentZones(updateZonesRequest)

Replace the agent's intervention zones — cities and/or districts (RM-M15-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAgentApi();
final UpdateZonesRequest updateZonesRequest = ; // UpdateZonesRequest | 

try {
    final response = api.updateMyAgentZones(updateZonesRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentApi->updateMyAgentZones: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateZonesRequest** | [**UpdateZonesRequest**](UpdateZonesRequest.md)|  | 

### Return type

[**AgentProfileResponse**](AgentProfileResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

