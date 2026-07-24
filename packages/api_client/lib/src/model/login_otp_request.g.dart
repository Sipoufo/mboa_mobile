// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_otp_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginOtpRequest extends LoginOtpRequest {
  @override
  final String email;
  @override
  final String code;

  factory _$LoginOtpRequest([void Function(LoginOtpRequestBuilder)? updates]) =>
      (LoginOtpRequestBuilder()..update(updates))._build();

  _$LoginOtpRequest._({required this.email, required this.code}) : super._();
  @override
  LoginOtpRequest rebuild(void Function(LoginOtpRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginOtpRequestBuilder toBuilder() => LoginOtpRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginOtpRequest &&
        email == other.email &&
        code == other.code;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginOtpRequest')
          ..add('email', email)
          ..add('code', code))
        .toString();
  }
}

class LoginOtpRequestBuilder
    implements Builder<LoginOtpRequest, LoginOtpRequestBuilder> {
  _$LoginOtpRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  LoginOtpRequestBuilder() {
    LoginOtpRequest._defaults(this);
  }

  LoginOtpRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _code = $v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginOtpRequest other) {
    _$v = other as _$LoginOtpRequest;
  }

  @override
  void update(void Function(LoginOtpRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginOtpRequest build() => _build();

  _$LoginOtpRequest _build() {
    final _$result =
        _$v ??
        _$LoginOtpRequest._(
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'LoginOtpRequest',
            'email',
          ),
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'LoginOtpRequest',
            'code',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
