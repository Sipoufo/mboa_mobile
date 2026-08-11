# api_client.api.AdminModrationApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listSignalements**](AdminModrationApi.md#listsignalements) | **GET** /api/v1/admin/signalements | The moderation queue, oldest first; optionally filtered by status
[**rejectSignalement**](AdminModrationApi.md#rejectsignalement) | **POST** /api/v1/admin/signalements/{id}/reject | Dismiss a report as a false positive
[**restoreAnnonce**](AdminModrationApi.md#restoreannonce) | **POST** /api/v1/admin/annonces/{id}/restore | Restore a suspended listing (false positive — RM-M19-04)
[**validateSignalement**](AdminModrationApi.md#validatesignalement) | **POST** /api/v1/admin/signalements/{id}/validate | Uphold a report; the 3rd upheld one on a listing suspends it automatically


# **listSignalements**
> PageResponseSignalementResponse listSignalements(pageable, status)

The moderation queue, oldest first; optionally filtered by status

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminModrationApi();
final Pageable pageable = ; // Pageable | 
final String status = status_example; // String | 

try {
    final response = api.listSignalements(pageable, status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminModrationApi->listSignalements: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **status** | **String**|  | [optional] 

### Return type

[**PageResponseSignalementResponse**](PageResponseSignalementResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rejectSignalement**
> SignalementResponse rejectSignalement(id, reviewSignalementRequest)

Dismiss a report as a false positive

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminModrationApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ReviewSignalementRequest reviewSignalementRequest = ; // ReviewSignalementRequest | 

try {
    final response = api.rejectSignalement(id, reviewSignalementRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminModrationApi->rejectSignalement: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **reviewSignalementRequest** | [**ReviewSignalementRequest**](ReviewSignalementRequest.md)|  | [optional] 

### Return type

[**SignalementResponse**](SignalementResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restoreAnnonce**
> AnnonceResponse restoreAnnonce(id)

Restore a suspended listing (false positive — RM-M19-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminModrationApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.restoreAnnonce(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminModrationApi->restoreAnnonce: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AnnonceResponse**](AnnonceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **validateSignalement**
> SignalementResponse validateSignalement(id, reviewSignalementRequest)

Uphold a report; the 3rd upheld one on a listing suspends it automatically

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminModrationApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ReviewSignalementRequest reviewSignalementRequest = ; // ReviewSignalementRequest | 

try {
    final response = api.validateSignalement(id, reviewSignalementRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminModrationApi->validateSignalement: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **reviewSignalementRequest** | [**ReviewSignalementRequest**](ReviewSignalementRequest.md)|  | [optional] 

### Return type

[**SignalementResponse**](SignalementResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

