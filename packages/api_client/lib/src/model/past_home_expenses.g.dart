// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_home_expenses.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PastHomeExpenses extends PastHomeExpenses {
  @override
  final int? confirmedTotal;
  @override
  final BuiltList<YearTotal>? byYear;
  @override
  final BuiltList<PastPayment>? confirmed;
  @override
  final BuiltList<PastPayment>? notConfirmed;

  factory _$PastHomeExpenses([
    void Function(PastHomeExpensesBuilder)? updates,
  ]) => (PastHomeExpensesBuilder()..update(updates))._build();

  _$PastHomeExpenses._({
    this.confirmedTotal,
    this.byYear,
    this.confirmed,
    this.notConfirmed,
  }) : super._();
  @override
  PastHomeExpenses rebuild(void Function(PastHomeExpensesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PastHomeExpensesBuilder toBuilder() =>
      PastHomeExpensesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PastHomeExpenses &&
        confirmedTotal == other.confirmedTotal &&
        byYear == other.byYear &&
        confirmed == other.confirmed &&
        notConfirmed == other.notConfirmed;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, confirmedTotal.hashCode);
    _$hash = $jc(_$hash, byYear.hashCode);
    _$hash = $jc(_$hash, confirmed.hashCode);
    _$hash = $jc(_$hash, notConfirmed.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PastHomeExpenses')
          ..add('confirmedTotal', confirmedTotal)
          ..add('byYear', byYear)
          ..add('confirmed', confirmed)
          ..add('notConfirmed', notConfirmed))
        .toString();
  }
}

class PastHomeExpensesBuilder
    implements Builder<PastHomeExpenses, PastHomeExpensesBuilder> {
  _$PastHomeExpenses? _$v;

  int? _confirmedTotal;
  int? get confirmedTotal => _$this._confirmedTotal;
  set confirmedTotal(int? confirmedTotal) =>
      _$this._confirmedTotal = confirmedTotal;

  ListBuilder<YearTotal>? _byYear;
  ListBuilder<YearTotal> get byYear =>
      _$this._byYear ??= ListBuilder<YearTotal>();
  set byYear(ListBuilder<YearTotal>? byYear) => _$this._byYear = byYear;

  ListBuilder<PastPayment>? _confirmed;
  ListBuilder<PastPayment> get confirmed =>
      _$this._confirmed ??= ListBuilder<PastPayment>();
  set confirmed(ListBuilder<PastPayment>? confirmed) =>
      _$this._confirmed = confirmed;

  ListBuilder<PastPayment>? _notConfirmed;
  ListBuilder<PastPayment> get notConfirmed =>
      _$this._notConfirmed ??= ListBuilder<PastPayment>();
  set notConfirmed(ListBuilder<PastPayment>? notConfirmed) =>
      _$this._notConfirmed = notConfirmed;

  PastHomeExpensesBuilder() {
    PastHomeExpenses._defaults(this);
  }

  PastHomeExpensesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _confirmedTotal = $v.confirmedTotal;
      _byYear = $v.byYear?.toBuilder();
      _confirmed = $v.confirmed?.toBuilder();
      _notConfirmed = $v.notConfirmed?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PastHomeExpenses other) {
    _$v = other as _$PastHomeExpenses;
  }

  @override
  void update(void Function(PastHomeExpensesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PastHomeExpenses build() => _build();

  _$PastHomeExpenses _build() {
    _$PastHomeExpenses _$result;
    try {
      _$result =
          _$v ??
          _$PastHomeExpenses._(
            confirmedTotal: confirmedTotal,
            byYear: _byYear?.build(),
            confirmed: _confirmed?.build(),
            notConfirmed: _notConfirmed?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'byYear';
        _byYear?.build();
        _$failedField = 'confirmed';
        _confirmed?.build();
        _$failedField = 'notConfirmed';
        _notConfirmed?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PastHomeExpenses',
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
