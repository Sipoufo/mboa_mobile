// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_address.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$KycAddress extends KycAddress {
  @override
  final String? districtId;
  @override
  final String? city;
  @override
  final String? district;
  @override
  final String? details;

  factory _$KycAddress([void Function(KycAddressBuilder)? updates]) =>
      (KycAddressBuilder()..update(updates))._build();

  _$KycAddress._({this.districtId, this.city, this.district, this.details})
    : super._();
  @override
  KycAddress rebuild(void Function(KycAddressBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KycAddressBuilder toBuilder() => KycAddressBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KycAddress &&
        districtId == other.districtId &&
        city == other.city &&
        district == other.district &&
        details == other.details;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, districtId.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, district.hashCode);
    _$hash = $jc(_$hash, details.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KycAddress')
          ..add('districtId', districtId)
          ..add('city', city)
          ..add('district', district)
          ..add('details', details))
        .toString();
  }
}

class KycAddressBuilder implements Builder<KycAddress, KycAddressBuilder> {
  _$KycAddress? _$v;

  String? _districtId;
  String? get districtId => _$this._districtId;
  set districtId(String? districtId) => _$this._districtId = districtId;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _district;
  String? get district => _$this._district;
  set district(String? district) => _$this._district = district;

  String? _details;
  String? get details => _$this._details;
  set details(String? details) => _$this._details = details;

  KycAddressBuilder() {
    KycAddress._defaults(this);
  }

  KycAddressBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _districtId = $v.districtId;
      _city = $v.city;
      _district = $v.district;
      _details = $v.details;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KycAddress other) {
    _$v = other as _$KycAddress;
  }

  @override
  void update(void Function(KycAddressBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KycAddress build() => _build();

  _$KycAddress _build() {
    final _$result =
        _$v ??
        _$KycAddress._(
          districtId: districtId,
          city: city,
          district: district,
          details: details,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
