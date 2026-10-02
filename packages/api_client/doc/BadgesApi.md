# api_client.api.BadgesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAnnoncePhotoVerification**](BadgesApi.md#getannoncephotoverification) | **GET** /api/v1/annonces/{id}/photo-verification | The latest photo verification on a listing
[**getMyBadges**](BadgesApi.md#getmybadges) | **GET** /api/v1/prestataires/me/badges | The prestataire&#39;s badges and photo verification requests
[**getResidencePhotoVerification**](BadgesApi.md#getresidencephotoverification) | **GET** /api/v1/residences/{id}/photo-verification | The latest photo verification on a residence
[**requestAnnoncePhotoVerification**](BadgesApi.md#requestannoncephotoverification) | **POST** /api/v1/annonces/{id}/photo-verification | Ask for a listing&#39;s photos to be verified
[**requestResidencePhotoVerification**](BadgesApi.md#requestresidencephotoverification) | **POST** /api/v1/residences/{id}/photo-verification | Ask for a residence&#39;s shared photos to be verified


# **getAnnoncePhotoVerification**
> PhotoVerificationResponse getAnnoncePhotoVerification(id)

The latest photo verification on a listing

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getAnnoncePhotoVerification(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BadgesApi->getAnnoncePhotoVerification: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**PhotoVerificationResponse**](PhotoVerificationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyBadges**
> MyBadgesResponse getMyBadges()

The prestataire's badges and photo verification requests

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgesApi();

try {
    final response = api.getMyBadges();
    print(response);
} on DioException catch (e) {
    print('Exception when calling BadgesApi->getMyBadges: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MyBadgesResponse**](MyBadgesResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getResidencePhotoVerification**
> PhotoVerificationResponse getResidencePhotoVerification(id)

The latest photo verification on a residence

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getResidencePhotoVerification(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BadgesApi->getResidencePhotoVerification: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**PhotoVerificationResponse**](PhotoVerificationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **requestAnnoncePhotoVerification**
> PhotoVerificationResponse requestAnnoncePhotoVerification(id)

Ask for a listing's photos to be verified

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.requestAnnoncePhotoVerification(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BadgesApi->requestAnnoncePhotoVerification: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**PhotoVerificationResponse**](PhotoVerificationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **requestResidencePhotoVerification**
> PhotoVerificationResponse requestResidencePhotoVerification(id)

Ask for a residence's shared photos to be verified

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.requestResidencePhotoVerification(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BadgesApi->requestResidencePhotoVerification: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**PhotoVerificationResponse**](PhotoVerificationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

