# api_client.api.FinanceAddOnApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getFinanceAddon**](FinanceAddOnApi.md#getfinanceaddon) | **GET** /api/v1/addons/finance | My finance add-on: active, until when, and its price
[**subscribeFinanceAddon**](FinanceAddOnApi.md#subscribefinanceaddon) | **POST** /api/v1/addons/finance/subscribe | Buy 30 days of the add-on — added after the running period; same payment flow as a tier


# **getFinanceAddon**
> FinanceAddonResponse getFinanceAddon()

My finance add-on: active, until when, and its price

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceAddOnApi();

try {
    final response = api.getFinanceAddon();
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceAddOnApi->getFinanceAddon: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**FinanceAddonResponse**](FinanceAddonResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **subscribeFinanceAddon**
> PaymentInitiatedResponse subscribeFinanceAddon(subscribeAddonRequest, idempotencyKey)

Buy 30 days of the add-on — added after the running period; same payment flow as a tier

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceAddOnApi();
final SubscribeAddonRequest subscribeAddonRequest = ; // SubscribeAddonRequest | 
final String idempotencyKey = idempotencyKey_example; // String | 

try {
    final response = api.subscribeFinanceAddon(subscribeAddonRequest, idempotencyKey);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceAddOnApi->subscribeFinanceAddon: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **subscribeAddonRequest** | [**SubscribeAddonRequest**](SubscribeAddonRequest.md)|  | 
 **idempotencyKey** | **String**|  | [optional] 

### Return type

[**PaymentInitiatedResponse**](PaymentInitiatedResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

