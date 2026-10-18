// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_invoice_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PayInvoiceRequestMethodEnum _$payInvoiceRequestMethodEnum_MTN_MOMO =
    const PayInvoiceRequestMethodEnum._('MTN_MOMO');
const PayInvoiceRequestMethodEnum _$payInvoiceRequestMethodEnum_ORANGE_MONEY =
    const PayInvoiceRequestMethodEnum._('ORANGE_MONEY');
const PayInvoiceRequestMethodEnum
_$payInvoiceRequestMethodEnum_unknownDefaultOpenApi =
    const PayInvoiceRequestMethodEnum._('unknownDefaultOpenApi');

PayInvoiceRequestMethodEnum _$payInvoiceRequestMethodEnumValueOf(String name) {
  switch (name) {
    case 'MTN_MOMO':
      return _$payInvoiceRequestMethodEnum_MTN_MOMO;
    case 'ORANGE_MONEY':
      return _$payInvoiceRequestMethodEnum_ORANGE_MONEY;
    case 'unknownDefaultOpenApi':
      return _$payInvoiceRequestMethodEnum_unknownDefaultOpenApi;
    default:
      return _$payInvoiceRequestMethodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PayInvoiceRequestMethodEnum>
_$payInvoiceRequestMethodEnumValues =
    BuiltSet<PayInvoiceRequestMethodEnum>(const <PayInvoiceRequestMethodEnum>[
      _$payInvoiceRequestMethodEnum_MTN_MOMO,
      _$payInvoiceRequestMethodEnum_ORANGE_MONEY,
      _$payInvoiceRequestMethodEnum_unknownDefaultOpenApi,
    ]);

Serializer<PayInvoiceRequestMethodEnum>
_$payInvoiceRequestMethodEnumSerializer =
    _$PayInvoiceRequestMethodEnumSerializer();

class _$PayInvoiceRequestMethodEnumSerializer
    implements PrimitiveSerializer<PayInvoiceRequestMethodEnum> {
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
  final Iterable<Type> types = const <Type>[PayInvoiceRequestMethodEnum];
  @override
  final String wireName = 'PayInvoiceRequestMethodEnum';

  @override
  Object serialize(
    Serializers serializers,
    PayInvoiceRequestMethodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PayInvoiceRequestMethodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PayInvoiceRequestMethodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PayInvoiceRequest extends PayInvoiceRequest {
  @override
  final PayInvoiceRequestMethodEnum method;

  factory _$PayInvoiceRequest([
    void Function(PayInvoiceRequestBuilder)? updates,
  ]) => (PayInvoiceRequestBuilder()..update(updates))._build();

  _$PayInvoiceRequest._({required this.method}) : super._();
  @override
  PayInvoiceRequest rebuild(void Function(PayInvoiceRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PayInvoiceRequestBuilder toBuilder() =>
      PayInvoiceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PayInvoiceRequest && method == other.method;
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
      r'PayInvoiceRequest',
    )..add('method', method)).toString();
  }
}

class PayInvoiceRequestBuilder
    implements Builder<PayInvoiceRequest, PayInvoiceRequestBuilder> {
  _$PayInvoiceRequest? _$v;

  PayInvoiceRequestMethodEnum? _method;
  PayInvoiceRequestMethodEnum? get method => _$this._method;
  set method(PayInvoiceRequestMethodEnum? method) => _$this._method = method;

  PayInvoiceRequestBuilder() {
    PayInvoiceRequest._defaults(this);
  }

  PayInvoiceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _method = $v.method;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PayInvoiceRequest other) {
    _$v = other as _$PayInvoiceRequest;
  }

  @override
  void update(void Function(PayInvoiceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PayInvoiceRequest build() => _build();

  _$PayInvoiceRequest _build() {
    final _$result =
        _$v ??
        _$PayInvoiceRequest._(
          method: BuiltValueNullFieldError.checkNotNull(
            method,
            r'PayInvoiceRequest',
            'method',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
