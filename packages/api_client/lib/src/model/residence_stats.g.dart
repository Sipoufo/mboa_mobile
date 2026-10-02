// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'residence_stats.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResidenceStats extends ResidenceStats {
  @override
  final String? residenceId;
  @override
  final String? name;
  @override
  final int? unitCount;
  @override
  final DashboardFigures? totals;
  @override
  final BuiltList<ListingStats>? units;

  factory _$ResidenceStats([void Function(ResidenceStatsBuilder)? updates]) =>
      (ResidenceStatsBuilder()..update(updates))._build();

  _$ResidenceStats._({
    this.residenceId,
    this.name,
    this.unitCount,
    this.totals,
    this.units,
  }) : super._();
  @override
  ResidenceStats rebuild(void Function(ResidenceStatsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResidenceStatsBuilder toBuilder() => ResidenceStatsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResidenceStats &&
        residenceId == other.residenceId &&
        name == other.name &&
        unitCount == other.unitCount &&
        totals == other.totals &&
        units == other.units;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, residenceId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, unitCount.hashCode);
    _$hash = $jc(_$hash, totals.hashCode);
    _$hash = $jc(_$hash, units.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResidenceStats')
          ..add('residenceId', residenceId)
          ..add('name', name)
          ..add('unitCount', unitCount)
          ..add('totals', totals)
          ..add('units', units))
        .toString();
  }
}

class ResidenceStatsBuilder
    implements Builder<ResidenceStats, ResidenceStatsBuilder> {
  _$ResidenceStats? _$v;

  String? _residenceId;
  String? get residenceId => _$this._residenceId;
  set residenceId(String? residenceId) => _$this._residenceId = residenceId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _unitCount;
  int? get unitCount => _$this._unitCount;
  set unitCount(int? unitCount) => _$this._unitCount = unitCount;

  DashboardFiguresBuilder? _totals;
  DashboardFiguresBuilder get totals =>
      _$this._totals ??= DashboardFiguresBuilder();
  set totals(DashboardFiguresBuilder? totals) => _$this._totals = totals;

  ListBuilder<ListingStats>? _units;
  ListBuilder<ListingStats> get units =>
      _$this._units ??= ListBuilder<ListingStats>();
  set units(ListBuilder<ListingStats>? units) => _$this._units = units;

  ResidenceStatsBuilder() {
    ResidenceStats._defaults(this);
  }

  ResidenceStatsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _residenceId = $v.residenceId;
      _name = $v.name;
      _unitCount = $v.unitCount;
      _totals = $v.totals?.toBuilder();
      _units = $v.units?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResidenceStats other) {
    _$v = other as _$ResidenceStats;
  }

  @override
  void update(void Function(ResidenceStatsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResidenceStats build() => _build();

  _$ResidenceStats _build() {
    _$ResidenceStats _$result;
    try {
      _$result =
          _$v ??
          _$ResidenceStats._(
            residenceId: residenceId,
            name: name,
            unitCount: unitCount,
            totals: _totals?.build(),
            units: _units?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'totals';
        _totals?.build();
        _$failedField = 'units';
        _units?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ResidenceStats',
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
