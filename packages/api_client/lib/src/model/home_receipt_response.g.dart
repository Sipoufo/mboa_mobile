// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_receipt_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HomeReceiptResponseKindEnum _$homeReceiptResponseKindEnum_RENT =
    const HomeReceiptResponseKindEnum._('RENT');
const HomeReceiptResponseKindEnum _$homeReceiptResponseKindEnum_RENT_PARTIAL =
    const HomeReceiptResponseKindEnum._('RENT_PARTIAL');
const HomeReceiptResponseKindEnum _$homeReceiptResponseKindEnum_DEPOSIT =
    const HomeReceiptResponseKindEnum._('DEPOSIT');
const HomeReceiptResponseKindEnum _$homeReceiptResponseKindEnum_INVOICE =
    const HomeReceiptResponseKindEnum._('INVOICE');
const HomeReceiptResponseKindEnum
_$homeReceiptResponseKindEnum_unknownDefaultOpenApi =
    const HomeReceiptResponseKindEnum._('unknownDefaultOpenApi');

HomeReceiptResponseKindEnum _$homeReceiptResponseKindEnumValueOf(String name) {
  switch (name) {
    case 'RENT':
      return _$homeReceiptResponseKindEnum_RENT;
    case 'RENT_PARTIAL':
      return _$homeReceiptResponseKindEnum_RENT_PARTIAL;
    case 'DEPOSIT':
      return _$homeReceiptResponseKindEnum_DEPOSIT;
    case 'INVOICE':
      return _$homeReceiptResponseKindEnum_INVOICE;
    case 'unknownDefaultOpenApi':
      return _$homeReceiptResponseKindEnum_unknownDefaultOpenApi;
    default:
      return _$homeReceiptResponseKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<HomeReceiptResponseKindEnum>
_$homeReceiptResponseKindEnumValues =
    BuiltSet<HomeReceiptResponseKindEnum>(const <HomeReceiptResponseKindEnum>[
      _$homeReceiptResponseKindEnum_RENT,
      _$homeReceiptResponseKindEnum_RENT_PARTIAL,
      _$homeReceiptResponseKindEnum_DEPOSIT,
      _$homeReceiptResponseKindEnum_INVOICE,
      _$homeReceiptResponseKindEnum_unknownDefaultOpenApi,
    ]);

Serializer<HomeReceiptResponseKindEnum>
_$homeReceiptResponseKindEnumSerializer =
    _$HomeReceiptResponseKindEnumSerializer();

class _$HomeReceiptResponseKindEnumSerializer
    implements PrimitiveSerializer<HomeReceiptResponseKindEnum> {
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
  final Iterable<Type> types = const <Type>[HomeReceiptResponseKindEnum];
  @override
  final String wireName = 'HomeReceiptResponseKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    HomeReceiptResponseKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HomeReceiptResponseKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HomeReceiptResponseKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HomeReceiptResponse extends HomeReceiptResponse {
  @override
  final String? id;
  @override
  final String? declarationId;
  @override
  final String? contractId;
  @override
  final HomeReceiptResponseKindEnum? kind;
  @override
  final Date? periodStart;
  @override
  final Date? periodEnd;
  @override
  final int? amount;
  @override
  final DateTime? issuedAt;
  @override
  final bool? ready;

  factory _$HomeReceiptResponse([
    void Function(HomeReceiptResponseBuilder)? updates,
  ]) => (HomeReceiptResponseBuilder()..update(updates))._build();

  _$HomeReceiptResponse._({
    this.id,
    this.declarationId,
    this.contractId,
    this.kind,
    this.periodStart,
    this.periodEnd,
    this.amount,
    this.issuedAt,
    this.ready,
  }) : super._();
  @override
  HomeReceiptResponse rebuild(
    void Function(HomeReceiptResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HomeReceiptResponseBuilder toBuilder() =>
      HomeReceiptResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeReceiptResponse &&
        id == other.id &&
        declarationId == other.declarationId &&
        contractId == other.contractId &&
        kind == other.kind &&
        periodStart == other.periodStart &&
        periodEnd == other.periodEnd &&
        amount == other.amount &&
        issuedAt == other.issuedAt &&
        ready == other.ready;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, declarationId.hashCode);
    _$hash = $jc(_$hash, contractId.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, periodStart.hashCode);
    _$hash = $jc(_$hash, periodEnd.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, issuedAt.hashCode);
    _$hash = $jc(_$hash, ready.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HomeReceiptResponse')
          ..add('id', id)
          ..add('declarationId', declarationId)
          ..add('contractId', contractId)
          ..add('kind', kind)
          ..add('periodStart', periodStart)
          ..add('periodEnd', periodEnd)
          ..add('amount', amount)
          ..add('issuedAt', issuedAt)
          ..add('ready', ready))
        .toString();
  }
}

class HomeReceiptResponseBuilder
    implements Builder<HomeReceiptResponse, HomeReceiptResponseBuilder> {
  _$HomeReceiptResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _declarationId;
  String? get declarationId => _$this._declarationId;
  set declarationId(String? declarationId) =>
      _$this._declarationId = declarationId;

  String? _contractId;
  String? get contractId => _$this._contractId;
  set contractId(String? contractId) => _$this._contractId = contractId;

  HomeReceiptResponseKindEnum? _kind;
  HomeReceiptResponseKindEnum? get kind => _$this._kind;
  set kind(HomeReceiptResponseKindEnum? kind) => _$this._kind = kind;

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

  bool? _ready;
  bool? get ready => _$this._ready;
  set ready(bool? ready) => _$this._ready = ready;

  HomeReceiptResponseBuilder() {
    HomeReceiptResponse._defaults(this);
  }

  HomeReceiptResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _declarationId = $v.declarationId;
      _contractId = $v.contractId;
      _kind = $v.kind;
      _periodStart = $v.periodStart;
      _periodEnd = $v.periodEnd;
      _amount = $v.amount;
      _issuedAt = $v.issuedAt;
      _ready = $v.ready;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeReceiptResponse other) {
    _$v = other as _$HomeReceiptResponse;
  }

  @override
  void update(void Function(HomeReceiptResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HomeReceiptResponse build() => _build();

  _$HomeReceiptResponse _build() {
    final _$result =
        _$v ??
        _$HomeReceiptResponse._(
          id: id,
          declarationId: declarationId,
          contractId: contractId,
          kind: kind,
          periodStart: periodStart,
          periodEnd: periodEnd,
          amount: amount,
          issuedAt: issuedAt,
          ready: ready,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
