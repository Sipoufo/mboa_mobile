// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Zone extends Zone {
  @override
  final String? city;
  @override
  final String? district;

  factory _$Zone([void Function(ZoneBuilder)? updates]) =>
      (ZoneBuilder()..update(updates))._build();

  _$Zone._({this.city, this.district}) : super._();
  @override
  Zone rebuild(void Function(ZoneBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ZoneBuilder toBuilder() => ZoneBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Zone && city == other.city && district == other.district;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, district.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Zone')
          ..add('city', city)
          ..add('district', district))
        .toString();
  }
}

class ZoneBuilder implements Builder<Zone, ZoneBuilder> {
  _$Zone? _$v;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _district;
  String? get district => _$this._district;
  set district(String? district) => _$this._district = district;

  ZoneBuilder() {
    Zone._defaults(this);
  }

  ZoneBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _city = $v.city;
      _district = $v.district;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Zone other) {
    _$v = other as _$Zone;
  }

  @override
  void update(void Function(ZoneBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Zone build() => _build();

  _$Zone _build() {
    final _$result = _$v ?? _$Zone._(city: city, district: district);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
