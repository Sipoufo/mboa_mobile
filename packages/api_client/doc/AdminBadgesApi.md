# api_client.api.AdminBadgesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**approvePhotoVerification**](AdminBadgesApi.md#approvephotoverification) | **POST** /api/v1/admin/badges/photo-verifications/{id}/approve | Grant the Photos vérifiées badge
[**getAdminPrestataireBadges**](AdminBadgesApi.md#getadminprestatairebadges) | **GET** /api/v1/admin/badges/prestataires/{id} | A prestataire&#39;s badges and their full trail
[**listAdminPhotoVerifications**](AdminBadgesApi.md#listadminphotoverifications) | **GET** /api/v1/admin/badges/photo-verifications | The photo verification queue, oldest first, with its 48h timer (RM-M20-01)
[**rejectPhotoVerification**](AdminBadgesApi.md#rejectphotoverification) | **POST** /api/v1/admin/badges/photo-verifications/{id}/reject | Refuse it, with a reason (RM-M20-02)
[**restoreIdentityBadge**](AdminBadgesApi.md#restoreidentitybadge) | **POST** /api/v1/admin/badges/prestataires/{id}/identity/restore | Give Identité vérifiée back once cleared up
[**revokeIdentityBadge**](AdminBadgesApi.md#revokeidentitybadge) | **POST** /api/v1/admin/badges/prestataires/{id}/identity/revoke | Withdraw Identité vérifiée — the CNI was reported false (RG-03)
[**revokePhotoVerification**](AdminBadgesApi.md#revokephotoverification) | **POST** /api/v1/admin/badges/photo-verifications/{id}/revoke | Withdraw a granted badge (RM-M20-04)


# **approvePhotoVerification**
> PhotoVerificationResponse approvePhotoVerification(id)

Grant the Photos vérifiées badge

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminBadgesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.approvePhotoVerification(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminBadgesApi->approvePhotoVerification: $e\n');
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

# **getAdminPrestataireBadges**
> AdminPrestataireBadgesResponse getAdminPrestataireBadges(id)

A prestataire's badges and their full trail

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminBadgesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getAdminPrestataireBadges(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminBadgesApi->getAdminPrestataireBadges: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AdminPrestataireBadgesResponse**](AdminPrestataireBadgesResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAdminPhotoVerifications**
> PageResponseAdminPhotoVerificationItem listAdminPhotoVerifications(pageable, status)

The photo verification queue, oldest first, with its 48h timer (RM-M20-01)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminBadgesApi();
final Pageable pageable = ; // Pageable | 
final String status = status_example; // String | 

try {
    final response = api.listAdminPhotoVerifications(pageable, status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminBadgesApi->listAdminPhotoVerifications: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **status** | **String**|  | [optional] [default to 'PENDING']

### Return type

[**PageResponseAdminPhotoVerificationItem**](PageResponseAdminPhotoVerificationItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rejectPhotoVerification**
> PhotoVerificationResponse rejectPhotoVerification(id, badgeDecisionRequest)

Refuse it, with a reason (RM-M20-02)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminBadgesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BadgeDecisionRequest badgeDecisionRequest = ; // BadgeDecisionRequest | 

try {
    final response = api.rejectPhotoVerification(id, badgeDecisionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminBadgesApi->rejectPhotoVerification: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **badgeDecisionRequest** | [**BadgeDecisionRequest**](BadgeDecisionRequest.md)|  | 

### Return type

[**PhotoVerificationResponse**](PhotoVerificationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restoreIdentityBadge**
> restoreIdentityBadge(id)

Give Identité vérifiée back once cleared up

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminBadgesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.restoreIdentityBadge(id);
} on DioException catch (e) {
    print('Exception when calling AdminBadgesApi->restoreIdentityBadge: $e\n');
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

# **revokeIdentityBadge**
> revokeIdentityBadge(id, badgeDecisionRequest)

Withdraw Identité vérifiée — the CNI was reported false (RG-03)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminBadgesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BadgeDecisionRequest badgeDecisionRequest = ; // BadgeDecisionRequest | 

try {
    api.revokeIdentityBadge(id, badgeDecisionRequest);
} on DioException catch (e) {
    print('Exception when calling AdminBadgesApi->revokeIdentityBadge: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **badgeDecisionRequest** | [**BadgeDecisionRequest**](BadgeDecisionRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **revokePhotoVerification**
> PhotoVerificationResponse revokePhotoVerification(id, badgeDecisionRequest)

Withdraw a granted badge (RM-M20-04)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminBadgesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BadgeDecisionRequest badgeDecisionRequest = ; // BadgeDecisionRequest | 

try {
    final response = api.revokePhotoVerification(id, badgeDecisionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminBadgesApi->revokePhotoVerification: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **badgeDecisionRequest** | [**BadgeDecisionRequest**](BadgeDecisionRequest.md)|  | 

### Return type

[**PhotoVerificationResponse**](PhotoVerificationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

