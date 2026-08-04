// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_change_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PhoneChangeResponse extends PhoneChangeResponse {
  @override
  final String? phoneNumber;

  factory _$PhoneChangeResponse([
    void Function(PhoneChangeResponseBuilder)? updates,
  ]) => (PhoneChangeResponseBuilder()..update(updates))._build();

  _$PhoneChangeResponse._({this.phoneNumber}) : super._();
  @override
  PhoneChangeResponse rebuild(
    void Function(PhoneChangeResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PhoneChangeResponseBuilder toBuilder() =>
      PhoneChangeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PhoneChangeResponse && phoneNumber == other.phoneNumber;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'PhoneChangeResponse',
    )..add('phoneNumber', phoneNumber)).toString();
  }
}

class PhoneChangeResponseBuilder
    implements Builder<PhoneChangeResponse, PhoneChangeResponseBuilder> {
  _$PhoneChangeResponse? _$v;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  PhoneChangeResponseBuilder() {
    PhoneChangeResponse._defaults(this);
  }

  PhoneChangeResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phoneNumber = $v.phoneNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PhoneChangeResponse other) {
    _$v = other as _$PhoneChangeResponse;
  }

  @override
  void update(void Function(PhoneChangeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PhoneChangeResponse build() => _build();

  _$PhoneChangeResponse _build() {
    final _$result = _$v ?? _$PhoneChangeResponse._(phoneNumber: phoneNumber);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
