# api_client.api.RservationsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**cancelMyReservation**](RservationsApi.md#cancelmyreservation) | **POST** /api/v1/reservations/{id}/cancel | Withdraw a request, or cancel an accepted reservation — free before signature (RM-M29-08)
[**getMyReservation**](RservationsApi.md#getmyreservation) | **GET** /api/v1/reservations/{id} | One of my reservation requests
[**listMyReservations**](RservationsApi.md#listmyreservations) | **GET** /api/v1/reservations | My reservation requests, newest first
[**requestReservation**](RservationsApi.md#requestreservation) | **POST** /api/v1/reservations | Ask to reserve a published listing: move-in day, duration, a word (RM-M29-01)


# **cancelMyReservation**
> ReservationResponse cancelMyReservation(id)

Withdraw a request, or cancel an accepted reservation — free before signature (RM-M29-08)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRservationsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.cancelMyReservation(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RservationsApi->cancelMyReservation: $e\n');
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

# **getMyReservation**
> ReservationResponse getMyReservation(id)

One of my reservation requests

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRservationsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getMyReservation(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RservationsApi->getMyReservation: $e\n');
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

# **listMyReservations**
> PageResponseReservationResponse listMyReservations(pageable, status)

My reservation requests, newest first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRservationsApi();
final Pageable pageable = ; // Pageable | 
final BuiltList<String> status = ; // BuiltList<String> | 

try {
    final response = api.listMyReservations(pageable, status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RservationsApi->listMyReservations: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **status** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 

### Return type

[**PageResponseReservationResponse**](PageResponseReservationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **requestReservation**
> ReservationResponse requestReservation(createReservationRequest)

Ask to reserve a published listing: move-in day, duration, a word (RM-M29-01)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRservationsApi();
final CreateReservationRequest createReservationRequest = ; // CreateReservationRequest | 

try {
    final response = api.requestReservation(createReservationRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RservationsApi->requestReservation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createReservationRequest** | [**CreateReservationRequest**](CreateReservationRequest.md)|  | 

### Return type

[**ReservationResponse**](ReservationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

