// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_verification.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ReceiptVerificationKindEnum _$receiptVerificationKindEnum_RENT =
    const ReceiptVerificationKindEnum._('RENT');
const ReceiptVerificationKindEnum _$receiptVerificationKindEnum_RENT_PARTIAL =
    const ReceiptVerificationKindEnum._('RENT_PARTIAL');
const ReceiptVerificationKindEnum _$receiptVerificationKindEnum_DEPOSIT =
    const ReceiptVerificationKindEnum._('DEPOSIT');
const ReceiptVerificationKindEnum _$receiptVerificationKindEnum_INVOICE =
    const ReceiptVerificationKindEnum._('INVOICE');
const ReceiptVerificationKindEnum
_$receiptVerificationKindEnum_unknownDefaultOpenApi =
    const ReceiptVerificationKindEnum._('unknownDefaultOpenApi');

ReceiptVerificationKindEnum _$receiptVerificationKindEnumValueOf(String name) {
  switch (name) {
    case 'RENT':
      return _$receiptVerificationKindEnum_RENT;
    case 'RENT_PARTIAL':
      return _$receiptVerificationKindEnum_RENT_PARTIAL;
    case 'DEPOSIT':
      return _$receiptVerificationKindEnum_DEPOSIT;
    case 'INVOICE':
      return _$receiptVerificationKindEnum_INVOICE;
    case 'unknownDefaultOpenApi':
      return _$receiptVerificationKindEnum_unknownDefaultOpenApi;
    default:
      return _$receiptVerificationKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ReceiptVerificationKindEnum>
_$receiptVerificationKindEnumValues =
    BuiltSet<ReceiptVerificationKindEnum>(const <ReceiptVerificationKindEnum>[
      _$receiptVerificationKindEnum_RENT,
      _$receiptVerificationKindEnum_RENT_PARTIAL,
      _$receiptVerificationKindEnum_DEPOSIT,
      _$receiptVerificationKindEnum_INVOICE,
      _$receiptVerificationKindEnum_unknownDefaultOpenApi,
    ]);

Serializer<ReceiptVerificationKindEnum>
_$receiptVerificationKindEnumSerializer =
    _$ReceiptVerificationKindEnumSerializer();

class _$ReceiptVerificationKindEnumSerializer
    implements PrimitiveSerializer<ReceiptVerificationKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'RENT': 'RENT',
    'RENT_PARTIAL': 'RENT_PARTIAL',
    'DEPOSIT': 'DEPOSIT',
    'INVOICE': 'INVOICE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'RENT': 'RENT',
    'RENT_PARTIAL': 'RENT_PARTIAL',
    'DEPOSIT': 'DEPOSIT',
    'INVOICE': 'INVOICE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ReceiptVerificationKindEnum];
  @override
  final String wireName = 'ReceiptVerificationKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    ReceiptVerificationKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ReceiptVerificationKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ReceiptVerificationKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ReceiptVerification extends ReceiptVerification {
  @override
  final String? receiptId;
  @override
  final ReceiptVerificationKindEnum? kind;
  @override
  final Date? periodStart;
  @override
  final Date? periodEnd;
  @override
  final int? amount;
  @override
  final DateTime? issuedAt;
  @override
  final String? city;
  @override
  final String? district;

  factory _$ReceiptVerification([
    void Function(ReceiptVerificationBuilder)? updates,
  ]) => (ReceiptVerificationBuilder()..update(updates))._build();

  _$ReceiptVerification._({
    this.receiptId,
    this.kind,
    this.periodStart,
    this.periodEnd,
    this.amount,
    this.issuedAt,
    this.city,
    this.district,
  }) : super._();
  @override
  ReceiptVerification rebuild(
    void Function(ReceiptVerificationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReceiptVerificationBuilder toBuilder() =>
      ReceiptVerificationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReceiptVerification &&
        receiptId == other.receiptId &&
        kind == other.kind &&
        periodStart == other.periodStart &&
        periodEnd == other.periodEnd &&
        amount == other.amount &&
        issuedAt == other.issuedAt &&
        city == other.city &&
        district == other.district;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, receiptId.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, periodStart.hashCode);
    _$hash = $jc(_$hash, periodEnd.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, issuedAt.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, district.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReceiptVerification')
          ..add('receiptId', receiptId)
          ..add('kind', kind)
          ..add('periodStart', periodStart)
          ..add('periodEnd', periodEnd)
          ..add('amount', amount)
          ..add('issuedAt', issuedAt)
          ..add('city', city)
          ..add('district', district))
        .toString();
  }
}

class ReceiptVerificationBuilder
    implements Builder<ReceiptVerification, ReceiptVerificationBuilder> {
  _$ReceiptVerification? _$v;

  String? _receiptId;
  String? get receiptId => _$this._receiptId;
  set receiptId(String? receiptId) => _$this._receiptId = receiptId;

  ReceiptVerificationKindEnum? _kind;
  ReceiptVerificationKindEnum? get kind => _$this._kind;
  set kind(ReceiptVerificationKindEnum? kind) => _$this._kind = kind;

  Date? _periodStart;
  Date? get periodStart => _$this._periodStart;
  set periodStart(Date? periodStart) => _$this._periodStart = periodStart;

  Date? _periodEnd;
  Date? get periodEnd => _$this._periodEnd;
  set periodEnd(Date? periodEnd) => _$this._periodEnd = periodEnd;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  DateTime? _issuedAt;
  DateTime? get issuedAt => _$this._issuedAt;
  set issuedAt(DateTime? issuedAt) => _$this._issuedAt = issuedAt;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _district;
  String? get district => _$this._district;
  set district(String? district) => _$this._district = district;

  ReceiptVerificationBuilder() {
    ReceiptVerification._defaults(this);
  }

  ReceiptVerificationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _receiptId = $v.receiptId;
      _kind = $v.kind;
      _periodStart = $v.periodStart;
      _periodEnd = $v.periodEnd;
      _amount = $v.amount;
      _issuedAt = $v.issuedAt;
      _city = $v.city;
      _district = $v.district;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReceiptVerification other) {
    _$v = other as _$ReceiptVerification;
  }

  @override
  void update(void Function(ReceiptVerificationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReceiptVerification build() => _build();

  _$ReceiptVerification _build() {
    final _$result =
        _$v ??
        _$ReceiptVerification._(
          receiptId: receiptId,
          kind: kind,
          periodStart: periodStart,
          periodEnd: periodEnd,
          amount: amount,
          issuedAt: issuedAt,
          city: city,
          district: district,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
