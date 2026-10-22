// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HomeSummaryStateEnum _$homeSummaryStateEnum_UPCOMING =
    const HomeSummaryStateEnum._('UPCOMING');
const HomeSummaryStateEnum _$homeSummaryStateEnum_ACTIVE =
    const HomeSummaryStateEnum._('ACTIVE');
const HomeSummaryStateEnum _$homeSummaryStateEnum_READ_ONLY =
    const HomeSummaryStateEnum._('READ_ONLY');
const HomeSummaryStateEnum _$homeSummaryStateEnum_unknownDefaultOpenApi =
    const HomeSummaryStateEnum._('unknownDefaultOpenApi');

HomeSummaryStateEnum _$homeSummaryStateEnumValueOf(String name) {
  switch (name) {
    case 'UPCOMING':
      return _$homeSummaryStateEnum_UPCOMING;
    case 'ACTIVE':
      return _$homeSummaryStateEnum_ACTIVE;
    case 'READ_ONLY':
      return _$homeSummaryStateEnum_READ_ONLY;
    case 'unknownDefaultOpenApi':
      return _$homeSummaryStateEnum_unknownDefaultOpenApi;
    default:
      return _$homeSummaryStateEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<HomeSummaryStateEnum> _$homeSummaryStateEnumValues =
    BuiltSet<HomeSummaryStateEnum>(const <HomeSummaryStateEnum>[
      _$homeSummaryStateEnum_UPCOMING,
      _$homeSummaryStateEnum_ACTIVE,
      _$homeSummaryStateEnum_READ_ONLY,
      _$homeSummaryStateEnum_unknownDefaultOpenApi,
    ]);

const HomeSummaryRentalPeriodEnum _$homeSummaryRentalPeriodEnum_DAY =
    const HomeSummaryRentalPeriodEnum._('DAY');
const HomeSummaryRentalPeriodEnum _$homeSummaryRentalPeriodEnum_WEEK =
    const HomeSummaryRentalPeriodEnum._('WEEK');
const HomeSummaryRentalPeriodEnum _$homeSummaryRentalPeriodEnum_MONTH =
    const HomeSummaryRentalPeriodEnum._('MONTH');
const HomeSummaryRentalPeriodEnum _$homeSummaryRentalPeriodEnum_QUARTER =
    const HomeSummaryRentalPeriodEnum._('QUARTER');
const HomeSummaryRentalPeriodEnum _$homeSummaryRentalPeriodEnum_YEAR =
    const HomeSummaryRentalPeriodEnum._('YEAR');
const HomeSummaryRentalPeriodEnum
_$homeSummaryRentalPeriodEnum_unknownDefaultOpenApi =
    const HomeSummaryRentalPeriodEnum._('unknownDefaultOpenApi');

HomeSummaryRentalPeriodEnum _$homeSummaryRentalPeriodEnumValueOf(String name) {
  switch (name) {
    case 'DAY':
      return _$homeSummaryRentalPeriodEnum_DAY;
    case 'WEEK':
      return _$homeSummaryRentalPeriodEnum_WEEK;
    case 'MONTH':
      return _$homeSummaryRentalPeriodEnum_MONTH;
    case 'QUARTER':
      return _$homeSummaryRentalPeriodEnum_QUARTER;
    case 'YEAR':
      return _$homeSummaryRentalPeriodEnum_YEAR;
    case 'unknownDefaultOpenApi':
      return _$homeSummaryRentalPeriodEnum_unknownDefaultOpenApi;
    default:
      return _$homeSummaryRentalPeriodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<HomeSummaryRentalPeriodEnum>
_$homeSummaryRentalPeriodEnumValues =
    BuiltSet<HomeSummaryRentalPeriodEnum>(const <HomeSummaryRentalPeriodEnum>[
      _$homeSummaryRentalPeriodEnum_DAY,
      _$homeSummaryRentalPeriodEnum_WEEK,
      _$homeSummaryRentalPeriodEnum_MONTH,
      _$homeSummaryRentalPeriodEnum_QUARTER,
      _$homeSummaryRentalPeriodEnum_YEAR,
      _$homeSummaryRentalPeriodEnum_unknownDefaultOpenApi,
    ]);

Serializer<HomeSummaryStateEnum> _$homeSummaryStateEnumSerializer =
    _$HomeSummaryStateEnumSerializer();
Serializer<HomeSummaryRentalPeriodEnum>
_$homeSummaryRentalPeriodEnumSerializer =
    _$HomeSummaryRentalPeriodEnumSerializer();

class _$HomeSummaryStateEnumSerializer
    implements PrimitiveSerializer<HomeSummaryStateEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'UPCOMING': 'UPCOMING',
    'ACTIVE': 'ACTIVE',
    'READ_ONLY': 'READ_ONLY',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'UPCOMING': 'UPCOMING',
    'ACTIVE': 'ACTIVE',
    'READ_ONLY': 'READ_ONLY',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[HomeSummaryStateEnum];
  @override
  final String wireName = 'HomeSummaryStateEnum';

  @override
  Object serialize(
    Serializers serializers,
    HomeSummaryStateEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HomeSummaryStateEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HomeSummaryStateEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HomeSummaryRentalPeriodEnumSerializer
    implements PrimitiveSerializer<HomeSummaryRentalPeriodEnum> {
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
  final Iterable<Type> types = const <Type>[HomeSummaryRentalPeriodEnum];
  @override
  final String wireName = 'HomeSummaryRentalPeriodEnum';

  @override
  Object serialize(
    Serializers serializers,
    HomeSummaryRentalPeriodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HomeSummaryRentalPeriodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HomeSummaryRentalPeriodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HomeSummary extends HomeSummary {
  @override
  final String? contractId;
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
  final String? coverPhotoKey;
  @override
  final ParticipantSummary? prestataire;
  @override
  final ParticipantSummary? tenant;
  @override
  final HomeSummaryStateEnum? state;
  @override
  final int? rent;
  @override
  final HomeSummaryRentalPeriodEnum? rentalPeriod;
  @override
  final bool? chargesIncluded;
  @override
  final int? depositAmount;
  @override
  final HomeDeposit? deposit;
  @override
  final Date? startDate;
  @override
  final Date? endDate;
  @override
  final bool? tacitRenewal;
  @override
  final Due? nextDue;
  @override
  final int? overdueCount;
  @override
  final int? overdueAmount;
  @override
  final String? residenceId;
  @override
  final String? residenceName;

  factory _$HomeSummary([void Function(HomeSummaryBuilder)? updates]) =>
      (HomeSummaryBuilder()..update(updates))._build();

  _$HomeSummary._({
    this.contractId,
    this.annonceId,
    this.annonceTitle,
    this.city,
    this.district,
    this.exactAddress,
    this.coverPhotoKey,
    this.prestataire,
    this.tenant,
    this.state,
    this.rent,
    this.rentalPeriod,
    this.chargesIncluded,
    this.depositAmount,
    this.deposit,
    this.startDate,
    this.endDate,
    this.tacitRenewal,
    this.nextDue,
    this.overdueCount,
    this.overdueAmount,
    this.residenceId,
    this.residenceName,
  }) : super._();
  @override
  HomeSummary rebuild(void Function(HomeSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeSummaryBuilder toBuilder() => HomeSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeSummary &&
        contractId == other.contractId &&
        annonceId == other.annonceId &&
        annonceTitle == other.annonceTitle &&
        city == other.city &&
        district == other.district &&
        exactAddress == other.exactAddress &&
        coverPhotoKey == other.coverPhotoKey &&
        prestataire == other.prestataire &&
        tenant == other.tenant &&
        state == other.state &&
        rent == other.rent &&
        rentalPeriod == other.rentalPeriod &&
        chargesIncluded == other.chargesIncluded &&
        depositAmount == other.depositAmount &&
        deposit == other.deposit &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        tacitRenewal == other.tacitRenewal &&
        nextDue == other.nextDue &&
        overdueCount == other.overdueCount &&
        overdueAmount == other.overdueAmount &&
        residenceId == other.residenceId &&
        residenceName == other.residenceName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, contractId.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, annonceTitle.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, district.hashCode);
    _$hash = $jc(_$hash, exactAddress.hashCode);
    _$hash = $jc(_$hash, coverPhotoKey.hashCode);
    _$hash = $jc(_$hash, prestataire.hashCode);
    _$hash = $jc(_$hash, tenant.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, rent.hashCode);
    _$hash = $jc(_$hash, rentalPeriod.hashCode);
    _$hash = $jc(_$hash, chargesIncluded.hashCode);
    _$hash = $jc(_$hash, depositAmount.hashCode);
    _$hash = $jc(_$hash, deposit.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, tacitRenewal.hashCode);
    _$hash = $jc(_$hash, nextDue.hashCode);
    _$hash = $jc(_$hash, overdueCount.hashCode);
    _$hash = $jc(_$hash, overdueAmount.hashCode);
    _$hash = $jc(_$hash, residenceId.hashCode);
    _$hash = $jc(_$hash, residenceName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HomeSummary')
          ..add('contractId', contractId)
          ..add('annonceId', annonceId)
          ..add('annonceTitle', annonceTitle)
          ..add('city', city)
          ..add('district', district)
          ..add('exactAddress', exactAddress)
          ..add('coverPhotoKey', coverPhotoKey)
          ..add('prestataire', prestataire)
          ..add('tenant', tenant)
          ..add('state', state)
          ..add('rent', rent)
          ..add('rentalPeriod', rentalPeriod)
          ..add('chargesIncluded', chargesIncluded)
          ..add('depositAmount', depositAmount)
          ..add('deposit', deposit)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('tacitRenewal', tacitRenewal)
          ..add('nextDue', nextDue)
          ..add('overdueCount', overdueCount)
          ..add('overdueAmount', overdueAmount)
          ..add('residenceId', residenceId)
          ..add('residenceName', residenceName))
        .toString();
  }
}

class HomeSummaryBuilder implements Builder<HomeSummary, HomeSummaryBuilder> {
  _$HomeSummary? _$v;

  String? _contractId;
  String? get contractId => _$this._contractId;
  set contractId(String? contractId) => _$this._contractId = contractId;

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

  String? _coverPhotoKey;
  String? get coverPhotoKey => _$this._coverPhotoKey;
  set coverPhotoKey(String? coverPhotoKey) =>
      _$this._coverPhotoKey = coverPhotoKey;

  ParticipantSummaryBuilder? _prestataire;
  ParticipantSummaryBuilder get prestataire =>
      _$this._prestataire ??= ParticipantSummaryBuilder();
  set prestataire(ParticipantSummaryBuilder? prestataire) =>
      _$this._prestataire = prestataire;

  ParticipantSummaryBuilder? _tenant;
  ParticipantSummaryBuilder get tenant =>
      _$this._tenant ??= ParticipantSummaryBuilder();
  set tenant(ParticipantSummaryBuilder? tenant) => _$this._tenant = tenant;

  HomeSummaryStateEnum? _state;
  HomeSummaryStateEnum? get state => _$this._state;
  set state(HomeSummaryStateEnum? state) => _$this._state = state;

  int? _rent;
  int? get rent => _$this._rent;
  set rent(int? rent) => _$this._rent = rent;

  HomeSummaryRentalPeriodEnum? _rentalPeriod;
  HomeSummaryRentalPeriodEnum? get rentalPeriod => _$this._rentalPeriod;
  set rentalPeriod(HomeSummaryRentalPeriodEnum? rentalPeriod) =>
      _$this._rentalPeriod = rentalPeriod;

  bool? _chargesIncluded;
  bool? get chargesIncluded => _$this._chargesIncluded;
  set chargesIncluded(bool? chargesIncluded) =>
      _$this._chargesIncluded = chargesIncluded;

  int? _depositAmount;
  int? get depositAmount => _$this._depositAmount;
  set depositAmount(int? depositAmount) =>
      _$this._depositAmount = depositAmount;

  HomeDepositBuilder? _deposit;
  HomeDepositBuilder get deposit => _$this._deposit ??= HomeDepositBuilder();
  set deposit(HomeDepositBuilder? deposit) => _$this._deposit = deposit;

  Date? _startDate;
  Date? get startDate => _$this._startDate;
  set startDate(Date? startDate) => _$this._startDate = startDate;

  Date? _endDate;
  Date? get endDate => _$this._endDate;
  set endDate(Date? endDate) => _$this._endDate = endDate;

  bool? _tacitRenewal;
  bool? get tacitRenewal => _$this._tacitRenewal;
  set tacitRenewal(bool? tacitRenewal) => _$this._tacitRenewal = tacitRenewal;

  DueBuilder? _nextDue;
  DueBuilder get nextDue => _$this._nextDue ??= DueBuilder();
  set nextDue(DueBuilder? nextDue) => _$this._nextDue = nextDue;

  int? _overdueCount;
  int? get overdueCount => _$this._overdueCount;
  set overdueCount(int? overdueCount) => _$this._overdueCount = overdueCount;

  int? _overdueAmount;
  int? get overdueAmount => _$this._overdueAmount;
  set overdueAmount(int? overdueAmount) =>
      _$this._overdueAmount = overdueAmount;

  String? _residenceId;
  String? get residenceId => _$this._residenceId;
  set residenceId(String? residenceId) => _$this._residenceId = residenceId;

  String? _residenceName;
  String? get residenceName => _$this._residenceName;
  set residenceName(String? residenceName) =>
      _$this._residenceName = residenceName;

  HomeSummaryBuilder() {
    HomeSummary._defaults(this);
  }

  HomeSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _contractId = $v.contractId;
      _annonceId = $v.annonceId;
      _annonceTitle = $v.annonceTitle;
      _city = $v.city;
      _district = $v.district;
      _exactAddress = $v.exactAddress;
      _coverPhotoKey = $v.coverPhotoKey;
      _prestataire = $v.prestataire?.toBuilder();
      _tenant = $v.tenant?.toBuilder();
      _state = $v.state;
      _rent = $v.rent;
      _rentalPeriod = $v.rentalPeriod;
      _chargesIncluded = $v.chargesIncluded;
      _depositAmount = $v.depositAmount;
      _deposit = $v.deposit?.toBuilder();
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _tacitRenewal = $v.tacitRenewal;
      _nextDue = $v.nextDue?.toBuilder();
      _overdueCount = $v.overdueCount;
      _overdueAmount = $v.overdueAmount;
      _residenceId = $v.residenceId;
      _residenceName = $v.residenceName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeSummary other) {
    _$v = other as _$HomeSummary;
  }

  @override
  void update(void Function(HomeSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HomeSummary build() => _build();

  _$HomeSummary _build() {
    _$HomeSummary _$result;
    try {
      _$result =
          _$v ??
          _$HomeSummary._(
            contractId: contractId,
            annonceId: annonceId,
            annonceTitle: annonceTitle,
            city: city,
            district: district,
            exactAddress: exactAddress,
            coverPhotoKey: coverPhotoKey,
            prestataire: _prestataire?.build(),
            tenant: _tenant?.build(),
            state: state,
            rent: rent,
            rentalPeriod: rentalPeriod,
            chargesIncluded: chargesIncluded,
            depositAmount: depositAmount,
            deposit: _deposit?.build(),
            startDate: startDate,
            endDate: endDate,
            tacitRenewal: tacitRenewal,
            nextDue: _nextDue?.build(),
            overdueCount: overdueCount,
            overdueAmount: overdueAmount,
            residenceId: residenceId,
            residenceName: residenceName,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'prestataire';
        _prestataire?.build();
        _$failedField = 'tenant';
        _tenant?.build();

        _$failedField = 'deposit';
        _deposit?.build();

        _$failedField = 'nextDue';
        _nextDue?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HomeSummary',
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
