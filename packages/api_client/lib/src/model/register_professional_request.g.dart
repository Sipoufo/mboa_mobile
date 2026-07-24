// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_professional_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RegisterProfessionalRequestRoleEnum
_$registerProfessionalRequestRoleEnum_USER =
    const RegisterProfessionalRequestRoleEnum._('USER');
const RegisterProfessionalRequestRoleEnum
_$registerProfessionalRequestRoleEnum_PRESTATAIRE =
    const RegisterProfessionalRequestRoleEnum._('PRESTATAIRE');
const RegisterProfessionalRequestRoleEnum
_$registerProfessionalRequestRoleEnum_AGENT =
    const RegisterProfessionalRequestRoleEnum._('AGENT');
const RegisterProfessionalRequestRoleEnum
_$registerProfessionalRequestRoleEnum_ADMIN =
    const RegisterProfessionalRequestRoleEnum._('ADMIN');
const RegisterProfessionalRequestRoleEnum
_$registerProfessionalRequestRoleEnum_unknownDefaultOpenApi =
    const RegisterProfessionalRequestRoleEnum._('unknownDefaultOpenApi');

RegisterProfessionalRequestRoleEnum
_$registerProfessionalRequestRoleEnumValueOf(String name) {
  switch (name) {
    case 'USER':
      return _$registerProfessionalRequestRoleEnum_USER;
    case 'PRESTATAIRE':
      return _$registerProfessionalRequestRoleEnum_PRESTATAIRE;
    case 'AGENT':
      return _$registerProfessionalRequestRoleEnum_AGENT;
    case 'ADMIN':
      return _$registerProfessionalRequestRoleEnum_ADMIN;
    case 'unknownDefaultOpenApi':
      return _$registerProfessionalRequestRoleEnum_unknownDefaultOpenApi;
    default:
      return _$registerProfessionalRequestRoleEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RegisterProfessionalRequestRoleEnum>
_$registerProfessionalRequestRoleEnumValues =
    BuiltSet<RegisterProfessionalRequestRoleEnum>(
      const <RegisterProfessionalRequestRoleEnum>[
        _$registerProfessionalRequestRoleEnum_USER,
        _$registerProfessionalRequestRoleEnum_PRESTATAIRE,
        _$registerProfessionalRequestRoleEnum_AGENT,
        _$registerProfessionalRequestRoleEnum_ADMIN,
        _$registerProfessionalRequestRoleEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<RegisterProfessionalRequestRoleEnum>
_$registerProfessionalRequestRoleEnumSerializer =
    _$RegisterProfessionalRequestRoleEnumSerializer();

class _$RegisterProfessionalRequestRoleEnumSerializer
    implements PrimitiveSerializer<RegisterProfessionalRequestRoleEnum> {
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
  final Iterable<Type> types = const <Type>[
    RegisterProfessionalRequestRoleEnum,
  ];
  @override
  final String wireName = 'RegisterProfessionalRequestRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    RegisterProfessionalRequestRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  RegisterProfessionalRequestRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => RegisterProfessionalRequestRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$RegisterProfessionalRequest extends RegisterProfessionalRequest {
  @override
  final RegisterProfessionalRequestRoleEnum role;
  @override
  final String email;
  @override
  final String password;
  @override
  final String phoneNumber;

  factory _$RegisterProfessionalRequest([
    void Function(RegisterProfessionalRequestBuilder)? updates,
  ]) => (RegisterProfessionalRequestBuilder()..update(updates))._build();

  _$RegisterProfessionalRequest._({
    required this.role,
    required this.email,
    required this.password,
    required this.phoneNumber,
  }) : super._();
  @override
  RegisterProfessionalRequest rebuild(
    void Function(RegisterProfessionalRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  RegisterProfessionalRequestBuilder toBuilder() =>
      RegisterProfessionalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterProfessionalRequest &&
        role == other.role &&
        email == other.email &&
        password == other.password &&
        phoneNumber == other.phoneNumber;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RegisterProfessionalRequest')
          ..add('role', role)
          ..add('email', email)
          ..add('password', password)
          ..add('phoneNumber', phoneNumber))
        .toString();
  }
}

class RegisterProfessionalRequestBuilder
    implements
        Builder<
          RegisterProfessionalRequest,
          RegisterProfessionalRequestBuilder
        > {
  _$RegisterProfessionalRequest? _$v;

  RegisterProfessionalRequestRoleEnum? _role;
  RegisterProfessionalRequestRoleEnum? get role => _$this._role;
  set role(RegisterProfessionalRequestRoleEnum? role) => _$this._role = role;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  RegisterProfessionalRequestBuilder() {
    RegisterProfessionalRequest._defaults(this);
  }

  RegisterProfessionalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _role = $v.role;
      _email = $v.email;
      _password = $v.password;
      _phoneNumber = $v.phoneNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterProfessionalRequest other) {
    _$v = other as _$RegisterProfessionalRequest;
  }

  @override
  void update(void Function(RegisterProfessionalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegisterProfessionalRequest build() => _build();

  _$RegisterProfessionalRequest _build() {
    final _$result =
        _$v ??
        _$RegisterProfessionalRequest._(
          role: BuiltValueNullFieldError.checkNotNull(
            role,
            r'RegisterProfessionalRequest',
            'role',
          ),
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'RegisterProfessionalRequest',
            'email',
          ),
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'RegisterProfessionalRequest',
            'password',
          ),
          phoneNumber: BuiltValueNullFieldError.checkNotNull(
            phoneNumber,
            r'RegisterProfessionalRequest',
            'phoneNumber',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
