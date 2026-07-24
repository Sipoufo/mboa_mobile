# api_client.api.CurrentUserApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**me**](CurrentUserApi.md#me) | **GET** /api/v1/me | Get the currently authenticated account


# **me**
> MeResponse me()

Get the currently authenticated account

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCurrentUserApi();

try {
    final response = api.me();
    print(response);
} on DioException catch (e) {
    print('Exception when calling CurrentUserApi->me: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MeResponse**](MeResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

