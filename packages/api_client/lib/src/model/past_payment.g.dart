// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_payment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PastPaymentKindEnum _$pastPaymentKindEnum_RENT =
    const PastPaymentKindEnum._('RENT');
const PastPaymentKindEnum _$pastPaymentKindEnum_DEPOSIT =
    const PastPaymentKindEnum._('DEPOSIT');
const PastPaymentKindEnum _$pastPaymentKindEnum_INVOICE =
    const PastPaymentKindEnum._('INVOICE');
const PastPaymentKindEnum _$pastPaymentKindEnum_unknownDefaultOpenApi =
    const PastPaymentKindEnum._('unknownDefaultOpenApi');

PastPaymentKindEnum _$pastPaymentKindEnumValueOf(String name) {
  switch (name) {
    case 'RENT':
      return _$pastPaymentKindEnum_RENT;
    case 'DEPOSIT':
      return _$pastPaymentKindEnum_DEPOSIT;
    case 'INVOICE':
      return _$pastPaymentKindEnum_INVOICE;
    case 'unknownDefaultOpenApi':
      return _$pastPaymentKindEnum_unknownDefaultOpenApi;
    default:
      return _$pastPaymentKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PastPaymentKindEnum> _$pastPaymentKindEnumValues =
    BuiltSet<PastPaymentKindEnum>(const <PastPaymentKindEnum>[
      _$pastPaymentKindEnum_RENT,
      _$pastPaymentKindEnum_DEPOSIT,
      _$pastPaymentKindEnum_INVOICE,
      _$pastPaymentKindEnum_unknownDefaultOpenApi,
    ]);

const PastPaymentStatusEnum _$pastPaymentStatusEnum_DECLARED =
    const PastPaymentStatusEnum._('DECLARED');
const PastPaymentStatusEnum _$pastPaymentStatusEnum_UNCONFIRMED =
    const PastPaymentStatusEnum._('UNCONFIRMED');
const PastPaymentStatusEnum _$pastPaymentStatusEnum_CONFIRMED =
    const PastPaymentStatusEnum._('CONFIRMED');
const PastPaymentStatusEnum _$pastPaymentStatusEnum_CONTESTED =
    const PastPaymentStatusEnum._('CONTESTED');
const PastPaymentStatusEnum _$pastPaymentStatusEnum_unknownDefaultOpenApi =
    const PastPaymentStatusEnum._('unknownDefaultOpenApi');

PastPaymentStatusEnum _$pastPaymentStatusEnumValueOf(String name) {
  switch (name) {
    case 'DECLARED':
      return _$pastPaymentStatusEnum_DECLARED;
    case 'UNCONFIRMED':
      return _$pastPaymentStatusEnum_UNCONFIRMED;
    case 'CONFIRMED':
      return _$pastPaymentStatusEnum_CONFIRMED;
    case 'CONTESTED':
      return _$pastPaymentStatusEnum_CONTESTED;
    case 'unknownDefaultOpenApi':
      return _$pastPaymentStatusEnum_unknownDefaultOpenApi;
    default:
      return _$pastPaymentStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PastPaymentStatusEnum> _$pastPaymentStatusEnumValues =
    BuiltSet<PastPaymentStatusEnum>(const <PastPaymentStatusEnum>[
      _$pastPaymentStatusEnum_DECLARED,
      _$pastPaymentStatusEnum_UNCONFIRMED,
      _$pastPaymentStatusEnum_CONFIRMED,
      _$pastPaymentStatusEnum_CONTESTED,
      _$pastPaymentStatusEnum_unknownDefaultOpenApi,
    ]);

Serializer<PastPaymentKindEnum> _$pastPaymentKindEnumSerializer =
    _$PastPaymentKindEnumSerializer();
Serializer<PastPaymentStatusEnum> _$pastPaymentStatusEnumSerializer =
    _$PastPaymentStatusEnumSerializer();

class _$PastPaymentKindEnumSerializer
    implements PrimitiveSerializer<PastPaymentKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'RENT': 'RENT',
    'DEPOSIT': 'DEPOSIT',
    'INVOICE': 'INVOICE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'RENT': 'RENT',
    'DEPOSIT': 'DEPOSIT',
    'INVOICE': 'INVOICE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PastPaymentKindEnum];
  @override
  final String wireName = 'PastPaymentKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    PastPaymentKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PastPaymentKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PastPaymentKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PastPaymentStatusEnumSerializer
    implements PrimitiveSerializer<PastPaymentStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'DECLARED': 'DECLARED',
    'UNCONFIRMED': 'UNCONFIRMED',
    'CONFIRMED': 'CONFIRMED',
    'CONTESTED': 'CONTESTED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'DECLARED': 'DECLARED',
    'UNCONFIRMED': 'UNCONFIRMED',
    'CONFIRMED': 'CONFIRMED',
    'CONTESTED': 'CONTESTED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PastPaymentStatusEnum];
  @override
  final String wireName = 'PastPaymentStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    PastPaymentStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PastPaymentStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PastPaymentStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PastPayment extends PastPayment {
  @override
  final String? declarationId;
  @override
  final PastPaymentKindEnum? kind;
  @override
  final String? label;
  @override
  final Date? periodStart;
  @override
  final Date? periodEnd;
  @override
  final String? invoiceId;
  @override
  final int? amount;
  @override
  final Date? paidOn;
  @override
  final PastPaymentStatusEnum? status;
  @override
  final String? receiptId;
  @override
  final bool? receiptReady;

  factory _$PastPayment([void Function(PastPaymentBuilder)? updates]) =>
      (PastPaymentBuilder()..update(updates))._build();

  _$PastPayment._({
    this.declarationId,
    this.kind,
    this.label,
    this.periodStart,
    this.periodEnd,
    this.invoiceId,
    this.amount,
    this.paidOn,
    this.status,
    this.receiptId,
    this.receiptReady,
  }) : super._();
  @override
  PastPayment rebuild(void Function(PastPaymentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PastPaymentBuilder toBuilder() => PastPaymentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PastPayment &&
        declarationId == other.declarationId &&
        kind == other.kind &&
        label == other.label &&
        periodStart == other.periodStart &&
        periodEnd == other.periodEnd &&
        invoiceId == other.invoiceId &&
        amount == other.amount &&
        paidOn == other.paidOn &&
        status == other.status &&
        receiptId == other.receiptId &&
        receiptReady == other.receiptReady;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, declarationId.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, periodStart.hashCode);
    _$hash = $jc(_$hash, periodEnd.hashCode);
    _$hash = $jc(_$hash, invoiceId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, paidOn.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, receiptId.hashCode);
    _$hash = $jc(_$hash, receiptReady.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PastPayment')
          ..add('declarationId', declarationId)
          ..add('kind', kind)
          ..add('label', label)
          ..add('periodStart', periodStart)
          ..add('periodEnd', periodEnd)
          ..add('invoiceId', invoiceId)
          ..add('amount', amount)
          ..add('paidOn', paidOn)
          ..add('status', status)
          ..add('receiptId', receiptId)
          ..add('receiptReady', receiptReady))
        .toString();
  }
}

class PastPaymentBuilder implements Builder<PastPayment, PastPaymentBuilder> {
  _$PastPayment? _$v;

  String? _declarationId;
  String? get declarationId => _$this._declarationId;
  set declarationId(String? declarationId) =>
      _$this._declarationId = declarationId;

  PastPaymentKindEnum? _kind;
  PastPaymentKindEnum? get kind => _$this._kind;
  set kind(PastPaymentKindEnum? kind) => _$this._kind = kind;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  Date? _periodStart;
  Date? get periodStart => _$this._periodStart;
  set periodStart(Date? periodStart) => _$this._periodStart = periodStart;

  Date? _periodEnd;
  Date? get periodEnd => _$this._periodEnd;
  set periodEnd(Date? periodEnd) => _$this._periodEnd = periodEnd;

  String? _invoiceId;
  String? get invoiceId => _$this._invoiceId;
  set invoiceId(String? invoiceId) => _$this._invoiceId = invoiceId;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  Date? _paidOn;
  Date? get paidOn => _$this._paidOn;
  set paidOn(Date? paidOn) => _$this._paidOn = paidOn;

  PastPaymentStatusEnum? _status;
  PastPaymentStatusEnum? get status => _$this._status;
  set status(PastPaymentStatusEnum? status) => _$this._status = status;

  String? _receiptId;
  String? get receiptId => _$this._receiptId;
  set receiptId(String? receiptId) => _$this._receiptId = receiptId;

  bool? _receiptReady;
  bool? get receiptReady => _$this._receiptReady;
  set receiptReady(bool? receiptReady) => _$this._receiptReady = receiptReady;

  PastPaymentBuilder() {
    PastPayment._defaults(this);
  }

  PastPaymentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _declarationId = $v.declarationId;
      _kind = $v.kind;
      _label = $v.label;
      _periodStart = $v.periodStart;
      _periodEnd = $v.periodEnd;
      _invoiceId = $v.invoiceId;
      _amount = $v.amount;
      _paidOn = $v.paidOn;
      _status = $v.status;
      _receiptId = $v.receiptId;
      _receiptReady = $v.receiptReady;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PastPayment other) {
    _$v = other as _$PastPayment;
  }

  @override
  void update(void Function(PastPaymentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PastPayment build() => _build();

  _$PastPayment _build() {
    final _$result =
        _$v ??
        _$PastPayment._(
          declarationId: declarationId,
          kind: kind,
          label: label,
          periodStart: periodStart,
          periodEnd: periodEnd,
          invoiceId: invoiceId,
          amount: amount,
          paidOn: paidOn,
          status: status,
          receiptId: receiptId,
          receiptReady: receiptReady,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
