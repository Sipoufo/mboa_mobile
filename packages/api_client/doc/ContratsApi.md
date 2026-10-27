# api_client.api.ContratsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**acceptContract**](ContratsApi.md#acceptcontract) | **POST** /api/v1/contracts/{id}/accept | Accept the terms; signing opens for both parties
[**cancelContract**](ContratsApi.md#cancelcontract) | **DELETE** /api/v1/contracts/{id} | Call the contract off — either party, up to the second signature
[**confirmContractTermination**](ContratsApi.md#confirmcontracttermination) | **POST** /api/v1/contracts/{id}/termination/confirm | Agree to the termination the other party proposed — it becomes binding
[**createContract**](ContratsApi.md#createcontract) | **POST** /api/v1/contracts | Draw up a contract on one of your listings (RM-M08-01)
[**declineContractTermination**](ContratsApi.md#declinecontracttermination) | **POST** /api/v1/contracts/{id}/termination/decline | Refuse the termination the other party proposed — the contract runs on
[**getContract**](ContratsApi.md#getcontract) | **GET** /api/v1/contracts/{id} | One contract; its exact address appears only once signed (CA-M08-02)
[**getContractPdf**](ContratsApi.md#getcontractpdf) | **GET** /api/v1/contracts/{id}/pdf | A short-lived URL to download the signed contract&#39;s PDF (CA-M08-01)
[**listMyContracts**](ContratsApi.md#listmycontracts) | **GET** /api/v1/contracts | Your contracts, as landlord or as tenant
[**rateTenant**](ContratsApi.md#ratetenant) | **POST** /api/v1/contracts/{id}/tenant-rating | The landlord rates the tenant, once, within 30 days after the tenancy ended (mobile §37 A)
[**requestContractChanges**](ContratsApi.md#requestcontractchanges) | **POST** /api/v1/contracts/{id}/changes | Ask the landlord to change the terms, with a comment (CE-M08-03)
[**respondToContractChange**](ContratsApi.md#respondtocontractchange) | **POST** /api/v1/contracts/{id}/changes/{changeId}/response | Answer one objection — whether or not you amend the terms (CE-M08-03)
[**sendContract**](ContratsApi.md#sendcontract) | **POST** /api/v1/contracts/{id}/send | Send the draft to the tenant for signature (N-07)
[**signContract**](ContratsApi.md#signcontract) | **POST** /api/v1/contracts/{id}/sign | Sign; the second signature locks the contract for good (RM-M08-03)
[**terminateContract**](ContratsApi.md#terminatecontract) | **POST** /api/v1/contracts/{id}/termination | End a signed contract: notified alone with one rent period&#39;s notice (3 months at most), or proposed to the other party (RM-M08-11)
[**updateContract**](ContratsApi.md#updatecontract) | **PATCH** /api/v1/contracts/{id} | Amend terms nobody has accepted or signed yet (RM-M08-03)
[**updateContractChange**](ContratsApi.md#updatecontractchange) | **PUT** /api/v1/contracts/{id}/changes/{changeId} | Correct your own objection while it is still unanswered
[**verifyContract**](ContratsApi.md#verifycontract) | **GET** /api/v1/contracts/verify/{id} | Check a printed contract is genuine — public, needs the code on the document (RM-M08-04)
[**withdrawContractChange**](ContratsApi.md#withdrawcontractchange) | **DELETE** /api/v1/contracts/{id}/changes/{changeId} | Take your objection back; the last one returns the contract to you
[**withdrawContractTermination**](ContratsApi.md#withdrawcontracttermination) | **DELETE** /api/v1/contracts/{id}/termination | Withdraw your own proposed termination before it is answered (one notified alone is final)


# **acceptContract**
> ContractResponse acceptContract(id)

Accept the terms; signing opens for both parties

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.acceptContract(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->acceptContract: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ContractResponse**](ContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cancelContract**
> cancelContract(id)

Call the contract off — either party, up to the second signature

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.cancelContract(id);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->cancelContract: $e\n');
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

# **confirmContractTermination**
> ContractResponse confirmContractTermination(id)

Agree to the termination the other party proposed — it becomes binding

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.confirmContractTermination(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->confirmContractTermination: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ContractResponse**](ContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createContract**
> ContractResponse createContract(createContractRequest)

Draw up a contract on one of your listings (RM-M08-01)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final CreateContractRequest createContractRequest = ; // CreateContractRequest | 

try {
    final response = api.createContract(createContractRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->createContract: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createContractRequest** | [**CreateContractRequest**](CreateContractRequest.md)|  | 

### Return type

[**ContractResponse**](ContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **declineContractTermination**
> ContractResponse declineContractTermination(id)

Refuse the termination the other party proposed — the contract runs on

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.declineContractTermination(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->declineContractTermination: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ContractResponse**](ContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getContract**
> ContractResponse getContract(id)

One contract; its exact address appears only once signed (CA-M08-02)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getContract(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->getContract: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ContractResponse**](ContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getContractPdf**
> ContractPdfResponse getContractPdf(id)

A short-lived URL to download the signed contract's PDF (CA-M08-01)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getContractPdf(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->getContractPdf: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ContractPdfResponse**](ContractPdfResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyContracts**
> PageResponseContractResponse listMyContracts(pageable, status)

Your contracts, as landlord or as tenant

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final Pageable pageable = ; // Pageable | 
final BuiltList<String> status = ; // BuiltList<String> | 

try {
    final response = api.listMyContracts(pageable, status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->listMyContracts: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **status** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 

### Return type

[**PageResponseContractResponse**](PageResponseContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rateTenant**
> TenantRatingResponse rateTenant(id, rateTenantRequest)

The landlord rates the tenant, once, within 30 days after the tenancy ended (mobile §37 A)

1 to 5 stars and an optional comment only the admin reads. Never shown publicly, never revised: it feeds the tenant's Mboa Score (PROVIDER_RATING). 409 RATING_NOT_OPEN outside the window, 409 ALREADY_RATED the second time; 404 for another's contract.

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RateTenantRequest rateTenantRequest = ; // RateTenantRequest | 

try {
    final response = api.rateTenant(id, rateTenantRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->rateTenant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **rateTenantRequest** | [**RateTenantRequest**](RateTenantRequest.md)|  | 

### Return type

[**TenantRatingResponse**](TenantRatingResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **requestContractChanges**
> ContractResponse requestContractChanges(id, requestChangesRequest)

Ask the landlord to change the terms, with a comment (CE-M08-03)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RequestChangesRequest requestChangesRequest = ; // RequestChangesRequest | 

try {
    final response = api.requestContractChanges(id, requestChangesRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->requestContractChanges: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **requestChangesRequest** | [**RequestChangesRequest**](RequestChangesRequest.md)|  | 

### Return type

[**ContractResponse**](ContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **respondToContractChange**
> ContractResponse respondToContractChange(id, changeId, respondToChangeRequest)

Answer one objection — whether or not you amend the terms (CE-M08-03)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String changeId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RespondToChangeRequest respondToChangeRequest = ; // RespondToChangeRequest | 

try {
    final response = api.respondToContractChange(id, changeId, respondToChangeRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->respondToContractChange: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **changeId** | **String**|  | 
 **respondToChangeRequest** | [**RespondToChangeRequest**](RespondToChangeRequest.md)|  | 

### Return type

[**ContractResponse**](ContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendContract**
> ContractResponse sendContract(id)

Send the draft to the tenant for signature (N-07)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.sendContract(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->sendContract: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ContractResponse**](ContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **signContract**
> ContractResponse signContract(id, signContractRequest)

Sign; the second signature locks the contract for good (RM-M08-03)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final SignContractRequest signContractRequest = ; // SignContractRequest | 

try {
    final response = api.signContract(id, signContractRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->signContract: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **signContractRequest** | [**SignContractRequest**](SignContractRequest.md)|  | [optional] 

### Return type

[**ContractResponse**](ContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **terminateContract**
> ContractResponse terminateContract(id, terminateContractRequest)

End a signed contract: notified alone with one rent period's notice (3 months at most), or proposed to the other party (RM-M08-11)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final TerminateContractRequest terminateContractRequest = ; // TerminateContractRequest | 

try {
    final response = api.terminateContract(id, terminateContractRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->terminateContract: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **terminateContractRequest** | [**TerminateContractRequest**](TerminateContractRequest.md)|  | 

### Return type

[**ContractResponse**](ContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateContract**
> ContractResponse updateContract(id, updateContractRequest)

Amend terms nobody has accepted or signed yet (RM-M08-03)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateContractRequest updateContractRequest = ; // UpdateContractRequest | 

try {
    final response = api.updateContract(id, updateContractRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->updateContract: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateContractRequest** | [**UpdateContractRequest**](UpdateContractRequest.md)|  | 

### Return type

[**ContractResponse**](ContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateContractChange**
> ContractResponse updateContractChange(id, changeId, requestChangesRequest)

Correct your own objection while it is still unanswered

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String changeId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RequestChangesRequest requestChangesRequest = ; // RequestChangesRequest | 

try {
    final response = api.updateContractChange(id, changeId, requestChangesRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->updateContractChange: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **changeId** | **String**|  | 
 **requestChangesRequest** | [**RequestChangesRequest**](RequestChangesRequest.md)|  | 

### Return type

[**ContractResponse**](ContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **verifyContract**
> ContractVerification verifyContract(id, code)

Check a printed contract is genuine — public, needs the code on the document (RM-M08-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String code = code_example; // String | 

try {
    final response = api.verifyContract(id, code);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->verifyContract: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **code** | **String**|  | 

### Return type

[**ContractVerification**](ContractVerification.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **withdrawContractChange**
> ContractResponse withdrawContractChange(id, changeId)

Take your objection back; the last one returns the contract to you

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String changeId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.withdrawContractChange(id, changeId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->withdrawContractChange: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **changeId** | **String**|  | 

### Return type

[**ContractResponse**](ContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **withdrawContractTermination**
> ContractResponse withdrawContractTermination(id)

Withdraw your own proposed termination before it is answered (one notified alone is final)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getContratsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.withdrawContractTermination(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContratsApi->withdrawContractTermination: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ContractResponse**](ContractResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

