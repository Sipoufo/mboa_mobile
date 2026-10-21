// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'declare_invoice_payment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeclareInvoicePaymentRequestMethodEnum
_$declareInvoicePaymentRequestMethodEnum_MOBILE_MONEY =
    const DeclareInvoicePaymentRequestMethodEnum._('MOBILE_MONEY');
const DeclareInvoicePaymentRequestMethodEnum
_$declareInvoicePaymentRequestMethodEnum_ORANGE_MONEY =
    const DeclareInvoicePaymentRequestMethodEnum._('ORANGE_MONEY');
const DeclareInvoicePaymentRequestMethodEnum
_$declareInvoicePaymentRequestMethodEnum_CASH =
    const DeclareInvoicePaymentRequestMethodEnum._('CASH');
const DeclareInvoicePaymentRequestMethodEnum
_$declareInvoicePaymentRequestMethodEnum_TRANSFER =
    const DeclareInvoicePaymentRequestMethodEnum._('TRANSFER');
const DeclareInvoicePaymentRequestMethodEnum
_$declareInvoicePaymentRequestMethodEnum_OTHER =
    const DeclareInvoicePaymentRequestMethodEnum._('OTHER');
const DeclareInvoicePaymentRequestMethodEnum
_$declareInvoicePaymentRequestMethodEnum_unknownDefaultOpenApi =
    const DeclareInvoicePaymentRequestMethodEnum._('unknownDefaultOpenApi');

DeclareInvoicePaymentRequestMethodEnum
_$declareInvoicePaymentRequestMethodEnumValueOf(String name) {
  switch (name) {
    case 'MOBILE_MONEY':
      return _$declareInvoicePaymentRequestMethodEnum_MOBILE_MONEY;
    case 'ORANGE_MONEY':
      return _$declareInvoicePaymentRequestMethodEnum_ORANGE_MONEY;
    case 'CASH':
      return _$declareInvoicePaymentRequestMethodEnum_CASH;
    case 'TRANSFER':
      return _$declareInvoicePaymentRequestMethodEnum_TRANSFER;
    case 'OTHER':
      return _$declareInvoicePaymentRequestMethodEnum_OTHER;
    case 'unknownDefaultOpenApi':
      return _$declareInvoicePaymentRequestMethodEnum_unknownDefaultOpenApi;
    default:
      return _$declareInvoicePaymentRequestMethodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DeclareInvoicePaymentRequestMethodEnum>
_$declareInvoicePaymentRequestMethodEnumValues =
    BuiltSet<DeclareInvoicePaymentRequestMethodEnum>(
      const <DeclareInvoicePaymentRequestMethodEnum>[
        _$declareInvoicePaymentRequestMethodEnum_MOBILE_MONEY,
        _$declareInvoicePaymentRequestMethodEnum_ORANGE_MONEY,
        _$declareInvoicePaymentRequestMethodEnum_CASH,
        _$declareInvoicePaymentRequestMethodEnum_TRANSFER,
        _$declareInvoicePaymentRequestMethodEnum_OTHER,
        _$declareInvoicePaymentRequestMethodEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<DeclareInvoicePaymentRequestMethodEnum>
_$declareInvoicePaymentRequestMethodEnumSerializer =
    _$DeclareInvoicePaymentRequestMethodEnumSerializer();

class _$DeclareInvoicePaymentRequestMethodEnumSerializer
    implements PrimitiveSerializer<DeclareInvoicePaymentRequestMethodEnum> {
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
  final Iterable<Type> types = const <Type>[
    DeclareInvoicePaymentRequestMethodEnum,
  ];
  @override
  final String wireName = 'DeclareInvoicePaymentRequestMethodEnum';

  @override
  Object serialize(
    Serializers serializers,
    DeclareInvoicePaymentRequestMethodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DeclareInvoicePaymentRequestMethodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DeclareInvoicePaymentRequestMethodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DeclareInvoicePaymentRequest extends DeclareInvoicePaymentRequest {
  @override
  final int amount;
  @override
  final Date paidOn;
  @override
  final DeclareInvoicePaymentRequestMethodEnum method;
  @override
  final String? reference;
  @override
  final String? note;
  @override
  final BuiltList<String>? proofKeys;

  factory _$DeclareInvoicePaymentRequest([
    void Function(DeclareInvoicePaymentRequestBuilder)? updates,
  ]) => (DeclareInvoicePaymentRequestBuilder()..update(updates))._build();

  _$DeclareInvoicePaymentRequest._({
    required this.amount,
    required this.paidOn,
    required this.method,
    this.reference,
    this.note,
    this.proofKeys,
  }) : super._();
  @override
  DeclareInvoicePaymentRequest rebuild(
    void Function(DeclareInvoicePaymentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DeclareInvoicePaymentRequestBuilder toBuilder() =>
      DeclareInvoicePaymentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeclareInvoicePaymentRequest &&
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
    return (newBuiltValueToStringHelper(r'DeclareInvoicePaymentRequest')
          ..add('amount', amount)
          ..add('paidOn', paidOn)
          ..add('method', method)
          ..add('reference', reference)
          ..add('note', note)
          ..add('proofKeys', proofKeys))
        .toString();
  }
}

class DeclareInvoicePaymentRequestBuilder
    implements
        Builder<
          DeclareInvoicePaymentRequest,
          DeclareInvoicePaymentRequestBuilder
        > {
  _$DeclareInvoicePaymentRequest? _$v;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  Date? _paidOn;
  Date? get paidOn => _$this._paidOn;
  set paidOn(Date? paidOn) => _$this._paidOn = paidOn;

  DeclareInvoicePaymentRequestMethodEnum? _method;
  DeclareInvoicePaymentRequestMethodEnum? get method => _$this._method;
  set method(DeclareInvoicePaymentRequestMethodEnum? method) =>
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

  DeclareInvoicePaymentRequestBuilder() {
    DeclareInvoicePaymentRequest._defaults(this);
  }

  DeclareInvoicePaymentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
  void replace(DeclareInvoicePaymentRequest other) {
    _$v = other as _$DeclareInvoicePaymentRequest;
  }

  @override
  void update(void Function(DeclareInvoicePaymentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeclareInvoicePaymentRequest build() => _build();

  _$DeclareInvoicePaymentRequest _build() {
    _$DeclareInvoicePaymentRequest _$result;
    try {
      _$result =
          _$v ??
          _$DeclareInvoicePaymentRequest._(
            amount: BuiltValueNullFieldError.checkNotNull(
              amount,
              r'DeclareInvoicePaymentRequest',
              'amount',
            ),
            paidOn: BuiltValueNullFieldError.checkNotNull(
              paidOn,
              r'DeclareInvoicePaymentRequest',
              'paidOn',
            ),
            method: BuiltValueNullFieldError.checkNotNull(
              method,
              r'DeclareInvoicePaymentRequest',
              'method',
            ),
            reference: reference,
            note: note,
            proofKeys: _proofKeys?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'proofKeys';
        _proofKeys?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DeclareInvoicePaymentRequest',
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
