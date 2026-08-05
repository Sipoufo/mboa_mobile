// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_plan_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdatePlanRequest extends UpdatePlanRequest {
  @override
  final int? monthlyPrice;
  @override
  final int? activeListingLimit;
  @override
  final int? residenceUnitAllowance;

  factory _$UpdatePlanRequest([
    void Function(UpdatePlanRequestBuilder)? updates,
  ]) => (UpdatePlanRequestBuilder()..update(updates))._build();

  _$UpdatePlanRequest._({
    this.monthlyPrice,
    this.activeListingLimit,
    this.residenceUnitAllowance,
  }) : super._();
  @override
  UpdatePlanRequest rebuild(void Function(UpdatePlanRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdatePlanRequestBuilder toBuilder() =>
      UpdatePlanRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdatePlanRequest &&
        monthlyPrice == other.monthlyPrice &&
        activeListingLimit == other.activeListingLimit &&
        residenceUnitAllowance == other.residenceUnitAllowance;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, monthlyPrice.hashCode);
    _$hash = $jc(_$hash, activeListingLimit.hashCode);
    _$hash = $jc(_$hash, residenceUnitAllowance.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdatePlanRequest')
          ..add('monthlyPrice', monthlyPrice)
          ..add('activeListingLimit', activeListingLimit)
          ..add('residenceUnitAllowance', residenceUnitAllowance))
        .toString();
  }
}

class UpdatePlanRequestBuilder
    implements Builder<UpdatePlanRequest, UpdatePlanRequestBuilder> {
  _$UpdatePlanRequest? _$v;

  int? _monthlyPrice;
  int? get monthlyPrice => _$this._monthlyPrice;
  set monthlyPrice(int? monthlyPrice) => _$this._monthlyPrice = monthlyPrice;

  int? _activeListingLimit;
  int? get activeListingLimit => _$this._activeListingLimit;
  set activeListingLimit(int? activeListingLimit) =>
      _$this._activeListingLimit = activeListingLimit;

  int? _residenceUnitAllowance;
  int? get residenceUnitAllowance => _$this._residenceUnitAllowance;
  set residenceUnitAllowance(int? residenceUnitAllowance) =>
      _$this._residenceUnitAllowance = residenceUnitAllowance;

  UpdatePlanRequestBuilder() {
    UpdatePlanRequest._defaults(this);
  }

  UpdatePlanRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _monthlyPrice = $v.monthlyPrice;
      _activeListingLimit = $v.activeListingLimit;
      _residenceUnitAllowance = $v.residenceUnitAllowance;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdatePlanRequest other) {
    _$v = other as _$UpdatePlanRequest;
  }

  @override
  void update(void Function(UpdatePlanRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdatePlanRequest build() => _build();

  _$UpdatePlanRequest _build() {
    final _$result =
        _$v ??
        _$UpdatePlanRequest._(
          monthlyPrice: monthlyPrice,
          activeListingLimit: activeListingLimit,
          residenceUnitAllowance: residenceUnitAllowance,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
