// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_invoice_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateInvoiceRequestKindEnum _$createInvoiceRequestKindEnum_WATER =
    const CreateInvoiceRequestKindEnum._('WATER');
const CreateInvoiceRequestKindEnum _$createInvoiceRequestKindEnum_ELECTRICITY =
    const CreateInvoiceRequestKindEnum._('ELECTRICITY');
const CreateInvoiceRequestKindEnum _$createInvoiceRequestKindEnum_OTHER =
    const CreateInvoiceRequestKindEnum._('OTHER');
const CreateInvoiceRequestKindEnum
_$createInvoiceRequestKindEnum_unknownDefaultOpenApi =
    const CreateInvoiceRequestKindEnum._('unknownDefaultOpenApi');

CreateInvoiceRequestKindEnum _$createInvoiceRequestKindEnumValueOf(
  String name,
) {
  switch (name) {
    case 'WATER':
      return _$createInvoiceRequestKindEnum_WATER;
    case 'ELECTRICITY':
      return _$createInvoiceRequestKindEnum_ELECTRICITY;
    case 'OTHER':
      return _$createInvoiceRequestKindEnum_OTHER;
    case 'unknownDefaultOpenApi':
      return _$createInvoiceRequestKindEnum_unknownDefaultOpenApi;
    default:
      return _$createInvoiceRequestKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CreateInvoiceRequestKindEnum>
_$createInvoiceRequestKindEnumValues =
    BuiltSet<CreateInvoiceRequestKindEnum>(const <CreateInvoiceRequestKindEnum>[
      _$createInvoiceRequestKindEnum_WATER,
      _$createInvoiceRequestKindEnum_ELECTRICITY,
      _$createInvoiceRequestKindEnum_OTHER,
      _$createInvoiceRequestKindEnum_unknownDefaultOpenApi,
    ]);

const CreateInvoiceRequestSettlementEnum
_$createInvoiceRequestSettlementEnum_IN_APP =
    const CreateInvoiceRequestSettlementEnum._('IN_APP');
const CreateInvoiceRequestSettlementEnum
_$createInvoiceRequestSettlementEnum_MANUAL =
    const CreateInvoiceRequestSettlementEnum._('MANUAL');
const CreateInvoiceRequestSettlementEnum
_$createInvoiceRequestSettlementEnum_DECLARED =
    const CreateInvoiceRequestSettlementEnum._('DECLARED');
const CreateInvoiceRequestSettlementEnum
_$createInvoiceRequestSettlementEnum_unknownDefaultOpenApi =
    const CreateInvoiceRequestSettlementEnum._('unknownDefaultOpenApi');

CreateInvoiceRequestSettlementEnum _$createInvoiceRequestSettlementEnumValueOf(
  String name,
) {
  switch (name) {
    case 'IN_APP':
      return _$createInvoiceRequestSettlementEnum_IN_APP;
    case 'MANUAL':
      return _$createInvoiceRequestSettlementEnum_MANUAL;
    case 'DECLARED':
      return _$createInvoiceRequestSettlementEnum_DECLARED;
    case 'unknownDefaultOpenApi':
      return _$createInvoiceRequestSettlementEnum_unknownDefaultOpenApi;
    default:
      return _$createInvoiceRequestSettlementEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CreateInvoiceRequestSettlementEnum>
_$createInvoiceRequestSettlementEnumValues =
    BuiltSet<CreateInvoiceRequestSettlementEnum>(
      const <CreateInvoiceRequestSettlementEnum>[
        _$createInvoiceRequestSettlementEnum_IN_APP,
        _$createInvoiceRequestSettlementEnum_MANUAL,
        _$createInvoiceRequestSettlementEnum_DECLARED,
        _$createInvoiceRequestSettlementEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<CreateInvoiceRequestKindEnum>
_$createInvoiceRequestKindEnumSerializer =
    _$CreateInvoiceRequestKindEnumSerializer();
Serializer<CreateInvoiceRequestSettlementEnum>
_$createInvoiceRequestSettlementEnumSerializer =
    _$CreateInvoiceRequestSettlementEnumSerializer();

class _$CreateInvoiceRequestKindEnumSerializer
    implements PrimitiveSerializer<CreateInvoiceRequestKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'WATER': 'WATER',
    'ELECTRICITY': 'ELECTRICITY',
    'OTHER': 'OTHER',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'WATER': 'WATER',
    'ELECTRICITY': 'ELECTRICITY',
    'OTHER': 'OTHER',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateInvoiceRequestKindEnum];
  @override
  final String wireName = 'CreateInvoiceRequestKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateInvoiceRequestKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateInvoiceRequestKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateInvoiceRequestKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateInvoiceRequestSettlementEnumSerializer
    implements PrimitiveSerializer<CreateInvoiceRequestSettlementEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'IN_APP': 'IN_APP',
    'MANUAL': 'MANUAL',
    'DECLARED': 'DECLARED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'IN_APP': 'IN_APP',
    'MANUAL': 'MANUAL',
    'DECLARED': 'DECLARED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateInvoiceRequestSettlementEnum];
  @override
  final String wireName = 'CreateInvoiceRequestSettlementEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateInvoiceRequestSettlementEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateInvoiceRequestSettlementEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateInvoiceRequestSettlementEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateInvoiceRequest extends CreateInvoiceRequest {
  @override
  final String contractId;
  @override
  final CreateInvoiceRequestKindEnum kind;
  @override
  final String? label;
  @override
  final int amount;
  @override
  final Date dueDate;
  @override
  final CreateInvoiceRequestSettlementEnum? settlement;

  factory _$CreateInvoiceRequest([
    void Function(CreateInvoiceRequestBuilder)? updates,
  ]) => (CreateInvoiceRequestBuilder()..update(updates))._build();

  _$CreateInvoiceRequest._({
    required this.contractId,
    required this.kind,
    this.label,
    required this.amount,
    required this.dueDate,
    this.settlement,
  }) : super._();
  @override
  CreateInvoiceRequest rebuild(
    void Function(CreateInvoiceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateInvoiceRequestBuilder toBuilder() =>
      CreateInvoiceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateInvoiceRequest &&
        contractId == other.contractId &&
        kind == other.kind &&
        label == other.label &&
        amount == other.amount &&
        dueDate == other.dueDate &&
        settlement == other.settlement;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, contractId.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, dueDate.hashCode);
    _$hash = $jc(_$hash, settlement.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateInvoiceRequest')
          ..add('contractId', contractId)
          ..add('kind', kind)
          ..add('label', label)
          ..add('amount', amount)
          ..add('dueDate', dueDate)
          ..add('settlement', settlement))
        .toString();
  }
}

class CreateInvoiceRequestBuilder
    implements Builder<CreateInvoiceRequest, CreateInvoiceRequestBuilder> {
  _$CreateInvoiceRequest? _$v;

  String? _contractId;
  String? get contractId => _$this._contractId;
  set contractId(String? contractId) => _$this._contractId = contractId;

  CreateInvoiceRequestKindEnum? _kind;
  CreateInvoiceRequestKindEnum? get kind => _$this._kind;
  set kind(CreateInvoiceRequestKindEnum? kind) => _$this._kind = kind;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  Date? _dueDate;
  Date? get dueDate => _$this._dueDate;
  set dueDate(Date? dueDate) => _$this._dueDate = dueDate;

  CreateInvoiceRequestSettlementEnum? _settlement;
  CreateInvoiceRequestSettlementEnum? get settlement => _$this._settlement;
  set settlement(CreateInvoiceRequestSettlementEnum? settlement) =>
      _$this._settlement = settlement;

  CreateInvoiceRequestBuilder() {
    CreateInvoiceRequest._defaults(this);
  }

  CreateInvoiceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _contractId = $v.contractId;
      _kind = $v.kind;
      _label = $v.label;
      _amount = $v.amount;
      _dueDate = $v.dueDate;
      _settlement = $v.settlement;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateInvoiceRequest other) {
    _$v = other as _$CreateInvoiceRequest;
  }

  @override
  void update(void Function(CreateInvoiceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateInvoiceRequest build() => _build();

  _$CreateInvoiceRequest _build() {
    final _$result =
        _$v ??
        _$CreateInvoiceRequest._(
          contractId: BuiltValueNullFieldError.checkNotNull(
            contractId,
            r'CreateInvoiceRequest',
            'contractId',
          ),
          kind: BuiltValueNullFieldError.checkNotNull(
            kind,
            r'CreateInvoiceRequest',
            'kind',
          ),
          label: label,
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'CreateInvoiceRequest',
            'amount',
          ),
          dueDate: BuiltValueNullFieldError.checkNotNull(
            dueDate,
            r'CreateInvoiceRequest',
            'dueDate',
          ),
          settlement: settlement,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
