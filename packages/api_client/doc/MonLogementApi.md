# api_client.api.MonLogementApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**acknowledgeEvidence**](MonLogementApi.md#acknowledgeevidence) | **POST** /api/v1/homes/{contractId}/evidence/{batchId}/acknowledge | Acknowledge a sending of photo proofs, with a word — never contest by deleting (RM-M30-12)
[**closeHomeRequest**](MonLogementApi.md#closehomerequest) | **POST** /api/v1/home-requests/{requestId}/close | The tenant closes a request — for good
[**compareEvidence**](MonLogementApi.md#compareevidence) | **GET** /api/v1/homes/{contractId}/evidence/compare | The home&#39;s state before and after, room by room: entry and exit photos side by side (CA-M31-04)
[**confirmDeclaration**](MonLogementApi.md#confirmdeclaration) | **POST** /api/v1/prestataires/me/declarations/{declarationId}/confirm | Confirm a declared payment: it now pays its échéances (RM-M30-04, RM-M30-08)
[**contestDeclaration**](MonLogementApi.md#contestdeclaration) | **POST** /api/v1/prestataires/me/declarations/{declarationId}/contest | Contest a declared payment, with a reason the tenant sees (RM-M30-04, RM-M30-07)
[**createEvidenceUploads**](MonLogementApi.md#createevidenceuploads) | **POST** /api/v1/homes/{contractId}/evidence/uploads | Get one upload per photo proof, its SHA-256 signed in — storage refuses any other content (RM-M30-11)
[**createHomeRequest**](MonLogementApi.md#createhomerequest) | **POST** /api/v1/homes/{contractId}/requests | Ask the landlord: a remark, a problem (with photos), a question — it lives in the property&#39;s thread (RM-M30-09)
[**createUsefulContact**](MonLogementApi.md#createusefulcontact) | **POST** /api/v1/prestataires/me/contacts | Add a useful contact, shared with my tenants or not, on all my properties or some (15 at most)
[**declareInvoicePayment**](MonLogementApi.md#declareinvoicepayment) | **POST** /api/v1/invoices/{invoiceId}/declarations | Declare an invoice paid outside Mboa, proofs optional — confirmed, it settles the invoice (RM-M24-09)
[**declarePayment**](MonLogementApi.md#declarepayment) | **POST** /api/v1/homes/{contractId}/declarations | Declare a payment made outside Mboa: rent (one or more échéances) or deposit, proofs optional (RM-M30-03)
[**deleteUsefulContact**](MonLogementApi.md#deleteusefulcontact) | **DELETE** /api/v1/prestataires/me/contacts/{contactId} | Remove a useful contact
[**getDeclarationProofs**](MonLogementApi.md#getdeclarationproofs) | **GET** /api/v1/homes/{contractId}/declarations/{declarationId}/proofs | Short-lived links to a declaration&#39;s proofs — the two parties only
[**getEvidenceBatch**](MonLogementApi.md#getevidencebatch) | **GET** /api/v1/homes/{contractId}/evidence/{batchId} | One sending of photo proofs, each with a short-lived link
[**getHome**](MonLogementApi.md#gethome) | **GET** /api/v1/homes/{contractId} | One home, tenant or landlord: the summary and its échéancier up to the next 12 (RM-M30-01/02)
[**getHomeDeclaration**](MonLogementApi.md#gethomedeclaration) | **GET** /api/v1/homes/{contractId}/declarations/{declarationId} | One declared payment of a home
[**getHomeFinanceSummary**](MonLogementApi.md#gethomefinancesummary) | **GET** /api/v1/homes/{contractId}/summary | A home&#39;s totals — confirmed, waiting, contested; only confirmed counts as paid (RM-M30-08)
[**getHomeRequest**](MonLogementApi.md#gethomerequest) | **GET** /api/v1/home-requests/{requestId} | One request with its photos and history — what N-38 opens; the landlord&#39;s first look marks it seen
[**getHomeSchedule**](MonLogementApi.md#gethomeschedule) | **GET** /api/v1/homes/{contractId}/schedule | A window of a home&#39;s échéancier, computed from the contract — at most the next 12, 100 per answer (RM-M30-02)
[**getMyReceivedDeclaration**](MonLogementApi.md#getmyreceiveddeclaration) | **GET** /api/v1/prestataires/me/declarations/{declarationId} | One declared payment on my homes — what N-35 opens
[**listEvidence**](MonLogementApi.md#listevidence) | **GET** /api/v1/homes/{contractId}/evidence | A home&#39;s photo proofs, by sending, newest first — the two parties only
[**listHomeContacts**](MonLogementApi.md#listhomecontacts) | **GET** /api/v1/homes/{contractId}/contacts | The contacts my landlord shares on my home: name, role, number (CA-M30-05)
[**listHomeDeclarations**](MonLogementApi.md#listhomedeclarations) | **GET** /api/v1/homes/{contractId}/declarations | A home&#39;s declared payments, newest first
[**listHomeReceipts**](MonLogementApi.md#listhomereceipts) | **GET** /api/v1/homes/{contractId}/receipts | A home&#39;s receipts, newest first — one per confirmed declaration (RM-M30-05)
[**listHomeRequests**](MonLogementApi.md#listhomerequests) | **GET** /api/v1/homes/{contractId}/requests | A home&#39;s requests, newest first
[**listInvoiceDeclarations**](MonLogementApi.md#listinvoicedeclarations) | **GET** /api/v1/invoices/{invoiceId}/declarations | An invoice&#39;s declared payments, newest first
[**listMyHomes**](MonLogementApi.md#listmyhomes) | **GET** /api/v1/homes | My homes — one per signed contract, active first, then to come, then ended (RM-M30-01)
[**listMyReceivedDeclarations**](MonLogementApi.md#listmyreceiveddeclarations) | **GET** /api/v1/prestataires/me/declarations | Declared payments on my homes, oldest first — status&#x3D;DECLARED,UNCONFIRMED is the inbox (RM-M30-04)
[**listMyReceivedRequests**](MonLogementApi.md#listmyreceivedrequests) | **GET** /api/v1/prestataires/me/requests | Requests on my homes, newest first — status&#x3D;SENT,SEEN,IN_PROGRESS is the inbox (no add-on, RM-M30-15)
[**listMyTenantHomes**](MonLogementApi.md#listmytenanthomes) | **GET** /api/v1/prestataires/me/homes | The homes on my properties, one per signed contract, active first — on one listing or one residence&#39;s units (RM-M30-14: mine only)
[**listMyUsefulContacts**](MonLogementApi.md#listmyusefulcontacts) | **GET** /api/v1/prestataires/me/contacts | My useful contacts — caretaker, cleaner, craftsmen (RM-M30-13)
[**moveHomeRequest**](MonLogementApi.md#movehomerequest) | **POST** /api/v1/home-requests/{requestId}/status | The landlord takes a request in hand or resolves it, with a word
[**recordEvidence**](MonLogementApi.md#recordevidence) | **POST** /api/v1/homes/{contractId}/evidence | Record uploaded photo proofs: checked in storage, then timestamped by the server — never modified (RM-M30-11)
[**reopenHomeRequest**](MonLogementApi.md#reopenhomerequest) | **POST** /api/v1/home-requests/{requestId}/reopen | The tenant reopens a resolved request: the problem is still there
[**updateUsefulContact**](MonLogementApi.md#updateusefulcontact) | **PUT** /api/v1/prestataires/me/contacts/{contactId} | Replace a useful contact


# **acknowledgeEvidence**
> EvidenceBatchResponse acknowledgeEvidence(contractId, batchId, acknowledgeEvidenceRequest)

Acknowledge a sending of photo proofs, with a word — never contest by deleting (RM-M30-12)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String batchId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final AcknowledgeEvidenceRequest acknowledgeEvidenceRequest = ; // AcknowledgeEvidenceRequest | 

try {
    final response = api.acknowledgeEvidence(contractId, batchId, acknowledgeEvidenceRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->acknowledgeEvidence: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **batchId** | **String**|  | 
 **acknowledgeEvidenceRequest** | [**AcknowledgeEvidenceRequest**](AcknowledgeEvidenceRequest.md)|  | [optional] 

### Return type

[**EvidenceBatchResponse**](EvidenceBatchResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **closeHomeRequest**
> HomeRequestResponse closeHomeRequest(requestId, homeRequestNoteRequest)

The tenant closes a request — for good

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String requestId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final HomeRequestNoteRequest homeRequestNoteRequest = ; // HomeRequestNoteRequest | 

try {
    final response = api.closeHomeRequest(requestId, homeRequestNoteRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->closeHomeRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestId** | **String**|  | 
 **homeRequestNoteRequest** | [**HomeRequestNoteRequest**](HomeRequestNoteRequest.md)|  | [optional] 

### Return type

[**HomeRequestResponse**](HomeRequestResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **compareEvidence**
> BuiltList<EvidenceRoomComparison> compareEvidence(contractId)

The home's state before and after, room by room: entry and exit photos side by side (CA-M31-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.compareEvidence(contractId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->compareEvidence: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 

### Return type

[**BuiltList&lt;EvidenceRoomComparison&gt;**](EvidenceRoomComparison.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

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

# **createEvidenceUploads**
> BuiltList<EvidenceUpload> createEvidenceUploads(contractId, evidenceUploadsRequest)

Get one upload per photo proof, its SHA-256 signed in — storage refuses any other content (RM-M30-11)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final EvidenceUploadsRequest evidenceUploadsRequest = ; // EvidenceUploadsRequest | 

try {
    final response = api.createEvidenceUploads(contractId, evidenceUploadsRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->createEvidenceUploads: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **evidenceUploadsRequest** | [**EvidenceUploadsRequest**](EvidenceUploadsRequest.md)|  | 

### Return type

[**BuiltList&lt;EvidenceUpload&gt;**](EvidenceUpload.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createHomeRequest**
> HomeRequestResponse createHomeRequest(contractId, createHomeRequest)

Ask the landlord: a remark, a problem (with photos), a question — it lives in the property's thread (RM-M30-09)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final CreateHomeRequest createHomeRequest = ; // CreateHomeRequest | 

try {
    final response = api.createHomeRequest(contractId, createHomeRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->createHomeRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **createHomeRequest** | [**CreateHomeRequest**](CreateHomeRequest.md)|  | 

### Return type

[**HomeRequestResponse**](HomeRequestResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createUsefulContact**
> UsefulContactResponse createUsefulContact(usefulContactRequest)

Add a useful contact, shared with my tenants or not, on all my properties or some (15 at most)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final UsefulContactRequest usefulContactRequest = ; // UsefulContactRequest | 

try {
    final response = api.createUsefulContact(usefulContactRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->createUsefulContact: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **usefulContactRequest** | [**UsefulContactRequest**](UsefulContactRequest.md)|  | 

### Return type

[**UsefulContactResponse**](UsefulContactResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **declareInvoicePayment**
> DeclarationResponse declareInvoicePayment(invoiceId, declareInvoicePaymentRequest)

Declare an invoice paid outside Mboa, proofs optional — confirmed, it settles the invoice (RM-M24-09)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String invoiceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final DeclareInvoicePaymentRequest declareInvoicePaymentRequest = ; // DeclareInvoicePaymentRequest | 

try {
    final response = api.declareInvoicePayment(invoiceId, declareInvoicePaymentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->declareInvoicePayment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **invoiceId** | **String**|  | 
 **declareInvoicePaymentRequest** | [**DeclareInvoicePaymentRequest**](DeclareInvoicePaymentRequest.md)|  | 

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

# **deleteUsefulContact**
> deleteUsefulContact(contactId)

Remove a useful contact

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contactId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.deleteUsefulContact(contactId);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->deleteUsefulContact: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contactId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

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

# **getEvidenceBatch**
> EvidenceBatchResponse getEvidenceBatch(contractId, batchId)

One sending of photo proofs, each with a short-lived link

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String batchId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getEvidenceBatch(contractId, batchId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->getEvidenceBatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **batchId** | **String**|  | 

### Return type

[**EvidenceBatchResponse**](EvidenceBatchResponse.md)

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

# **getHomeRequest**
> HomeRequestResponse getHomeRequest(requestId)

One request with its photos and history — what N-38 opens; the landlord's first look marks it seen

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String requestId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getHomeRequest(requestId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->getHomeRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestId** | **String**|  | 

### Return type

[**HomeRequestResponse**](HomeRequestResponse.md)

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

# **listEvidence**
> PageResponseEvidenceBatchResponse listEvidence(contractId, pageable)

A home's photo proofs, by sending, newest first — the two parties only

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listEvidence(contractId, pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->listEvidence: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseEvidenceBatchResponse**](PageResponseEvidenceBatchResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listHomeContacts**
> BuiltList<UsefulContactResponse> listHomeContacts(contractId)

The contacts my landlord shares on my home: name, role, number (CA-M30-05)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listHomeContacts(contractId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->listHomeContacts: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 

### Return type

[**BuiltList&lt;UsefulContactResponse&gt;**](UsefulContactResponse.md)

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

# **listHomeReceipts**
> PageResponseHomeReceiptResponse listHomeReceipts(contractId, pageable)

A home's receipts, newest first — one per confirmed declaration (RM-M30-05)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listHomeReceipts(contractId, pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->listHomeReceipts: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseHomeReceiptResponse**](PageResponseHomeReceiptResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listHomeRequests**
> PageResponseHomeRequestResponse listHomeRequests(contractId, pageable, status)

A home's requests, newest first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final Pageable pageable = ; // Pageable | 
final BuiltList<String> status = ; // BuiltList<String> | 

try {
    final response = api.listHomeRequests(contractId, pageable, status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->listHomeRequests: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **pageable** | [**Pageable**](.md)|  | 
 **status** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 

### Return type

[**PageResponseHomeRequestResponse**](PageResponseHomeRequestResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listInvoiceDeclarations**
> PageResponseDeclarationResponse listInvoiceDeclarations(invoiceId, pageable)

An invoice's declared payments, newest first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String invoiceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listInvoiceDeclarations(invoiceId, pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->listInvoiceDeclarations: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **invoiceId** | **String**|  | 
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
> PageResponseDeclarationResponse listMyReceivedDeclarations(pageable, status, contractId, residenceId)

Declared payments on my homes, oldest first — status=DECLARED,UNCONFIRMED is the inbox (RM-M30-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final Pageable pageable = ; // Pageable | 
final BuiltList<String> status = ; // BuiltList<String> | 
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listMyReceivedDeclarations(pageable, status, contractId, residenceId);
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
 **residenceId** | **String**|  | [optional] 

### Return type

[**PageResponseDeclarationResponse**](PageResponseDeclarationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyReceivedRequests**
> PageResponseHomeRequestResponse listMyReceivedRequests(pageable, status, contractId)

Requests on my homes, newest first — status=SENT,SEEN,IN_PROGRESS is the inbox (no add-on, RM-M30-15)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final Pageable pageable = ; // Pageable | 
final BuiltList<String> status = ; // BuiltList<String> | 
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listMyReceivedRequests(pageable, status, contractId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->listMyReceivedRequests: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **status** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 
 **contractId** | **String**|  | [optional] 

### Return type

[**PageResponseHomeRequestResponse**](PageResponseHomeRequestResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyTenantHomes**
> PageResponseHomeSummary listMyTenantHomes(pageable, annonceId, residenceId, state)

The homes on my properties, one per signed contract, active first — on one listing or one residence's units (RM-M30-14: mine only)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final Pageable pageable = ; // Pageable | 
final String annonceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String residenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BuiltList<String> state = ; // BuiltList<String> | 

try {
    final response = api.listMyTenantHomes(pageable, annonceId, residenceId, state);
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
 **residenceId** | **String**|  | [optional] 
 **state** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 

### Return type

[**PageResponseHomeSummary**](PageResponseHomeSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyUsefulContacts**
> BuiltList<UsefulContactResponse> listMyUsefulContacts()

My useful contacts — caretaker, cleaner, craftsmen (RM-M30-13)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();

try {
    final response = api.listMyUsefulContacts();
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->listMyUsefulContacts: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;UsefulContactResponse&gt;**](UsefulContactResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **moveHomeRequest**
> HomeRequestResponse moveHomeRequest(requestId, homeRequestStatusRequest)

The landlord takes a request in hand or resolves it, with a word

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String requestId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final HomeRequestStatusRequest homeRequestStatusRequest = ; // HomeRequestStatusRequest | 

try {
    final response = api.moveHomeRequest(requestId, homeRequestStatusRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->moveHomeRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestId** | **String**|  | 
 **homeRequestStatusRequest** | [**HomeRequestStatusRequest**](HomeRequestStatusRequest.md)|  | 

### Return type

[**HomeRequestResponse**](HomeRequestResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **recordEvidence**
> EvidenceBatchResponse recordEvidence(contractId, recordEvidenceRequest)

Record uploaded photo proofs: checked in storage, then timestamped by the server — never modified (RM-M30-11)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RecordEvidenceRequest recordEvidenceRequest = ; // RecordEvidenceRequest | 

try {
    final response = api.recordEvidence(contractId, recordEvidenceRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->recordEvidence: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 
 **recordEvidenceRequest** | [**RecordEvidenceRequest**](RecordEvidenceRequest.md)|  | 

### Return type

[**EvidenceBatchResponse**](EvidenceBatchResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reopenHomeRequest**
> HomeRequestResponse reopenHomeRequest(requestId, homeRequestNoteRequest)

The tenant reopens a resolved request: the problem is still there

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String requestId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final HomeRequestNoteRequest homeRequestNoteRequest = ; // HomeRequestNoteRequest | 

try {
    final response = api.reopenHomeRequest(requestId, homeRequestNoteRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->reopenHomeRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestId** | **String**|  | 
 **homeRequestNoteRequest** | [**HomeRequestNoteRequest**](HomeRequestNoteRequest.md)|  | [optional] 

### Return type

[**HomeRequestResponse**](HomeRequestResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUsefulContact**
> UsefulContactResponse updateUsefulContact(contactId, usefulContactRequest)

Replace a useful contact

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMonLogementApi();
final String contactId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UsefulContactRequest usefulContactRequest = ; // UsefulContactRequest | 

try {
    final response = api.updateUsefulContact(contactId, usefulContactRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MonLogementApi->updateUsefulContact: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contactId** | **String**|  | 
 **usefulContactRequest** | [**UsefulContactRequest**](UsefulContactRequest.md)|  | 

### Return type

[**UsefulContactResponse**](UsefulContactResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

