# api_client.api.RservationsPrestataireApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**acceptReservation**](RservationsPrestataireApi.md#acceptreservation) | **POST** /api/v1/prestataires/me/reservations/{id}/accept | Accept: the listing is reserved for this client 7 days; the others are not retained (RM-M29-04/07)
[**cancelIncomingReservation**](RservationsPrestataireApi.md#cancelincomingreservation) | **POST** /api/v1/prestataires/me/reservations/{id}/cancel | Cancel an accepted reservation, with a reason — counted for the admin (RM-M29-08)
[**extendReservation**](RservationsPrestataireApi.md#extendreservation) | **POST** /api/v1/prestataires/me/reservations/{id}/extend | Extend an accepted reservation by 7 days, once (RM-M29-07)
[**getIncomingReservation**](RservationsPrestataireApi.md#getincomingreservation) | **GET** /api/v1/prestataires/me/reservations/{id} | One request on my listings
[**listIncomingReservations**](RservationsPrestataireApi.md#listincomingreservations) | **GET** /api/v1/prestataires/me/reservations | Requests on my listings, newest first — status&#x3D;PENDING&#39;s totalElements is the home counter
[**refuseReservation**](RservationsPrestataireApi.md#refusereservation) | **POST** /api/v1/prestataires/me/reservations/{id}/refuse | Refuse, with a reason — never public (RM-M29-06)


# **acceptReservation**
> ReservationResponse acceptReservation(id)

Accept: the listing is reserved for this client 7 days; the others are not retained (RM-M29-04/07)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRservationsPrestataireApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.acceptReservation(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RservationsPrestataireApi->acceptReservation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ReservationResponse**](ReservationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cancelIncomingReservation**
> ReservationResponse cancelIncomingReservation(id, ownerDecisionRequest)

Cancel an accepted reservation, with a reason — counted for the admin (RM-M29-08)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRservationsPrestataireApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final OwnerDecisionRequest ownerDecisionRequest = ; // OwnerDecisionRequest | 

try {
    final response = api.cancelIncomingReservation(id, ownerDecisionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RservationsPrestataireApi->cancelIncomingReservation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **ownerDecisionRequest** | [**OwnerDecisionRequest**](OwnerDecisionRequest.md)|  | 

### Return type

[**ReservationResponse**](ReservationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **extendReservation**
> ReservationResponse extendReservation(id)

Extend an accepted reservation by 7 days, once (RM-M29-07)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRservationsPrestataireApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.extendReservation(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RservationsPrestataireApi->extendReservation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ReservationResponse**](ReservationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getIncomingReservation**
> ReservationResponse getIncomingReservation(id)

One request on my listings

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRservationsPrestataireApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getIncomingReservation(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RservationsPrestataireApi->getIncomingReservation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ReservationResponse**](ReservationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listIncomingReservations**
> PageResponseReservationResponse listIncomingReservations(pageable, annonceId, status)

Requests on my listings, newest first — status=PENDING's totalElements is the home counter

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRservationsPrestataireApi();
final Pageable pageable = ; // Pageable | 
final String annonceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BuiltList<String> status = ; // BuiltList<String> | 

try {
    final response = api.listIncomingReservations(pageable, annonceId, status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RservationsPrestataireApi->listIncomingReservations: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **annonceId** | **String**|  | [optional] 
 **status** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 

### Return type

[**PageResponseReservationResponse**](PageResponseReservationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refuseReservation**
> ReservationResponse refuseReservation(id, ownerDecisionRequest)

Refuse, with a reason — never public (RM-M29-06)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRservationsPrestataireApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final OwnerDecisionRequest ownerDecisionRequest = ; // OwnerDecisionRequest | 

try {
    final response = api.refuseReservation(id, ownerDecisionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RservationsPrestataireApi->refuseReservation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **ownerDecisionRequest** | [**OwnerDecisionRequest**](OwnerDecisionRequest.md)|  | 

### Return type

[**ReservationResponse**](ReservationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

