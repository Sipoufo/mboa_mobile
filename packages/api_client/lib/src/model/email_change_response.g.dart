// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_change_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EmailChangeResponse extends EmailChangeResponse {
  @override
  final String? email;

  factory _$EmailChangeResponse([
    void Function(EmailChangeResponseBuilder)? updates,
  ]) => (EmailChangeResponseBuilder()..update(updates))._build();

  _$EmailChangeResponse._({this.email}) : super._();
  @override
  EmailChangeResponse rebuild(
    void Function(EmailChangeResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EmailChangeResponseBuilder toBuilder() =>
      EmailChangeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EmailChangeResponse && email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'EmailChangeResponse',
    )..add('email', email)).toString();
  }
}

class EmailChangeResponseBuilder
    implements Builder<EmailChangeResponse, EmailChangeResponseBuilder> {
  _$EmailChangeResponse? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  EmailChangeResponseBuilder() {
    EmailChangeResponse._defaults(this);
  }

  EmailChangeResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EmailChangeResponse other) {
    _$v = other as _$EmailChangeResponse;
  }

  @override
  void update(void Function(EmailChangeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EmailChangeResponse build() => _build();

  _$EmailChangeResponse _build() {
    final _$result = _$v ?? _$EmailChangeResponse._(email: email);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
