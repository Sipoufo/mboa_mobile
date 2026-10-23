# api_client.api.SignalementsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createSignalement**](SignalementsApi.md#createsignalement) | **POST** /api/v1/signalements | Report a listing, a message or a review, or dispute a home; the reason must fit the target


# **createSignalement**
> SignalementResponse createSignalement(createSignalementRequest)

Report a listing, a message or a review, or dispute a home; the reason must fit the target

ANNONCE: FRAUDULENT_LISTING, ABNORMAL_PRICE, INAPPROPRIATE_CONTENT, ASKED_FOR_MONEY. MESSAGE: INAPPROPRIATE_CONTENT, HARASSMENT, ASKED_FOR_MONEY. REVIEW: INAPPROPRIATE_CONTENT, HARASSMENT. CONTRACT, DECLARATION, EVIDENCE (a sending of photo proofs): DISPUTE only, by a party to the home (404 otherwise) — escalated to the admin, against nobody, and while pending it keeps the tenant's proofs and requests past their account (RM-M30-07, RM-M31-07). Anything else is 400 REASON_NOT_APPLICABLE. One upheld report removes a review; a listing takes three. The reporter is only told the report was received — the outcome is never disclosed to them (RM-M23-05).

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSignalementsApi();
final CreateSignalementRequest createSignalementRequest = ; // CreateSignalementRequest | 

try {
    final response = api.createSignalement(createSignalementRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SignalementsApi->createSignalement: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createSignalementRequest** | [**CreateSignalementRequest**](CreateSignalementRequest.md)|  | 

### Return type

[**SignalementResponse**](SignalementResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

