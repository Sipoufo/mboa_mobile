// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'declare_payment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeclarePaymentRequestKindEnum _$declarePaymentRequestKindEnum_RENT =
    const DeclarePaymentRequestKindEnum._('RENT');
const DeclarePaymentRequestKindEnum _$declarePaymentRequestKindEnum_DEPOSIT =
    const DeclarePaymentRequestKindEnum._('DEPOSIT');
const DeclarePaymentRequestKindEnum
_$declarePaymentRequestKindEnum_unknownDefaultOpenApi =
    const DeclarePaymentRequestKindEnum._('unknownDefaultOpenApi');

DeclarePaymentRequestKindEnum _$declarePaymentRequestKindEnumValueOf(
  String name,
) {
  switch (name) {
    case 'RENT':
      return _$declarePaymentRequestKindEnum_RENT;
    case 'DEPOSIT':
      return _$declarePaymentRequestKindEnum_DEPOSIT;
    case 'unknownDefaultOpenApi':
      return _$declarePaymentRequestKindEnum_unknownDefaultOpenApi;
    default:
      return _$declarePaymentRequestKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DeclarePaymentRequestKindEnum>
_$declarePaymentRequestKindEnumValues = BuiltSet<DeclarePaymentRequestKindEnum>(
  const <DeclarePaymentRequestKindEnum>[
    _$declarePaymentRequestKindEnum_RENT,
    _$declarePaymentRequestKindEnum_DEPOSIT,
    _$declarePaymentRequestKindEnum_unknownDefaultOpenApi,
  ],
);

const DeclarePaymentRequestMethodEnum
_$declarePaymentRequestMethodEnum_MOBILE_MONEY =
    const DeclarePaymentRequestMethodEnum._('MOBILE_MONEY');
const DeclarePaymentRequestMethodEnum
_$declarePaymentRequestMethodEnum_ORANGE_MONEY =
    const DeclarePaymentRequestMethodEnum._('ORANGE_MONEY');
const DeclarePaymentRequestMethodEnum _$declarePaymentRequestMethodEnum_CASH =
    const DeclarePaymentRequestMethodEnum._('CASH');
const DeclarePaymentRequestMethodEnum
_$declarePaymentRequestMethodEnum_TRANSFER =
    const DeclarePaymentRequestMethodEnum._('TRANSFER');
const DeclarePaymentRequestMethodEnum _$declarePaymentRequestMethodEnum_OTHER =
    const DeclarePaymentRequestMethodEnum._('OTHER');
const DeclarePaymentRequestMethodEnum
_$declarePaymentRequestMethodEnum_unknownDefaultOpenApi =
    const DeclarePaymentRequestMethodEnum._('unknownDefaultOpenApi');

DeclarePaymentRequestMethodEnum _$declarePaymentRequestMethodEnumValueOf(
  String name,
) {
  switch (name) {
    case 'MOBILE_MONEY':
      return _$declarePaymentRequestMethodEnum_MOBILE_MONEY;
    case 'ORANGE_MONEY':
      return _$declarePaymentRequestMethodEnum_ORANGE_MONEY;
    case 'CASH':
      return _$declarePaymentRequestMethodEnum_CASH;
    case 'TRANSFER':
      return _$declarePaymentRequestMethodEnum_TRANSFER;
    case 'OTHER':
      return _$declarePaymentRequestMethodEnum_OTHER;
    case 'unknownDefaultOpenApi':
      return _$declarePaymentRequestMethodEnum_unknownDefaultOpenApi;
    default:
      return _$declarePaymentRequestMethodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DeclarePaymentRequestMethodEnum>
_$declarePaymentRequestMethodEnumValues =
    BuiltSet<DeclarePaymentRequestMethodEnum>(
      const <DeclarePaymentRequestMethodEnum>[
        _$declarePaymentRequestMethodEnum_MOBILE_MONEY,
        _$declarePaymentRequestMethodEnum_ORANGE_MONEY,
        _$declarePaymentRequestMethodEnum_CASH,
        _$declarePaymentRequestMethodEnum_TRANSFER,
        _$declarePaymentRequestMethodEnum_OTHER,
        _$declarePaymentRequestMethodEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<DeclarePaymentRequestKindEnum>
_$declarePaymentRequestKindEnumSerializer =
    _$DeclarePaymentRequestKindEnumSerializer();
Serializer<DeclarePaymentRequestMethodEnum>
_$declarePaymentRequestMethodEnumSerializer =
    _$DeclarePaymentRequestMethodEnumSerializer();

class _$DeclarePaymentRequestKindEnumSerializer
    implements PrimitiveSerializer<DeclarePaymentRequestKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'RENT': 'RENT',
    'DEPOSIT': 'DEPOSIT',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'RENT': 'RENT',
    'DEPOSIT': 'DEPOSIT',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DeclarePaymentRequestKindEnum];
  @override
  final String wireName = 'DeclarePaymentRequestKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    DeclarePaymentRequestKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DeclarePaymentRequestKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DeclarePaymentRequestKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DeclarePaymentRequestMethodEnumSerializer
    implements PrimitiveSerializer<DeclarePaymentRequestMethodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MOBILE_MONEY': 'MOBILE_MONEY',
    'ORANGE_MONEY': 'ORANGE_MONEY',
    'CASH': 'CASH',
    'TRANSFER': 'TRANSFER',
    'OTHER': 'OTHER',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MOBILE_MONEY': 'MOBILE_MONEY',
    'ORANGE_MONEY': 'ORANGE_MONEY',
    'CASH': 'CASH',
    'TRANSFER': 'TRANSFER',
    'OTHER': 'OTHER',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DeclarePaymentRequestMethodEnum];
  @override
  final String wireName = 'DeclarePaymentRequestMethodEnum';

  @override
  Object serialize(
    Serializers serializers,
    DeclarePaymentRequestMethodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DeclarePaymentRequestMethodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DeclarePaymentRequestMethodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DeclarePaymentRequest extends DeclarePaymentRequest {
  @override
  final DeclarePaymentRequestKindEnum kind;
  @override
  final BuiltList<int>? dueIndexes;
  @override
  final int amount;
  @override
  final Date paidOn;
  @override
  final DeclarePaymentRequestMethodEnum method;
  @override
  final String? reference;
  @override
  final String? note;
  @override
  final BuiltList<String>? proofKeys;

  factory _$DeclarePaymentRequest([
    void Function(DeclarePaymentRequestBuilder)? updates,
  ]) => (DeclarePaymentRequestBuilder()..update(updates))._build();

  _$DeclarePaymentRequest._({
    required this.kind,
    this.dueIndexes,
    required this.amount,
    required this.paidOn,
    required this.method,
    this.reference,
    this.note,
    this.proofKeys,
  }) : super._();
  @override
  DeclarePaymentRequest rebuild(
    void Function(DeclarePaymentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DeclarePaymentRequestBuilder toBuilder() =>
      DeclarePaymentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeclarePaymentRequest &&
        kind == other.kind &&
        dueIndexes == other.dueIndexes &&
        amount == other.amount &&
        paidOn == other.paidOn &&
        method == other.method &&
        reference == other.reference &&
        note == other.note &&
        proofKeys == other.proofKeys;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, dueIndexes.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, paidOn.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, proofKeys.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeclarePaymentRequest')
          ..add('kind', kind)
          ..add('dueIndexes', dueIndexes)
          ..add('amount', amount)
          ..add('paidOn', paidOn)
          ..add('method', method)
          ..add('reference', reference)
          ..add('note', note)
          ..add('proofKeys', proofKeys))
        .toString();
  }
}

class DeclarePaymentRequestBuilder
    implements Builder<DeclarePaymentRequest, DeclarePaymentRequestBuilder> {
  _$DeclarePaymentRequest? _$v;

  DeclarePaymentRequestKindEnum? _kind;
  DeclarePaymentRequestKindEnum? get kind => _$this._kind;
  set kind(DeclarePaymentRequestKindEnum? kind) => _$this._kind = kind;

  ListBuilder<int>? _dueIndexes;
  ListBuilder<int> get dueIndexes => _$this._dueIndexes ??= ListBuilder<int>();
  set dueIndexes(ListBuilder<int>? dueIndexes) =>
      _$this._dueIndexes = dueIndexes;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  Date? _paidOn;
  Date? get paidOn => _$this._paidOn;
  set paidOn(Date? paidOn) => _$this._paidOn = paidOn;

  DeclarePaymentRequestMethodEnum? _method;
  DeclarePaymentRequestMethodEnum? get method => _$this._method;
  set method(DeclarePaymentRequestMethodEnum? method) =>
      _$this._method = method;

  String? _reference;
  String? get reference => _$this._reference;
  set reference(String? reference) => _$this._reference = reference;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  ListBuilder<String>? _proofKeys;
  ListBuilder<String> get proofKeys =>
      _$this._proofKeys ??= ListBuilder<String>();
  set proofKeys(ListBuilder<String>? proofKeys) =>
      _$this._proofKeys = proofKeys;

  DeclarePaymentRequestBuilder() {
    DeclarePaymentRequest._defaults(this);
  }

  DeclarePaymentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _kind = $v.kind;
      _dueIndexes = $v.dueIndexes?.toBuilder();
      _amount = $v.amount;
      _paidOn = $v.paidOn;
      _method = $v.method;
      _reference = $v.reference;
      _note = $v.note;
      _proofKeys = $v.proofKeys?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeclarePaymentRequest other) {
    _$v = other as _$DeclarePaymentRequest;
  }

  @override
  void update(void Function(DeclarePaymentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeclarePaymentRequest build() => _build();

  _$DeclarePaymentRequest _build() {
    _$DeclarePaymentRequest _$result;
    try {
      _$result =
          _$v ??
          _$DeclarePaymentRequest._(
            kind: BuiltValueNullFieldError.checkNotNull(
              kind,
              r'DeclarePaymentRequest',
              'kind',
            ),
            dueIndexes: _dueIndexes?.build(),
            amount: BuiltValueNullFieldError.checkNotNull(
              amount,
              r'DeclarePaymentRequest',
              'amount',
            ),
            paidOn: BuiltValueNullFieldError.checkNotNull(
              paidOn,
              r'DeclarePaymentRequest',
              'paidOn',
            ),
            method: BuiltValueNullFieldError.checkNotNull(
              method,
              r'DeclarePaymentRequest',
              'method',
            ),
            reference: reference,
            note: note,
            proofKeys: _proofKeys?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'dueIndexes';
        _dueIndexes?.build();

        _$failedField = 'proofKeys';
        _proofKeys?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DeclarePaymentRequest',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
