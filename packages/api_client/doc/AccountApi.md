# api_client.api.AccountApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteMyAccount**](AccountApi.md#deletemyaccount) | **DELETE** /api/v1/account | Delete the authenticated account (RGPD): anonymises personal data


# **deleteMyAccount**
> deleteMyAccount()

Delete the authenticated account (RGPD): anonymises personal data

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAccountApi();

try {
    api.deleteMyAccount();
} on DioException catch (e) {
    print('Exception when calling AccountApi->deleteMyAccount: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

