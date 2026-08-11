# api_client.api.MessagerieApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listConversationMessages**](MessagerieApi.md#listconversationmessages) | **GET** /api/v1/conversations/{id}/messages | List a conversation&#39;s messages, newest first
[**listMyConversations**](MessagerieApi.md#listmyconversations) | **GET** /api/v1/conversations | List the authenticated participant&#39;s conversations
[**markConversationRead**](MessagerieApi.md#markconversationread) | **POST** /api/v1/conversations/{id}/read | Mark the conversation&#39;s incoming messages as read
[**sendMessage**](MessagerieApi.md#sendmessage) | **POST** /api/v1/conversations/{id}/messages | Post a message in a conversation
[**startConversation**](MessagerieApi.md#startconversation) | **POST** /api/v1/conversations | Contact a listing — opens (or reuses) the thread and posts the first message


# **listConversationMessages**
> PageResponseMessageResponse listConversationMessages(id, pageable)

List a conversation's messages, newest first

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMessagerieApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listConversationMessages(id, pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MessagerieApi->listConversationMessages: $e\n');
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
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyConversations**
> PageResponseConversationResponse listMyConversations(pageable)

List the authenticated participant's conversations

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMessagerieApi();
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listMyConversations(pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MessagerieApi->listMyConversations: $e\n');
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
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markConversationRead**
> markConversationRead(id)

Mark the conversation's incoming messages as read

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMessagerieApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.markConversationRead(id);
} on DioException catch (e) {
    print('Exception when calling MessagerieApi->markConversationRead: $e\n');
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

# **sendMessage**
> MessageResponse sendMessage(id, sendMessageRequest)

Post a message in a conversation

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMessagerieApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final SendMessageRequest sendMessageRequest = ; // SendMessageRequest | 

try {
    final response = api.sendMessage(id, sendMessageRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MessagerieApi->sendMessage: $e\n');
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
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **startConversation**
> ConversationResponse startConversation(startConversationRequest)

Contact a listing — opens (or reuses) the thread and posts the first message

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMessagerieApi();
final StartConversationRequest startConversationRequest = ; // StartConversationRequest | 

try {
    final response = api.startConversation(startConversationRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MessagerieApi->startConversation: $e\n');
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
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

