# api_client.api.FavorisApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://api.mboa.cm/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addFavori**](FavorisApi.md#addfavori) | **POST** /api/v1/favoris | Save a listing (max 50 — RM-M06-02); saving one twice is a no-op
[**listMyFavoris**](FavorisApi.md#listmyfavoris) | **GET** /api/v1/favoris | List saved listings; unavailable ones stay for 30 days flagged available&#x3D;false
[**removeFavori**](FavorisApi.md#removefavori) | **DELETE** /api/v1/favoris/{annonceId} | Unsave a listing; unsaving one that is not saved is not an error


# **addFavori**
> FavoriResponse addFavori(addFavoriRequest)

Save a listing (max 50 — RM-M06-02); saving one twice is a no-op

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFavorisApi();
final AddFavoriRequest addFavoriRequest = ; // AddFavoriRequest | 

try {
    final response = api.addFavori(addFavoriRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FavorisApi->addFavori: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **addFavoriRequest** | [**AddFavoriRequest**](AddFavoriRequest.md)|  | 

### Return type

[**FavoriResponse**](FavoriResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listMyFavoris**
> PageResponseFavoriResponse listMyFavoris(pageable)

List saved listings; unavailable ones stay for 30 days flagged available=false

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFavorisApi();
final Pageable pageable = ; // Pageable | 

try {
    final response = api.listMyFavoris(pageable);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FavorisApi->listMyFavoris: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageResponseFavoriResponse**](PageResponseFavoriResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeFavori**
> removeFavori(annonceId)

Unsave a listing; unsaving one that is not saved is not an error

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFavorisApi();
final String annonceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.removeFavori(annonceId);
} on DioException catch (e) {
    print('Exception when calling FavorisApi->removeFavori: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **annonceId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

