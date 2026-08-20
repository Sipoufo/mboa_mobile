// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_contract_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SignContractRequest extends SignContractRequest {
  @override
  final String? sessionId;

  factory _$SignContractRequest([
    void Function(SignContractRequestBuilder)? updates,
  ]) => (SignContractRequestBuilder()..update(updates))._build();

  _$SignContractRequest._({this.sessionId}) : super._();
  @override
  SignContractRequest rebuild(
    void Function(SignContractRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SignContractRequestBuilder toBuilder() =>
      SignContractRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignContractRequest && sessionId == other.sessionId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'SignContractRequest',
    )..add('sessionId', sessionId)).toString();
  }
}

class SignContractRequestBuilder
    implements Builder<SignContractRequest, SignContractRequestBuilder> {
  _$SignContractRequest? _$v;

  String? _sessionId;
  String? get sessionId => _$this._sessionId;
  set sessionId(String? sessionId) => _$this._sessionId = sessionId;

  SignContractRequestBuilder() {
    SignContractRequest._defaults(this);
  }

  SignContractRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessionId = $v.sessionId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignContractRequest other) {
    _$v = other as _$SignContractRequest;
  }

  @override
  void update(void Function(SignContractRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignContractRequest build() => _build();

  _$SignContractRequest _build() {
    final _$result = _$v ?? _$SignContractRequest._(sessionId: sessionId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
