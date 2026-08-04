// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_type_change_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RequestTypeChangeRequestNewTypeEnum
_$requestTypeChangeRequestNewTypeEnum_PARTICULIER =
    const RequestTypeChangeRequestNewTypeEnum._('PARTICULIER');
const RequestTypeChangeRequestNewTypeEnum
_$requestTypeChangeRequestNewTypeEnum_AGENCE =
    const RequestTypeChangeRequestNewTypeEnum._('AGENCE');
const RequestTypeChangeRequestNewTypeEnum
_$requestTypeChangeRequestNewTypeEnum_PROMOTEUR =
    const RequestTypeChangeRequestNewTypeEnum._('PROMOTEUR');
const RequestTypeChangeRequestNewTypeEnum
_$requestTypeChangeRequestNewTypeEnum_unknownDefaultOpenApi =
    const RequestTypeChangeRequestNewTypeEnum._('unknownDefaultOpenApi');

RequestTypeChangeRequestNewTypeEnum
_$requestTypeChangeRequestNewTypeEnumValueOf(String name) {
  switch (name) {
    case 'PARTICULIER':
      return _$requestTypeChangeRequestNewTypeEnum_PARTICULIER;
    case 'AGENCE':
      return _$requestTypeChangeRequestNewTypeEnum_AGENCE;
    case 'PROMOTEUR':
      return _$requestTypeChangeRequestNewTypeEnum_PROMOTEUR;
    case 'unknownDefaultOpenApi':
      return _$requestTypeChangeRequestNewTypeEnum_unknownDefaultOpenApi;
    default:
      return _$requestTypeChangeRequestNewTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RequestTypeChangeRequestNewTypeEnum>
_$requestTypeChangeRequestNewTypeEnumValues =
    BuiltSet<RequestTypeChangeRequestNewTypeEnum>(
      const <RequestTypeChangeRequestNewTypeEnum>[
        _$requestTypeChangeRequestNewTypeEnum_PARTICULIER,
        _$requestTypeChangeRequestNewTypeEnum_AGENCE,
        _$requestTypeChangeRequestNewTypeEnum_PROMOTEUR,
        _$requestTypeChangeRequestNewTypeEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<RequestTypeChangeRequestNewTypeEnum>
_$requestTypeChangeRequestNewTypeEnumSerializer =
    _$RequestTypeChangeRequestNewTypeEnumSerializer();

class _$RequestTypeChangeRequestNewTypeEnumSerializer
    implements PrimitiveSerializer<RequestTypeChangeRequestNewTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PARTICULIER': 'PARTICULIER',
    'AGENCE': 'AGENCE',
    'PROMOTEUR': 'PROMOTEUR',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PARTICULIER': 'PARTICULIER',
    'AGENCE': 'AGENCE',
    'PROMOTEUR': 'PROMOTEUR',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    RequestTypeChangeRequestNewTypeEnum,
  ];
  @override
  final String wireName = 'RequestTypeChangeRequestNewTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    RequestTypeChangeRequestNewTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  RequestTypeChangeRequestNewTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => RequestTypeChangeRequestNewTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$RequestTypeChangeRequest extends RequestTypeChangeRequest {
  @override
  final RequestTypeChangeRequestNewTypeEnum newType;
  @override
  final String? reason;

  factory _$RequestTypeChangeRequest([
    void Function(RequestTypeChangeRequestBuilder)? updates,
  ]) => (RequestTypeChangeRequestBuilder()..update(updates))._build();

  _$RequestTypeChangeRequest._({required this.newType, this.reason})
    : super._();
  @override
  RequestTypeChangeRequest rebuild(
    void Function(RequestTypeChangeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  RequestTypeChangeRequestBuilder toBuilder() =>
      RequestTypeChangeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RequestTypeChangeRequest &&
        newType == other.newType &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newType.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RequestTypeChangeRequest')
          ..add('newType', newType)
          ..add('reason', reason))
        .toString();
  }
}

class RequestTypeChangeRequestBuilder
    implements
        Builder<RequestTypeChangeRequest, RequestTypeChangeRequestBuilder> {
  _$RequestTypeChangeRequest? _$v;

  RequestTypeChangeRequestNewTypeEnum? _newType;
  RequestTypeChangeRequestNewTypeEnum? get newType => _$this._newType;
  set newType(RequestTypeChangeRequestNewTypeEnum? newType) =>
      _$this._newType = newType;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  RequestTypeChangeRequestBuilder() {
    RequestTypeChangeRequest._defaults(this);
  }

  RequestTypeChangeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newType = $v.newType;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RequestTypeChangeRequest other) {
    _$v = other as _$RequestTypeChangeRequest;
  }

  @override
  void update(void Function(RequestTypeChangeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RequestTypeChangeRequest build() => _build();

  _$RequestTypeChangeRequest _build() {
    final _$result =
        _$v ??
        _$RequestTypeChangeRequest._(
          newType: BuiltValueNullFieldError.checkNotNull(
            newType,
            r'RequestTypeChangeRequest',
            'newType',
          ),
          reason: reason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
