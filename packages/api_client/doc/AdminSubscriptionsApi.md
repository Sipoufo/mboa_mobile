# api_client.api.AdminSubscriptionsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**extendSubscription**](AdminSubscriptionsApi.md#extendsubscription) | **POST** /api/v1/admin/subscriptions/{accountId}/extend | Add days to a subscription, same tier, with a mandatory reason (RM-M21-04)
[**getAdminSubscription**](AdminSubscriptionsApi.md#getadminsubscription) | **GET** /api/v1/admin/subscriptions/{accountId} | One prestataire&#39;s subscription, payments and admin adjustments
[**getSubscriptionRecap**](AdminSubscriptionsApi.md#getsubscriptionrecap) | **GET** /api/v1/admin/subscriptions/recap | Monthly recap: revenue, refunds, active prestataires and MRR per tier, exact FCFA (RM-M21-02)
[**grantSubscription**](AdminSubscriptionsApi.md#grantsubscription) | **POST** /api/v1/admin/subscriptions | Grant a tier without payment, with a mandatory reason; refused over a paid period (RM-M21-01)
[**listAdminPayments**](AdminSubscriptionsApi.md#listadminpayments) | **GET** /api/v1/admin/payments | Payment history, filtered by status, account and month
[**listAdminSubscriptions**](AdminSubscriptionsApi.md#listadminsubscriptions) | **GET** /api/v1/admin/subscriptions | Subscriptions, filtered by tier and status
[**refundPayment**](AdminSubscriptionsApi.md#refundpayment) | **POST** /api/v1/admin/payments/{id}/refund | Record a refund made outside the platform; access is not cut (RM-M21-03)
[**updatePlan**](AdminSubscriptionsApi.md#updateplan) | **PATCH** /api/v1/admin/plans/{tier} | Update a tier&#39;s parameters (price, listing limit, residence unit allowance)


# **extendSubscription**
> AdminSubscriptionItem extendSubscription(accountId, extendSubscriptionRequest)

Add days to a subscription, same tier, with a mandatory reason (RM-M21-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminSubscriptionsApi();
final String accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ExtendSubscriptionRequest extendSubscriptionRequest = ; // ExtendSubscriptionRequest | 

try {
    final response = api.extendSubscription(accountId, extendSubscriptionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminSubscriptionsApi->extendSubscription: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 
 **extendSubscriptionRequest** | [**ExtendSubscriptionRequest**](ExtendSubscriptionRequest.md)|  | 

### Return type

[**AdminSubscriptionItem**](AdminSubscriptionItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAdminSubscription**
> AdminSubscriptionDetail getAdminSubscription(accountId)

One prestataire's subscription, payments and admin adjustments

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminSubscriptionsApi();
final String accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getAdminSubscription(accountId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminSubscriptionsApi->getAdminSubscription: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 

### Return type

[**AdminSubscriptionDetail**](AdminSubscriptionDetail.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSubscriptionRecap**
> SubscriptionRecapResponse getSubscriptionRecap(month)

Monthly recap: revenue, refunds, active prestataires and MRR per tier, exact FCFA (RM-M21-02)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminSubscriptionsApi();
final String month = month_example; // String | YYYY-MM, Africa/Douala; the current month when absent

try {
    final response = api.getSubscriptionRecap(month);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminSubscriptionsApi->getSubscriptionRecap: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **month** | **String**| YYYY-MM, Africa/Douala; the current month when absent | [optional] 

### Return type

[**SubscriptionRecapResponse**](SubscriptionRecapResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **grantSubscription**
> AdminSubscriptionItem grantSubscription(grantSubscriptionRequest)

Grant a tier without payment, with a mandatory reason; refused over a paid period (RM-M21-01)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminSubscriptionsApi();
final GrantSubscriptionRequest grantSubscriptionRequest = ; // GrantSubscriptionRequest | 

try {
    final response = api.grantSubscription(grantSubscriptionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminSubscriptionsApi->grantSubscription: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **grantSubscriptionRequest** | [**GrantSubscriptionRequest**](GrantSubscriptionRequest.md)|  | 

### Return type

[**AdminSubscriptionItem**](AdminSubscriptionItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAdminPayments**
> PageResponseAdminPaymentItem listAdminPayments(pageable, status, accountId, month)

Payment history, filtered by status, account and month

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminSubscriptionsApi();
final Pageable pageable = ; // Pageable | 
final String status = status_example; // String | 
final String accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String month = month_example; // String | YYYY-MM, by initiation date

try {
    final response = api.listAdminPayments(pageable, status, accountId, month);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminSubscriptionsApi->listAdminPayments: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **status** | **String**|  | [optional] 
 **accountId** | **String**|  | [optional] 
 **month** | **String**| YYYY-MM, by initiation date | [optional] 

### Return type

[**PageResponseAdminPaymentItem**](PageResponseAdminPaymentItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAdminSubscriptions**
> PageResponseAdminSubscriptionItem listAdminSubscriptions(pageable, tier, status)

Subscriptions, filtered by tier and status

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminSubscriptionsApi();
final Pageable pageable = ; // Pageable | 
final String tier = tier_example; // String | 
final String status = status_example; // String | 

try {
    final response = api.listAdminSubscriptions(pageable, tier, status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminSubscriptionsApi->listAdminSubscriptions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **tier** | **String**|  | [optional] 
 **status** | **String**|  | [optional] 

### Return type

[**PageResponseAdminSubscriptionItem**](PageResponseAdminSubscriptionItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refundPayment**
> AdminPaymentItem refundPayment(id, refundPaymentRequest)

Record a refund made outside the platform; access is not cut (RM-M21-03)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminSubscriptionsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RefundPaymentRequest refundPaymentRequest = ; // RefundPaymentRequest | 

try {
    final response = api.refundPayment(id, refundPaymentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminSubscriptionsApi->refundPayment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **refundPaymentRequest** | [**RefundPaymentRequest**](RefundPaymentRequest.md)|  | 

### Return type

[**AdminPaymentItem**](AdminPaymentItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePlan**
> TierInfo updatePlan(tier, updatePlanRequest)

Update a tier's parameters (price, listing limit, residence unit allowance)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminSubscriptionsApi();
final String tier = tier_example; // String | 
final UpdatePlanRequest updatePlanRequest = ; // UpdatePlanRequest | 

try {
    final response = api.updatePlan(tier, updatePlanRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminSubscriptionsApi->updatePlan: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tier** | **String**|  | 
 **updatePlanRequest** | [**UpdatePlanRequest**](UpdatePlanRequest.md)|  | 

### Return type

[**TierInfo**](TierInfo.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

