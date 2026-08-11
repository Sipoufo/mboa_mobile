// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdminUserSummaryRoleEnum _$adminUserSummaryRoleEnum_USER =
    const AdminUserSummaryRoleEnum._('USER');
const AdminUserSummaryRoleEnum _$adminUserSummaryRoleEnum_PRESTATAIRE =
    const AdminUserSummaryRoleEnum._('PRESTATAIRE');
const AdminUserSummaryRoleEnum _$adminUserSummaryRoleEnum_AGENT =
    const AdminUserSummaryRoleEnum._('AGENT');
const AdminUserSummaryRoleEnum _$adminUserSummaryRoleEnum_ADMIN =
    const AdminUserSummaryRoleEnum._('ADMIN');
const AdminUserSummaryRoleEnum
_$adminUserSummaryRoleEnum_unknownDefaultOpenApi =
    const AdminUserSummaryRoleEnum._('unknownDefaultOpenApi');

AdminUserSummaryRoleEnum _$adminUserSummaryRoleEnumValueOf(String name) {
  switch (name) {
    case 'USER':
      return _$adminUserSummaryRoleEnum_USER;
    case 'PRESTATAIRE':
      return _$adminUserSummaryRoleEnum_PRESTATAIRE;
    case 'AGENT':
      return _$adminUserSummaryRoleEnum_AGENT;
    case 'ADMIN':
      return _$adminUserSummaryRoleEnum_ADMIN;
    case 'unknownDefaultOpenApi':
      return _$adminUserSummaryRoleEnum_unknownDefaultOpenApi;
    default:
      return _$adminUserSummaryRoleEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminUserSummaryRoleEnum> _$adminUserSummaryRoleEnumValues =
    BuiltSet<AdminUserSummaryRoleEnum>(const <AdminUserSummaryRoleEnum>[
      _$adminUserSummaryRoleEnum_USER,
      _$adminUserSummaryRoleEnum_PRESTATAIRE,
      _$adminUserSummaryRoleEnum_AGENT,
      _$adminUserSummaryRoleEnum_ADMIN,
      _$adminUserSummaryRoleEnum_unknownDefaultOpenApi,
    ]);

const AdminUserSummaryStatusEnum _$adminUserSummaryStatusEnum_PENDING =
    const AdminUserSummaryStatusEnum._('PENDING');
const AdminUserSummaryStatusEnum _$adminUserSummaryStatusEnum_ACTIVE =
    const AdminUserSummaryStatusEnum._('ACTIVE');
const AdminUserSummaryStatusEnum _$adminUserSummaryStatusEnum_SUSPENDED =
    const AdminUserSummaryStatusEnum._('SUSPENDED');
const AdminUserSummaryStatusEnum _$adminUserSummaryStatusEnum_DELETED =
    const AdminUserSummaryStatusEnum._('DELETED');
const AdminUserSummaryStatusEnum
_$adminUserSummaryStatusEnum_unknownDefaultOpenApi =
    const AdminUserSummaryStatusEnum._('unknownDefaultOpenApi');

AdminUserSummaryStatusEnum _$adminUserSummaryStatusEnumValueOf(String name) {
  switch (name) {
    case 'PENDING':
      return _$adminUserSummaryStatusEnum_PENDING;
    case 'ACTIVE':
      return _$adminUserSummaryStatusEnum_ACTIVE;
    case 'SUSPENDED':
      return _$adminUserSummaryStatusEnum_SUSPENDED;
    case 'DELETED':
      return _$adminUserSummaryStatusEnum_DELETED;
    case 'unknownDefaultOpenApi':
      return _$adminUserSummaryStatusEnum_unknownDefaultOpenApi;
    default:
      return _$adminUserSummaryStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminUserSummaryStatusEnum> _$adminUserSummaryStatusEnumValues =
    BuiltSet<AdminUserSummaryStatusEnum>(const <AdminUserSummaryStatusEnum>[
      _$adminUserSummaryStatusEnum_PENDING,
      _$adminUserSummaryStatusEnum_ACTIVE,
      _$adminUserSummaryStatusEnum_SUSPENDED,
      _$adminUserSummaryStatusEnum_DELETED,
      _$adminUserSummaryStatusEnum_unknownDefaultOpenApi,
    ]);

const AdminUserSummaryTierEnum _$adminUserSummaryTierEnum_FREE =
    const AdminUserSummaryTierEnum._('FREE');
const AdminUserSummaryTierEnum _$adminUserSummaryTierEnum_BASIC_PLUS =
    const AdminUserSummaryTierEnum._('BASIC_PLUS');
const AdminUserSummaryTierEnum _$adminUserSummaryTierEnum_PRO =
    const AdminUserSummaryTierEnum._('PRO');
const AdminUserSummaryTierEnum _$adminUserSummaryTierEnum_PRO_PLUS =
    const AdminUserSummaryTierEnum._('PRO_PLUS');
const AdminUserSummaryTierEnum
_$adminUserSummaryTierEnum_unknownDefaultOpenApi =
    const AdminUserSummaryTierEnum._('unknownDefaultOpenApi');

AdminUserSummaryTierEnum _$adminUserSummaryTierEnumValueOf(String name) {
  switch (name) {
    case 'FREE':
      return _$adminUserSummaryTierEnum_FREE;
    case 'BASIC_PLUS':
      return _$adminUserSummaryTierEnum_BASIC_PLUS;
    case 'PRO':
      return _$adminUserSummaryTierEnum_PRO;
    case 'PRO_PLUS':
      return _$adminUserSummaryTierEnum_PRO_PLUS;
    case 'unknownDefaultOpenApi':
      return _$adminUserSummaryTierEnum_unknownDefaultOpenApi;
    default:
      return _$adminUserSummaryTierEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminUserSummaryTierEnum> _$adminUserSummaryTierEnumValues =
    BuiltSet<AdminUserSummaryTierEnum>(const <AdminUserSummaryTierEnum>[
      _$adminUserSummaryTierEnum_FREE,
      _$adminUserSummaryTierEnum_BASIC_PLUS,
      _$adminUserSummaryTierEnum_PRO,
      _$adminUserSummaryTierEnum_PRO_PLUS,
      _$adminUserSummaryTierEnum_unknownDefaultOpenApi,
    ]);

Serializer<AdminUserSummaryRoleEnum> _$adminUserSummaryRoleEnumSerializer =
    _$AdminUserSummaryRoleEnumSerializer();
Serializer<AdminUserSummaryStatusEnum> _$adminUserSummaryStatusEnumSerializer =
    _$AdminUserSummaryStatusEnumSerializer();
Serializer<AdminUserSummaryTierEnum> _$adminUserSummaryTierEnumSerializer =
    _$AdminUserSummaryTierEnumSerializer();

class _$AdminUserSummaryRoleEnumSerializer
    implements PrimitiveSerializer<AdminUserSummaryRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USER': 'USER',
    'PRESTATAIRE': 'PRESTATAIRE',
    'AGENT': 'AGENT',
    'ADMIN': 'ADMIN',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USER': 'USER',
    'PRESTATAIRE': 'PRESTATAIRE',
    'AGENT': 'AGENT',
    'ADMIN': 'ADMIN',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AdminUserSummaryRoleEnum];
  @override
  final String wireName = 'AdminUserSummaryRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminUserSummaryRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminUserSummaryRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminUserSummaryRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminUserSummaryStatusEnumSerializer
    implements PrimitiveSerializer<AdminUserSummaryStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
    'ACTIVE': 'ACTIVE',
    'SUSPENDED': 'SUSPENDED',
    'DELETED': 'DELETED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
    'ACTIVE': 'ACTIVE',
    'SUSPENDED': 'SUSPENDED',
    'DELETED': 'DELETED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AdminUserSummaryStatusEnum];
  @override
  final String wireName = 'AdminUserSummaryStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminUserSummaryStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminUserSummaryStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminUserSummaryStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminUserSummaryTierEnumSerializer
    implements PrimitiveSerializer<AdminUserSummaryTierEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'FREE': 'FREE',
    'BASIC_PLUS': 'BASIC_PLUS',
    'PRO': 'PRO',
    'PRO_PLUS': 'PRO_PLUS',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'FREE': 'FREE',
    'BASIC_PLUS': 'BASIC_PLUS',
    'PRO': 'PRO',
    'PRO_PLUS': 'PRO_PLUS',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AdminUserSummaryTierEnum];
  @override
  final String wireName = 'AdminUserSummaryTierEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminUserSummaryTierEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminUserSummaryTierEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminUserSummaryTierEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminUserSummary extends AdminUserSummary {
  @override
  final String? accountId;
  @override
  final String? displayName;
  @override
  final String? phoneNumber;
  @override
  final String? email;
  @override
  final AdminUserSummaryRoleEnum? role;
  @override
  final AdminUserSummaryStatusEnum? status;
  @override
  final AdminUserSummaryTierEnum? tier;
  @override
  final DateTime? periodEnd;
  @override
  final int? listingCount;
  @override
  final DateTime? createdAt;

  factory _$AdminUserSummary([
    void Function(AdminUserSummaryBuilder)? updates,
  ]) => (AdminUserSummaryBuilder()..update(updates))._build();

  _$AdminUserSummary._({
    this.accountId,
    this.displayName,
    this.phoneNumber,
    this.email,
    this.role,
    this.status,
    this.tier,
    this.periodEnd,
    this.listingCount,
    this.createdAt,
  }) : super._();
  @override
  AdminUserSummary rebuild(void Function(AdminUserSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdminUserSummaryBuilder toBuilder() =>
      AdminUserSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminUserSummary &&
        accountId == other.accountId &&
        displayName == other.displayName &&
        phoneNumber == other.phoneNumber &&
        email == other.email &&
        role == other.role &&
        status == other.status &&
        tier == other.tier &&
        periodEnd == other.periodEnd &&
        listingCount == other.listingCount &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, periodEnd.hashCode);
    _$hash = $jc(_$hash, listingCount.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminUserSummary')
          ..add('accountId', accountId)
          ..add('displayName', displayName)
          ..add('phoneNumber', phoneNumber)
          ..add('email', email)
          ..add('role', role)
          ..add('status', status)
          ..add('tier', tier)
          ..add('periodEnd', periodEnd)
          ..add('listingCount', listingCount)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class AdminUserSummaryBuilder
    implements Builder<AdminUserSummary, AdminUserSummaryBuilder> {
  _$AdminUserSummary? _$v;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  AdminUserSummaryRoleEnum? _role;
  AdminUserSummaryRoleEnum? get role => _$this._role;
  set role(AdminUserSummaryRoleEnum? role) => _$this._role = role;

  AdminUserSummaryStatusEnum? _status;
  AdminUserSummaryStatusEnum? get status => _$this._status;
  set status(AdminUserSummaryStatusEnum? status) => _$this._status = status;

  AdminUserSummaryTierEnum? _tier;
  AdminUserSummaryTierEnum? get tier => _$this._tier;
  set tier(AdminUserSummaryTierEnum? tier) => _$this._tier = tier;

  DateTime? _periodEnd;
  DateTime? get periodEnd => _$this._periodEnd;
  set periodEnd(DateTime? periodEnd) => _$this._periodEnd = periodEnd;

  int? _listingCount;
  int? get listingCount => _$this._listingCount;
  set listingCount(int? listingCount) => _$this._listingCount = listingCount;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  AdminUserSummaryBuilder() {
    AdminUserSummary._defaults(this);
  }

  AdminUserSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountId = $v.accountId;
      _displayName = $v.displayName;
      _phoneNumber = $v.phoneNumber;
      _email = $v.email;
      _role = $v.role;
      _status = $v.status;
      _tier = $v.tier;
      _periodEnd = $v.periodEnd;
      _listingCount = $v.listingCount;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminUserSummary other) {
    _$v = other as _$AdminUserSummary;
  }

  @override
  void update(void Function(AdminUserSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminUserSummary build() => _build();

  _$AdminUserSummary _build() {
    final _$result =
        _$v ??
        _$AdminUserSummary._(
          accountId: accountId,
          displayName: displayName,
          phoneNumber: phoneNumber,
          email: email,
          role: role,
          status: status,
          tier: tier,
          periodEnd: periodEnd,
          listingCount: listingCount,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
