//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:api_client/src/api_util.dart';
import 'package:api_client/src/model/agent_public_profile.dart';
import 'package:api_client/src/model/annonce_detail_response.dart';
import 'package:api_client/src/model/error_response.dart';
import 'package:api_client/src/model/page_response_property_review.dart';
import 'package:api_client/src/model/page_response_search_result.dart';
import 'package:api_client/src/model/pageable.dart';
import 'package:api_client/src/model/residence_detail_response.dart';
import 'package:built_collection/built_collection.dart';

class SearchApi {

  final Dio _dio;

  final Serializers _serializers;

  const SearchApi(this._dio, this._serializers);

  /// Public profile of an Agent Mboa (M15)
  /// Readable without an account, like a listing&#39;s fiche. Carries no phone number, no email and nothing from KYC. A suspended agent still resolves — they are named on every visit they carried out; only a deleted account is withheld.
  ///
  /// Parameters:
  /// * [id] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [AgentPublicProfile] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<AgentPublicProfile>> getAgentPublicProfile({ 
    required String id,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/search/agents/{id}'.replaceAll('{' r'id' '}', encodeQueryParameter(_serializers, id, const FullType(String)).toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearerAuth',
          },
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    AgentPublicProfile? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(AgentPublicProfile),
      ) as AgentPublicProfile;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<AgentPublicProfile>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Public fiche of a listing (M05)
  /// Readable without an account. The exact address is never returned and the coordinates are fuzzed by ~200m. Send X-Device-Id so anonymous views are counted once per device per 24h; signed-in views are counted by account.
  ///
  /// Parameters:
  /// * [id] 
  /// * [xDeviceId] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [AnnonceDetailResponse] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<AnnonceDetailResponse>> getAnnonceDetail({ 
    required String id,
    String? xDeviceId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/search/annonces/{id}'.replaceAll('{' r'id' '}', encodeQueryParameter(_serializers, id, const FullType(String)).toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        if (xDeviceId != null) r'X-Device-Id': xDeviceId,
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearerAuth',
          },
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    AnnonceDetailResponse? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(AnnonceDetailResponse),
      ) as AnnonceDetailResponse;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<AnnonceDetailResponse>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Public detail of a residence with its live units
  /// 
  ///
  /// Parameters:
  /// * [id] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ResidenceDetailResponse] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ResidenceDetailResponse>> getResidenceDetail({ 
    required String id,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/search/residences/{id}'.replaceAll('{' r'id' '}', encodeQueryParameter(_serializers, id, const FullType(String)).toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearerAuth',
          },
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ResidenceDetailResponse? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(ResidenceDetailResponse),
      ) as ResidenceDetailResponse;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ResidenceDetailResponse>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// A property&#39;s reviews — visits and tenancies in one feed (RM-M27-05)
  /// Public, like the fiche itself. Each item carries a &#x60;type&#x60; of VISIT or RESIDENT; a resident&#39;s review counts three times a visitor&#39;s in the note (RG-06). Filter with &#x60;?type&#x3D;&#x60; to show one kind. An author who has deleted their account appears without a name; the review stays, because it describes the property.
  ///
  /// Parameters:
  /// * [id] 
  /// * [pageable] 
  /// * [type] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [PageResponsePropertyReview] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<PageResponsePropertyReview>> listAnnonceReviews({ 
    required String id,
    required Pageable pageable,
    String? type,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/search/annonces/{id}/reviews'.replaceAll('{' r'id' '}', encodeQueryParameter(_serializers, id, const FullType(String)).toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearerAuth',
          },
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (type != null) r'type': encodeQueryParameter(_serializers, type, const FullType(String)),
      r'pageable': encodeQueryParameter(_serializers, pageable, const FullType(Pageable)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    PageResponsePropertyReview? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(PageResponsePropertyReview),
      ) as PageResponsePropertyReview;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<PageResponsePropertyReview>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// A residence&#39;s reviews — all its units&#39;, visits and tenancies in one feed (RM-M27-05)
  /// Public, like the residence fiche. The same items as a listing&#39;s feed; each keeps its &#x60;annonceId&#x60;, the unit it describes. Every unit counts, whatever its status now. &#x60;?type&#x3D;&#x60; keeps one kind. 404 RESIDENCE_NOT_FOUND (mobile §36).
  ///
  /// Parameters:
  /// * [id] 
  /// * [pageable] 
  /// * [type] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [PageResponsePropertyReview] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<PageResponsePropertyReview>> listResidenceReviews({ 
    required String id,
    required Pageable pageable,
    String? type,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/search/residences/{id}/reviews'.replaceAll('{' r'id' '}', encodeQueryParameter(_serializers, id, const FullType(String)).toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearerAuth',
          },
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (type != null) r'type': encodeQueryParameter(_serializers, type, const FullType(String)),
      r'pageable': encodeQueryParameter(_serializers, pageable, const FullType(Pageable)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    PageResponsePropertyReview? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(PageResponsePropertyReview),
      ) as PageResponsePropertyReview;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<PageResponsePropertyReview>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Search listings and residences (city/district required; other filters cumulative)
  /// With &#x60;lat&#x60; and &#x60;lng&#x60; (the user&#39;s position, both or neither), each card carries &#x60;distanceKm&#x60;, measured to the point it shows. &#x60;sort&#x3D;distance&#x60; puts the nearest first (ties by tier then recency); the default, &#x60;relevance&#x60;, is tier then recency. Each card carries its &#x60;rating&#x60;, as on the fiche — a residence&#39;s gathers all its units&#39; reviews.
  ///
  /// Parameters:
  /// * [cityId] 
  /// * [districtIds] 
  /// * [propertyTypes] 
  /// * [rentalPeriods] 
  /// * [rentMin] 
  /// * [rentMax] 
  /// * [roomsMin] 
  /// * [surfaceMin] 
  /// * [surfaceMax] 
  /// * [furnished] 
  /// * [availableNow] 
  /// * [badges] - Doc 10 \"Badges requis\": only listings carrying every one of these
  /// * [amenities] - Only listings offering every one of these équipements
  /// * [lat] - The user's latitude (WGS 84), with lng — only when they allowed it
  /// * [lng] - The user's longitude (WGS 84), with lat
  /// * [sort] - relevance (default: tier, then recency) or distance (nearest first; needs lat/lng)
  /// * [page] 
  /// * [size] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [PageResponseSearchResult] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<PageResponseSearchResult>> searchListings({ 
    String? cityId,
    BuiltList<String>? districtIds,
    BuiltList<String>? propertyTypes,
    BuiltList<String>? rentalPeriods,
    int? rentMin,
    int? rentMax,
    int? roomsMin,
    int? surfaceMin,
    int? surfaceMax,
    bool? furnished,
    bool? availableNow,
    BuiltList<String>? badges,
    BuiltList<String>? amenities,
    double? lat,
    double? lng,
    String? sort,
    int? page = 0,
    int? size = 20,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/search';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearerAuth',
          },
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (cityId != null) r'cityId': encodeQueryParameter(_serializers, cityId, const FullType(String)),
      if (districtIds != null) r'districtIds': encodeCollectionQueryParameter<String>(_serializers, districtIds, const FullType(BuiltList, [FullType(String)]), format: ListFormat.multi,),
      if (propertyTypes != null) r'propertyTypes': encodeCollectionQueryParameter<String>(_serializers, propertyTypes, const FullType(BuiltList, [FullType(String)]), format: ListFormat.multi,),
      if (rentalPeriods != null) r'rentalPeriods': encodeCollectionQueryParameter<String>(_serializers, rentalPeriods, const FullType(BuiltList, [FullType(String)]), format: ListFormat.multi,),
      if (rentMin != null) r'rentMin': encodeQueryParameter(_serializers, rentMin, const FullType(int)),
      if (rentMax != null) r'rentMax': encodeQueryParameter(_serializers, rentMax, const FullType(int)),
      if (roomsMin != null) r'roomsMin': encodeQueryParameter(_serializers, roomsMin, const FullType(int)),
      if (surfaceMin != null) r'surfaceMin': encodeQueryParameter(_serializers, surfaceMin, const FullType(int)),
      if (surfaceMax != null) r'surfaceMax': encodeQueryParameter(_serializers, surfaceMax, const FullType(int)),
      if (furnished != null) r'furnished': encodeQueryParameter(_serializers, furnished, const FullType(bool)),
      if (availableNow != null) r'availableNow': encodeQueryParameter(_serializers, availableNow, const FullType(bool)),
      if (badges != null) r'badges': encodeCollectionQueryParameter<String>(_serializers, badges, const FullType(BuiltList, [FullType(String)]), format: ListFormat.multi,),
      if (amenities != null) r'amenities': encodeCollectionQueryParameter<String>(_serializers, amenities, const FullType(BuiltList, [FullType(String)]), format: ListFormat.multi,),
      if (lat != null) r'lat': encodeQueryParameter(_serializers, lat, const FullType(double)),
      if (lng != null) r'lng': encodeQueryParameter(_serializers, lng, const FullType(double)),
      if (sort != null) r'sort': encodeQueryParameter(_serializers, sort, const FullType(String)),
      if (page != null) r'page': encodeQueryParameter(_serializers, page, const FullType(int)),
      if (size != null) r'size': encodeQueryParameter(_serializers, size, const FullType(int)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    PageResponseSearchResult? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(PageResponseSearchResult),
      ) as PageResponseSearchResult;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<PageResponseSearchResult>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

}
