// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendOtpRequest extends SendOtpRequest {
  @override
  final String? phoneNumber;
  @override
  final String? email;

  factory _$SendOtpRequest([void Function(SendOtpRequestBuilder)? updates]) =>
      (SendOtpRequestBuilder()..update(updates))._build();

  _$SendOtpRequest._({this.phoneNumber, this.email}) : super._();
  @override
  SendOtpRequest rebuild(void Function(SendOtpRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendOtpRequestBuilder toBuilder() => SendOtpRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendOtpRequest &&
        phoneNumber == other.phoneNumber &&
        email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SendOtpRequest')
          ..add('phoneNumber', phoneNumber)
          ..add('email', email))
        .toString();
  }
}

class SendOtpRequestBuilder
    implements Builder<SendOtpRequest, SendOtpRequestBuilder> {
  _$SendOtpRequest? _$v;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  SendOtpRequestBuilder() {
    SendOtpRequest._defaults(this);
  }

  SendOtpRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phoneNumber = $v.phoneNumber;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendOtpRequest other) {
    _$v = other as _$SendOtpRequest;
  }

  @override
  void update(void Function(SendOtpRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendOtpRequest build() => _build();

  _$SendOtpRequest _build() {
    final _$result =
        _$v ?? _$SendOtpRequest._(phoneNumber: phoneNumber, email: email);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
