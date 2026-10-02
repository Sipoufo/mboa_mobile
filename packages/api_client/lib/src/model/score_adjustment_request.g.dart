// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_adjustment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScoreAdjustmentRequest extends ScoreAdjustmentRequest {
  @override
  final int delta;
  @override
  final String reason;

  factory _$ScoreAdjustmentRequest([
    void Function(ScoreAdjustmentRequestBuilder)? updates,
  ]) => (ScoreAdjustmentRequestBuilder()..update(updates))._build();

  _$ScoreAdjustmentRequest._({required this.delta, required this.reason})
    : super._();
  @override
  ScoreAdjustmentRequest rebuild(
    void Function(ScoreAdjustmentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ScoreAdjustmentRequestBuilder toBuilder() =>
      ScoreAdjustmentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScoreAdjustmentRequest &&
        delta == other.delta &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, delta.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScoreAdjustmentRequest')
          ..add('delta', delta)
          ..add('reason', reason))
        .toString();
  }
}

class ScoreAdjustmentRequestBuilder
    implements Builder<ScoreAdjustmentRequest, ScoreAdjustmentRequestBuilder> {
  _$ScoreAdjustmentRequest? _$v;

  int? _delta;
  int? get delta => _$this._delta;
  set delta(int? delta) => _$this._delta = delta;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  ScoreAdjustmentRequestBuilder() {
    ScoreAdjustmentRequest._defaults(this);
  }

  ScoreAdjustmentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _delta = $v.delta;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScoreAdjustmentRequest other) {
    _$v = other as _$ScoreAdjustmentRequest;
  }

  @override
  void update(void Function(ScoreAdjustmentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScoreAdjustmentRequest build() => _build();

  _$ScoreAdjustmentRequest _build() {
    final _$result =
        _$v ??
        _$ScoreAdjustmentRequest._(
          delta: BuiltValueNullFieldError.checkNotNull(
            delta,
            r'ScoreAdjustmentRequest',
            'delta',
          ),
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'ScoreAdjustmentRequest',
            'reason',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
