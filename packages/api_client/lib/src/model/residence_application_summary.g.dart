// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'residence_application_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResidenceApplicationSummary extends ResidenceApplicationSummary {
  @override
  final String? residenceId;
  @override
  final String? agentAccountId;
  @override
  final String? agentName;
  @override
  final String? photoObjectKey;
  @override
  final int? completedVisitCount;
  @override
  final int? unitCount;
  @override
  final DateTime? appliedAt;

  factory _$ResidenceApplicationSummary([
    void Function(ResidenceApplicationSummaryBuilder)? updates,
  ]) => (ResidenceApplicationSummaryBuilder()..update(updates))._build();

  _$ResidenceApplicationSummary._({
    this.residenceId,
    this.agentAccountId,
    this.agentName,
    this.photoObjectKey,
    this.completedVisitCount,
    this.unitCount,
    this.appliedAt,
  }) : super._();
  @override
  ResidenceApplicationSummary rebuild(
    void Function(ResidenceApplicationSummaryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ResidenceApplicationSummaryBuilder toBuilder() =>
      ResidenceApplicationSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResidenceApplicationSummary &&
        residenceId == other.residenceId &&
        agentAccountId == other.agentAccountId &&
        agentName == other.agentName &&
        photoObjectKey == other.photoObjectKey &&
        completedVisitCount == other.completedVisitCount &&
        unitCount == other.unitCount &&
        appliedAt == other.appliedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, residenceId.hashCode);
    _$hash = $jc(_$hash, agentAccountId.hashCode);
    _$hash = $jc(_$hash, agentName.hashCode);
    _$hash = $jc(_$hash, photoObjectKey.hashCode);
    _$hash = $jc(_$hash, completedVisitCount.hashCode);
    _$hash = $jc(_$hash, unitCount.hashCode);
    _$hash = $jc(_$hash, appliedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResidenceApplicationSummary')
          ..add('residenceId', residenceId)
          ..add('agentAccountId', agentAccountId)
          ..add('agentName', agentName)
          ..add('photoObjectKey', photoObjectKey)
          ..add('completedVisitCount', completedVisitCount)
          ..add('unitCount', unitCount)
          ..add('appliedAt', appliedAt))
        .toString();
  }
}

class ResidenceApplicationSummaryBuilder
    implements
        Builder<
          ResidenceApplicationSummary,
          ResidenceApplicationSummaryBuilder
        > {
  _$ResidenceApplicationSummary? _$v;

  String? _residenceId;
  String? get residenceId => _$this._residenceId;
  set residenceId(String? residenceId) => _$this._residenceId = residenceId;

  String? _agentAccountId;
  String? get agentAccountId => _$this._agentAccountId;
  set agentAccountId(String? agentAccountId) =>
      _$this._agentAccountId = agentAccountId;

  String? _agentName;
  String? get agentName => _$this._agentName;
  set agentName(String? agentName) => _$this._agentName = agentName;

  String? _photoObjectKey;
  String? get photoObjectKey => _$this._photoObjectKey;
  set photoObjectKey(String? photoObjectKey) =>
      _$this._photoObjectKey = photoObjectKey;

  int? _completedVisitCount;
  int? get completedVisitCount => _$this._completedVisitCount;
  set completedVisitCount(int? completedVisitCount) =>
      _$this._completedVisitCount = completedVisitCount;

  int? _unitCount;
  int? get unitCount => _$this._unitCount;
  set unitCount(int? unitCount) => _$this._unitCount = unitCount;

  DateTime? _appliedAt;
  DateTime? get appliedAt => _$this._appliedAt;
  set appliedAt(DateTime? appliedAt) => _$this._appliedAt = appliedAt;

  ResidenceApplicationSummaryBuilder() {
    ResidenceApplicationSummary._defaults(this);
  }

  ResidenceApplicationSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _residenceId = $v.residenceId;
      _agentAccountId = $v.agentAccountId;
      _agentName = $v.agentName;
      _photoObjectKey = $v.photoObjectKey;
      _completedVisitCount = $v.completedVisitCount;
      _unitCount = $v.unitCount;
      _appliedAt = $v.appliedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResidenceApplicationSummary other) {
    _$v = other as _$ResidenceApplicationSummary;
  }

  @override
  void update(void Function(ResidenceApplicationSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResidenceApplicationSummary build() => _build();

  _$ResidenceApplicationSummary _build() {
    final _$result =
        _$v ??
        _$ResidenceApplicationSummary._(
          residenceId: residenceId,
          agentAccountId: agentAccountId,
          agentName: agentName,
          photoObjectKey: photoObjectKey,
          completedVisitCount: completedVisitCount,
          unitCount: unitCount,
          appliedAt: appliedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
