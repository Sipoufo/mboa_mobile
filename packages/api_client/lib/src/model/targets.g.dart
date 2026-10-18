// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'targets.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Targets extends Targets {
  @override
  final int? activeListings;
  @override
  final int? paidPrestataires;
  @override
  final int? newPrestatairesPer30Days;
  @override
  final double? conversionRate;
  @override
  final int? mrr;
  @override
  final double? monthlyChurn;

  factory _$Targets([void Function(TargetsBuilder)? updates]) =>
      (TargetsBuilder()..update(updates))._build();

  _$Targets._({
    this.activeListings,
    this.paidPrestataires,
    this.newPrestatairesPer30Days,
    this.conversionRate,
    this.mrr,
    this.monthlyChurn,
  }) : super._();
  @override
  Targets rebuild(void Function(TargetsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TargetsBuilder toBuilder() => TargetsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Targets &&
        activeListings == other.activeListings &&
        paidPrestataires == other.paidPrestataires &&
        newPrestatairesPer30Days == other.newPrestatairesPer30Days &&
        conversionRate == other.conversionRate &&
        mrr == other.mrr &&
        monthlyChurn == other.monthlyChurn;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, activeListings.hashCode);
    _$hash = $jc(_$hash, paidPrestataires.hashCode);
    _$hash = $jc(_$hash, newPrestatairesPer30Days.hashCode);
    _$hash = $jc(_$hash, conversionRate.hashCode);
    _$hash = $jc(_$hash, mrr.hashCode);
    _$hash = $jc(_$hash, monthlyChurn.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Targets')
          ..add('activeListings', activeListings)
          ..add('paidPrestataires', paidPrestataires)
          ..add('newPrestatairesPer30Days', newPrestatairesPer30Days)
          ..add('conversionRate', conversionRate)
          ..add('mrr', mrr)
          ..add('monthlyChurn', monthlyChurn))
        .toString();
  }
}

class TargetsBuilder implements Builder<Targets, TargetsBuilder> {
  _$Targets? _$v;

  int? _activeListings;
  int? get activeListings => _$this._activeListings;
  set activeListings(int? activeListings) =>
      _$this._activeListings = activeListings;

  int? _paidPrestataires;
  int? get paidPrestataires => _$this._paidPrestataires;
  set paidPrestataires(int? paidPrestataires) =>
      _$this._paidPrestataires = paidPrestataires;

  int? _newPrestatairesPer30Days;
  int? get newPrestatairesPer30Days => _$this._newPrestatairesPer30Days;
  set newPrestatairesPer30Days(int? newPrestatairesPer30Days) =>
      _$this._newPrestatairesPer30Days = newPrestatairesPer30Days;

  double? _conversionRate;
  double? get conversionRate => _$this._conversionRate;
  set conversionRate(double? conversionRate) =>
      _$this._conversionRate = conversionRate;

  int? _mrr;
  int? get mrr => _$this._mrr;
  set mrr(int? mrr) => _$this._mrr = mrr;

  double? _monthlyChurn;
  double? get monthlyChurn => _$this._monthlyChurn;
  set monthlyChurn(double? monthlyChurn) => _$this._monthlyChurn = monthlyChurn;

  TargetsBuilder() {
    Targets._defaults(this);
  }

  TargetsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _activeListings = $v.activeListings;
      _paidPrestataires = $v.paidPrestataires;
      _newPrestatairesPer30Days = $v.newPrestatairesPer30Days;
      _conversionRate = $v.conversionRate;
      _mrr = $v.mrr;
      _monthlyChurn = $v.monthlyChurn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Targets other) {
    _$v = other as _$Targets;
  }

  @override
  void update(void Function(TargetsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Targets build() => _build();

  _$Targets _build() {
    final _$result =
        _$v ??
        _$Targets._(
          activeListings: activeListings,
          paidPrestataires: paidPrestataires,
          newPrestatairesPer30Days: newPrestatairesPer30Days,
          conversionRate: conversionRate,
          mrr: mrr,
          monthlyChurn: monthlyChurn,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
