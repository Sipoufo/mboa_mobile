// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ZoneResponse extends ZoneResponse {
  @override
  final String? cityId;
  @override
  final String? districtId;

  factory _$ZoneResponse([void Function(ZoneResponseBuilder)? updates]) =>
      (ZoneResponseBuilder()..update(updates))._build();

  _$ZoneResponse._({this.cityId, this.districtId}) : super._();
  @override
  ZoneResponse rebuild(void Function(ZoneResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ZoneResponseBuilder toBuilder() => ZoneResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ZoneResponse &&
        cityId == other.cityId &&
        districtId == other.districtId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, cityId.hashCode);
    _$hash = $jc(_$hash, districtId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ZoneResponse')
          ..add('cityId', cityId)
          ..add('districtId', districtId))
        .toString();
  }
}

class ZoneResponseBuilder
    implements Builder<ZoneResponse, ZoneResponseBuilder> {
  _$ZoneResponse? _$v;

  String? _cityId;
  String? get cityId => _$this._cityId;
  set cityId(String? cityId) => _$this._cityId = cityId;

  String? _districtId;
  String? get districtId => _$this._districtId;
  set districtId(String? districtId) => _$this._districtId = districtId;

  ZoneResponseBuilder() {
    ZoneResponse._defaults(this);
  }

  ZoneResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cityId = $v.cityId;
      _districtId = $v.districtId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ZoneResponse other) {
    _$v = other as _$ZoneResponse;
  }

  @override
  void update(void Function(ZoneResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ZoneResponse build() => _build();

  _$ZoneResponse _build() {
    final _$result =
        _$v ?? _$ZoneResponse._(cityId: cityId, districtId: districtId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
