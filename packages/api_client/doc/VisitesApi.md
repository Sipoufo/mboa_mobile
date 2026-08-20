# api_client.api.VisitesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**bookVisite**](VisitesApi.md#bookvisite) | **POST** /api/v1/visites | Book a visit in one of the agent&#39;s free slots
[**cancelMyVisite**](VisitesApi.md#cancelmyvisite) | **POST** /api/v1/visites/{id}/cancel | Cancel a visit — allowed up to 4 hours before the slot (RM-M07-04)
[**confirmClientPresence**](VisitesApi.md#confirmclientpresence) | **POST** /api/v1/visites/{id}/client-confirmation | Confirm you are at the visit; with the visitor&#39;s, it completes it (RM-M07-05)
[**listBookableSlots**](VisitesApi.md#listbookableslots) | **GET** /api/v1/visites/slots | The bookable visitors for a listing, each with their own times (RM-M07-01)
[**listMyVisites**](VisitesApi.md#listmyvisites) | **GET** /api/v1/visites | The authenticated user&#39;s visits
[**rateVisiteAgent**](VisitesApi.md#ratevisiteagent) | **POST** /api/v1/visites/{id}/rating | Rate the agent 1–5 after the visit; optional, and only once (RM-M07-07)


# **bookVisite**
> VisiteResponse bookVisite(bookVisiteRequest)

Book a visit in one of the agent's free slots

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVisitesApi();
final BookVisiteRequest bookVisiteRequest = ; // BookVisiteRequest | 

try {
    final response = api.bookVisite(bookVisiteRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling VisitesApi->bookVisite: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookVisiteRequest** | [**BookVisiteRequest**](BookVisiteRequest.md)|  | 

### Return type

[**VisiteResponse**](VisiteResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cancelMyVisite**
> cancelMyVisite(id)

Cancel a visit — allowed up to 4 hours before the slot (RM-M07-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVisitesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.cancelMyVisite(id);
} on DioException catch (e) {
    print('Exception when calling VisitesApi->cancelMyVisite: $e\n');
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

# **confirmClientPresence**
> VisiteResponse confirmClientPresence(id)

Confirm you are at the visit; with the visitor's, it completes it (RM-M07-05)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVisitesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.confirmClientPresence(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling VisitesApi->confirmClientPresence: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**VisiteResponse**](VisiteResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listBookableSlots**
> BuiltList<VisitorSlots> listBookableSlots(annonceId)

The bookable visitors for a listing, each with their own times (RM-M07-01)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVisitesApi();
final String annonceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listBookableSlots(annonceId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling VisitesApi->listBookableSlots: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **annonceId** | **String**|  | 

### Return type

[**BuiltList&lt;VisitorSlots&gt;**](VisitorSlots.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyVisites**
> PageResponseVisiteResponse listMyVisites(pageable, status, from, to)

The authenticated user's visits

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVisitesApi();
final Pageable pageable = ; // Pageable | 
final BuiltList<String> status = ; // BuiltList<String> | 
final DateTime from = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime to = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final response = api.listMyVisites(pageable, status, from, to);
    print(response);
} on DioException catch (e) {
    print('Exception when calling VisitesApi->listMyVisites: $e\n');
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

# **rateVisiteAgent**
> rateVisiteAgent(id, rateAgentRequest)

Rate the agent 1–5 after the visit; optional, and only once (RM-M07-07)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVisitesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RateAgentRequest rateAgentRequest = ; // RateAgentRequest | 

try {
    api.rateVisiteAgent(id, rateAgentRequest);
} on DioException catch (e) {
    print('Exception when calling VisitesApi->rateVisiteAgent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **rateAgentRequest** | [**RateAgentRequest**](RateAgentRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

