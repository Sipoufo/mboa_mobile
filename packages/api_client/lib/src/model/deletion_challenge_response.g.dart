// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletion_challenge_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeletionChallengeResponse extends DeletionChallengeResponse {
  @override
  final String? confirmationToken;
  @override
  final DateTime? expiresAt;

  factory _$DeletionChallengeResponse([
    void Function(DeletionChallengeResponseBuilder)? updates,
  ]) => (DeletionChallengeResponseBuilder()..update(updates))._build();

  _$DeletionChallengeResponse._({this.confirmationToken, this.expiresAt})
    : super._();
  @override
  DeletionChallengeResponse rebuild(
    void Function(DeletionChallengeResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DeletionChallengeResponseBuilder toBuilder() =>
      DeletionChallengeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeletionChallengeResponse &&
        confirmationToken == other.confirmationToken &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, confirmationToken.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeletionChallengeResponse')
          ..add('confirmationToken', confirmationToken)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class DeletionChallengeResponseBuilder
    implements
        Builder<DeletionChallengeResponse, DeletionChallengeResponseBuilder> {
  _$DeletionChallengeResponse? _$v;

  String? _confirmationToken;
  String? get confirmationToken => _$this._confirmationToken;
  set confirmationToken(String? confirmationToken) =>
      _$this._confirmationToken = confirmationToken;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  DeletionChallengeResponseBuilder() {
    DeletionChallengeResponse._defaults(this);
  }

  DeletionChallengeResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _confirmationToken = $v.confirmationToken;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeletionChallengeResponse other) {
    _$v = other as _$DeletionChallengeResponse;
  }

  @override
  void update(void Function(DeletionChallengeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeletionChallengeResponse build() => _build();

  _$DeletionChallengeResponse _build() {
    final _$result =
        _$v ??
        _$DeletionChallengeResponse._(
          confirmationToken: confirmationToken,
          expiresAt: expiresAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
