// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MeResponseRoleEnum _$meResponseRoleEnum_USER = const MeResponseRoleEnum._(
  'USER',
);
const MeResponseRoleEnum _$meResponseRoleEnum_PRESTATAIRE =
    const MeResponseRoleEnum._('PRESTATAIRE');
const MeResponseRoleEnum _$meResponseRoleEnum_AGENT =
    const MeResponseRoleEnum._('AGENT');
const MeResponseRoleEnum _$meResponseRoleEnum_ADMIN =
    const MeResponseRoleEnum._('ADMIN');
const MeResponseRoleEnum _$meResponseRoleEnum_unknownDefaultOpenApi =
    const MeResponseRoleEnum._('unknownDefaultOpenApi');

MeResponseRoleEnum _$meResponseRoleEnumValueOf(String name) {
  switch (name) {
    case 'USER':
      return _$meResponseRoleEnum_USER;
    case 'PRESTATAIRE':
      return _$meResponseRoleEnum_PRESTATAIRE;
    case 'AGENT':
      return _$meResponseRoleEnum_AGENT;
    case 'ADMIN':
      return _$meResponseRoleEnum_ADMIN;
    case 'unknownDefaultOpenApi':
      return _$meResponseRoleEnum_unknownDefaultOpenApi;
    default:
      return _$meResponseRoleEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MeResponseRoleEnum> _$meResponseRoleEnumValues =
    BuiltSet<MeResponseRoleEnum>(const <MeResponseRoleEnum>[
      _$meResponseRoleEnum_USER,
      _$meResponseRoleEnum_PRESTATAIRE,
      _$meResponseRoleEnum_AGENT,
      _$meResponseRoleEnum_ADMIN,
      _$meResponseRoleEnum_unknownDefaultOpenApi,
    ]);

const MeResponseStatusEnum _$meResponseStatusEnum_PENDING =
    const MeResponseStatusEnum._('PENDING');
const MeResponseStatusEnum _$meResponseStatusEnum_ACTIVE =
    const MeResponseStatusEnum._('ACTIVE');
const MeResponseStatusEnum _$meResponseStatusEnum_SUSPENDED =
    const MeResponseStatusEnum._('SUSPENDED');
const MeResponseStatusEnum _$meResponseStatusEnum_DELETED =
    const MeResponseStatusEnum._('DELETED');
const MeResponseStatusEnum _$meResponseStatusEnum_unknownDefaultOpenApi =
    const MeResponseStatusEnum._('unknownDefaultOpenApi');

MeResponseStatusEnum _$meResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'PENDING':
      return _$meResponseStatusEnum_PENDING;
    case 'ACTIVE':
      return _$meResponseStatusEnum_ACTIVE;
    case 'SUSPENDED':
      return _$meResponseStatusEnum_SUSPENDED;
    case 'DELETED':
      return _$meResponseStatusEnum_DELETED;
    case 'unknownDefaultOpenApi':
      return _$meResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$meResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MeResponseStatusEnum> _$meResponseStatusEnumValues =
    BuiltSet<MeResponseStatusEnum>(const <MeResponseStatusEnum>[
      _$meResponseStatusEnum_PENDING,
      _$meResponseStatusEnum_ACTIVE,
      _$meResponseStatusEnum_SUSPENDED,
      _$meResponseStatusEnum_DELETED,
      _$meResponseStatusEnum_unknownDefaultOpenApi,
    ]);

const MeResponseAuthProviderEnum _$meResponseAuthProviderEnum_PHONE =
    const MeResponseAuthProviderEnum._('PHONE');
const MeResponseAuthProviderEnum _$meResponseAuthProviderEnum_GOOGLE =
    const MeResponseAuthProviderEnum._('GOOGLE');
const MeResponseAuthProviderEnum _$meResponseAuthProviderEnum_APPLE =
    const MeResponseAuthProviderEnum._('APPLE');
const MeResponseAuthProviderEnum
_$meResponseAuthProviderEnum_unknownDefaultOpenApi =
    const MeResponseAuthProviderEnum._('unknownDefaultOpenApi');

MeResponseAuthProviderEnum _$meResponseAuthProviderEnumValueOf(String name) {
  switch (name) {
    case 'PHONE':
      return _$meResponseAuthProviderEnum_PHONE;
    case 'GOOGLE':
      return _$meResponseAuthProviderEnum_GOOGLE;
    case 'APPLE':
      return _$meResponseAuthProviderEnum_APPLE;
    case 'unknownDefaultOpenApi':
      return _$meResponseAuthProviderEnum_unknownDefaultOpenApi;
    default:
      return _$meResponseAuthProviderEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MeResponseAuthProviderEnum> _$meResponseAuthProviderEnumValues =
    BuiltSet<MeResponseAuthProviderEnum>(const <MeResponseAuthProviderEnum>[
      _$meResponseAuthProviderEnum_PHONE,
      _$meResponseAuthProviderEnum_GOOGLE,
      _$meResponseAuthProviderEnum_APPLE,
      _$meResponseAuthProviderEnum_unknownDefaultOpenApi,
    ]);

const MeResponseTierEnum _$meResponseTierEnum_FREE = const MeResponseTierEnum._(
  'FREE',
);
const MeResponseTierEnum _$meResponseTierEnum_BASIC_PLUS =
    const MeResponseTierEnum._('BASIC_PLUS');
const MeResponseTierEnum _$meResponseTierEnum_PRO = const MeResponseTierEnum._(
  'PRO',
);
const MeResponseTierEnum _$meResponseTierEnum_PRO_PLUS =
    const MeResponseTierEnum._('PRO_PLUS');
const MeResponseTierEnum _$meResponseTierEnum_unknownDefaultOpenApi =
    const MeResponseTierEnum._('unknownDefaultOpenApi');

MeResponseTierEnum _$meResponseTierEnumValueOf(String name) {
  switch (name) {
    case 'FREE':
      return _$meResponseTierEnum_FREE;
    case 'BASIC_PLUS':
      return _$meResponseTierEnum_BASIC_PLUS;
    case 'PRO':
      return _$meResponseTierEnum_PRO;
    case 'PRO_PLUS':
      return _$meResponseTierEnum_PRO_PLUS;
    case 'unknownDefaultOpenApi':
      return _$meResponseTierEnum_unknownDefaultOpenApi;
    default:
      return _$meResponseTierEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MeResponseTierEnum> _$meResponseTierEnumValues =
    BuiltSet<MeResponseTierEnum>(const <MeResponseTierEnum>[
      _$meResponseTierEnum_FREE,
      _$meResponseTierEnum_BASIC_PLUS,
      _$meResponseTierEnum_PRO,
      _$meResponseTierEnum_PRO_PLUS,
      _$meResponseTierEnum_unknownDefaultOpenApi,
    ]);

Serializer<MeResponseRoleEnum> _$meResponseRoleEnumSerializer =
    _$MeResponseRoleEnumSerializer();
Serializer<MeResponseStatusEnum> _$meResponseStatusEnumSerializer =
    _$MeResponseStatusEnumSerializer();
Serializer<MeResponseAuthProviderEnum> _$meResponseAuthProviderEnumSerializer =
    _$MeResponseAuthProviderEnumSerializer();
Serializer<MeResponseTierEnum> _$meResponseTierEnumSerializer =
    _$MeResponseTierEnumSerializer();

class _$MeResponseRoleEnumSerializer
    implements PrimitiveSerializer<MeResponseRoleEnum> {
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
  final Iterable<Type> types = const <Type>[MeResponseRoleEnum];
  @override
  final String wireName = 'MeResponseRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    MeResponseRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  MeResponseRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => MeResponseRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$MeResponseStatusEnumSerializer
    implements PrimitiveSerializer<MeResponseStatusEnum> {
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
  final Iterable<Type> types = const <Type>[MeResponseStatusEnum];
  @override
  final String wireName = 'MeResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    MeResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  MeResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => MeResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$MeResponseAuthProviderEnumSerializer
    implements PrimitiveSerializer<MeResponseAuthProviderEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PHONE': 'PHONE',
    'GOOGLE': 'GOOGLE',
    'APPLE': 'APPLE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PHONE': 'PHONE',
    'GOOGLE': 'GOOGLE',
    'APPLE': 'APPLE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[MeResponseAuthProviderEnum];
  @override
  final String wireName = 'MeResponseAuthProviderEnum';

  @override
  Object serialize(
    Serializers serializers,
    MeResponseAuthProviderEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  MeResponseAuthProviderEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => MeResponseAuthProviderEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$MeResponseTierEnumSerializer
    implements PrimitiveSerializer<MeResponseTierEnum> {
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
  final Iterable<Type> types = const <Type>[MeResponseTierEnum];
  @override
  final String wireName = 'MeResponseTierEnum';

  @override
  Object serialize(
    Serializers serializers,
    MeResponseTierEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  MeResponseTierEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => MeResponseTierEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$MeResponse extends MeResponse {
  @override
  final String? id;
  @override
  final String? phoneNumber;
  @override
  final String? email;
  @override
  final MeResponseRoleEnum? role;
  @override
  final MeResponseStatusEnum? status;
  @override
  final MeResponseAuthProviderEnum? authProvider;
  @override
  final bool? emailVerified;
  @override
  final MeResponseTierEnum? tier;
  @override
  final DateTime? createdAt;

  factory _$MeResponse([void Function(MeResponseBuilder)? updates]) =>
      (MeResponseBuilder()..update(updates))._build();

  _$MeResponse._({
    this.id,
    this.phoneNumber,
    this.email,
    this.role,
    this.status,
    this.authProvider,
    this.emailVerified,
    this.tier,
    this.createdAt,
  }) : super._();
  @override
  MeResponse rebuild(void Function(MeResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MeResponseBuilder toBuilder() => MeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MeResponse &&
        id == other.id &&
        phoneNumber == other.phoneNumber &&
        email == other.email &&
        role == other.role &&
        status == other.status &&
        authProvider == other.authProvider &&
        emailVerified == other.emailVerified &&
        tier == other.tier &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, authProvider.hashCode);
    _$hash = $jc(_$hash, emailVerified.hashCode);
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MeResponse')
          ..add('id', id)
          ..add('phoneNumber', phoneNumber)
          ..add('email', email)
          ..add('role', role)
          ..add('status', status)
          ..add('authProvider', authProvider)
          ..add('emailVerified', emailVerified)
          ..add('tier', tier)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class MeResponseBuilder implements Builder<MeResponse, MeResponseBuilder> {
  _$MeResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  MeResponseRoleEnum? _role;
  MeResponseRoleEnum? get role => _$this._role;
  set role(MeResponseRoleEnum? role) => _$this._role = role;

  MeResponseStatusEnum? _status;
  MeResponseStatusEnum? get status => _$this._status;
  set status(MeResponseStatusEnum? status) => _$this._status = status;

  MeResponseAuthProviderEnum? _authProvider;
  MeResponseAuthProviderEnum? get authProvider => _$this._authProvider;
  set authProvider(MeResponseAuthProviderEnum? authProvider) =>
      _$this._authProvider = authProvider;

  bool? _emailVerified;
  bool? get emailVerified => _$this._emailVerified;
  set emailVerified(bool? emailVerified) =>
      _$this._emailVerified = emailVerified;

  MeResponseTierEnum? _tier;
  MeResponseTierEnum? get tier => _$this._tier;
  set tier(MeResponseTierEnum? tier) => _$this._tier = tier;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  MeResponseBuilder() {
    MeResponse._defaults(this);
  }

  MeResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _phoneNumber = $v.phoneNumber;
      _email = $v.email;
      _role = $v.role;
      _status = $v.status;
      _authProvider = $v.authProvider;
      _emailVerified = $v.emailVerified;
      _tier = $v.tier;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MeResponse other) {
    _$v = other as _$MeResponse;
  }

  @override
  void update(void Function(MeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MeResponse build() => _build();

  _$MeResponse _build() {
    final _$result =
        _$v ??
        _$MeResponse._(
          id: id,
          phoneNumber: phoneNumber,
          email: email,
          role: role,
          status: status,
          authProvider: authProvider,
          emailVerified: emailVerified,
          tier: tier,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
