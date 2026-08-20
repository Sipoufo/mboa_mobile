# api_client.api.VisitesPrsenceApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**confirmVisitorPresence**](VisitesPrsenceApi.md#confirmvisitorpresence) | **POST** /api/v1/visites/{id}/visitor-confirmation | Confirm you are at the property; beyond 500 m a justification is required


# **confirmVisitorPresence**
> VisiteResponse confirmVisitorPresence(id, startVisiteRequest)

Confirm you are at the property; beyond 500 m a justification is required

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVisitesPrsenceApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final StartVisiteRequest startVisiteRequest = ; // StartVisiteRequest | 

try {
    final response = api.confirmVisitorPresence(id, startVisiteRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling VisitesPrsenceApi->confirmVisitorPresence: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **startVisiteRequest** | [**StartVisiteRequest**](StartVisiteRequest.md)|  | 

### Return type

[**VisiteResponse**](VisiteResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

