// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ContractResponseStatusEnum _$contractResponseStatusEnum_DRAFT =
    const ContractResponseStatusEnum._('DRAFT');
const ContractResponseStatusEnum _$contractResponseStatusEnum_SENT =
    const ContractResponseStatusEnum._('SENT');
const ContractResponseStatusEnum
_$contractResponseStatusEnum_CHANGES_REQUESTED =
    const ContractResponseStatusEnum._('CHANGES_REQUESTED');
const ContractResponseStatusEnum _$contractResponseStatusEnum_ACCEPTED =
    const ContractResponseStatusEnum._('ACCEPTED');
const ContractResponseStatusEnum _$contractResponseStatusEnum_SIGNED =
    const ContractResponseStatusEnum._('SIGNED');
const ContractResponseStatusEnum _$contractResponseStatusEnum_CANCELLED =
    const ContractResponseStatusEnum._('CANCELLED');
const ContractResponseStatusEnum
_$contractResponseStatusEnum_unknownDefaultOpenApi =
    const ContractResponseStatusEnum._('unknownDefaultOpenApi');

ContractResponseStatusEnum _$contractResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'DRAFT':
      return _$contractResponseStatusEnum_DRAFT;
    case 'SENT':
      return _$contractResponseStatusEnum_SENT;
    case 'CHANGES_REQUESTED':
      return _$contractResponseStatusEnum_CHANGES_REQUESTED;
    case 'ACCEPTED':
      return _$contractResponseStatusEnum_ACCEPTED;
    case 'SIGNED':
      return _$contractResponseStatusEnum_SIGNED;
    case 'CANCELLED':
      return _$contractResponseStatusEnum_CANCELLED;
    case 'unknownDefaultOpenApi':
      return _$contractResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$contractResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ContractResponseStatusEnum> _$contractResponseStatusEnumValues =
    BuiltSet<ContractResponseStatusEnum>(const <ContractResponseStatusEnum>[
      _$contractResponseStatusEnum_DRAFT,
      _$contractResponseStatusEnum_SENT,
      _$contractResponseStatusEnum_CHANGES_REQUESTED,
      _$contractResponseStatusEnum_ACCEPTED,
      _$contractResponseStatusEnum_SIGNED,
      _$contractResponseStatusEnum_CANCELLED,
      _$contractResponseStatusEnum_unknownDefaultOpenApi,
    ]);

const ContractResponseRentalPeriodEnum _$contractResponseRentalPeriodEnum_DAY =
    const ContractResponseRentalPeriodEnum._('DAY');
const ContractResponseRentalPeriodEnum _$contractResponseRentalPeriodEnum_WEEK =
    const ContractResponseRentalPeriodEnum._('WEEK');
const ContractResponseRentalPeriodEnum
_$contractResponseRentalPeriodEnum_MONTH =
    const ContractResponseRentalPeriodEnum._('MONTH');
const ContractResponseRentalPeriodEnum
_$contractResponseRentalPeriodEnum_QUARTER =
    const ContractResponseRentalPeriodEnum._('QUARTER');
const ContractResponseRentalPeriodEnum _$contractResponseRentalPeriodEnum_YEAR =
    const ContractResponseRentalPeriodEnum._('YEAR');
const ContractResponseRentalPeriodEnum
_$contractResponseRentalPeriodEnum_unknownDefaultOpenApi =
    const ContractResponseRentalPeriodEnum._('unknownDefaultOpenApi');

