// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_decision_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BadgeDecisionRequest extends BadgeDecisionRequest {
  @override
  final String reason;

  factory _$BadgeDecisionRequest([
    void Function(BadgeDecisionRequestBuilder)? updates,
  ]) => (BadgeDecisionRequestBuilder()..update(updates))._build();

  _$BadgeDecisionRequest._({required this.reason}) : super._();
  @override
  BadgeDecisionRequest rebuild(
    void Function(BadgeDecisionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BadgeDecisionRequestBuilder toBuilder() =>
      BadgeDecisionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BadgeDecisionRequest && reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'BadgeDecisionRequest',
    )..add('reason', reason)).toString();
  }
}

class BadgeDecisionRequestBuilder
    implements Builder<BadgeDecisionRequest, BadgeDecisionRequestBuilder> {
  _$BadgeDecisionRequest? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  BadgeDecisionRequestBuilder() {
    BadgeDecisionRequest._defaults(this);
  }

  BadgeDecisionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BadgeDecisionRequest other) {
    _$v = other as _$BadgeDecisionRequest;
  }

  @override
  void update(void Function(BadgeDecisionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BadgeDecisionRequest build() => _build();

  _$BadgeDecisionRequest _build() {
    final _$result =
        _$v ??
        _$BadgeDecisionRequest._(
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'BadgeDecisionRequest',
            'reason',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
