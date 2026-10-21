// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const InvoiceResponseKindEnum _$invoiceResponseKindEnum_WATER =
    const InvoiceResponseKindEnum._('WATER');
const InvoiceResponseKindEnum _$invoiceResponseKindEnum_ELECTRICITY =
    const InvoiceResponseKindEnum._('ELECTRICITY');
const InvoiceResponseKindEnum _$invoiceResponseKindEnum_OTHER =
    const InvoiceResponseKindEnum._('OTHER');
const InvoiceResponseKindEnum _$invoiceResponseKindEnum_unknownDefaultOpenApi =
    const InvoiceResponseKindEnum._('unknownDefaultOpenApi');

InvoiceResponseKindEnum _$invoiceResponseKindEnumValueOf(String name) {
  switch (name) {
    case 'WATER':
      return _$invoiceResponseKindEnum_WATER;
    case 'ELECTRICITY':
      return _$invoiceResponseKindEnum_ELECTRICITY;
    case 'OTHER':
      return _$invoiceResponseKindEnum_OTHER;
    case 'unknownDefaultOpenApi':
      return _$invoiceResponseKindEnum_unknownDefaultOpenApi;
    default:
      return _$invoiceResponseKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<InvoiceResponseKindEnum> _$invoiceResponseKindEnumValues =
    BuiltSet<InvoiceResponseKindEnum>(const <InvoiceResponseKindEnum>[
      _$invoiceResponseKindEnum_WATER,
      _$invoiceResponseKindEnum_ELECTRICITY,
      _$invoiceResponseKindEnum_OTHER,
      _$invoiceResponseKindEnum_unknownDefaultOpenApi,
    ]);

const InvoiceResponseSettlementEnum _$invoiceResponseSettlementEnum_IN_APP =
    const InvoiceResponseSettlementEnum._('IN_APP');
const InvoiceResponseSettlementEnum _$invoiceResponseSettlementEnum_MANUAL =
    const InvoiceResponseSettlementEnum._('MANUAL');
const InvoiceResponseSettlementEnum _$invoiceResponseSettlementEnum_DECLARED =
    const InvoiceResponseSettlementEnum._('DECLARED');
const InvoiceResponseSettlementEnum
_$invoiceResponseSettlementEnum_unknownDefaultOpenApi =
    const InvoiceResponseSettlementEnum._('unknownDefaultOpenApi');

InvoiceResponseSettlementEnum _$invoiceResponseSettlementEnumValueOf(
  String name,
) {
  switch (name) {
    case 'IN_APP':
      return _$invoiceResponseSettlementEnum_IN_APP;
    case 'MANUAL':
      return _$invoiceResponseSettlementEnum_MANUAL;
    case 'DECLARED':
      return _$invoiceResponseSettlementEnum_DECLARED;
    case 'unknownDefaultOpenApi':
      return _$invoiceResponseSettlementEnum_unknownDefaultOpenApi;
    default:
      return _$invoiceResponseSettlementEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<InvoiceResponseSettlementEnum>
_$invoiceResponseSettlementEnumValues = BuiltSet<InvoiceResponseSettlementEnum>(
  const <InvoiceResponseSettlementEnum>[
    _$invoiceResponseSettlementEnum_IN_APP,
    _$invoiceResponseSettlementEnum_MANUAL,
    _$invoiceResponseSettlementEnum_DECLARED,
    _$invoiceResponseSettlementEnum_unknownDefaultOpenApi,
  ],
);

const InvoiceResponseStatusEnum _$invoiceResponseStatusEnum_TO_PAY =
    const InvoiceResponseStatusEnum._('TO_PAY');
const InvoiceResponseStatusEnum _$invoiceResponseStatusEnum_OVERDUE =
    const InvoiceResponseStatusEnum._('OVERDUE');
const InvoiceResponseStatusEnum _$invoiceResponseStatusEnum_PAID =
    const InvoiceResponseStatusEnum._('PAID');
const InvoiceResponseStatusEnum _$invoiceResponseStatusEnum_CANCELLED =
    const InvoiceResponseStatusEnum._('CANCELLED');
const InvoiceResponseStatusEnum
_$invoiceResponseStatusEnum_unknownDefaultOpenApi =
    const InvoiceResponseStatusEnum._('unknownDefaultOpenApi');

InvoiceResponseStatusEnum _$invoiceResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'TO_PAY':
      return _$invoiceResponseStatusEnum_TO_PAY;
    case 'OVERDUE':
      return _$invoiceResponseStatusEnum_OVERDUE;
    case 'PAID':
      return _$invoiceResponseStatusEnum_PAID;
    case 'CANCELLED':
      return _$invoiceResponseStatusEnum_CANCELLED;
    case 'unknownDefaultOpenApi':
      return _$invoiceResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$invoiceResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<InvoiceResponseStatusEnum> _$invoiceResponseStatusEnumValues =
    BuiltSet<InvoiceResponseStatusEnum>(const <InvoiceResponseStatusEnum>[
      _$invoiceResponseStatusEnum_TO_PAY,
      _$invoiceResponseStatusEnum_OVERDUE,
      _$invoiceResponseStatusEnum_PAID,
      _$invoiceResponseStatusEnum_CANCELLED,
      _$invoiceResponseStatusEnum_unknownDefaultOpenApi,
    ]);

const InvoiceResponsePaidViaEnum _$invoiceResponsePaidViaEnum_IN_APP =
    const InvoiceResponsePaidViaEnum._('IN_APP');
const InvoiceResponsePaidViaEnum _$invoiceResponsePaidViaEnum_MANUAL =
    const InvoiceResponsePaidViaEnum._('MANUAL');
const InvoiceResponsePaidViaEnum _$invoiceResponsePaidViaEnum_DECLARED =
    const InvoiceResponsePaidViaEnum._('DECLARED');
const InvoiceResponsePaidViaEnum
_$invoiceResponsePaidViaEnum_unknownDefaultOpenApi =
    const InvoiceResponsePaidViaEnum._('unknownDefaultOpenApi');

InvoiceResponsePaidViaEnum _$invoiceResponsePaidViaEnumValueOf(String name) {
  switch (name) {
    case 'IN_APP':
      return _$invoiceResponsePaidViaEnum_IN_APP;
    case 'MANUAL':
      return _$invoiceResponsePaidViaEnum_MANUAL;
    case 'DECLARED':
      return _$invoiceResponsePaidViaEnum_DECLARED;
    case 'unknownDefaultOpenApi':
      return _$invoiceResponsePaidViaEnum_unknownDefaultOpenApi;
    default:
      return _$invoiceResponsePaidViaEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<InvoiceResponsePaidViaEnum> _$invoiceResponsePaidViaEnumValues =
    BuiltSet<InvoiceResponsePaidViaEnum>(const <InvoiceResponsePaidViaEnum>[
      _$invoiceResponsePaidViaEnum_IN_APP,
      _$invoiceResponsePaidViaEnum_MANUAL,
      _$invoiceResponsePaidViaEnum_DECLARED,
      _$invoiceResponsePaidViaEnum_unknownDefaultOpenApi,
    ]);

Serializer<InvoiceResponseKindEnum> _$invoiceResponseKindEnumSerializer =
    _$InvoiceResponseKindEnumSerializer();
Serializer<InvoiceResponseSettlementEnum>
_$invoiceResponseSettlementEnumSerializer =
    _$InvoiceResponseSettlementEnumSerializer();
Serializer<InvoiceResponseStatusEnum> _$invoiceResponseStatusEnumSerializer =
    _$InvoiceResponseStatusEnumSerializer();
Serializer<InvoiceResponsePaidViaEnum> _$invoiceResponsePaidViaEnumSerializer =
    _$InvoiceResponsePaidViaEnumSerializer();

class _$InvoiceResponseKindEnumSerializer
    implements PrimitiveSerializer<InvoiceResponseKindEnum> {
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
  final Iterable<Type> types = const <Type>[InvoiceResponseKindEnum];
  @override
  final String wireName = 'InvoiceResponseKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    InvoiceResponseKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  InvoiceResponseKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => InvoiceResponseKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$InvoiceResponseSettlementEnumSerializer
    implements PrimitiveSerializer<InvoiceResponseSettlementEnum> {
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
  final Iterable<Type> types = const <Type>[InvoiceResponseSettlementEnum];
  @override
  final String wireName = 'InvoiceResponseSettlementEnum';

  @override
  Object serialize(
    Serializers serializers,
    InvoiceResponseSettlementEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  InvoiceResponseSettlementEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => InvoiceResponseSettlementEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$InvoiceResponseStatusEnumSerializer
    implements PrimitiveSerializer<InvoiceResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'TO_PAY': 'TO_PAY',
    'OVERDUE': 'OVERDUE',
    'PAID': 'PAID',
    'CANCELLED': 'CANCELLED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'TO_PAY': 'TO_PAY',
    'OVERDUE': 'OVERDUE',
    'PAID': 'PAID',
    'CANCELLED': 'CANCELLED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[InvoiceResponseStatusEnum];
  @override
  final String wireName = 'InvoiceResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    InvoiceResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  InvoiceResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => InvoiceResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$InvoiceResponsePaidViaEnumSerializer
    implements PrimitiveSerializer<InvoiceResponsePaidViaEnum> {
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
  final Iterable<Type> types = const <Type>[InvoiceResponsePaidViaEnum];
  @override
  final String wireName = 'InvoiceResponsePaidViaEnum';

  @override
  Object serialize(
    Serializers serializers,
    InvoiceResponsePaidViaEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  InvoiceResponsePaidViaEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => InvoiceResponsePaidViaEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$InvoiceResponse extends InvoiceResponse {
  @override
  final String? id;
  @override
  final String? contractId;
  @override
  final String? annonceId;
  @override
  final String? annonceTitle;
  @override
  final InvoiceResponseKindEnum? kind;
  @override
  final String? label;
  @override
  final int? amount;
  @override
  final Date? dueDate;
  @override
  final InvoiceResponseSettlementEnum? settlement;
  @override
  final InvoiceResponseStatusEnum? status;
  @override
  final bool? pastDue;
  @override
  final bool? payableInApp;
  @override
  final DateTime? paidAt;
  @override
  final InvoiceResponsePaidViaEnum? paidVia;
  @override
  final String? paymentId;
  @override
  final DateTime? cancelledAt;
  @override
  final DateTime? createdAt;

  factory _$InvoiceResponse([void Function(InvoiceResponseBuilder)? updates]) =>
      (InvoiceResponseBuilder()..update(updates))._build();

  _$InvoiceResponse._({
    this.id,
    this.contractId,
    this.annonceId,
    this.annonceTitle,
    this.kind,
    this.label,
    this.amount,
    this.dueDate,
    this.settlement,
    this.status,
    this.pastDue,
    this.payableInApp,
    this.paidAt,
    this.paidVia,
    this.paymentId,
    this.cancelledAt,
    this.createdAt,
  }) : super._();
  @override
  InvoiceResponse rebuild(void Function(InvoiceResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceResponseBuilder toBuilder() => InvoiceResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceResponse &&
        id == other.id &&
        contractId == other.contractId &&
        annonceId == other.annonceId &&
        annonceTitle == other.annonceTitle &&
        kind == other.kind &&
        label == other.label &&
        amount == other.amount &&
        dueDate == other.dueDate &&
        settlement == other.settlement &&
        status == other.status &&
        pastDue == other.pastDue &&
        payableInApp == other.payableInApp &&
        paidAt == other.paidAt &&
        paidVia == other.paidVia &&
        paymentId == other.paymentId &&
        cancelledAt == other.cancelledAt &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, contractId.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, annonceTitle.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, dueDate.hashCode);
    _$hash = $jc(_$hash, settlement.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, pastDue.hashCode);
    _$hash = $jc(_$hash, payableInApp.hashCode);
    _$hash = $jc(_$hash, paidAt.hashCode);
    _$hash = $jc(_$hash, paidVia.hashCode);
    _$hash = $jc(_$hash, paymentId.hashCode);
    _$hash = $jc(_$hash, cancelledAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InvoiceResponse')
          ..add('id', id)
          ..add('contractId', contractId)
          ..add('annonceId', annonceId)
          ..add('annonceTitle', annonceTitle)
          ..add('kind', kind)
          ..add('label', label)
          ..add('amount', amount)
          ..add('dueDate', dueDate)
          ..add('settlement', settlement)
          ..add('status', status)
          ..add('pastDue', pastDue)
          ..add('payableInApp', payableInApp)
          ..add('paidAt', paidAt)
          ..add('paidVia', paidVia)
          ..add('paymentId', paymentId)
          ..add('cancelledAt', cancelledAt)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class InvoiceResponseBuilder
    implements Builder<InvoiceResponse, InvoiceResponseBuilder> {
  _$InvoiceResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _contractId;
  String? get contractId => _$this._contractId;
  set contractId(String? contractId) => _$this._contractId = contractId;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _annonceTitle;
  String? get annonceTitle => _$this._annonceTitle;
  set annonceTitle(String? annonceTitle) => _$this._annonceTitle = annonceTitle;

  InvoiceResponseKindEnum? _kind;
  InvoiceResponseKindEnum? get kind => _$this._kind;
  set kind(InvoiceResponseKindEnum? kind) => _$this._kind = kind;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  Date? _dueDate;
  Date? get dueDate => _$this._dueDate;
  set dueDate(Date? dueDate) => _$this._dueDate = dueDate;

  InvoiceResponseSettlementEnum? _settlement;
  InvoiceResponseSettlementEnum? get settlement => _$this._settlement;
  set settlement(InvoiceResponseSettlementEnum? settlement) =>
      _$this._settlement = settlement;

  InvoiceResponseStatusEnum? _status;
  InvoiceResponseStatusEnum? get status => _$this._status;
  set status(InvoiceResponseStatusEnum? status) => _$this._status = status;

  bool? _pastDue;
  bool? get pastDue => _$this._pastDue;
  set pastDue(bool? pastDue) => _$this._pastDue = pastDue;

  bool? _payableInApp;
  bool? get payableInApp => _$this._payableInApp;
  set payableInApp(bool? payableInApp) => _$this._payableInApp = payableInApp;

  DateTime? _paidAt;
  DateTime? get paidAt => _$this._paidAt;
  set paidAt(DateTime? paidAt) => _$this._paidAt = paidAt;

  InvoiceResponsePaidViaEnum? _paidVia;
  InvoiceResponsePaidViaEnum? get paidVia => _$this._paidVia;
  set paidVia(InvoiceResponsePaidViaEnum? paidVia) => _$this._paidVia = paidVia;

  String? _paymentId;
  String? get paymentId => _$this._paymentId;
  set paymentId(String? paymentId) => _$this._paymentId = paymentId;

  DateTime? _cancelledAt;
  DateTime? get cancelledAt => _$this._cancelledAt;
  set cancelledAt(DateTime? cancelledAt) => _$this._cancelledAt = cancelledAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  InvoiceResponseBuilder() {
    InvoiceResponse._defaults(this);
  }

  InvoiceResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _contractId = $v.contractId;
      _annonceId = $v.annonceId;
      _annonceTitle = $v.annonceTitle;
      _kind = $v.kind;
      _label = $v.label;
      _amount = $v.amount;
      _dueDate = $v.dueDate;
      _settlement = $v.settlement;
      _status = $v.status;
      _pastDue = $v.pastDue;
      _payableInApp = $v.payableInApp;
      _paidAt = $v.paidAt;
      _paidVia = $v.paidVia;
      _paymentId = $v.paymentId;
      _cancelledAt = $v.cancelledAt;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceResponse other) {
    _$v = other as _$InvoiceResponse;
  }

  @override
  void update(void Function(InvoiceResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvoiceResponse build() => _build();

  _$InvoiceResponse _build() {
    final _$result =
        _$v ??
        _$InvoiceResponse._(
          id: id,
          contractId: contractId,
          annonceId: annonceId,
          annonceTitle: annonceTitle,
          kind: kind,
          label: label,
          amount: amount,
          dueDate: dueDate,
          settlement: settlement,
          status: status,
          pastDue: pastDue,
          payableInApp: payableInApp,
          paidAt: paidAt,
          paidVia: paidVia,
          paymentId: paymentId,
          cancelledAt: cancelledAt,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
