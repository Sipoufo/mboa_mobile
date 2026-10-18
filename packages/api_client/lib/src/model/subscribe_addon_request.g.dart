// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribe_addon_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SubscribeAddonRequestMethodEnum
_$subscribeAddonRequestMethodEnum_MTN_MOMO =
    const SubscribeAddonRequestMethodEnum._('MTN_MOMO');
const SubscribeAddonRequestMethodEnum
_$subscribeAddonRequestMethodEnum_ORANGE_MONEY =
    const SubscribeAddonRequestMethodEnum._('ORANGE_MONEY');
const SubscribeAddonRequestMethodEnum
_$subscribeAddonRequestMethodEnum_unknownDefaultOpenApi =
    const SubscribeAddonRequestMethodEnum._('unknownDefaultOpenApi');

SubscribeAddonRequestMethodEnum _$subscribeAddonRequestMethodEnumValueOf(
  String name,
) {
  switch (name) {
    case 'MTN_MOMO':
      return _$subscribeAddonRequestMethodEnum_MTN_MOMO;
    case 'ORANGE_MONEY':
      return _$subscribeAddonRequestMethodEnum_ORANGE_MONEY;
    case 'unknownDefaultOpenApi':
      return _$subscribeAddonRequestMethodEnum_unknownDefaultOpenApi;
    default:
      return _$subscribeAddonRequestMethodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<SubscribeAddonRequestMethodEnum>
_$subscribeAddonRequestMethodEnumValues =
    BuiltSet<SubscribeAddonRequestMethodEnum>(
      const <SubscribeAddonRequestMethodEnum>[
        _$subscribeAddonRequestMethodEnum_MTN_MOMO,
        _$subscribeAddonRequestMethodEnum_ORANGE_MONEY,
        _$subscribeAddonRequestMethodEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<SubscribeAddonRequestMethodEnum>
_$subscribeAddonRequestMethodEnumSerializer =
    _$SubscribeAddonRequestMethodEnumSerializer();

class _$SubscribeAddonRequestMethodEnumSerializer
    implements PrimitiveSerializer<SubscribeAddonRequestMethodEnum> {
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
  final Iterable<Type> types = const <Type>[SubscribeAddonRequestMethodEnum];
  @override
  final String wireName = 'SubscribeAddonRequestMethodEnum';

  @override
  Object serialize(
    Serializers serializers,
    SubscribeAddonRequestMethodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SubscribeAddonRequestMethodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SubscribeAddonRequestMethodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SubscribeAddonRequest extends SubscribeAddonRequest {
  @override
  final SubscribeAddonRequestMethodEnum method;

  factory _$SubscribeAddonRequest([
    void Function(SubscribeAddonRequestBuilder)? updates,
  ]) => (SubscribeAddonRequestBuilder()..update(updates))._build();

  _$SubscribeAddonRequest._({required this.method}) : super._();
  @override
  SubscribeAddonRequest rebuild(
    void Function(SubscribeAddonRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SubscribeAddonRequestBuilder toBuilder() =>
      SubscribeAddonRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubscribeAddonRequest && method == other.method;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'SubscribeAddonRequest',
    )..add('method', method)).toString();
  }
}

class SubscribeAddonRequestBuilder
    implements Builder<SubscribeAddonRequest, SubscribeAddonRequestBuilder> {
  _$SubscribeAddonRequest? _$v;

  SubscribeAddonRequestMethodEnum? _method;
  SubscribeAddonRequestMethodEnum? get method => _$this._method;
  set method(SubscribeAddonRequestMethodEnum? method) =>
      _$this._method = method;

  SubscribeAddonRequestBuilder() {
    SubscribeAddonRequest._defaults(this);
  }

  SubscribeAddonRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _method = $v.method;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubscribeAddonRequest other) {
    _$v = other as _$SubscribeAddonRequest;
  }

  @override
  void update(void Function(SubscribeAddonRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubscribeAddonRequest build() => _build();

  _$SubscribeAddonRequest _build() {
    final _$result =
        _$v ??
        _$SubscribeAddonRequest._(
          method: BuiltValueNullFieldError.checkNotNull(
            method,
            r'SubscribeAddonRequest',
            'method',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
