# api_client.api.MboaScoreApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getMyMboaScore**](MboaScoreApi.md#getmymboascore) | **GET** /api/v1/users/me/score | The authenticated user&#39;s Mboa Score and its breakdown
[**getTenantMboaScore**](MboaScoreApi.md#gettenantmboascore) | **GET** /api/v1/prestataires/me/tenants/{userId}/score | A tenant&#39;s Mboa Score, once they have messaged you or asked to visit (RM-M09-04)


# **getMyMboaScore**
> MboaScoreResponse getMyMboaScore()

The authenticated user's Mboa Score and its breakdown

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMboaScoreApi();

try {
    final response = api.getMyMboaScore();
    print(response);
} on DioException catch (e) {
    print('Exception when calling MboaScoreApi->getMyMboaScore: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MboaScoreResponse**](MboaScoreResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTenantMboaScore**
> MboaScoreResponse getTenantMboaScore(userId)

A tenant's Mboa Score, once they have messaged you or asked to visit (RM-M09-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMboaScoreApi();
final String userId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getTenantMboaScore(userId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MboaScoreApi->getTenantMboaScore: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

[**MboaScoreResponse**](MboaScoreResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

