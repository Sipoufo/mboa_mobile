# api_client.api.SignalementsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createSignalement**](SignalementsApi.md#createsignalement) | **POST** /api/v1/signalements | Report a listing or a message


# **createSignalement**
> SignalementResponse createSignalement(createSignalementRequest)

Report a listing or a message

The reporter is only told the report was received — the outcome is never disclosed to them (RM-M23-05).

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSignalementsApi();
final CreateSignalementRequest createSignalementRequest = ; // CreateSignalementRequest | 

try {
    final response = api.createSignalement(createSignalementRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SignalementsApi->createSignalement: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createSignalementRequest** | [**CreateSignalementRequest**](CreateSignalementRequest.md)|  | 

### Return type

[**SignalementResponse**](SignalementResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

