// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'residence_assignment_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResidenceAssignmentResult extends ResidenceAssignmentResult {
  @override
  final String? residenceId;
  @override
  final String? residenceName;
  @override
  final String? agentAccountId;
  @override
  final int? offered;
  @override
  final BuiltList<SkippedUnit>? skipped;

  factory _$ResidenceAssignmentResult([
    void Function(ResidenceAssignmentResultBuilder)? updates,
  ]) => (ResidenceAssignmentResultBuilder()..update(updates))._build();

  _$ResidenceAssignmentResult._({
    this.residenceId,
    this.residenceName,
    this.agentAccountId,
    this.offered,
    this.skipped,
  }) : super._();
  @override
  ResidenceAssignmentResult rebuild(
    void Function(ResidenceAssignmentResultBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ResidenceAssignmentResultBuilder toBuilder() =>
      ResidenceAssignmentResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResidenceAssignmentResult &&
        residenceId == other.residenceId &&
        residenceName == other.residenceName &&
        agentAccountId == other.agentAccountId &&
        offered == other.offered &&
        skipped == other.skipped;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, residenceId.hashCode);
    _$hash = $jc(_$hash, residenceName.hashCode);
    _$hash = $jc(_$hash, agentAccountId.hashCode);
    _$hash = $jc(_$hash, offered.hashCode);
    _$hash = $jc(_$hash, skipped.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResidenceAssignmentResult')
          ..add('residenceId', residenceId)
          ..add('residenceName', residenceName)
          ..add('agentAccountId', agentAccountId)
          ..add('offered', offered)
          ..add('skipped', skipped))
        .toString();
  }
}

class ResidenceAssignmentResultBuilder
    implements
        Builder<ResidenceAssignmentResult, ResidenceAssignmentResultBuilder> {
  _$ResidenceAssignmentResult? _$v;

  String? _residenceId;
  String? get residenceId => _$this._residenceId;
  set residenceId(String? residenceId) => _$this._residenceId = residenceId;

  String? _residenceName;
  String? get residenceName => _$this._residenceName;
  set residenceName(String? residenceName) =>
      _$this._residenceName = residenceName;

  String? _agentAccountId;
  String? get agentAccountId => _$this._agentAccountId;
  set agentAccountId(String? agentAccountId) =>
      _$this._agentAccountId = agentAccountId;

  int? _offered;
  int? get offered => _$this._offered;
  set offered(int? offered) => _$this._offered = offered;

  ListBuilder<SkippedUnit>? _skipped;
  ListBuilder<SkippedUnit> get skipped =>
      _$this._skipped ??= ListBuilder<SkippedUnit>();
  set skipped(ListBuilder<SkippedUnit>? skipped) => _$this._skipped = skipped;

  ResidenceAssignmentResultBuilder() {
    ResidenceAssignmentResult._defaults(this);
  }

  ResidenceAssignmentResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _residenceId = $v.residenceId;
      _residenceName = $v.residenceName;
      _agentAccountId = $v.agentAccountId;
      _offered = $v.offered;
      _skipped = $v.skipped?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResidenceAssignmentResult other) {
    _$v = other as _$ResidenceAssignmentResult;
  }

  @override
  void update(void Function(ResidenceAssignmentResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResidenceAssignmentResult build() => _build();

  _$ResidenceAssignmentResult _build() {
    _$ResidenceAssignmentResult _$result;
    try {
      _$result =
          _$v ??
          _$ResidenceAssignmentResult._(
            residenceId: residenceId,
            residenceName: residenceName,
            agentAccountId: agentAccountId,
            offered: offered,
            skipped: _skipped?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'skipped';
        _skipped?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ResidenceAssignmentResult',
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
