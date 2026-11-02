// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VerifyOtpRequest extends VerifyOtpRequest {
  @override
  final String? phoneNumber;
  @override
  final String? email;
  @override
  final String code;

  factory _$VerifyOtpRequest([
    void Function(VerifyOtpRequestBuilder)? updates,
  ]) => (VerifyOtpRequestBuilder()..update(updates))._build();

  _$VerifyOtpRequest._({this.phoneNumber, this.email, required this.code})
    : super._();
  @override
  VerifyOtpRequest rebuild(void Function(VerifyOtpRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerifyOtpRequestBuilder toBuilder() =>
      VerifyOtpRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyOtpRequest &&
        phoneNumber == other.phoneNumber &&
        email == other.email &&
        code == other.code;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerifyOtpRequest')
          ..add('phoneNumber', phoneNumber)
          ..add('email', email)
          ..add('code', code))
        .toString();
  }
}

class VerifyOtpRequestBuilder
    implements Builder<VerifyOtpRequest, VerifyOtpRequestBuilder> {
  _$VerifyOtpRequest? _$v;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  VerifyOtpRequestBuilder() {
    VerifyOtpRequest._defaults(this);
  }

  VerifyOtpRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phoneNumber = $v.phoneNumber;
      _email = $v.email;
      _code = $v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerifyOtpRequest other) {
    _$v = other as _$VerifyOtpRequest;
  }

  @override
  void update(void Function(VerifyOtpRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerifyOtpRequest build() => _build();

  _$VerifyOtpRequest _build() {
    final _$result =
        _$v ??
        _$VerifyOtpRequest._(
          phoneNumber: phoneNumber,
          email: email,
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'VerifyOtpRequest',
            'code',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
