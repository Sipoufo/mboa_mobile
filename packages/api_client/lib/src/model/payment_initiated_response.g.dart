// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_initiated_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PaymentInitiatedResponseStatusEnum
_$paymentInitiatedResponseStatusEnum_PENDING =
    const PaymentInitiatedResponseStatusEnum._('PENDING');
const PaymentInitiatedResponseStatusEnum
_$paymentInitiatedResponseStatusEnum_CONFIRMED =
    const PaymentInitiatedResponseStatusEnum._('CONFIRMED');
const PaymentInitiatedResponseStatusEnum
_$paymentInitiatedResponseStatusEnum_FAILED =
    const PaymentInitiatedResponseStatusEnum._('FAILED');
const PaymentInitiatedResponseStatusEnum
_$paymentInitiatedResponseStatusEnum_CANCELLED =
    const PaymentInitiatedResponseStatusEnum._('CANCELLED');
const PaymentInitiatedResponseStatusEnum
_$paymentInitiatedResponseStatusEnum_unknownDefaultOpenApi =
    const PaymentInitiatedResponseStatusEnum._('unknownDefaultOpenApi');

PaymentInitiatedResponseStatusEnum _$paymentInitiatedResponseStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PENDING':
      return _$paymentInitiatedResponseStatusEnum_PENDING;
    case 'CONFIRMED':
      return _$paymentInitiatedResponseStatusEnum_CONFIRMED;
    case 'FAILED':
      return _$paymentInitiatedResponseStatusEnum_FAILED;
    case 'CANCELLED':
      return _$paymentInitiatedResponseStatusEnum_CANCELLED;
    case 'unknownDefaultOpenApi':
      return _$paymentInitiatedResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$paymentInitiatedResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PaymentInitiatedResponseStatusEnum>
_$paymentInitiatedResponseStatusEnumValues =
    BuiltSet<PaymentInitiatedResponseStatusEnum>(
      const <PaymentInitiatedResponseStatusEnum>[
        _$paymentInitiatedResponseStatusEnum_PENDING,
        _$paymentInitiatedResponseStatusEnum_CONFIRMED,
        _$paymentInitiatedResponseStatusEnum_FAILED,
        _$paymentInitiatedResponseStatusEnum_CANCELLED,
        _$paymentInitiatedResponseStatusEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<PaymentInitiatedResponseStatusEnum>
_$paymentInitiatedResponseStatusEnumSerializer =
    _$PaymentInitiatedResponseStatusEnumSerializer();

class _$PaymentInitiatedResponseStatusEnumSerializer
    implements PrimitiveSerializer<PaymentInitiatedResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
    'CONFIRMED': 'CONFIRMED',
    'FAILED': 'FAILED',
    'CANCELLED': 'CANCELLED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
    'CONFIRMED': 'CONFIRMED',
    'FAILED': 'FAILED',
    'CANCELLED': 'CANCELLED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PaymentInitiatedResponseStatusEnum];
  @override
  final String wireName = 'PaymentInitiatedResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    PaymentInitiatedResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PaymentInitiatedResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PaymentInitiatedResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PaymentInitiatedResponse extends PaymentInitiatedResponse {
  @override
  final String? paymentId;
  @override
  final String? providerRef;
  @override
  final int? amount;
  @override
  final PaymentInitiatedResponseStatusEnum? status;

  factory _$PaymentInitiatedResponse([
    void Function(PaymentInitiatedResponseBuilder)? updates,
  ]) => (PaymentInitiatedResponseBuilder()..update(updates))._build();

  _$PaymentInitiatedResponse._({
    this.paymentId,
    this.providerRef,
    this.amount,
    this.status,
  }) : super._();
  @override
  PaymentInitiatedResponse rebuild(
    void Function(PaymentInitiatedResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaymentInitiatedResponseBuilder toBuilder() =>
      PaymentInitiatedResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentInitiatedResponse &&
        paymentId == other.paymentId &&
        providerRef == other.providerRef &&
        amount == other.amount &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, paymentId.hashCode);
    _$hash = $jc(_$hash, providerRef.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaymentInitiatedResponse')
          ..add('paymentId', paymentId)
          ..add('providerRef', providerRef)
          ..add('amount', amount)
          ..add('status', status))
        .toString();
  }
}

class PaymentInitiatedResponseBuilder
    implements
        Builder<PaymentInitiatedResponse, PaymentInitiatedResponseBuilder> {
  _$PaymentInitiatedResponse? _$v;

  String? _paymentId;
  String? get paymentId => _$this._paymentId;
  set paymentId(String? paymentId) => _$this._paymentId = paymentId;

  String? _providerRef;
  String? get providerRef => _$this._providerRef;
  set providerRef(String? providerRef) => _$this._providerRef = providerRef;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  PaymentInitiatedResponseStatusEnum? _status;
  PaymentInitiatedResponseStatusEnum? get status => _$this._status;
  set status(PaymentInitiatedResponseStatusEnum? status) =>
      _$this._status = status;

  PaymentInitiatedResponseBuilder() {
    PaymentInitiatedResponse._defaults(this);
  }

  PaymentInitiatedResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _paymentId = $v.paymentId;
      _providerRef = $v.providerRef;
      _amount = $v.amount;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentInitiatedResponse other) {
    _$v = other as _$PaymentInitiatedResponse;
  }

  @override
  void update(void Function(PaymentInitiatedResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentInitiatedResponse build() => _build();

  _$PaymentInitiatedResponse _build() {
    final _$result =
        _$v ??
        _$PaymentInitiatedResponse._(
          paymentId: paymentId,
          providerRef: providerRef,
          amount: amount,
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
