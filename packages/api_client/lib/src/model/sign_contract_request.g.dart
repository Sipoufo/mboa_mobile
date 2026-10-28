// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_contract_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SignContractRequest extends SignContractRequest {
  @override
  final String? sessionId;
  @override
  final SigningIdentityRequest? identity;

  factory _$SignContractRequest([
    void Function(SignContractRequestBuilder)? updates,
  ]) => (SignContractRequestBuilder()..update(updates))._build();

  _$SignContractRequest._({this.sessionId, this.identity}) : super._();
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
    return other is SignContractRequest &&
        sessionId == other.sessionId &&
        identity == other.identity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jc(_$hash, identity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignContractRequest')
          ..add('sessionId', sessionId)
          ..add('identity', identity))
        .toString();
  }
}

class SignContractRequestBuilder
    implements Builder<SignContractRequest, SignContractRequestBuilder> {
  _$SignContractRequest? _$v;

  String? _sessionId;
  String? get sessionId => _$this._sessionId;
  set sessionId(String? sessionId) => _$this._sessionId = sessionId;

  SigningIdentityRequestBuilder? _identity;
  SigningIdentityRequestBuilder get identity =>
      _$this._identity ??= SigningIdentityRequestBuilder();
  set identity(SigningIdentityRequestBuilder? identity) =>
      _$this._identity = identity;

  SignContractRequestBuilder() {
    SignContractRequest._defaults(this);
  }

  SignContractRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessionId = $v.sessionId;
      _identity = $v.identity?.toBuilder();
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
    _$SignContractRequest _$result;
    try {
      _$result =
          _$v ??
          _$SignContractRequest._(
            sessionId: sessionId,
            identity: _identity?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'identity';
        _identity?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SignContractRequest',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
