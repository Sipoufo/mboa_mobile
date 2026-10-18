// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'churn.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Churn extends Churn {
  @override
  final String? month;
  @override
  final bool? provisional;
  @override
  final int? paidAtStart;
  @override
  final int? lost;
  @override
  final double? rate;

  factory _$Churn([void Function(ChurnBuilder)? updates]) =>
      (ChurnBuilder()..update(updates))._build();

  _$Churn._({
    this.month,
    this.provisional,
    this.paidAtStart,
    this.lost,
    this.rate,
  }) : super._();
  @override
  Churn rebuild(void Function(ChurnBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChurnBuilder toBuilder() => ChurnBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Churn &&
        month == other.month &&
        provisional == other.provisional &&
        paidAtStart == other.paidAtStart &&
        lost == other.lost &&
        rate == other.rate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, provisional.hashCode);
    _$hash = $jc(_$hash, paidAtStart.hashCode);
    _$hash = $jc(_$hash, lost.hashCode);
    _$hash = $jc(_$hash, rate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Churn')
          ..add('month', month)
          ..add('provisional', provisional)
          ..add('paidAtStart', paidAtStart)
          ..add('lost', lost)
          ..add('rate', rate))
        .toString();
  }
}

class ChurnBuilder implements Builder<Churn, ChurnBuilder> {
  _$Churn? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  bool? _provisional;
  bool? get provisional => _$this._provisional;
  set provisional(bool? provisional) => _$this._provisional = provisional;

  int? _paidAtStart;
  int? get paidAtStart => _$this._paidAtStart;
  set paidAtStart(int? paidAtStart) => _$this._paidAtStart = paidAtStart;

  int? _lost;
  int? get lost => _$this._lost;
  set lost(int? lost) => _$this._lost = lost;

  double? _rate;
  double? get rate => _$this._rate;
  set rate(double? rate) => _$this._rate = rate;

  ChurnBuilder() {
    Churn._defaults(this);
  }

  ChurnBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _provisional = $v.provisional;
      _paidAtStart = $v.paidAtStart;
      _lost = $v.lost;
      _rate = $v.rate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Churn other) {
    _$v = other as _$Churn;
  }

  @override
  void update(void Function(ChurnBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Churn build() => _build();

  _$Churn _build() {
    final _$result =
        _$v ??
        _$Churn._(
          month: month,
          provisional: provisional,
          paidAtStart: paidAtStart,
          lost: lost,
          rate: rate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
