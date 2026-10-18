# api_client.api.FinanceServiceProvidersApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addServiceProviderPayment**](FinanceServiceProvidersApi.md#addserviceproviderpayment) | **POST** /api/v1/finance/providers/{id}/payments | Declare a payment; it goes into the ledger as Sortie · Prestataires (RM-M26-04)
[**archiveServiceProvider**](FinanceServiceProvidersApi.md#archiveserviceprovider) | **POST** /api/v1/finance/providers/{id}/archive | Hide an intervenant from pickers; history kept
[**createServiceProvider**](FinanceServiceProvidersApi.md#createserviceprovider) | **POST** /api/v1/finance/providers | Add an intervenant — a free entry, or linked to a messaging contact (RM-M26-01)
[**deleteServiceProvider**](FinanceServiceProvidersApi.md#deleteserviceprovider) | **DELETE** /api/v1/finance/providers/{id} | Delete an intervenant with no payments; archive the others
[**deleteServiceProviderPayment**](FinanceServiceProvidersApi.md#deleteserviceproviderpayment) | **DELETE** /api/v1/finance/providers/{id}/payments/{paymentId} | Remove a payment and its ledger line
[**getServiceProvider**](FinanceServiceProvidersApi.md#getserviceprovider) | **GET** /api/v1/finance/providers/{id} | One intervenant
[**listServiceProviderPayments**](FinanceServiceProvidersApi.md#listserviceproviderpayments) | **GET** /api/v1/finance/providers/{id}/payments | An intervenant&#39;s payments, latest first
[**listServiceProviders**](FinanceServiceProvidersApi.md#listserviceproviders) | **GET** /api/v1/finance/providers | My intervenants by name, with what each was paid
[**restoreServiceProvider**](FinanceServiceProvidersApi.md#restoreserviceprovider) | **POST** /api/v1/finance/providers/{id}/restore | Bring an archived intervenant back
[**updateServiceProvider**](FinanceServiceProvidersApi.md#updateserviceprovider) | **PATCH** /api/v1/finance/providers/{id} | Change an intervenant&#39;s name, kind or note
[**updateServiceProviderPayment**](FinanceServiceProvidersApi.md#updateserviceproviderpayment) | **PUT** /api/v1/finance/providers/{id}/payments/{paymentId} | Correct a payment; its ledger line follows


# **addServiceProviderPayment**
> ServiceProviderPaymentResponse addServiceProviderPayment(id, serviceProviderPaymentRequest)

Declare a payment; it goes into the ledger as Sortie · Prestataires (RM-M26-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceServiceProvidersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ServiceProviderPaymentRequest serviceProviderPaymentRequest = ; // ServiceProviderPaymentRequest | 

try {
    final response = api.addServiceProviderPayment(id, serviceProviderPaymentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceServiceProvidersApi->addServiceProviderPayment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **serviceProviderPaymentRequest** | [**ServiceProviderPaymentRequest**](ServiceProviderPaymentRequest.md)|  | 

### Return type

[**ServiceProviderPaymentResponse**](ServiceProviderPaymentResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **archiveServiceProvider**
> ServiceProviderResponse archiveServiceProvider(id)

Hide an intervenant from pickers; history kept

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceServiceProvidersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.archiveServiceProvider(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceServiceProvidersApi->archiveServiceProvider: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ServiceProviderResponse**](ServiceProviderResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createServiceProvider**
> ServiceProviderResponse createServiceProvider(serviceProviderRequest)

Add an intervenant — a free entry, or linked to a messaging contact (RM-M26-01)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceServiceProvidersApi();
final ServiceProviderRequest serviceProviderRequest = ; // ServiceProviderRequest | 

try {
    final response = api.createServiceProvider(serviceProviderRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceServiceProvidersApi->createServiceProvider: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **serviceProviderRequest** | [**ServiceProviderRequest**](ServiceProviderRequest.md)|  | 

### Return type

[**ServiceProviderResponse**](ServiceProviderResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteServiceProvider**
> deleteServiceProvider(id)

Delete an intervenant with no payments; archive the others

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceServiceProvidersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.deleteServiceProvider(id);
} on DioException catch (e) {
    print('Exception when calling FinanceServiceProvidersApi->deleteServiceProvider: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteServiceProviderPayment**
> deleteServiceProviderPayment(id, paymentId)

Remove a payment and its ledger line

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceServiceProvidersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String paymentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.deleteServiceProviderPayment(id, paymentId);
} on DioException catch (e) {
    print('Exception when calling FinanceServiceProvidersApi->deleteServiceProviderPayment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **paymentId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getServiceProvider**
> ServiceProviderResponse getServiceProvider(id)

One intervenant

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceServiceProvidersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getServiceProvider(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceServiceProvidersApi->getServiceProvider: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ServiceProviderResponse**](ServiceProviderResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listServiceProviderPayments**
> BuiltList<ServiceProviderPaymentResponse> listServiceProviderPayments(id)

An intervenant's payments, latest first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceServiceProvidersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listServiceProviderPayments(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceServiceProvidersApi->listServiceProviderPayments: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BuiltList&lt;ServiceProviderPaymentResponse&gt;**](ServiceProviderPaymentResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listServiceProviders**
> BuiltList<ServiceProviderResponse> listServiceProviders(includeArchived)

My intervenants by name, with what each was paid

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceServiceProvidersApi();
final bool includeArchived = true; // bool | 

try {
    final response = api.listServiceProviders(includeArchived);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceServiceProvidersApi->listServiceProviders: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **includeArchived** | **bool**|  | [optional] [default to false]

### Return type

[**BuiltList&lt;ServiceProviderResponse&gt;**](ServiceProviderResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restoreServiceProvider**
> ServiceProviderResponse restoreServiceProvider(id)

Bring an archived intervenant back

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceServiceProvidersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.restoreServiceProvider(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceServiceProvidersApi->restoreServiceProvider: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ServiceProviderResponse**](ServiceProviderResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateServiceProvider**
> ServiceProviderResponse updateServiceProvider(id, updateServiceProviderRequest)

Change an intervenant's name, kind or note

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceServiceProvidersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateServiceProviderRequest updateServiceProviderRequest = ; // UpdateServiceProviderRequest | 

try {
    final response = api.updateServiceProvider(id, updateServiceProviderRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceServiceProvidersApi->updateServiceProvider: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateServiceProviderRequest** | [**UpdateServiceProviderRequest**](UpdateServiceProviderRequest.md)|  | 

### Return type

[**ServiceProviderResponse**](ServiceProviderResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateServiceProviderPayment**
> ServiceProviderPaymentResponse updateServiceProviderPayment(id, paymentId, serviceProviderPaymentRequest)

Correct a payment; its ledger line follows

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFinanceServiceProvidersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String paymentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ServiceProviderPaymentRequest serviceProviderPaymentRequest = ; // ServiceProviderPaymentRequest | 

try {
    final response = api.updateServiceProviderPayment(id, paymentId, serviceProviderPaymentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FinanceServiceProvidersApi->updateServiceProviderPayment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **paymentId** | **String**|  | 
 **serviceProviderPaymentRequest** | [**ServiceProviderPaymentRequest**](ServiceProviderPaymentRequest.md)|  | 

### Return type

[**ServiceProviderPaymentResponse**](ServiceProviderPaymentResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

