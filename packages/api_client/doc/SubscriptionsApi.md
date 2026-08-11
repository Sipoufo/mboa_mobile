# api_client.api.SubscriptionsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getMySubscription**](SubscriptionsApi.md#getmysubscription) | **GET** /api/v1/subscriptions/me | Get the authenticated account&#39;s current subscription
[**getPayment**](SubscriptionsApi.md#getpayment) | **GET** /api/v1/subscriptions/payments/{id} | Get one payment&#39;s current status (poll this after initiating a payment)
[**getPaymentReceipt**](SubscriptionsApi.md#getpaymentreceipt) | **GET** /api/v1/subscriptions/payments/{id}/receipt | Get a short-lived URL to download a payment&#39;s PDF receipt
[**listMyPayments**](SubscriptionsApi.md#listmypayments) | **GET** /api/v1/subscriptions/payments | List the authenticated prestataire&#39;s payments, most recent first
[**listSubscriptionTiers**](SubscriptionsApi.md#listsubscriptiontiers) | **GET** /api/v1/subscriptions/tiers | List the subscription tiers and their current parameters
[**paymentWebhook**](SubscriptionsApi.md#paymentwebhook) | **POST** /api/v1/subscriptions/webhook | Payment confirmation webhook (HMAC-verified)
[**subscribe**](SubscriptionsApi.md#subscribe) | **POST** /api/v1/subscriptions | Subscribe to (or upgrade to) a paid tier; initiates a mobile-money payment


# **getMySubscription**
> SubscriptionResponse getMySubscription()

Get the authenticated account's current subscription

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSubscriptionsApi();

try {
    final response = api.getMySubscription();
    print(response);
} on DioException catch (e) {
    print('Exception when calling SubscriptionsApi->getMySubscription: $e\n');
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

# **getPaymentReceipt**
> ReceiptResponse getPaymentReceipt(id)

Get a short-lived URL to download a payment's PDF receipt

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSubscriptionsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getPaymentReceipt(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SubscriptionsApi->getPaymentReceipt: $e\n');
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

# **listSubscriptionTiers**
> BuiltList<TierInfo> listSubscriptionTiers()

List the subscription tiers and their current parameters

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSubscriptionsApi();

try {
    final response = api.listSubscriptionTiers();
    print(response);
} on DioException catch (e) {
    print('Exception when calling SubscriptionsApi->listSubscriptionTiers: $e\n');
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

# **paymentWebhook**
> paymentWebhook(paymentWebhookRequest)

Payment confirmation webhook (HMAC-verified)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSubscriptionsApi();
final PaymentWebhookRequest paymentWebhookRequest = ; // PaymentWebhookRequest | 

try {
    api.paymentWebhook(paymentWebhookRequest);
} on DioException catch (e) {
    print('Exception when calling SubscriptionsApi->paymentWebhook: $e\n');
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

