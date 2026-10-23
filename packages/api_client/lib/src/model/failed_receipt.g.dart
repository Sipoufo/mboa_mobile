// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failed_receipt.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FailedReceiptKindEnum _$failedReceiptKindEnum_RENT =
    const FailedReceiptKindEnum._('RENT');
const FailedReceiptKindEnum _$failedReceiptKindEnum_RENT_PARTIAL =
    const FailedReceiptKindEnum._('RENT_PARTIAL');
const FailedReceiptKindEnum _$failedReceiptKindEnum_DEPOSIT =
    const FailedReceiptKindEnum._('DEPOSIT');
const FailedReceiptKindEnum _$failedReceiptKindEnum_INVOICE =
    const FailedReceiptKindEnum._('INVOICE');
const FailedReceiptKindEnum _$failedReceiptKindEnum_unknownDefaultOpenApi =
    const FailedReceiptKindEnum._('unknownDefaultOpenApi');

FailedReceiptKindEnum _$failedReceiptKindEnumValueOf(String name) {
  switch (name) {
    case 'RENT':
      return _$failedReceiptKindEnum_RENT;
    case 'RENT_PARTIAL':
      return _$failedReceiptKindEnum_RENT_PARTIAL;
    case 'DEPOSIT':
      return _$failedReceiptKindEnum_DEPOSIT;
    case 'INVOICE':
      return _$failedReceiptKindEnum_INVOICE;
    case 'unknownDefaultOpenApi':
      return _$failedReceiptKindEnum_unknownDefaultOpenApi;
    default:
      return _$failedReceiptKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FailedReceiptKindEnum> _$failedReceiptKindEnumValues =
    BuiltSet<FailedReceiptKindEnum>(const <FailedReceiptKindEnum>[
      _$failedReceiptKindEnum_RENT,
      _$failedReceiptKindEnum_RENT_PARTIAL,
      _$failedReceiptKindEnum_DEPOSIT,
      _$failedReceiptKindEnum_INVOICE,
      _$failedReceiptKindEnum_unknownDefaultOpenApi,
    ]);

Serializer<FailedReceiptKindEnum> _$failedReceiptKindEnumSerializer =
    _$FailedReceiptKindEnumSerializer();

class _$FailedReceiptKindEnumSerializer
    implements PrimitiveSerializer<FailedReceiptKindEnum> {
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
  final Iterable<Type> types = const <Type>[FailedReceiptKindEnum];
  @override
  final String wireName = 'FailedReceiptKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    FailedReceiptKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FailedReceiptKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FailedReceiptKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FailedReceipt extends FailedReceipt {
  @override
  final String? id;
  @override
  final String? declarationId;
  @override
  final String? contractId;
  @override
  final FailedReceiptKindEnum? kind;
  @override
  final int? amount;
  @override
  final DateTime? issuedAt;
  @override
  final int? pdfAttempts;
  @override
  final DateTime? pdfFailedAt;

  factory _$FailedReceipt([void Function(FailedReceiptBuilder)? updates]) =>
      (FailedReceiptBuilder()..update(updates))._build();

  _$FailedReceipt._({
    this.id,
    this.declarationId,
    this.contractId,
    this.kind,
    this.amount,
    this.issuedAt,
    this.pdfAttempts,
    this.pdfFailedAt,
  }) : super._();
  @override
  FailedReceipt rebuild(void Function(FailedReceiptBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FailedReceiptBuilder toBuilder() => FailedReceiptBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FailedReceipt &&
        id == other.id &&
        declarationId == other.declarationId &&
        contractId == other.contractId &&
        kind == other.kind &&
        amount == other.amount &&
        issuedAt == other.issuedAt &&
        pdfAttempts == other.pdfAttempts &&
        pdfFailedAt == other.pdfFailedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, declarationId.hashCode);
    _$hash = $jc(_$hash, contractId.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, issuedAt.hashCode);
    _$hash = $jc(_$hash, pdfAttempts.hashCode);
    _$hash = $jc(_$hash, pdfFailedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FailedReceipt')
          ..add('id', id)
          ..add('declarationId', declarationId)
          ..add('contractId', contractId)
          ..add('kind', kind)
          ..add('amount', amount)
          ..add('issuedAt', issuedAt)
          ..add('pdfAttempts', pdfAttempts)
          ..add('pdfFailedAt', pdfFailedAt))
        .toString();
  }
}

class FailedReceiptBuilder
    implements Builder<FailedReceipt, FailedReceiptBuilder> {
  _$FailedReceipt? _$v;

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

  FailedReceiptKindEnum? _kind;
  FailedReceiptKindEnum? get kind => _$this._kind;
  set kind(FailedReceiptKindEnum? kind) => _$this._kind = kind;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  DateTime? _issuedAt;
  DateTime? get issuedAt => _$this._issuedAt;
  set issuedAt(DateTime? issuedAt) => _$this._issuedAt = issuedAt;

  int? _pdfAttempts;
  int? get pdfAttempts => _$this._pdfAttempts;
  set pdfAttempts(int? pdfAttempts) => _$this._pdfAttempts = pdfAttempts;

  DateTime? _pdfFailedAt;
  DateTime? get pdfFailedAt => _$this._pdfFailedAt;
  set pdfFailedAt(DateTime? pdfFailedAt) => _$this._pdfFailedAt = pdfFailedAt;

  FailedReceiptBuilder() {
    FailedReceipt._defaults(this);
  }

  FailedReceiptBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _declarationId = $v.declarationId;
      _contractId = $v.contractId;
      _kind = $v.kind;
      _amount = $v.amount;
      _issuedAt = $v.issuedAt;
      _pdfAttempts = $v.pdfAttempts;
      _pdfFailedAt = $v.pdfFailedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FailedReceipt other) {
    _$v = other as _$FailedReceipt;
  }

  @override
  void update(void Function(FailedReceiptBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FailedReceipt build() => _build();

  _$FailedReceipt _build() {
    final _$result =
        _$v ??
        _$FailedReceipt._(
          id: id,
          declarationId: declarationId,
          contractId: contractId,
          kind: kind,
          amount: amount,
          issuedAt: issuedAt,
          pdfAttempts: pdfAttempts,
          pdfFailedAt: pdfFailedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
