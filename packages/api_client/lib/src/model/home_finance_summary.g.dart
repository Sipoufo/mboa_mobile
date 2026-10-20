// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_finance_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HomeFinanceSummary extends HomeFinanceSummary {
  @override
  final int? confirmedTotal;
  @override
  final int? declaredTotal;
  @override
  final int? contestedTotal;
  @override
  final DateTime? lastConfirmedAt;

  factory _$HomeFinanceSummary([
    void Function(HomeFinanceSummaryBuilder)? updates,
  ]) => (HomeFinanceSummaryBuilder()..update(updates))._build();

  _$HomeFinanceSummary._({
    this.confirmedTotal,
    this.declaredTotal,
    this.contestedTotal,
    this.lastConfirmedAt,
  }) : super._();
  @override
  HomeFinanceSummary rebuild(
    void Function(HomeFinanceSummaryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HomeFinanceSummaryBuilder toBuilder() =>
      HomeFinanceSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeFinanceSummary &&
        confirmedTotal == other.confirmedTotal &&
        declaredTotal == other.declaredTotal &&
        contestedTotal == other.contestedTotal &&
        lastConfirmedAt == other.lastConfirmedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, confirmedTotal.hashCode);
    _$hash = $jc(_$hash, declaredTotal.hashCode);
    _$hash = $jc(_$hash, contestedTotal.hashCode);
    _$hash = $jc(_$hash, lastConfirmedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HomeFinanceSummary')
          ..add('confirmedTotal', confirmedTotal)
          ..add('declaredTotal', declaredTotal)
          ..add('contestedTotal', contestedTotal)
          ..add('lastConfirmedAt', lastConfirmedAt))
        .toString();
  }
}

class HomeFinanceSummaryBuilder
    implements Builder<HomeFinanceSummary, HomeFinanceSummaryBuilder> {
  _$HomeFinanceSummary? _$v;

  int? _confirmedTotal;
  int? get confirmedTotal => _$this._confirmedTotal;
  set confirmedTotal(int? confirmedTotal) =>
      _$this._confirmedTotal = confirmedTotal;

  int? _declaredTotal;
  int? get declaredTotal => _$this._declaredTotal;
  set declaredTotal(int? declaredTotal) =>
      _$this._declaredTotal = declaredTotal;

  int? _contestedTotal;
  int? get contestedTotal => _$this._contestedTotal;
  set contestedTotal(int? contestedTotal) =>
      _$this._contestedTotal = contestedTotal;

  DateTime? _lastConfirmedAt;
  DateTime? get lastConfirmedAt => _$this._lastConfirmedAt;
  set lastConfirmedAt(DateTime? lastConfirmedAt) =>
      _$this._lastConfirmedAt = lastConfirmedAt;

  HomeFinanceSummaryBuilder() {
    HomeFinanceSummary._defaults(this);
  }

  HomeFinanceSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _confirmedTotal = $v.confirmedTotal;
      _declaredTotal = $v.declaredTotal;
      _contestedTotal = $v.contestedTotal;
      _lastConfirmedAt = $v.lastConfirmedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeFinanceSummary other) {
    _$v = other as _$HomeFinanceSummary;
  }

  @override
  void update(void Function(HomeFinanceSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HomeFinanceSummary build() => _build();

  _$HomeFinanceSummary _build() {
    final _$result =
        _$v ??
        _$HomeFinanceSummary._(
          confirmedTotal: confirmedTotal,
          declaredTotal: declaredTotal,
          contestedTotal: contestedTotal,
          lastConfirmedAt: lastConfirmedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
