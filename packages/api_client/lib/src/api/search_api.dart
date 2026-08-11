//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:api_client/src/api_util.dart';
import 'package:api_client/src/model/annonce_detail_response.dart';
import 'package:api_client/src/model/error_response.dart';
import 'package:api_client/src/model/page_response_search_result.dart';
import 'package:api_client/src/model/residence_detail_response.dart';
import 'package:built_collection/built_collection.dart';

class SearchApi {

  final Dio _dio;

  final Serializers _serializers;

  const SearchApi(this._dio, this._serializers);

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

  /// Search listings and residences (city/district required; other filters cumulative)
  /// 
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
