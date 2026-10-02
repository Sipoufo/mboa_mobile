# api_client.api.PrestataireVisitesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**cancelMyOwnerVisite**](PrestataireVisitesApi.md#cancelmyownervisite) | **POST** /api/v1/prestataires/me/visites/{id}/cancel | Cancel a visit up to one hour before the slot; the client is told (N-05)
[**confirmVisiteRequest**](PrestataireVisitesApi.md#confirmvisiterequest) | **POST** /api/v1/prestataires/me/visites/{id}/confirm | Confirm a proposed time; the visit becomes scheduled (RM-M15-06)
[**declineVisiteRequest**](PrestataireVisitesApi.md#declinevisiterequest) | **POST** /api/v1/prestataires/me/visites/{id}/decline | Turn a proposed time down; the client may propose another
[**getMyOwnerVisite**](PrestataireVisitesApi.md#getmyownervisite) | **GET** /api/v1/prestataires/me/visites/{id} | One visit the prestataire carries out: the client&#39;s name and phone (RM-M16-01)
[**listMyOwnerVisites**](PrestataireVisitesApi.md#listmyownervisites) | **GET** /api/v1/prestataires/me/visites | Visits the prestataire carries out themselves, newest first


# **cancelMyOwnerVisite**
> cancelMyOwnerVisite(id)

Cancel a visit up to one hour before the slot; the client is told (N-05)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPrestataireVisitesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.cancelMyOwnerVisite(id);
} on DioException catch (e) {
    print('Exception when calling PrestataireVisitesApi->cancelMyOwnerVisite: $e\n');
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

# **confirmVisiteRequest**
> VisiteResponse confirmVisiteRequest(id)

Confirm a proposed time; the visit becomes scheduled (RM-M15-06)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPrestataireVisitesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.confirmVisiteRequest(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PrestataireVisitesApi->confirmVisiteRequest: $e\n');
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

# **declineVisiteRequest**
> VisiteResponse declineVisiteRequest(id)

Turn a proposed time down; the client may propose another

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPrestataireVisitesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.declineVisiteRequest(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PrestataireVisitesApi->declineVisiteRequest: $e\n');
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

# **getMyOwnerVisite**
> AgentVisiteDetail getMyOwnerVisite(id)

One visit the prestataire carries out: the client's name and phone (RM-M16-01)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPrestataireVisitesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getMyOwnerVisite(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PrestataireVisitesApi->getMyOwnerVisite: $e\n');
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

# **listMyOwnerVisites**
> PageResponseVisiteResponse listMyOwnerVisites(pageable, status, from, to)

Visits the prestataire carries out themselves, newest first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPrestataireVisitesApi();
final Pageable pageable = ; // Pageable | 
final BuiltList<String> status = ; // BuiltList<String> | 
final DateTime from = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime to = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final response = api.listMyOwnerVisites(pageable, status, from, to);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PrestataireVisitesApi->listMyOwnerVisites: $e\n');
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

