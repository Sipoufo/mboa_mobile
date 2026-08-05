// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribe_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SubscribeRequestTierEnum _$subscribeRequestTierEnum_FREE =
    const SubscribeRequestTierEnum._('FREE');
const SubscribeRequestTierEnum _$subscribeRequestTierEnum_BASIC_PLUS =
    const SubscribeRequestTierEnum._('BASIC_PLUS');
const SubscribeRequestTierEnum _$subscribeRequestTierEnum_PRO =
    const SubscribeRequestTierEnum._('PRO');
const SubscribeRequestTierEnum _$subscribeRequestTierEnum_PRO_PLUS =
    const SubscribeRequestTierEnum._('PRO_PLUS');
const SubscribeRequestTierEnum
_$subscribeRequestTierEnum_unknownDefaultOpenApi =
    const SubscribeRequestTierEnum._('unknownDefaultOpenApi');

SubscribeRequestTierEnum _$subscribeRequestTierEnumValueOf(String name) {
  switch (name) {
    case 'FREE':
      return _$subscribeRequestTierEnum_FREE;
    case 'BASIC_PLUS':
      return _$subscribeRequestTierEnum_BASIC_PLUS;
    case 'PRO':
      return _$subscribeRequestTierEnum_PRO;
    case 'PRO_PLUS':
      return _$subscribeRequestTierEnum_PRO_PLUS;
    case 'unknownDefaultOpenApi':
      return _$subscribeRequestTierEnum_unknownDefaultOpenApi;
    default:
      return _$subscribeRequestTierEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<SubscribeRequestTierEnum> _$subscribeRequestTierEnumValues =
    BuiltSet<SubscribeRequestTierEnum>(const <SubscribeRequestTierEnum>[
      _$subscribeRequestTierEnum_FREE,
      _$subscribeRequestTierEnum_BASIC_PLUS,
      _$subscribeRequestTierEnum_PRO,
      _$subscribeRequestTierEnum_PRO_PLUS,
      _$subscribeRequestTierEnum_unknownDefaultOpenApi,
    ]);

const SubscribeRequestMethodEnum _$subscribeRequestMethodEnum_MTN_MOMO =
    const SubscribeRequestMethodEnum._('MTN_MOMO');
const SubscribeRequestMethodEnum _$subscribeRequestMethodEnum_ORANGE_MONEY =
    const SubscribeRequestMethodEnum._('ORANGE_MONEY');
const SubscribeRequestMethodEnum
_$subscribeRequestMethodEnum_unknownDefaultOpenApi =
    const SubscribeRequestMethodEnum._('unknownDefaultOpenApi');

SubscribeRequestMethodEnum _$subscribeRequestMethodEnumValueOf(String name) {
  switch (name) {
    case 'MTN_MOMO':
      return _$subscribeRequestMethodEnum_MTN_MOMO;
    case 'ORANGE_MONEY':
      return _$subscribeRequestMethodEnum_ORANGE_MONEY;
    case 'unknownDefaultOpenApi':
      return _$subscribeRequestMethodEnum_unknownDefaultOpenApi;
    default:
      return _$subscribeRequestMethodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<SubscribeRequestMethodEnum> _$subscribeRequestMethodEnumValues =
    BuiltSet<SubscribeRequestMethodEnum>(const <SubscribeRequestMethodEnum>[
      _$subscribeRequestMethodEnum_MTN_MOMO,
      _$subscribeRequestMethodEnum_ORANGE_MONEY,
      _$subscribeRequestMethodEnum_unknownDefaultOpenApi,
    ]);

Serializer<SubscribeRequestTierEnum> _$subscribeRequestTierEnumSerializer =
    _$SubscribeRequestTierEnumSerializer();
Serializer<SubscribeRequestMethodEnum> _$subscribeRequestMethodEnumSerializer =
    _$SubscribeRequestMethodEnumSerializer();

class _$SubscribeRequestTierEnumSerializer
    implements PrimitiveSerializer<SubscribeRequestTierEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'FREE': 'FREE',
    'BASIC_PLUS': 'BASIC_PLUS',
    'PRO': 'PRO',
    'PRO_PLUS': 'PRO_PLUS',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'FREE': 'FREE',
    'BASIC_PLUS': 'BASIC_PLUS',
    'PRO': 'PRO',
    'PRO_PLUS': 'PRO_PLUS',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[SubscribeRequestTierEnum];
  @override
  final String wireName = 'SubscribeRequestTierEnum';

  @override
  Object serialize(
    Serializers serializers,
    SubscribeRequestTierEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SubscribeRequestTierEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SubscribeRequestTierEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SubscribeRequestMethodEnumSerializer
    implements PrimitiveSerializer<SubscribeRequestMethodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MTN_MOMO': 'MTN_MOMO',
    'ORANGE_MONEY': 'ORANGE_MONEY',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MTN_MOMO': 'MTN_MOMO',
    'ORANGE_MONEY': 'ORANGE_MONEY',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[SubscribeRequestMethodEnum];
  @override
  final String wireName = 'SubscribeRequestMethodEnum';

  @override
  Object serialize(
    Serializers serializers,
    SubscribeRequestMethodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SubscribeRequestMethodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SubscribeRequestMethodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SubscribeRequest extends SubscribeRequest {
  @override
  final SubscribeRequestTierEnum tier;
  @override
  final SubscribeRequestMethodEnum method;

  factory _$SubscribeRequest([
    void Function(SubscribeRequestBuilder)? updates,
  ]) => (SubscribeRequestBuilder()..update(updates))._build();

  _$SubscribeRequest._({required this.tier, required this.method}) : super._();
  @override
  SubscribeRequest rebuild(void Function(SubscribeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubscribeRequestBuilder toBuilder() =>
      SubscribeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubscribeRequest &&
        tier == other.tier &&
        method == other.method;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubscribeRequest')
          ..add('tier', tier)
          ..add('method', method))
        .toString();
  }
}

class SubscribeRequestBuilder
    implements Builder<SubscribeRequest, SubscribeRequestBuilder> {
  _$SubscribeRequest? _$v;

  SubscribeRequestTierEnum? _tier;
  SubscribeRequestTierEnum? get tier => _$this._tier;
  set tier(SubscribeRequestTierEnum? tier) => _$this._tier = tier;

  SubscribeRequestMethodEnum? _method;
  SubscribeRequestMethodEnum? get method => _$this._method;
  set method(SubscribeRequestMethodEnum? method) => _$this._method = method;

  SubscribeRequestBuilder() {
    SubscribeRequest._defaults(this);
  }

  SubscribeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tier = $v.tier;
      _method = $v.method;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubscribeRequest other) {
    _$v = other as _$SubscribeRequest;
  }

  @override
  void update(void Function(SubscribeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubscribeRequest build() => _build();

  _$SubscribeRequest _build() {
    final _$result =
        _$v ??
        _$SubscribeRequest._(
          tier: BuiltValueNullFieldError.checkNotNull(
            tier,
            r'SubscribeRequest',
            'tier',
          ),
          method: BuiltValueNullFieldError.checkNotNull(
            method,
            r'SubscribeRequest',
            'method',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
