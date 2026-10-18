// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_summary_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LedgerSummaryResponse extends LedgerSummaryResponse {
  @override
  final int? income;
  @override
  final int? expense;
  @override
  final int? net;
  @override
  final int? entryCount;
  @override
  final BuiltList<CategoryTotal>? byCategory;

  factory _$LedgerSummaryResponse([
    void Function(LedgerSummaryResponseBuilder)? updates,
  ]) => (LedgerSummaryResponseBuilder()..update(updates))._build();

  _$LedgerSummaryResponse._({
    this.income,
    this.expense,
    this.net,
    this.entryCount,
    this.byCategory,
  }) : super._();
  @override
  LedgerSummaryResponse rebuild(
    void Function(LedgerSummaryResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LedgerSummaryResponseBuilder toBuilder() =>
      LedgerSummaryResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LedgerSummaryResponse &&
        income == other.income &&
        expense == other.expense &&
        net == other.net &&
        entryCount == other.entryCount &&
        byCategory == other.byCategory;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, income.hashCode);
    _$hash = $jc(_$hash, expense.hashCode);
    _$hash = $jc(_$hash, net.hashCode);
    _$hash = $jc(_$hash, entryCount.hashCode);
    _$hash = $jc(_$hash, byCategory.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LedgerSummaryResponse')
          ..add('income', income)
          ..add('expense', expense)
          ..add('net', net)
          ..add('entryCount', entryCount)
          ..add('byCategory', byCategory))
        .toString();
  }
}

class LedgerSummaryResponseBuilder
    implements Builder<LedgerSummaryResponse, LedgerSummaryResponseBuilder> {
  _$LedgerSummaryResponse? _$v;

  int? _income;
  int? get income => _$this._income;
  set income(int? income) => _$this._income = income;

  int? _expense;
  int? get expense => _$this._expense;
  set expense(int? expense) => _$this._expense = expense;

  int? _net;
  int? get net => _$this._net;
  set net(int? net) => _$this._net = net;

  int? _entryCount;
  int? get entryCount => _$this._entryCount;
  set entryCount(int? entryCount) => _$this._entryCount = entryCount;

  ListBuilder<CategoryTotal>? _byCategory;
  ListBuilder<CategoryTotal> get byCategory =>
      _$this._byCategory ??= ListBuilder<CategoryTotal>();
  set byCategory(ListBuilder<CategoryTotal>? byCategory) =>
      _$this._byCategory = byCategory;

  LedgerSummaryResponseBuilder() {
    LedgerSummaryResponse._defaults(this);
  }

  LedgerSummaryResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _income = $v.income;
      _expense = $v.expense;
      _net = $v.net;
      _entryCount = $v.entryCount;
      _byCategory = $v.byCategory?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LedgerSummaryResponse other) {
    _$v = other as _$LedgerSummaryResponse;
  }

  @override
  void update(void Function(LedgerSummaryResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LedgerSummaryResponse build() => _build();

  _$LedgerSummaryResponse _build() {
    _$LedgerSummaryResponse _$result;
    try {
      _$result =
          _$v ??
          _$LedgerSummaryResponse._(
            income: income,
            expense: expense,
            net: net,
            entryCount: entryCount,
            byCategory: _byCategory?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'byCategory';
        _byCategory?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'LedgerSummaryResponse',
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
