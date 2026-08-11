# api_client.api.MediaApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createMediaUpload**](MediaApi.md#createmediaupload) | **POST** /api/v1/media/uploads | Get a pre-signed URL to upload a file directly to storage


# **createMediaUpload**
> PresignedUpload createMediaUpload(createUploadRequest)

Get a pre-signed URL to upload a file directly to storage

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMediaApi();
final CreateUploadRequest createUploadRequest = ; // CreateUploadRequest | 

try {
    final response = api.createMediaUpload(createUploadRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MediaApi->createMediaUpload: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createUploadRequest** | [**CreateUploadRequest**](CreateUploadRequest.md)|  | 

### Return type

[**PresignedUpload**](PresignedUpload.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

