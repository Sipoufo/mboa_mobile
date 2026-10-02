// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_adjustment_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScoreAdjustmentResponse extends ScoreAdjustmentResponse {
  @override
  final String? id;
  @override
  final int? delta;
  @override
  final String? reason;
  @override
  final String? adminAccountId;
  @override
  final DateTime? createdAt;

  factory _$ScoreAdjustmentResponse([
    void Function(ScoreAdjustmentResponseBuilder)? updates,
  ]) => (ScoreAdjustmentResponseBuilder()..update(updates))._build();

  _$ScoreAdjustmentResponse._({
    this.id,
    this.delta,
    this.reason,
    this.adminAccountId,
    this.createdAt,
  }) : super._();
  @override
  ScoreAdjustmentResponse rebuild(
    void Function(ScoreAdjustmentResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ScoreAdjustmentResponseBuilder toBuilder() =>
      ScoreAdjustmentResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScoreAdjustmentResponse &&
        id == other.id &&
        delta == other.delta &&
        reason == other.reason &&
        adminAccountId == other.adminAccountId &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, delta.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, adminAccountId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScoreAdjustmentResponse')
          ..add('id', id)
          ..add('delta', delta)
          ..add('reason', reason)
          ..add('adminAccountId', adminAccountId)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ScoreAdjustmentResponseBuilder
    implements
        Builder<ScoreAdjustmentResponse, ScoreAdjustmentResponseBuilder> {
  _$ScoreAdjustmentResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  int? _delta;
  int? get delta => _$this._delta;
  set delta(int? delta) => _$this._delta = delta;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  String? _adminAccountId;
  String? get adminAccountId => _$this._adminAccountId;
  set adminAccountId(String? adminAccountId) =>
      _$this._adminAccountId = adminAccountId;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ScoreAdjustmentResponseBuilder() {
    ScoreAdjustmentResponse._defaults(this);
  }

  ScoreAdjustmentResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _delta = $v.delta;
      _reason = $v.reason;
      _adminAccountId = $v.adminAccountId;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScoreAdjustmentResponse other) {
    _$v = other as _$ScoreAdjustmentResponse;
  }

  @override
  void update(void Function(ScoreAdjustmentResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScoreAdjustmentResponse build() => _build();

  _$ScoreAdjustmentResponse _build() {
    final _$result =
        _$v ??
        _$ScoreAdjustmentResponse._(
          id: id,
          delta: delta,
          reason: reason,
          adminAccountId: adminAccountId,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
