// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_changes_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RequestChangesRequestContestedTermsEnum
_$requestChangesRequestContestedTermsEnum_PRICE =
    const RequestChangesRequestContestedTermsEnum._('PRICE');
const RequestChangesRequestContestedTermsEnum
_$requestChangesRequestContestedTermsEnum_RENTAL_PERIOD =
    const RequestChangesRequestContestedTermsEnum._('RENTAL_PERIOD');
const RequestChangesRequestContestedTermsEnum
_$requestChangesRequestContestedTermsEnum_DEPOSIT_AMOUNT =
    const RequestChangesRequestContestedTermsEnum._('DEPOSIT_AMOUNT');
const RequestChangesRequestContestedTermsEnum
_$requestChangesRequestContestedTermsEnum_CHARGES_INCLUDED =
    const RequestChangesRequestContestedTermsEnum._('CHARGES_INCLUDED');
const RequestChangesRequestContestedTermsEnum
_$requestChangesRequestContestedTermsEnum_START_DATE =
    const RequestChangesRequestContestedTermsEnum._('START_DATE');
const RequestChangesRequestContestedTermsEnum
_$requestChangesRequestContestedTermsEnum_DURATION_UNITS =
    const RequestChangesRequestContestedTermsEnum._('DURATION_UNITS');
const RequestChangesRequestContestedTermsEnum
_$requestChangesRequestContestedTermsEnum_TACIT_RENEWAL =
    const RequestChangesRequestContestedTermsEnum._('TACIT_RENEWAL');
const RequestChangesRequestContestedTermsEnum
_$requestChangesRequestContestedTermsEnum_unknownDefaultOpenApi =
    const RequestChangesRequestContestedTermsEnum._('unknownDefaultOpenApi');

RequestChangesRequestContestedTermsEnum
_$requestChangesRequestContestedTermsEnumValueOf(String name) {
  switch (name) {
    case 'PRICE':
      return _$requestChangesRequestContestedTermsEnum_PRICE;
    case 'RENTAL_PERIOD':
      return _$requestChangesRequestContestedTermsEnum_RENTAL_PERIOD;
    case 'DEPOSIT_AMOUNT':
      return _$requestChangesRequestContestedTermsEnum_DEPOSIT_AMOUNT;
    case 'CHARGES_INCLUDED':
      return _$requestChangesRequestContestedTermsEnum_CHARGES_INCLUDED;
    case 'START_DATE':
      return _$requestChangesRequestContestedTermsEnum_START_DATE;
    case 'DURATION_UNITS':
      return _$requestChangesRequestContestedTermsEnum_DURATION_UNITS;
    case 'TACIT_RENEWAL':
      return _$requestChangesRequestContestedTermsEnum_TACIT_RENEWAL;
    case 'unknownDefaultOpenApi':
      return _$requestChangesRequestContestedTermsEnum_unknownDefaultOpenApi;
    default:
      return _$requestChangesRequestContestedTermsEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RequestChangesRequestContestedTermsEnum>
_$requestChangesRequestContestedTermsEnumValues =
    BuiltSet<RequestChangesRequestContestedTermsEnum>(
      const <RequestChangesRequestContestedTermsEnum>[
        _$requestChangesRequestContestedTermsEnum_PRICE,
        _$requestChangesRequestContestedTermsEnum_RENTAL_PERIOD,
        _$requestChangesRequestContestedTermsEnum_DEPOSIT_AMOUNT,
        _$requestChangesRequestContestedTermsEnum_CHARGES_INCLUDED,
        _$requestChangesRequestContestedTermsEnum_START_DATE,
        _$requestChangesRequestContestedTermsEnum_DURATION_UNITS,
        _$requestChangesRequestContestedTermsEnum_TACIT_RENEWAL,
        _$requestChangesRequestContestedTermsEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<RequestChangesRequestContestedTermsEnum>
_$requestChangesRequestContestedTermsEnumSerializer =
    _$RequestChangesRequestContestedTermsEnumSerializer();

class _$RequestChangesRequestContestedTermsEnumSerializer
    implements PrimitiveSerializer<RequestChangesRequestContestedTermsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PRICE': 'PRICE',
    'RENTAL_PERIOD': 'RENTAL_PERIOD',
    'DEPOSIT_AMOUNT': 'DEPOSIT_AMOUNT',
    'CHARGES_INCLUDED': 'CHARGES_INCLUDED',
    'START_DATE': 'START_DATE',
    'DURATION_UNITS': 'DURATION_UNITS',
    'TACIT_RENEWAL': 'TACIT_RENEWAL',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PRICE': 'PRICE',
    'RENTAL_PERIOD': 'RENTAL_PERIOD',
    'DEPOSIT_AMOUNT': 'DEPOSIT_AMOUNT',
    'CHARGES_INCLUDED': 'CHARGES_INCLUDED',
    'START_DATE': 'START_DATE',
    'DURATION_UNITS': 'DURATION_UNITS',
    'TACIT_RENEWAL': 'TACIT_RENEWAL',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    RequestChangesRequestContestedTermsEnum,
  ];
  @override
  final String wireName = 'RequestChangesRequestContestedTermsEnum';

  @override
  Object serialize(
    Serializers serializers,
    RequestChangesRequestContestedTermsEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  RequestChangesRequestContestedTermsEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => RequestChangesRequestContestedTermsEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$RequestChangesRequest extends RequestChangesRequest {
  @override
  final String comment;
  @override
  final BuiltList<RequestChangesRequestContestedTermsEnum>? contestedTerms;

  factory _$RequestChangesRequest([
    void Function(RequestChangesRequestBuilder)? updates,
  ]) => (RequestChangesRequestBuilder()..update(updates))._build();

  _$RequestChangesRequest._({required this.comment, this.contestedTerms})
    : super._();
  @override
  RequestChangesRequest rebuild(
    void Function(RequestChangesRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  RequestChangesRequestBuilder toBuilder() =>
      RequestChangesRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RequestChangesRequest &&
        comment == other.comment &&
        contestedTerms == other.contestedTerms;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, contestedTerms.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RequestChangesRequest')
          ..add('comment', comment)
          ..add('contestedTerms', contestedTerms))
        .toString();
  }
}

class RequestChangesRequestBuilder
    implements Builder<RequestChangesRequest, RequestChangesRequestBuilder> {
  _$RequestChangesRequest? _$v;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  ListBuilder<RequestChangesRequestContestedTermsEnum>? _contestedTerms;
  ListBuilder<RequestChangesRequestContestedTermsEnum> get contestedTerms =>
      _$this._contestedTerms ??=
          ListBuilder<RequestChangesRequestContestedTermsEnum>();
  set contestedTerms(
    ListBuilder<RequestChangesRequestContestedTermsEnum>? contestedTerms,
  ) => _$this._contestedTerms = contestedTerms;

  RequestChangesRequestBuilder() {
    RequestChangesRequest._defaults(this);
  }

  RequestChangesRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _comment = $v.comment;
      _contestedTerms = $v.contestedTerms?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RequestChangesRequest other) {
    _$v = other as _$RequestChangesRequest;
  }

  @override
  void update(void Function(RequestChangesRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RequestChangesRequest build() => _build();

  _$RequestChangesRequest _build() {
    _$RequestChangesRequest _$result;
    try {
      _$result =
          _$v ??
          _$RequestChangesRequest._(
            comment: BuiltValueNullFieldError.checkNotNull(
              comment,
              r'RequestChangesRequest',
              'comment',
            ),
            contestedTerms: _contestedTerms?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'contestedTerms';
        _contestedTerms?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'RequestChangesRequest',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
