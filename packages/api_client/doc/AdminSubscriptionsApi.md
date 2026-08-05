# api_client.api.AdminSubscriptionsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**grant**](AdminSubscriptionsApi.md#grant) | **POST** /api/v1/admin/subscriptions | Grant a tier to an account for a number of days, without payment
[**updatePlan**](AdminSubscriptionsApi.md#updateplan) | **PATCH** /api/v1/admin/plans/{tier} | Update a tier&#39;s parameters (price, listing limit, residence unit allowance)


# **grant**
> grant(grantSubscriptionRequest)

Grant a tier to an account for a number of days, without payment

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminSubscriptionsApi();
final GrantSubscriptionRequest grantSubscriptionRequest = ; // GrantSubscriptionRequest | 

try {
    api.grant(grantSubscriptionRequest);
} on DioException catch (e) {
    print('Exception when calling AdminSubscriptionsApi->grant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **grantSubscriptionRequest** | [**GrantSubscriptionRequest**](GrantSubscriptionRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

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

