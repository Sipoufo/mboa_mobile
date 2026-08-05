# api_client.api.MessagerieApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listMessages**](MessagerieApi.md#listmessages) | **GET** /api/v1/conversations/{id}/messages | List a conversation&#39;s messages, newest first
[**listMine1**](MessagerieApi.md#listmine1) | **GET** /api/v1/conversations | List the authenticated participant&#39;s conversations
[**markRead**](MessagerieApi.md#markread) | **POST** /api/v1/conversations/{id}/read | Mark the conversation&#39;s incoming messages as read
[**send**](MessagerieApi.md#send) | **POST** /api/v1/conversations/{id}/messages | Post a message in a conversation
[**start**](MessagerieApi.md#start) | **POST** /api/v1/conversations | Contact a listing — opens (or reuses) the thread and posts the first message


# **listMessages**
> PageResponseMessageResponse listMessages(id, pageable)

List a conversation's messages, newest first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMessagerieApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listMessages(id, pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MessagerieApi->listMessages: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseMessageResponse**](PageResponseMessageResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMine1**
> PageResponseConversationResponse listMine1(pageable)

List the authenticated participant's conversations

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMessagerieApi();
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listMine1(pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MessagerieApi->listMine1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseConversationResponse**](PageResponseConversationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markRead**
> markRead(id)

Mark the conversation's incoming messages as read

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMessagerieApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.markRead(id);
} on DioException catch (e) {
    print('Exception when calling MessagerieApi->markRead: $e\n');
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
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **send**
> MessageResponse send(id, sendMessageRequest)

Post a message in a conversation

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMessagerieApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final SendMessageRequest sendMessageRequest = ; // SendMessageRequest | 

try {
    final response = api.send(id, sendMessageRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MessagerieApi->send: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **sendMessageRequest** | [**SendMessageRequest**](SendMessageRequest.md)|  | 

### Return type

[**MessageResponse**](MessageResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **start**
> ConversationResponse start(startConversationRequest)

Contact a listing — opens (or reuses) the thread and posts the first message

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMessagerieApi();
final StartConversationRequest startConversationRequest = ; // StartConversationRequest | 

try {
    final response = api.start(startConversationRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MessagerieApi->start: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **startConversationRequest** | [**StartConversationRequest**](StartConversationRequest.md)|  | 

### Return type

[**ConversationResponse**](ConversationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

