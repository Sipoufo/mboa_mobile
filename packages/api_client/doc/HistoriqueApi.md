# api_client.api.HistoriqueApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**clearMyHistorique**](HistoriqueApi.md#clearmyhistorique) | **DELETE** /api/v1/historique | Reset the consultation history (RM-M06-05)
[**listMyHistorique**](HistoriqueApi.md#listmyhistorique) | **GET** /api/v1/historique | The 30 most recently consulted listings, newest first


# **clearMyHistorique**
> clearMyHistorique()

Reset the consultation history (RM-M06-05)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getHistoriqueApi();

try {
    api.clearMyHistorique();
} on DioException catch (e) {
    print('Exception when calling HistoriqueApi->clearMyHistorique: $e\n');
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

# **listMyHistorique**
> PageResponseHistoriqueResponse listMyHistorique(pageable)

The 30 most recently consulted listings, newest first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getHistoriqueApi();
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listMyHistorique(pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling HistoriqueApi->listMyHistorique: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseHistoriqueResponse**](PageResponseHistoriqueResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

