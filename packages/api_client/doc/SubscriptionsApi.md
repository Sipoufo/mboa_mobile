# api_client.api.SubscriptionsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getPayment**](SubscriptionsApi.md#getpayment) | **GET** /api/v1/subscriptions/payments/{id} | Get one payment&#39;s current status (poll this after initiating a payment)
[**listMyPayments**](SubscriptionsApi.md#listmypayments) | **GET** /api/v1/subscriptions/payments | List the authenticated prestataire&#39;s payments, most recent first
[**mySubscription**](SubscriptionsApi.md#mysubscription) | **GET** /api/v1/subscriptions/me | Get the authenticated account&#39;s current subscription
[**receipt**](SubscriptionsApi.md#receipt) | **GET** /api/v1/subscriptions/payments/{id}/receipt | Get a short-lived URL to download a payment&#39;s PDF receipt
[**subscribe**](SubscriptionsApi.md#subscribe) | **POST** /api/v1/subscriptions | Subscribe to (or upgrade to) a paid tier; initiates a mobile-money payment
[**tiers**](SubscriptionsApi.md#tiers) | **GET** /api/v1/subscriptions/tiers | List the subscription tiers and their current parameters
[**webhook**](SubscriptionsApi.md#webhook) | **POST** /api/v1/subscriptions/webhook | Payment confirmation webhook (HMAC-verified)


# **getPayment**
> PaymentSummary getPayment(id)

Get one payment's current status (poll this after initiating a payment)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSubscriptionsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getPayment(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SubscriptionsApi->getPayment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**PaymentSummary**](PaymentSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyPayments**
> PageResponsePaymentSummary listMyPayments(pageable)

List the authenticated prestataire's payments, most recent first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSubscriptionsApi();
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listMyPayments(pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SubscriptionsApi->listMyPayments: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponsePaymentSummary**](PageResponsePaymentSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mySubscription**
> SubscriptionResponse mySubscription()

Get the authenticated account's current subscription

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSubscriptionsApi();

try {
    final response = api.mySubscription();
    print(response);
} on DioException catch (e) {
    print('Exception when calling SubscriptionsApi->mySubscription: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SubscriptionResponse**](SubscriptionResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **receipt**
> ReceiptResponse receipt(id)

Get a short-lived URL to download a payment's PDF receipt

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSubscriptionsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.receipt(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SubscriptionsApi->receipt: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ReceiptResponse**](ReceiptResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **subscribe**
> PaymentInitiatedResponse subscribe(subscribeRequest, idempotencyKey)

Subscribe to (or upgrade to) a paid tier; initiates a mobile-money payment

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSubscriptionsApi();
final SubscribeRequest subscribeRequest = ; // SubscribeRequest | 
final String idempotencyKey = idempotencyKey_example; // String | 

try {
    final response = api.subscribe(subscribeRequest, idempotencyKey);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SubscriptionsApi->subscribe: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **subscribeRequest** | [**SubscribeRequest**](SubscribeRequest.md)|  | 
 **idempotencyKey** | **String**|  | [optional] 

### Return type

[**PaymentInitiatedResponse**](PaymentInitiatedResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tiers**
> BuiltList<TierInfo> tiers()

List the subscription tiers and their current parameters

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSubscriptionsApi();

try {
    final response = api.tiers();
    print(response);
} on DioException catch (e) {
    print('Exception when calling SubscriptionsApi->tiers: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;TierInfo&gt;**](TierInfo.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **webhook**
> webhook(paymentWebhookRequest)

Payment confirmation webhook (HMAC-verified)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSubscriptionsApi();
final PaymentWebhookRequest paymentWebhookRequest = ; // PaymentWebhookRequest | 

try {
    api.webhook(paymentWebhookRequest);
} on DioException catch (e) {
    print('Exception when calling SubscriptionsApi->webhook: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **paymentWebhookRequest** | [**PaymentWebhookRequest**](PaymentWebhookRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

