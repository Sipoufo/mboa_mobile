// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SignatureResponse extends SignatureResponse {
  @override
  final String? signerAccountId;
  @override
  final DateTime? signedAt;
  @override
  final bool? current;

  factory _$SignatureResponse([
    void Function(SignatureResponseBuilder)? updates,
  ]) => (SignatureResponseBuilder()..update(updates))._build();

  _$SignatureResponse._({this.signerAccountId, this.signedAt, this.current})
    : super._();
  @override
  SignatureResponse rebuild(void Function(SignatureResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignatureResponseBuilder toBuilder() =>
      SignatureResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignatureResponse &&
        signerAccountId == other.signerAccountId &&
        signedAt == other.signedAt &&
        current == other.current;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, signerAccountId.hashCode);
    _$hash = $jc(_$hash, signedAt.hashCode);
    _$hash = $jc(_$hash, current.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignatureResponse')
          ..add('signerAccountId', signerAccountId)
          ..add('signedAt', signedAt)
          ..add('current', current))
        .toString();
  }
}

class SignatureResponseBuilder
    implements Builder<SignatureResponse, SignatureResponseBuilder> {
  _$SignatureResponse? _$v;

  String? _signerAccountId;
  String? get signerAccountId => _$this._signerAccountId;
  set signerAccountId(String? signerAccountId) =>
      _$this._signerAccountId = signerAccountId;

  DateTime? _signedAt;
  DateTime? get signedAt => _$this._signedAt;
  set signedAt(DateTime? signedAt) => _$this._signedAt = signedAt;

  bool? _current;
  bool? get current => _$this._current;
  set current(bool? current) => _$this._current = current;

  SignatureResponseBuilder() {
    SignatureResponse._defaults(this);
  }

  SignatureResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _signerAccountId = $v.signerAccountId;
      _signedAt = $v.signedAt;
      _current = $v.current;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignatureResponse other) {
    _$v = other as _$SignatureResponse;
  }

  @override
  void update(void Function(SignatureResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignatureResponse build() => _build();

  _$SignatureResponse _build() {
    final _$result =
        _$v ??
        _$SignatureResponse._(
          signerAccountId: signerAccountId,
          signedAt: signedAt,
          current: current,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
