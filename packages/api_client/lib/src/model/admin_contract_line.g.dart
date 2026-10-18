// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_contract_line.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdminContractLineStatusEnum _$adminContractLineStatusEnum_DRAFT =
    const AdminContractLineStatusEnum._('DRAFT');
const AdminContractLineStatusEnum _$adminContractLineStatusEnum_SENT =
    const AdminContractLineStatusEnum._('SENT');
const AdminContractLineStatusEnum
_$adminContractLineStatusEnum_CHANGES_REQUESTED =
    const AdminContractLineStatusEnum._('CHANGES_REQUESTED');
const AdminContractLineStatusEnum _$adminContractLineStatusEnum_ACCEPTED =
    const AdminContractLineStatusEnum._('ACCEPTED');
const AdminContractLineStatusEnum _$adminContractLineStatusEnum_SIGNED =
    const AdminContractLineStatusEnum._('SIGNED');
const AdminContractLineStatusEnum _$adminContractLineStatusEnum_CANCELLED =
    const AdminContractLineStatusEnum._('CANCELLED');
const AdminContractLineStatusEnum
_$adminContractLineStatusEnum_unknownDefaultOpenApi =
    const AdminContractLineStatusEnum._('unknownDefaultOpenApi');

AdminContractLineStatusEnum _$adminContractLineStatusEnumValueOf(String name) {
  switch (name) {
    case 'DRAFT':
      return _$adminContractLineStatusEnum_DRAFT;
    case 'SENT':
      return _$adminContractLineStatusEnum_SENT;
    case 'CHANGES_REQUESTED':
      return _$adminContractLineStatusEnum_CHANGES_REQUESTED;
    case 'ACCEPTED':
      return _$adminContractLineStatusEnum_ACCEPTED;
    case 'SIGNED':
      return _$adminContractLineStatusEnum_SIGNED;
    case 'CANCELLED':
      return _$adminContractLineStatusEnum_CANCELLED;
    case 'unknownDefaultOpenApi':
      return _$adminContractLineStatusEnum_unknownDefaultOpenApi;
    default:
      return _$adminContractLineStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminContractLineStatusEnum>
_$adminContractLineStatusEnumValues =
    BuiltSet<AdminContractLineStatusEnum>(const <AdminContractLineStatusEnum>[
      _$adminContractLineStatusEnum_DRAFT,
      _$adminContractLineStatusEnum_SENT,
      _$adminContractLineStatusEnum_CHANGES_REQUESTED,
      _$adminContractLineStatusEnum_ACCEPTED,
      _$adminContractLineStatusEnum_SIGNED,
      _$adminContractLineStatusEnum_CANCELLED,
      _$adminContractLineStatusEnum_unknownDefaultOpenApi,
    ]);

const AdminContractLineRentalPeriodEnum
_$adminContractLineRentalPeriodEnum_DAY =
    const AdminContractLineRentalPeriodEnum._('DAY');
const AdminContractLineRentalPeriodEnum
_$adminContractLineRentalPeriodEnum_WEEK =
    const AdminContractLineRentalPeriodEnum._('WEEK');
const AdminContractLineRentalPeriodEnum
_$adminContractLineRentalPeriodEnum_MONTH =
    const AdminContractLineRentalPeriodEnum._('MONTH');
const AdminContractLineRentalPeriodEnum
_$adminContractLineRentalPeriodEnum_QUARTER =
    const AdminContractLineRentalPeriodEnum._('QUARTER');
const AdminContractLineRentalPeriodEnum
_$adminContractLineRentalPeriodEnum_YEAR =
    const AdminContractLineRentalPeriodEnum._('YEAR');
const AdminContractLineRentalPeriodEnum
_$adminContractLineRentalPeriodEnum_unknownDefaultOpenApi =
    const AdminContractLineRentalPeriodEnum._('unknownDefaultOpenApi');

AdminContractLineRentalPeriodEnum _$adminContractLineRentalPeriodEnumValueOf(
  String name,
) {
  switch (name) {
    case 'DAY':
      return _$adminContractLineRentalPeriodEnum_DAY;
    case 'WEEK':
      return _$adminContractLineRentalPeriodEnum_WEEK;
    case 'MONTH':
      return _$adminContractLineRentalPeriodEnum_MONTH;
    case 'QUARTER':
      return _$adminContractLineRentalPeriodEnum_QUARTER;
    case 'YEAR':
      return _$adminContractLineRentalPeriodEnum_YEAR;
    case 'unknownDefaultOpenApi':
      return _$adminContractLineRentalPeriodEnum_unknownDefaultOpenApi;
    default:
      return _$adminContractLineRentalPeriodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminContractLineRentalPeriodEnum>
_$adminContractLineRentalPeriodEnumValues =
    BuiltSet<AdminContractLineRentalPeriodEnum>(
      const <AdminContractLineRentalPeriodEnum>[
        _$adminContractLineRentalPeriodEnum_DAY,
        _$adminContractLineRentalPeriodEnum_WEEK,
        _$adminContractLineRentalPeriodEnum_MONTH,
        _$adminContractLineRentalPeriodEnum_QUARTER,
        _$adminContractLineRentalPeriodEnum_YEAR,
        _$adminContractLineRentalPeriodEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<AdminContractLineStatusEnum>
_$adminContractLineStatusEnumSerializer =
    _$AdminContractLineStatusEnumSerializer();
Serializer<AdminContractLineRentalPeriodEnum>
_$adminContractLineRentalPeriodEnumSerializer =
    _$AdminContractLineRentalPeriodEnumSerializer();

class _$AdminContractLineStatusEnumSerializer
    implements PrimitiveSerializer<AdminContractLineStatusEnum> {
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
  final Iterable<Type> types = const <Type>[AdminContractLineStatusEnum];
  @override
  final String wireName = 'AdminContractLineStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminContractLineStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminContractLineStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminContractLineStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminContractLineRentalPeriodEnumSerializer
    implements PrimitiveSerializer<AdminContractLineRentalPeriodEnum> {
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
  final Iterable<Type> types = const <Type>[AdminContractLineRentalPeriodEnum];
  @override
  final String wireName = 'AdminContractLineRentalPeriodEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminContractLineRentalPeriodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminContractLineRentalPeriodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminContractLineRentalPeriodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminContractLine extends AdminContractLine {
  @override
  final String? contractId;
  @override
  final String? annonceId;
  @override
  final String? annonceTitle;
  @override
  final AdminContractLineStatusEnum? status;
  @override
  final Date? startDate;
  @override
  final int? durationUnits;
  @override
  final AdminContractLineRentalPeriodEnum? rentalPeriod;
  @override
  final DateTime? signedAt;
  @override
  final DateTime? createdAt;

  factory _$AdminContractLine([
    void Function(AdminContractLineBuilder)? updates,
  ]) => (AdminContractLineBuilder()..update(updates))._build();

  _$AdminContractLine._({
    this.contractId,
    this.annonceId,
    this.annonceTitle,
    this.status,
    this.startDate,
    this.durationUnits,
    this.rentalPeriod,
    this.signedAt,
    this.createdAt,
  }) : super._();
  @override
  AdminContractLine rebuild(void Function(AdminContractLineBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdminContractLineBuilder toBuilder() =>
      AdminContractLineBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminContractLine &&
        contractId == other.contractId &&
        annonceId == other.annonceId &&
        annonceTitle == other.annonceTitle &&
        status == other.status &&
        startDate == other.startDate &&
        durationUnits == other.durationUnits &&
        rentalPeriod == other.rentalPeriod &&
        signedAt == other.signedAt &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, contractId.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, annonceTitle.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, durationUnits.hashCode);
    _$hash = $jc(_$hash, rentalPeriod.hashCode);
    _$hash = $jc(_$hash, signedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminContractLine')
          ..add('contractId', contractId)
          ..add('annonceId', annonceId)
          ..add('annonceTitle', annonceTitle)
          ..add('status', status)
          ..add('startDate', startDate)
          ..add('durationUnits', durationUnits)
          ..add('rentalPeriod', rentalPeriod)
          ..add('signedAt', signedAt)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class AdminContractLineBuilder
    implements Builder<AdminContractLine, AdminContractLineBuilder> {
  _$AdminContractLine? _$v;

  String? _contractId;
  String? get contractId => _$this._contractId;
  set contractId(String? contractId) => _$this._contractId = contractId;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _annonceTitle;
  String? get annonceTitle => _$this._annonceTitle;
  set annonceTitle(String? annonceTitle) => _$this._annonceTitle = annonceTitle;

  AdminContractLineStatusEnum? _status;
  AdminContractLineStatusEnum? get status => _$this._status;
  set status(AdminContractLineStatusEnum? status) => _$this._status = status;

  Date? _startDate;
  Date? get startDate => _$this._startDate;
  set startDate(Date? startDate) => _$this._startDate = startDate;

  int? _durationUnits;
  int? get durationUnits => _$this._durationUnits;
  set durationUnits(int? durationUnits) =>
      _$this._durationUnits = durationUnits;

  AdminContractLineRentalPeriodEnum? _rentalPeriod;
  AdminContractLineRentalPeriodEnum? get rentalPeriod => _$this._rentalPeriod;
  set rentalPeriod(AdminContractLineRentalPeriodEnum? rentalPeriod) =>
      _$this._rentalPeriod = rentalPeriod;

  DateTime? _signedAt;
  DateTime? get signedAt => _$this._signedAt;
  set signedAt(DateTime? signedAt) => _$this._signedAt = signedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  AdminContractLineBuilder() {
    AdminContractLine._defaults(this);
  }

  AdminContractLineBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _contractId = $v.contractId;
      _annonceId = $v.annonceId;
      _annonceTitle = $v.annonceTitle;
      _status = $v.status;
      _startDate = $v.startDate;
      _durationUnits = $v.durationUnits;
      _rentalPeriod = $v.rentalPeriod;
      _signedAt = $v.signedAt;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminContractLine other) {
    _$v = other as _$AdminContractLine;
  }

  @override
  void update(void Function(AdminContractLineBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminContractLine build() => _build();

  _$AdminContractLine _build() {
    final _$result =
        _$v ??
        _$AdminContractLine._(
          contractId: contractId,
          annonceId: annonceId,
          annonceTitle: annonceTitle,
          status: status,
          startDate: startDate,
          durationUnits: durationUnits,
          rentalPeriod: rentalPeriod,
          signedAt: signedAt,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
