// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'declaration_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeclarationResponseKindEnum _$declarationResponseKindEnum_RENT =
    const DeclarationResponseKindEnum._('RENT');
const DeclarationResponseKindEnum _$declarationResponseKindEnum_DEPOSIT =
    const DeclarationResponseKindEnum._('DEPOSIT');
const DeclarationResponseKindEnum _$declarationResponseKindEnum_INVOICE =
    const DeclarationResponseKindEnum._('INVOICE');
const DeclarationResponseKindEnum
_$declarationResponseKindEnum_unknownDefaultOpenApi =
    const DeclarationResponseKindEnum._('unknownDefaultOpenApi');

DeclarationResponseKindEnum _$declarationResponseKindEnumValueOf(String name) {
  switch (name) {
    case 'RENT':
      return _$declarationResponseKindEnum_RENT;
    case 'DEPOSIT':
      return _$declarationResponseKindEnum_DEPOSIT;
    case 'INVOICE':
      return _$declarationResponseKindEnum_INVOICE;
    case 'unknownDefaultOpenApi':
      return _$declarationResponseKindEnum_unknownDefaultOpenApi;
    default:
      return _$declarationResponseKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DeclarationResponseKindEnum>
_$declarationResponseKindEnumValues =
    BuiltSet<DeclarationResponseKindEnum>(const <DeclarationResponseKindEnum>[
      _$declarationResponseKindEnum_RENT,
      _$declarationResponseKindEnum_DEPOSIT,
      _$declarationResponseKindEnum_INVOICE,
      _$declarationResponseKindEnum_unknownDefaultOpenApi,
    ]);

const DeclarationResponseMethodEnum
_$declarationResponseMethodEnum_MOBILE_MONEY =
    const DeclarationResponseMethodEnum._('MOBILE_MONEY');
const DeclarationResponseMethodEnum
_$declarationResponseMethodEnum_ORANGE_MONEY =
    const DeclarationResponseMethodEnum._('ORANGE_MONEY');
const DeclarationResponseMethodEnum _$declarationResponseMethodEnum_CASH =
    const DeclarationResponseMethodEnum._('CASH');
const DeclarationResponseMethodEnum _$declarationResponseMethodEnum_TRANSFER =
    const DeclarationResponseMethodEnum._('TRANSFER');
const DeclarationResponseMethodEnum _$declarationResponseMethodEnum_OTHER =
    const DeclarationResponseMethodEnum._('OTHER');
const DeclarationResponseMethodEnum
_$declarationResponseMethodEnum_unknownDefaultOpenApi =
    const DeclarationResponseMethodEnum._('unknownDefaultOpenApi');

DeclarationResponseMethodEnum _$declarationResponseMethodEnumValueOf(
  String name,
) {
  switch (name) {
    case 'MOBILE_MONEY':
      return _$declarationResponseMethodEnum_MOBILE_MONEY;
    case 'ORANGE_MONEY':
      return _$declarationResponseMethodEnum_ORANGE_MONEY;
    case 'CASH':
      return _$declarationResponseMethodEnum_CASH;
    case 'TRANSFER':
      return _$declarationResponseMethodEnum_TRANSFER;
    case 'OTHER':
      return _$declarationResponseMethodEnum_OTHER;
    case 'unknownDefaultOpenApi':
      return _$declarationResponseMethodEnum_unknownDefaultOpenApi;
    default:
      return _$declarationResponseMethodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DeclarationResponseMethodEnum>
_$declarationResponseMethodEnumValues = BuiltSet<DeclarationResponseMethodEnum>(
  const <DeclarationResponseMethodEnum>[
    _$declarationResponseMethodEnum_MOBILE_MONEY,
    _$declarationResponseMethodEnum_ORANGE_MONEY,
    _$declarationResponseMethodEnum_CASH,
    _$declarationResponseMethodEnum_TRANSFER,
    _$declarationResponseMethodEnum_OTHER,
    _$declarationResponseMethodEnum_unknownDefaultOpenApi,
  ],
);

const DeclarationResponseStatusEnum _$declarationResponseStatusEnum_DECLARED =
    const DeclarationResponseStatusEnum._('DECLARED');
const DeclarationResponseStatusEnum
_$declarationResponseStatusEnum_UNCONFIRMED =
    const DeclarationResponseStatusEnum._('UNCONFIRMED');
const DeclarationResponseStatusEnum _$declarationResponseStatusEnum_CONFIRMED =
    const DeclarationResponseStatusEnum._('CONFIRMED');
const DeclarationResponseStatusEnum _$declarationResponseStatusEnum_CONTESTED =
    const DeclarationResponseStatusEnum._('CONTESTED');
const DeclarationResponseStatusEnum
_$declarationResponseStatusEnum_unknownDefaultOpenApi =
    const DeclarationResponseStatusEnum._('unknownDefaultOpenApi');

DeclarationResponseStatusEnum _$declarationResponseStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'DECLARED':
      return _$declarationResponseStatusEnum_DECLARED;
    case 'UNCONFIRMED':
      return _$declarationResponseStatusEnum_UNCONFIRMED;
    case 'CONFIRMED':
      return _$declarationResponseStatusEnum_CONFIRMED;
    case 'CONTESTED':
      return _$declarationResponseStatusEnum_CONTESTED;
    case 'unknownDefaultOpenApi':
      return _$declarationResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$declarationResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DeclarationResponseStatusEnum>
_$declarationResponseStatusEnumValues = BuiltSet<DeclarationResponseStatusEnum>(
  const <DeclarationResponseStatusEnum>[
    _$declarationResponseStatusEnum_DECLARED,
    _$declarationResponseStatusEnum_UNCONFIRMED,
    _$declarationResponseStatusEnum_CONFIRMED,
    _$declarationResponseStatusEnum_CONTESTED,
    _$declarationResponseStatusEnum_unknownDefaultOpenApi,
  ],
);

Serializer<DeclarationResponseKindEnum>
_$declarationResponseKindEnumSerializer =
    _$DeclarationResponseKindEnumSerializer();
Serializer<DeclarationResponseMethodEnum>
_$declarationResponseMethodEnumSerializer =
    _$DeclarationResponseMethodEnumSerializer();
Serializer<DeclarationResponseStatusEnum>
_$declarationResponseStatusEnumSerializer =
    _$DeclarationResponseStatusEnumSerializer();

class _$DeclarationResponseKindEnumSerializer
    implements PrimitiveSerializer<DeclarationResponseKindEnum> {
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
  final Iterable<Type> types = const <Type>[DeclarationResponseKindEnum];
  @override
  final String wireName = 'DeclarationResponseKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    DeclarationResponseKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DeclarationResponseKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DeclarationResponseKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DeclarationResponseMethodEnumSerializer
    implements PrimitiveSerializer<DeclarationResponseMethodEnum> {
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
  final Iterable<Type> types = const <Type>[DeclarationResponseMethodEnum];
  @override
  final String wireName = 'DeclarationResponseMethodEnum';

  @override
  Object serialize(
    Serializers serializers,
    DeclarationResponseMethodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DeclarationResponseMethodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DeclarationResponseMethodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DeclarationResponseStatusEnumSerializer
    implements PrimitiveSerializer<DeclarationResponseStatusEnum> {
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
  final Iterable<Type> types = const <Type>[DeclarationResponseStatusEnum];
  @override
  final String wireName = 'DeclarationResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    DeclarationResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DeclarationResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DeclarationResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DeclarationResponse extends DeclarationResponse {
  @override
  final String? id;
  @override
  final String? contractId;
  @override
  final String? annonceId;
  @override
  final String? annonceTitle;
  @override
  final ParticipantSummary? tenant;
  @override
  final DeclarationResponseKindEnum? kind;
  @override
  final BuiltList<int>? dueIndexes;
  @override
  final String? invoiceId;
  @override
  final int? amount;
  @override
  final Date? paidOn;
  @override
  final DeclarationResponseMethodEnum? method;
  @override
  final String? reference;
  @override
  final String? note;
  @override
  final BuiltList<String>? proofKeys;
  @override
  final bool? hasProof;
  @override
  final DeclarationResponseStatusEnum? status;
  @override
  final String? contestReason;
  @override
  final DateTime? declaredAt;
  @override
  final DateTime? answeredAt;
  @override
  final bool? canConfirm;
  @override
  final bool? canContest;
  @override
  final String? receiptId;
  @override
  final bool? receiptReady;

  factory _$DeclarationResponse([
    void Function(DeclarationResponseBuilder)? updates,
  ]) => (DeclarationResponseBuilder()..update(updates))._build();

  _$DeclarationResponse._({
    this.id,
    this.contractId,
    this.annonceId,
    this.annonceTitle,
    this.tenant,
    this.kind,
    this.dueIndexes,
    this.invoiceId,
    this.amount,
    this.paidOn,
    this.method,
    this.reference,
    this.note,
    this.proofKeys,
    this.hasProof,
    this.status,
    this.contestReason,
    this.declaredAt,
    this.answeredAt,
    this.canConfirm,
    this.canContest,
    this.receiptId,
    this.receiptReady,
  }) : super._();
  @override
  DeclarationResponse rebuild(
    void Function(DeclarationResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DeclarationResponseBuilder toBuilder() =>
      DeclarationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeclarationResponse &&
        id == other.id &&
        contractId == other.contractId &&
        annonceId == other.annonceId &&
        annonceTitle == other.annonceTitle &&
        tenant == other.tenant &&
        kind == other.kind &&
        dueIndexes == other.dueIndexes &&
        invoiceId == other.invoiceId &&
        amount == other.amount &&
        paidOn == other.paidOn &&
        method == other.method &&
        reference == other.reference &&
        note == other.note &&
        proofKeys == other.proofKeys &&
        hasProof == other.hasProof &&
        status == other.status &&
        contestReason == other.contestReason &&
        declaredAt == other.declaredAt &&
        answeredAt == other.answeredAt &&
        canConfirm == other.canConfirm &&
        canContest == other.canContest &&
        receiptId == other.receiptId &&
        receiptReady == other.receiptReady;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, contractId.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, annonceTitle.hashCode);
    _$hash = $jc(_$hash, tenant.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, dueIndexes.hashCode);
    _$hash = $jc(_$hash, invoiceId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, paidOn.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, proofKeys.hashCode);
    _$hash = $jc(_$hash, hasProof.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, contestReason.hashCode);
    _$hash = $jc(_$hash, declaredAt.hashCode);
    _$hash = $jc(_$hash, answeredAt.hashCode);
    _$hash = $jc(_$hash, canConfirm.hashCode);
    _$hash = $jc(_$hash, canContest.hashCode);
    _$hash = $jc(_$hash, receiptId.hashCode);
    _$hash = $jc(_$hash, receiptReady.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeclarationResponse')
          ..add('id', id)
          ..add('contractId', contractId)
          ..add('annonceId', annonceId)
          ..add('annonceTitle', annonceTitle)
          ..add('tenant', tenant)
          ..add('kind', kind)
          ..add('dueIndexes', dueIndexes)
          ..add('invoiceId', invoiceId)
          ..add('amount', amount)
          ..add('paidOn', paidOn)
          ..add('method', method)
          ..add('reference', reference)
          ..add('note', note)
          ..add('proofKeys', proofKeys)
          ..add('hasProof', hasProof)
          ..add('status', status)
          ..add('contestReason', contestReason)
          ..add('declaredAt', declaredAt)
          ..add('answeredAt', answeredAt)
          ..add('canConfirm', canConfirm)
          ..add('canContest', canContest)
          ..add('receiptId', receiptId)
          ..add('receiptReady', receiptReady))
        .toString();
  }
}

class DeclarationResponseBuilder
    implements Builder<DeclarationResponse, DeclarationResponseBuilder> {
  _$DeclarationResponse? _$v;

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

  ParticipantSummaryBuilder? _tenant;
  ParticipantSummaryBuilder get tenant =>
      _$this._tenant ??= ParticipantSummaryBuilder();
  set tenant(ParticipantSummaryBuilder? tenant) => _$this._tenant = tenant;

  DeclarationResponseKindEnum? _kind;
  DeclarationResponseKindEnum? get kind => _$this._kind;
  set kind(DeclarationResponseKindEnum? kind) => _$this._kind = kind;

  ListBuilder<int>? _dueIndexes;
  ListBuilder<int> get dueIndexes => _$this._dueIndexes ??= ListBuilder<int>();
  set dueIndexes(ListBuilder<int>? dueIndexes) =>
      _$this._dueIndexes = dueIndexes;

  String? _invoiceId;
  String? get invoiceId => _$this._invoiceId;
  set invoiceId(String? invoiceId) => _$this._invoiceId = invoiceId;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  Date? _paidOn;
  Date? get paidOn => _$this._paidOn;
  set paidOn(Date? paidOn) => _$this._paidOn = paidOn;

  DeclarationResponseMethodEnum? _method;
  DeclarationResponseMethodEnum? get method => _$this._method;
  set method(DeclarationResponseMethodEnum? method) => _$this._method = method;

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

  bool? _hasProof;
  bool? get hasProof => _$this._hasProof;
  set hasProof(bool? hasProof) => _$this._hasProof = hasProof;

  DeclarationResponseStatusEnum? _status;
  DeclarationResponseStatusEnum? get status => _$this._status;
  set status(DeclarationResponseStatusEnum? status) => _$this._status = status;

  String? _contestReason;
  String? get contestReason => _$this._contestReason;
  set contestReason(String? contestReason) =>
      _$this._contestReason = contestReason;

  DateTime? _declaredAt;
  DateTime? get declaredAt => _$this._declaredAt;
  set declaredAt(DateTime? declaredAt) => _$this._declaredAt = declaredAt;

  DateTime? _answeredAt;
  DateTime? get answeredAt => _$this._answeredAt;
  set answeredAt(DateTime? answeredAt) => _$this._answeredAt = answeredAt;

  bool? _canConfirm;
  bool? get canConfirm => _$this._canConfirm;
  set canConfirm(bool? canConfirm) => _$this._canConfirm = canConfirm;

  bool? _canContest;
  bool? get canContest => _$this._canContest;
  set canContest(bool? canContest) => _$this._canContest = canContest;

  String? _receiptId;
  String? get receiptId => _$this._receiptId;
  set receiptId(String? receiptId) => _$this._receiptId = receiptId;

  bool? _receiptReady;
  bool? get receiptReady => _$this._receiptReady;
  set receiptReady(bool? receiptReady) => _$this._receiptReady = receiptReady;

  DeclarationResponseBuilder() {
    DeclarationResponse._defaults(this);
  }

  DeclarationResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _contractId = $v.contractId;
      _annonceId = $v.annonceId;
      _annonceTitle = $v.annonceTitle;
      _tenant = $v.tenant?.toBuilder();
      _kind = $v.kind;
      _dueIndexes = $v.dueIndexes?.toBuilder();
      _invoiceId = $v.invoiceId;
      _amount = $v.amount;
      _paidOn = $v.paidOn;
      _method = $v.method;
      _reference = $v.reference;
      _note = $v.note;
      _proofKeys = $v.proofKeys?.toBuilder();
      _hasProof = $v.hasProof;
      _status = $v.status;
      _contestReason = $v.contestReason;
      _declaredAt = $v.declaredAt;
      _answeredAt = $v.answeredAt;
      _canConfirm = $v.canConfirm;
      _canContest = $v.canContest;
      _receiptId = $v.receiptId;
      _receiptReady = $v.receiptReady;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeclarationResponse other) {
    _$v = other as _$DeclarationResponse;
  }

  @override
  void update(void Function(DeclarationResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeclarationResponse build() => _build();

  _$DeclarationResponse _build() {
    _$DeclarationResponse _$result;
    try {
      _$result =
          _$v ??
          _$DeclarationResponse._(
            id: id,
            contractId: contractId,
            annonceId: annonceId,
            annonceTitle: annonceTitle,
            tenant: _tenant?.build(),
            kind: kind,
            dueIndexes: _dueIndexes?.build(),
            invoiceId: invoiceId,
            amount: amount,
            paidOn: paidOn,
            method: method,
            reference: reference,
            note: note,
            proofKeys: _proofKeys?.build(),
            hasProof: hasProof,
            status: status,
            contestReason: contestReason,
            declaredAt: declaredAt,
            answeredAt: answeredAt,
            canConfirm: canConfirm,
            canContest: canContest,
            receiptId: receiptId,
            receiptReady: receiptReady,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tenant';
        _tenant?.build();

        _$failedField = 'dueIndexes';
        _dueIndexes?.build();

        _$failedField = 'proofKeys';
        _proofKeys?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DeclarationResponse',
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
