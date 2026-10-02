# api_client.api.AdminMboaScoreApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adjustMboaScore**](AdminMboaScoreApi.md#adjustmboascore) | **POST** /api/v1/admin/users/{userId}/score/adjustments | Adjust a user&#39;s Mboa Score by hand, with a mandatory reason (RM-M18-05)
[**getAdminMboaScore**](AdminMboaScoreApi.md#getadminmboascore) | **GET** /api/v1/admin/users/{userId}/score | A user&#39;s Mboa Score with its adjustment trail


# **adjustMboaScore**
> AdminMboaScoreResponse adjustMboaScore(userId, scoreAdjustmentRequest)

Adjust a user's Mboa Score by hand, with a mandatory reason (RM-M18-05)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminMboaScoreApi();
final String userId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ScoreAdjustmentRequest scoreAdjustmentRequest = ; // ScoreAdjustmentRequest | 

try {
    final response = api.adjustMboaScore(userId, scoreAdjustmentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminMboaScoreApi->adjustMboaScore: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **scoreAdjustmentRequest** | [**ScoreAdjustmentRequest**](ScoreAdjustmentRequest.md)|  | 

### Return type

[**AdminMboaScoreResponse**](AdminMboaScoreResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAdminMboaScore**
> AdminMboaScoreResponse getAdminMboaScore(userId)

A user's Mboa Score with its adjustment trail

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminMboaScoreApi();
final String userId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getAdminMboaScore(userId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminMboaScoreApi->getAdminMboaScore: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

[**AdminMboaScoreResponse**](AdminMboaScoreResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