ContractResponseRentalPeriodEnum _$contractResponseRentalPeriodEnumValueOf(
  String name,
) {
  switch (name) {
    case 'DAY':
      return _$contractResponseRentalPeriodEnum_DAY;
    case 'WEEK':
      return _$contractResponseRentalPeriodEnum_WEEK;
    case 'MONTH':
      return _$contractResponseRentalPeriodEnum_MONTH;
    case 'QUARTER':
      return _$contractResponseRentalPeriodEnum_QUARTER;
    case 'YEAR':
      return _$contractResponseRentalPeriodEnum_YEAR;
    case 'unknownDefaultOpenApi':
      return _$contractResponseRentalPeriodEnum_unknownDefaultOpenApi;
    default:
      return _$contractResponseRentalPeriodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ContractResponseRentalPeriodEnum>
_$contractResponseRentalPeriodEnumValues =
    BuiltSet<ContractResponseRentalPeriodEnum>(
      const <ContractResponseRentalPeriodEnum>[
        _$contractResponseRentalPeriodEnum_DAY,
        _$contractResponseRentalPeriodEnum_WEEK,
        _$contractResponseRentalPeriodEnum_MONTH,
        _$contractResponseRentalPeriodEnum_QUARTER,
        _$contractResponseRentalPeriodEnum_YEAR,
        _$contractResponseRentalPeriodEnum_unknownDefaultOpenApi,
      ],
    );

const ContractResponseAwaitingEnum _$contractResponseAwaitingEnum_PRESTATAIRE =
    const ContractResponseAwaitingEnum._('PRESTATAIRE');
const ContractResponseAwaitingEnum _$contractResponseAwaitingEnum_TENANT =
    const ContractResponseAwaitingEnum._('TENANT');
const ContractResponseAwaitingEnum _$contractResponseAwaitingEnum_BOTH =
    const ContractResponseAwaitingEnum._('BOTH');
const ContractResponseAwaitingEnum _$contractResponseAwaitingEnum_NOBODY =
    const ContractResponseAwaitingEnum._('NOBODY');
const ContractResponseAwaitingEnum
_$contractResponseAwaitingEnum_unknownDefaultOpenApi =
    const ContractResponseAwaitingEnum._('unknownDefaultOpenApi');

ContractResponseAwaitingEnum _$contractResponseAwaitingEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PRESTATAIRE':
      return _$contractResponseAwaitingEnum_PRESTATAIRE;
    case 'TENANT':
      return _$contractResponseAwaitingEnum_TENANT;
    case 'BOTH':
      return _$contractResponseAwaitingEnum_BOTH;
    case 'NOBODY':
      return _$contractResponseAwaitingEnum_NOBODY;
    case 'unknownDefaultOpenApi':
      return _$contractResponseAwaitingEnum_unknownDefaultOpenApi;
    default:
      return _$contractResponseAwaitingEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ContractResponseAwaitingEnum>
_$contractResponseAwaitingEnumValues =
    BuiltSet<ContractResponseAwaitingEnum>(const <ContractResponseAwaitingEnum>[
      _$contractResponseAwaitingEnum_PRESTATAIRE,
      _$contractResponseAwaitingEnum_TENANT,
      _$contractResponseAwaitingEnum_BOTH,
      _$contractResponseAwaitingEnum_NOBODY,
      _$contractResponseAwaitingEnum_unknownDefaultOpenApi,
    ]);

Serializer<ContractResponseStatusEnum> _$contractResponseStatusEnumSerializer =
    _$ContractResponseStatusEnumSerializer();
Serializer<ContractResponseRentalPeriodEnum>
_$contractResponseRentalPeriodEnumSerializer =
    _$ContractResponseRentalPeriodEnumSerializer();
Serializer<ContractResponseAwaitingEnum>
_$contractResponseAwaitingEnumSerializer =
    _$ContractResponseAwaitingEnumSerializer();

class _$ContractResponseStatusEnumSerializer
    implements PrimitiveSerializer<ContractResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'DRAFT': 'DRAFT',
    'SENT': 'SENT',
    'CHANGES_REQUESTED': 'CHANGES_REQUESTED',
    'ACCEPTED': 'ACCEPTED',
    'SIGNED': 'SIGNED',
    'CANCELLED': 'CANCELLED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'DRAFT': 'DRAFT',
    'SENT': 'SENT',
    'CHANGES_REQUESTED': 'CHANGES_REQUESTED',
    'ACCEPTED': 'ACCEPTED',
    'SIGNED': 'SIGNED',
    'CANCELLED': 'CANCELLED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ContractResponseStatusEnum];
  @override
  final String wireName = 'ContractResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    ContractResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ContractResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ContractResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ContractResponseRentalPeriodEnumSerializer
    implements PrimitiveSerializer<ContractResponseRentalPeriodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'DAY': 'DAY',
    'WEEK': 'WEEK',
    'MONTH': 'MONTH',
    'QUARTER': 'QUARTER',
    'YEAR': 'YEAR',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'DAY': 'DAY',
    'WEEK': 'WEEK',
    'MONTH': 'MONTH',
    'QUARTER': 'QUARTER',
    'YEAR': 'YEAR',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ContractResponseRentalPeriodEnum];
  @override
  final String wireName = 'ContractResponseRentalPeriodEnum';

  @override
  Object serialize(
    Serializers serializers,
    ContractResponseRentalPeriodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ContractResponseRentalPeriodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ContractResponseRentalPeriodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ContractResponseAwaitingEnumSerializer
    implements PrimitiveSerializer<ContractResponseAwaitingEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PRESTATAIRE': 'PRESTATAIRE',
    'TENANT': 'TENANT',
    'BOTH': 'BOTH',
    'NOBODY': 'NOBODY',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PRESTATAIRE': 'PRESTATAIRE',
    'TENANT': 'TENANT',
    'BOTH': 'BOTH',
    'NOBODY': 'NOBODY',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ContractResponseAwaitingEnum];
  @override
  final String wireName = 'ContractResponseAwaitingEnum';

  @override
  Object serialize(
    Serializers serializers,
    ContractResponseAwaitingEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ContractResponseAwaitingEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ContractResponseAwaitingEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ContractResponse extends ContractResponse {
  @override
  final String? id;
  @override
  final ContractResponseStatusEnum? status;
  @override
  final String? annonceId;
  @override
  final String? annonceTitle;
  @override
  final String? city;
  @override
  final String? district;
  @override
  final String? exactAddress;
  @override
  final ParticipantSummary? prestataire;
  @override
  final ParticipantSummary? tenant;
  @override
  final ParticipantSummary? agent;
  @override
  final int? price;
  @override
  final ContractResponseRentalPeriodEnum? rentalPeriod;
  @override
  final int? monthlyRent;
  @override
  final int? depositAmount;
  @override
  final bool? chargesIncluded;
  @override
  final Date? startDate;
  @override
  final Date? endDate;
  @override
  final int? durationUnits;
  @override
  final bool? tacitRenewal;
  @override
  final BuiltList<SignatureResponse>? signatures;
  @override
  final BuiltList<ChangeRequestResponse>? changeRequests;
  @override
  final ContractResponseAwaitingEnum? awaiting;
  @override
  final bool? canSign;
  @override
  final bool? residentReviewEligible;
  @override
  final DateTime? lockedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  factory _$ContractResponse([
    void Function(ContractResponseBuilder)? updates,
  ]) => (ContractResponseBuilder()..update(updates))._build();

  _$ContractResponse._({
    this.id,
    this.status,
    this.annonceId,
    this.annonceTitle,
    this.city,
    this.district,
    this.exactAddress,
    this.prestataire,
    this.tenant,
    this.agent,
    this.price,
    this.rentalPeriod,
    this.monthlyRent,
    this.depositAmount,
    this.chargesIncluded,
    this.startDate,
    this.endDate,
    this.durationUnits,
    this.tacitRenewal,
    this.signatures,
    this.changeRequests,
    this.awaiting,
    this.canSign,
    this.residentReviewEligible,
    this.lockedAt,
    this.createdAt,
    this.updatedAt,
  }) : super._();
  @override
  ContractResponse rebuild(void Function(ContractResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ContractResponseBuilder toBuilder() =>
      ContractResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContractResponse &&
        id == other.id &&
        status == other.status &&
        annonceId == other.annonceId &&
        annonceTitle == other.annonceTitle &&
        city == other.city &&
        district == other.district &&
        exactAddress == other.exactAddress &&
        prestataire == other.prestataire &&
        tenant == other.tenant &&
        agent == other.agent &&
        price == other.price &&
        rentalPeriod == other.rentalPeriod &&
        monthlyRent == other.monthlyRent &&
        depositAmount == other.depositAmount &&
        chargesIncluded == other.chargesIncluded &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        durationUnits == other.durationUnits &&
        tacitRenewal == other.tacitRenewal &&
        signatures == other.signatures &&
        changeRequests == other.changeRequests &&
        awaiting == other.awaiting &&
        canSign == other.canSign &&
        residentReviewEligible == other.residentReviewEligible &&
        lockedAt == other.lockedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, annonceTitle.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, district.hashCode);
    _$hash = $jc(_$hash, exactAddress.hashCode);
    _$hash = $jc(_$hash, prestataire.hashCode);
    _$hash = $jc(_$hash, tenant.hashCode);
    _$hash = $jc(_$hash, agent.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, rentalPeriod.hashCode);
    _$hash = $jc(_$hash, monthlyRent.hashCode);
    _$hash = $jc(_$hash, depositAmount.hashCode);
    _$hash = $jc(_$hash, chargesIncluded.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, durationUnits.hashCode);
    _$hash = $jc(_$hash, tacitRenewal.hashCode);
    _$hash = $jc(_$hash, signatures.hashCode);
    _$hash = $jc(_$hash, changeRequests.hashCode);
    _$hash = $jc(_$hash, awaiting.hashCode);
    _$hash = $jc(_$hash, canSign.hashCode);
    _$hash = $jc(_$hash, residentReviewEligible.hashCode);
    _$hash = $jc(_$hash, lockedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ContractResponse')
          ..add('id', id)
          ..add('status', status)
          ..add('annonceId', annonceId)
          ..add('annonceTitle', annonceTitle)
          ..add('city', city)
          ..add('district', district)
          ..add('exactAddress', exactAddress)
          ..add('prestataire', prestataire)
          ..add('tenant', tenant)
          ..add('agent', agent)
          ..add('price', price)
          ..add('rentalPeriod', rentalPeriod)
          ..add('monthlyRent', monthlyRent)
          ..add('depositAmount', depositAmount)
          ..add('chargesIncluded', chargesIncluded)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('durationUnits', durationUnits)
          ..add('tacitRenewal', tacitRenewal)
          ..add('signatures', signatures)
          ..add('changeRequests', changeRequests)
          ..add('awaiting', awaiting)
          ..add('canSign', canSign)
          ..add('residentReviewEligible', residentReviewEligible)
          ..add('lockedAt', lockedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class ContractResponseBuilder
    implements Builder<ContractResponse, ContractResponseBuilder> {
  _$ContractResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ContractResponseStatusEnum? _status;
  ContractResponseStatusEnum? get status => _$this._status;
  set status(ContractResponseStatusEnum? status) => _$this._status = status;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _annonceTitle;
  String? get annonceTitle => _$this._annonceTitle;
  set annonceTitle(String? annonceTitle) => _$this._annonceTitle = annonceTitle;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _district;
  String? get district => _$this._district;
  set district(String? district) => _$this._district = district;

  String? _exactAddress;
  String? get exactAddress => _$this._exactAddress;
  set exactAddress(String? exactAddress) => _$this._exactAddress = exactAddress;

  ParticipantSummaryBuilder? _prestataire;
  ParticipantSummaryBuilder get prestataire =>
      _$this._prestataire ??= ParticipantSummaryBuilder();
  set prestataire(ParticipantSummaryBuilder? prestataire) =>
      _$this._prestataire = prestataire;

  ParticipantSummaryBuilder? _tenant;
  ParticipantSummaryBuilder get tenant =>
      _$this._tenant ??= ParticipantSummaryBuilder();
  set tenant(ParticipantSummaryBuilder? tenant) => _$this._tenant = tenant;

  ParticipantSummaryBuilder? _agent;
  ParticipantSummaryBuilder get agent =>
      _$this._agent ??= ParticipantSummaryBuilder();
  set agent(ParticipantSummaryBuilder? agent) => _$this._agent = agent;

  int? _price;
  int? get price => _$this._price;
  set price(int? price) => _$this._price = price;

  ContractResponseRentalPeriodEnum? _rentalPeriod;
  ContractResponseRentalPeriodEnum? get rentalPeriod => _$this._rentalPeriod;
  set rentalPeriod(ContractResponseRentalPeriodEnum? rentalPeriod) =>
      _$this._rentalPeriod = rentalPeriod;

  int? _monthlyRent;
  int? get monthlyRent => _$this._monthlyRent;
  set monthlyRent(int? monthlyRent) => _$this._monthlyRent = monthlyRent;

  int? _depositAmount;
  int? get depositAmount => _$this._depositAmount;
  set depositAmount(int? depositAmount) =>
      _$this._depositAmount = depositAmount;

  bool? _chargesIncluded;
  bool? get chargesIncluded => _$this._chargesIncluded;
  set chargesIncluded(bool? chargesIncluded) =>
      _$this._chargesIncluded = chargesIncluded;

  Date? _startDate;
  Date? get startDate => _$this._startDate;
  set startDate(Date? startDate) => _$this._startDate = startDate;

  Date? _endDate;
  Date? get endDate => _$this._endDate;
  set endDate(Date? endDate) => _$this._endDate = endDate;

  int? _durationUnits;
  int? get durationUnits => _$this._durationUnits;
  set durationUnits(int? durationUnits) =>
      _$this._durationUnits = durationUnits;

  bool? _tacitRenewal;
  bool? get tacitRenewal => _$this._tacitRenewal;
  set tacitRenewal(bool? tacitRenewal) => _$this._tacitRenewal = tacitRenewal;

  ListBuilder<SignatureResponse>? _signatures;
  ListBuilder<SignatureResponse> get signatures =>
      _$this._signatures ??= ListBuilder<SignatureResponse>();
  set signatures(ListBuilder<SignatureResponse>? signatures) =>
      _$this._signatures = signatures;

  ListBuilder<ChangeRequestResponse>? _changeRequests;
  ListBuilder<ChangeRequestResponse> get changeRequests =>
      _$this._changeRequests ??= ListBuilder<ChangeRequestResponse>();
  set changeRequests(ListBuilder<ChangeRequestResponse>? changeRequests) =>
      _$this._changeRequests = changeRequests;

  ContractResponseAwaitingEnum? _awaiting;
  ContractResponseAwaitingEnum? get awaiting => _$this._awaiting;
  set awaiting(ContractResponseAwaitingEnum? awaiting) =>
      _$this._awaiting = awaiting;

  bool? _canSign;
  bool? get canSign => _$this._canSign;
  set canSign(bool? canSign) => _$this._canSign = canSign;

  bool? _residentReviewEligible;
  bool? get residentReviewEligible => _$this._residentReviewEligible;
  set residentReviewEligible(bool? residentReviewEligible) =>
      _$this._residentReviewEligible = residentReviewEligible;

  DateTime? _lockedAt;
  DateTime? get lockedAt => _$this._lockedAt;
  set lockedAt(DateTime? lockedAt) => _$this._lockedAt = lockedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  ContractResponseBuilder() {
    ContractResponse._defaults(this);
  }

  ContractResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _status = $v.status;
      _annonceId = $v.annonceId;
      _annonceTitle = $v.annonceTitle;
      _city = $v.city;
      _district = $v.district;
      _exactAddress = $v.exactAddress;
      _prestataire = $v.prestataire?.toBuilder();
      _tenant = $v.tenant?.toBuilder();
      _agent = $v.agent?.toBuilder();
      _price = $v.price;
      _rentalPeriod = $v.rentalPeriod;
      _monthlyRent = $v.monthlyRent;
      _depositAmount = $v.depositAmount;
      _chargesIncluded = $v.chargesIncluded;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _durationUnits = $v.durationUnits;
      _tacitRenewal = $v.tacitRenewal;
      _signatures = $v.signatures?.toBuilder();
      _changeRequests = $v.changeRequests?.toBuilder();
      _awaiting = $v.awaiting;
      _canSign = $v.canSign;
      _residentReviewEligible = $v.residentReviewEligible;
      _lockedAt = $v.lockedAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ContractResponse other) {
    _$v = other as _$ContractResponse;
  }

  @override
  void update(void Function(ContractResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ContractResponse build() => _build();

  _$ContractResponse _build() {
    _$ContractResponse _$result;
    try {
      _$result =
          _$v ??
          _$ContractResponse._(
            id: id,
            status: status,
            annonceId: annonceId,
            annonceTitle: annonceTitle,
            city: city,
            district: district,
            exactAddress: exactAddress,
            prestataire: _prestataire?.build(),
            tenant: _tenant?.build(),
            agent: _agent?.build(),
            price: price,
            rentalPeriod: rentalPeriod,
            monthlyRent: monthlyRent,
            depositAmount: depositAmount,
            chargesIncluded: chargesIncluded,
            startDate: startDate,
            endDate: endDate,
            durationUnits: durationUnits,
            tacitRenewal: tacitRenewal,
            signatures: _signatures?.build(),
            changeRequests: _changeRequests?.build(),
            awaiting: awaiting,
            canSign: canSign,
            residentReviewEligible: residentReviewEligible,
            lockedAt: lockedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'prestataire';
        _prestataire?.build();
        _$failedField = 'tenant';
        _tenant?.build();
        _$failedField = 'agent';
        _agent?.build();

        _$failedField = 'signatures';
        _signatures?.build();
        _$failedField = 'changeRequests';
        _changeRequests?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ContractResponse',
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
