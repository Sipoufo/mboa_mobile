// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_addon_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinanceAddonResponse extends FinanceAddonResponse {
  @override
  final bool? active;
  @override
  final DateTime? periodEnd;
  @override
  final bool? everSubscribed;
  @override
  final bool? paid;
  @override
  final int? monthlyPrice;

  factory _$FinanceAddonResponse([
    void Function(FinanceAddonResponseBuilder)? updates,
  ]) => (FinanceAddonResponseBuilder()..update(updates))._build();

  _$FinanceAddonResponse._({
    this.active,
    this.periodEnd,
    this.everSubscribed,
    this.paid,
    this.monthlyPrice,
  }) : super._();
  @override
  FinanceAddonResponse rebuild(
    void Function(FinanceAddonResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceAddonResponseBuilder toBuilder() =>
      FinanceAddonResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceAddonResponse &&
        active == other.active &&
        periodEnd == other.periodEnd &&
        everSubscribed == other.everSubscribed &&
        paid == other.paid &&
        monthlyPrice == other.monthlyPrice;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, active.hashCode);
    _$hash = $jc(_$hash, periodEnd.hashCode);
    _$hash = $jc(_$hash, everSubscribed.hashCode);
    _$hash = $jc(_$hash, paid.hashCode);
    _$hash = $jc(_$hash, monthlyPrice.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinanceAddonResponse')
          ..add('active', active)
          ..add('periodEnd', periodEnd)
          ..add('everSubscribed', everSubscribed)
          ..add('paid', paid)
          ..add('monthlyPrice', monthlyPrice))
        .toString();
  }
}

class FinanceAddonResponseBuilder
    implements Builder<FinanceAddonResponse, FinanceAddonResponseBuilder> {
  _$FinanceAddonResponse? _$v;

  bool? _active;
  bool? get active => _$this._active;
  set active(bool? active) => _$this._active = active;

  DateTime? _periodEnd;
  DateTime? get periodEnd => _$this._periodEnd;
  set periodEnd(DateTime? periodEnd) => _$this._periodEnd = periodEnd;

  bool? _everSubscribed;
  bool? get everSubscribed => _$this._everSubscribed;
  set everSubscribed(bool? everSubscribed) =>
      _$this._everSubscribed = everSubscribed;

  bool? _paid;
  bool? get paid => _$this._paid;
  set paid(bool? paid) => _$this._paid = paid;

  int? _monthlyPrice;
  int? get monthlyPrice => _$this._monthlyPrice;
  set monthlyPrice(int? monthlyPrice) => _$this._monthlyPrice = monthlyPrice;

  FinanceAddonResponseBuilder() {
    FinanceAddonResponse._defaults(this);
  }

  FinanceAddonResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _active = $v.active;
      _periodEnd = $v.periodEnd;
      _everSubscribed = $v.everSubscribed;
      _paid = $v.paid;
      _monthlyPrice = $v.monthlyPrice;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceAddonResponse other) {
    _$v = other as _$FinanceAddonResponse;
  }

  @override
  void update(void Function(FinanceAddonResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceAddonResponse build() => _build();

  _$FinanceAddonResponse _build() {
    final _$result =
        _$v ??
        _$FinanceAddonResponse._(
          active: active,
          periodEnd: periodEnd,
          everSubscribed: everSubscribed,
          paid: paid,
          monthlyPrice: monthlyPrice,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
