# api_client.api.KYCApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**myStatus**](KYCApi.md#mystatus) | **GET** /api/v1/kyc/me | Get the authenticated account&#39;s KYC status
[**submit**](KYCApi.md#submit) | **POST** /api/v1/kyc | Submit KYC documents (R2 object keys) for verification


# **myStatus**
> KycStatusResponse myStatus()

Get the authenticated account's KYC status

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getKYCApi();

try {
    final response = api.myStatus();
    print(response);
} on DioException catch (e) {
    print('Exception when calling KYCApi->myStatus: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**KycStatusResponse**](KycStatusResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **submit**
> KycStatusResponse submit(submitKycRequest)

Submit KYC documents (R2 object keys) for verification

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getKYCApi();
final SubmitKycRequest submitKycRequest = ; // SubmitKycRequest | 

try {
    final response = api.submit(submitKycRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling KYCApi->submit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **submitKycRequest** | [**SubmitKycRequest**](SubmitKycRequest.md)|  | 

### Return type

[**KycStatusResponse**](KycStatusResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

