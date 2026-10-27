# api_client.api.NotificationsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**countMyUnreadNotifications**](NotificationsApi.md#countmyunreadnotifications) | **GET** /api/v1/notifications/unread-count | How many are unread — what the bell shows
[**listMyNotifications**](NotificationsApi.md#listmynotifications) | **GET** /api/v1/notifications | My notifications, newest first — the push&#39;s title, text, type, entity and link (30 days)
[**markAllNotificationsRead**](NotificationsApi.md#markallnotificationsread) | **POST** /api/v1/notifications/read-all | « Tout marquer comme lu » (idempotent)
[**markNotificationRead**](NotificationsApi.md#marknotificationread) | **POST** /api/v1/notifications/{id}/read | Mark one read (idempotent); another account&#39;s id is 404 NOTIFICATION_NOT_FOUND


# **countMyUnreadNotifications**
> UnreadCount countMyUnreadNotifications()

How many are unread — what the bell shows

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationsApi();

try {
    final response = api.countMyUnreadNotifications();
    print(response);
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->countMyUnreadNotifications: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**UnreadCount**](UnreadCount.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyNotifications**
> PageResponseNotificationItem listMyNotifications(pageable)

My notifications, newest first — the push's title, text, type, entity and link (30 days)

Every notification sent to the account, including those whose push was turned off in the settings: the opt-out silences the push, not this list. A burst merged into one push stays one item per notification here.

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationsApi();
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listMyNotifications(pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->listMyNotifications: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseNotificationItem**](PageResponseNotificationItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markAllNotificationsRead**
> markAllNotificationsRead()

« Tout marquer comme lu » (idempotent)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationsApi();

try {
    api.markAllNotificationsRead();
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->markAllNotificationsRead: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markNotificationRead**
> NotificationItem markNotificationRead(id)

Mark one read (idempotent); another account's id is 404 NOTIFICATION_NOT_FOUND

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.markNotificationRead(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->markNotificationRead: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**NotificationItem**](NotificationItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

