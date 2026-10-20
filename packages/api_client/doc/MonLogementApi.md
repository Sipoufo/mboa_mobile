# api_client.api.MonLogementApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**confirmDeclaration**](MonLogementApi.md#confirmdeclaration) | **POST** /api/v1/prestataires/me/declarations/{declarationId}/confirm | Confirm a declared payment: it now pays its échéances (RM-M30-04, RM-M30-08)
[**contestDeclaration**](MonLogementApi.md#contestdeclaration) | **POST** /api/v1/prestataires/me/declarations/{declarationId}/contest | Contest a declared payment, with a reason the tenant sees (RM-M30-04, RM-M30-07)
[**declarePayment**](MonLogementApi.md#declarepayment) | **POST** /api/v1/homes/{contractId}/declarations | Declare a payment made outside Mboa: rent (one or more échéances) or deposit, proofs optional (RM-M30-03)
[**getDeclarationProofs**](MonLogementApi.md#getdeclarationproofs) | **GET** /api/v1/homes/{contractId}/declarations/{declarationId}/proofs | Short-lived links to a declaration&#39;s proofs — the two parties only
[**getHome**](MonLogementApi.md#gethome) | **GET** /api/v1/homes/{contractId} | One home, tenant or landlord: the summary and its échéancier up to the next 12 (RM-M30-01/02)
[**getHomeDeclaration**](MonLogementApi.md#gethomedeclaration) | **GET** /api/v1/homes/{contractId}/declarations/{declarationId} | One declared payment of a home
[**getHomeFinanceSummary**](MonLogementApi.md#gethomefinancesummary) | **GET** /api/v1/homes/{contractId}/summary | A home&#39;s totals — confirmed, waiting, contested; only confirmed counts as paid (RM-M30-08)
[**getHomeSchedule**](MonLogementApi.md#gethomeschedule) | **GET** /api/v1/homes/{contractId}/schedule | A window of a home&#39;s échéancier, computed from the contract — at most the next 12, 100 per answer (RM-M30-02)
[**getMyReceivedDeclaration**](MonLogementApi.md#getmyreceiveddeclaration) | **GET** /api/v1/prestataires/me/declarations/{declarationId} | One declared payment on my homes — what N-35 opens
[**listHomeDeclarations**](MonLogementApi.md#listhomedeclarations) | **GET** /api/v1/homes/{contractId}/declarations | A home&#39;s declared payments, newest first
[**listMyHomes**](MonLogementApi.md#listmyhomes) | **GET** /api/v1/homes | My homes — one per signed contract, active first, then to come, then ended (RM-M30-01)
[**listMyReceivedDeclarations**](MonLogementApi.md#listmyreceiveddeclarations) | **GET** /api/v1/prestataires/me/declarations | Declared payments on my homes, oldest first — status&#x3D;DECLARED,UNCONFIRMED is the inbox (RM-M30-04)
[**listMyTenantHomes**](MonLogementApi.md#listmytenanthomes) | **GET** /api/v1/prestataires/me/homes | The homes on my properties, one per signed contract, active first (RM-M30-14: mine only)


# **confirmDeclaration**
> DeclarationResponse confirmDeclaration(declarationId)

Confirm a declared payment: it now pays its échéances (RM-M30-04, RM-M30-08)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String declarationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.confirmDeclaration(declarationId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->confirmDeclaration: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **declarationId** | **String**|  | 

### Return type

[**DeclarationResponse**](DeclarationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **contestDeclaration**
> DeclarationResponse contestDeclaration(declarationId, contestDeclarationRequest)

Contest a declared payment, with a reason the tenant sees (RM-M30-04, RM-M30-07)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String declarationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ContestDeclarationRequest contestDeclarationRequest = ; // ContestDeclarationRequest | 

try {
    final response = api.contestDeclaration(declarationId, contestDeclarationRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->contestDeclaration: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **declarationId** | **String**|  | 
 **contestDeclarationRequest** | [**ContestDeclarationRequest**](ContestDeclarationRequest.md)|  | 

### Return type

[**DeclarationResponse**](DeclarationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **declarePayment**
> DeclarationResponse declarePayment(contractId, declarePaymentRequest)

Declare a payment made outside Mboa: rent (one or more échéances) or deposit, proofs optional (RM-M30-03)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final DeclarePaymentRequest declarePaymentRequest = ; // DeclarePaymentRequest | 

try {
    final response = api.declarePayment(contractId, declarePaymentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->declarePayment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **declarePaymentRequest** | [**DeclarePaymentRequest**](DeclarePaymentRequest.md)|  | 

### Return type

[**DeclarationResponse**](DeclarationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDeclarationProofs**
> BuiltList<PresignedDownload> getDeclarationProofs(contractId, declarationId)

Short-lived links to a declaration's proofs — the two parties only

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String declarationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getDeclarationProofs(contractId, declarationId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->getDeclarationProofs: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **declarationId** | **String**|  | 

### Return type

[**BuiltList&lt;PresignedDownload&gt;**](PresignedDownload.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getHome**
> HomeDetail getHome(contractId)

One home, tenant or landlord: the summary and its échéancier up to the next 12 (RM-M30-01/02)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getHome(contractId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->getHome: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 

### Return type

[**HomeDetail**](HomeDetail.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getHomeDeclaration**
> DeclarationResponse getHomeDeclaration(contractId, declarationId)

One declared payment of a home

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String declarationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getHomeDeclaration(contractId, declarationId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->getHomeDeclaration: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **declarationId** | **String**|  | 

### Return type

[**DeclarationResponse**](DeclarationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getHomeFinanceSummary**
> HomeFinanceSummary getHomeFinanceSummary(contractId)

A home's totals — confirmed, waiting, contested; only confirmed counts as paid (RM-M30-08)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getHomeFinanceSummary(contractId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->getHomeFinanceSummary: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 

### Return type

[**HomeFinanceSummary**](HomeFinanceSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getHomeSchedule**
> HomeSchedule getHomeSchedule(contractId, from, to)

A window of a home's échéancier, computed from the contract — at most the next 12, 100 per answer (RM-M30-02)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final Date from = 2013-10-20; // Date | 
final Date to = 2013-10-20; // Date | 

try {
    final response = api.getHomeSchedule(contractId, from, to);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->getHomeSchedule: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **from** | **Date**|  | [optional] 
 **to** | **Date**|  | [optional] 

### Return type

[**HomeSchedule**](HomeSchedule.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyReceivedDeclaration**
> DeclarationResponse getMyReceivedDeclaration(declarationId)

One declared payment on my homes — what N-35 opens

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String declarationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getMyReceivedDeclaration(declarationId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->getMyReceivedDeclaration: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **declarationId** | **String**|  | 

### Return type

[**DeclarationResponse**](DeclarationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listHomeDeclarations**
> PageResponseDeclarationResponse listHomeDeclarations(contractId, pageable)

A home's declared payments, newest first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listHomeDeclarations(contractId, pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->listHomeDeclarations: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseDeclarationResponse**](PageResponseDeclarationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyHomes**
> PageResponseHomeSummary listMyHomes(pageable, state)

My homes — one per signed contract, active first, then to come, then ended (RM-M30-01)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final Pageable pageable = ; // Pageable | 
final BuiltList<String> state = ; // BuiltList<String> | 

try {
    final response = api.listMyHomes(pageable, state);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->listMyHomes: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **state** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 

### Return type

[**PageResponseHomeSummary**](PageResponseHomeSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyReceivedDeclarations**
> PageResponseDeclarationResponse listMyReceivedDeclarations(pageable, status, contractId)

Declared payments on my homes, oldest first — status=DECLARED,UNCONFIRMED is the inbox (RM-M30-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final Pageable pageable = ; // Pageable | 
final BuiltList<String> status = ; // BuiltList<String> | 
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listMyReceivedDeclarations(pageable, status, contractId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->listMyReceivedDeclarations: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **status** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 
 **contractId** | **String**|  | [optional] 

### Return type

[**PageResponseDeclarationResponse**](PageResponseDeclarationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyTenantHomes**
> PageResponseHomeSummary listMyTenantHomes(pageable, annonceId, state)

The homes on my properties, one per signed contract, active first (RM-M30-14: mine only)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final Pageable pageable = ; // Pageable | 
final String annonceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BuiltList<String> state = ; // BuiltList<String> | 

try {
    final response = api.listMyTenantHomes(pageable, annonceId, state);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->listMyTenantHomes: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **annonceId** | **String**|  | [optional] 
 **state** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 

### Return type

[**PageResponseHomeSummary**](PageResponseHomeSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

