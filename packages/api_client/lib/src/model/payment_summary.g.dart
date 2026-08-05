// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PaymentSummaryTierEnum _$paymentSummaryTierEnum_FREE =
    const PaymentSummaryTierEnum._('FREE');
const PaymentSummaryTierEnum _$paymentSummaryTierEnum_BASIC_PLUS =
    const PaymentSummaryTierEnum._('BASIC_PLUS');
const PaymentSummaryTierEnum _$paymentSummaryTierEnum_PRO =
    const PaymentSummaryTierEnum._('PRO');
const PaymentSummaryTierEnum _$paymentSummaryTierEnum_PRO_PLUS =
    const PaymentSummaryTierEnum._('PRO_PLUS');
const PaymentSummaryTierEnum _$paymentSummaryTierEnum_unknownDefaultOpenApi =
    const PaymentSummaryTierEnum._('unknownDefaultOpenApi');

PaymentSummaryTierEnum _$paymentSummaryTierEnumValueOf(String name) {
  switch (name) {
    case 'FREE':
      return _$paymentSummaryTierEnum_FREE;
    case 'BASIC_PLUS':
      return _$paymentSummaryTierEnum_BASIC_PLUS;
    case 'PRO':
      return _$paymentSummaryTierEnum_PRO;
    case 'PRO_PLUS':
      return _$paymentSummaryTierEnum_PRO_PLUS;
    case 'unknownDefaultOpenApi':
      return _$paymentSummaryTierEnum_unknownDefaultOpenApi;
    default:
      return _$paymentSummaryTierEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PaymentSummaryTierEnum> _$paymentSummaryTierEnumValues =
    BuiltSet<PaymentSummaryTierEnum>(const <PaymentSummaryTierEnum>[
      _$paymentSummaryTierEnum_FREE,
      _$paymentSummaryTierEnum_BASIC_PLUS,
      _$paymentSummaryTierEnum_PRO,
      _$paymentSummaryTierEnum_PRO_PLUS,
      _$paymentSummaryTierEnum_unknownDefaultOpenApi,
    ]);

const PaymentSummaryMethodEnum _$paymentSummaryMethodEnum_MTN_MOMO =
    const PaymentSummaryMethodEnum._('MTN_MOMO');
const PaymentSummaryMethodEnum _$paymentSummaryMethodEnum_ORANGE_MONEY =
    const PaymentSummaryMethodEnum._('ORANGE_MONEY');
const PaymentSummaryMethodEnum
_$paymentSummaryMethodEnum_unknownDefaultOpenApi =
    const PaymentSummaryMethodEnum._('unknownDefaultOpenApi');

PaymentSummaryMethodEnum _$paymentSummaryMethodEnumValueOf(String name) {
  switch (name) {
    case 'MTN_MOMO':
      return _$paymentSummaryMethodEnum_MTN_MOMO;
    case 'ORANGE_MONEY':
      return _$paymentSummaryMethodEnum_ORANGE_MONEY;
    case 'unknownDefaultOpenApi':
      return _$paymentSummaryMethodEnum_unknownDefaultOpenApi;
    default:
      return _$paymentSummaryMethodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PaymentSummaryMethodEnum> _$paymentSummaryMethodEnumValues =
    BuiltSet<PaymentSummaryMethodEnum>(const <PaymentSummaryMethodEnum>[
      _$paymentSummaryMethodEnum_MTN_MOMO,
      _$paymentSummaryMethodEnum_ORANGE_MONEY,
      _$paymentSummaryMethodEnum_unknownDefaultOpenApi,
    ]);

const PaymentSummaryStatusEnum _$paymentSummaryStatusEnum_PENDING =
    const PaymentSummaryStatusEnum._('PENDING');
const PaymentSummaryStatusEnum _$paymentSummaryStatusEnum_CONFIRMED =
    const PaymentSummaryStatusEnum._('CONFIRMED');
const PaymentSummaryStatusEnum _$paymentSummaryStatusEnum_FAILED =
    const PaymentSummaryStatusEnum._('FAILED');
const PaymentSummaryStatusEnum _$paymentSummaryStatusEnum_CANCELLED =
    const PaymentSummaryStatusEnum._('CANCELLED');
const PaymentSummaryStatusEnum
_$paymentSummaryStatusEnum_unknownDefaultOpenApi =
    const PaymentSummaryStatusEnum._('unknownDefaultOpenApi');

PaymentSummaryStatusEnum _$paymentSummaryStatusEnumValueOf(String name) {
  switch (name) {
    case 'PENDING':
      return _$paymentSummaryStatusEnum_PENDING;
    case 'CONFIRMED':
      return _$paymentSummaryStatusEnum_CONFIRMED;
    case 'FAILED':
      return _$paymentSummaryStatusEnum_FAILED;
    case 'CANCELLED':
      return _$paymentSummaryStatusEnum_CANCELLED;
    case 'unknownDefaultOpenApi':
      return _$paymentSummaryStatusEnum_unknownDefaultOpenApi;
    default:
      return _$paymentSummaryStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PaymentSummaryStatusEnum> _$paymentSummaryStatusEnumValues =
    BuiltSet<PaymentSummaryStatusEnum>(const <PaymentSummaryStatusEnum>[
      _$paymentSummaryStatusEnum_PENDING,
      _$paymentSummaryStatusEnum_CONFIRMED,
      _$paymentSummaryStatusEnum_FAILED,
      _$paymentSummaryStatusEnum_CANCELLED,
      _$paymentSummaryStatusEnum_unknownDefaultOpenApi,
    ]);

Serializer<PaymentSummaryTierEnum> _$paymentSummaryTierEnumSerializer =
    _$PaymentSummaryTierEnumSerializer();
Serializer<PaymentSummaryMethodEnum> _$paymentSummaryMethodEnumSerializer =
    _$PaymentSummaryMethodEnumSerializer();
Serializer<PaymentSummaryStatusEnum> _$paymentSummaryStatusEnumSerializer =
    _$PaymentSummaryStatusEnumSerializer();

class _$PaymentSummaryTierEnumSerializer
    implements PrimitiveSerializer<PaymentSummaryTierEnum> {
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
  final Iterable<Type> types = const <Type>[PaymentSummaryTierEnum];
  @override
  final String wireName = 'PaymentSummaryTierEnum';

  @override
  Object serialize(
    Serializers serializers,
    PaymentSummaryTierEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PaymentSummaryTierEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PaymentSummaryTierEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PaymentSummaryMethodEnumSerializer
    implements PrimitiveSerializer<PaymentSummaryMethodEnum> {
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
  final Iterable<Type> types = const <Type>[PaymentSummaryMethodEnum];
  @override
  final String wireName = 'PaymentSummaryMethodEnum';

  @override
  Object serialize(
    Serializers serializers,
    PaymentSummaryMethodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PaymentSummaryMethodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PaymentSummaryMethodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PaymentSummaryStatusEnumSerializer
    implements PrimitiveSerializer<PaymentSummaryStatusEnum> {
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
  final Iterable<Type> types = const <Type>[PaymentSummaryStatusEnum];
  @override
  final String wireName = 'PaymentSummaryStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    PaymentSummaryStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PaymentSummaryStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PaymentSummaryStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PaymentSummary extends PaymentSummary {
  @override
  final String? paymentId;
  @override
  final PaymentSummaryTierEnum? tier;
  @override
  final int? amount;
  @override
  final PaymentSummaryMethodEnum? method;
  @override
  final PaymentSummaryStatusEnum? status;
  @override
  final bool? hasReceipt;
  @override
  final DateTime? paidAt;
  @override
  final DateTime? createdAt;

  factory _$PaymentSummary([void Function(PaymentSummaryBuilder)? updates]) =>
      (PaymentSummaryBuilder()..update(updates))._build();

  _$PaymentSummary._({
    this.paymentId,
    this.tier,
    this.amount,
    this.method,
    this.status,
    this.hasReceipt,
    this.paidAt,
    this.createdAt,
  }) : super._();
  @override
  PaymentSummary rebuild(void Function(PaymentSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentSummaryBuilder toBuilder() => PaymentSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentSummary &&
        paymentId == other.paymentId &&
        tier == other.tier &&
        amount == other.amount &&
        method == other.method &&
        status == other.status &&
        hasReceipt == other.hasReceipt &&
        paidAt == other.paidAt &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, paymentId.hashCode);
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, hasReceipt.hashCode);
    _$hash = $jc(_$hash, paidAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaymentSummary')
          ..add('paymentId', paymentId)
          ..add('tier', tier)
          ..add('amount', amount)
          ..add('method', method)
          ..add('status', status)
          ..add('hasReceipt', hasReceipt)
          ..add('paidAt', paidAt)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class PaymentSummaryBuilder
    implements Builder<PaymentSummary, PaymentSummaryBuilder> {
  _$PaymentSummary? _$v;

  String? _paymentId;
  String? get paymentId => _$this._paymentId;
  set paymentId(String? paymentId) => _$this._paymentId = paymentId;

  PaymentSummaryTierEnum? _tier;
  PaymentSummaryTierEnum? get tier => _$this._tier;
  set tier(PaymentSummaryTierEnum? tier) => _$this._tier = tier;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  PaymentSummaryMethodEnum? _method;
  PaymentSummaryMethodEnum? get method => _$this._method;
  set method(PaymentSummaryMethodEnum? method) => _$this._method = method;

  PaymentSummaryStatusEnum? _status;
  PaymentSummaryStatusEnum? get status => _$this._status;
  set status(PaymentSummaryStatusEnum? status) => _$this._status = status;

  bool? _hasReceipt;
  bool? get hasReceipt => _$this._hasReceipt;
  set hasReceipt(bool? hasReceipt) => _$this._hasReceipt = hasReceipt;

  DateTime? _paidAt;
  DateTime? get paidAt => _$this._paidAt;
  set paidAt(DateTime? paidAt) => _$this._paidAt = paidAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  PaymentSummaryBuilder() {
    PaymentSummary._defaults(this);
  }

  PaymentSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _paymentId = $v.paymentId;
      _tier = $v.tier;
      _amount = $v.amount;
      _method = $v.method;
      _status = $v.status;
      _hasReceipt = $v.hasReceipt;
      _paidAt = $v.paidAt;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentSummary other) {
    _$v = other as _$PaymentSummary;
  }

  @override
  void update(void Function(PaymentSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentSummary build() => _build();

  _$PaymentSummary _build() {
    final _$result =
        _$v ??
        _$PaymentSummary._(
          paymentId: paymentId,
          tier: tier,
          amount: amount,
          method: method,
          status: status,
          hasReceipt: hasReceipt,
          paidAt: paidAt,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
