// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_addon_price_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateAddonPriceRequest extends UpdateAddonPriceRequest {
  @override
  final int? monthlyPrice;

  factory _$UpdateAddonPriceRequest([
    void Function(UpdateAddonPriceRequestBuilder)? updates,
  ]) => (UpdateAddonPriceRequestBuilder()..update(updates))._build();

  _$UpdateAddonPriceRequest._({this.monthlyPrice}) : super._();
  @override
  UpdateAddonPriceRequest rebuild(
    void Function(UpdateAddonPriceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateAddonPriceRequestBuilder toBuilder() =>
      UpdateAddonPriceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateAddonPriceRequest &&
        monthlyPrice == other.monthlyPrice;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, monthlyPrice.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'UpdateAddonPriceRequest',
    )..add('monthlyPrice', monthlyPrice)).toString();
  }
}

class UpdateAddonPriceRequestBuilder
    implements
        Builder<UpdateAddonPriceRequest, UpdateAddonPriceRequestBuilder> {
  _$UpdateAddonPriceRequest? _$v;

  int? _monthlyPrice;
  int? get monthlyPrice => _$this._monthlyPrice;
  set monthlyPrice(int? monthlyPrice) => _$this._monthlyPrice = monthlyPrice;

  UpdateAddonPriceRequestBuilder() {
    UpdateAddonPriceRequest._defaults(this);
  }

  UpdateAddonPriceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _monthlyPrice = $v.monthlyPrice;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateAddonPriceRequest other) {
    _$v = other as _$UpdateAddonPriceRequest;
  }

  @override
  void update(void Function(UpdateAddonPriceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateAddonPriceRequest build() => _build();

  _$UpdateAddonPriceRequest _build() {
    final _$result =
        _$v ?? _$UpdateAddonPriceRequest._(monthlyPrice: monthlyPrice);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
