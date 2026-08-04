// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_residence_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateResidenceRequest extends UpdateResidenceRequest {
  @override
  final String? name;
  @override
  final String? districtId;
  @override
  final String? exactAddress;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? description;
  @override
  final BuiltList<String>? photoKeys;

  factory _$UpdateResidenceRequest([
    void Function(UpdateResidenceRequestBuilder)? updates,
  ]) => (UpdateResidenceRequestBuilder()..update(updates))._build();

  _$UpdateResidenceRequest._({
    this.name,
    this.districtId,
    this.exactAddress,
    this.latitude,
    this.longitude,
    this.description,
    this.photoKeys,
  }) : super._();
  @override
  UpdateResidenceRequest rebuild(
    void Function(UpdateResidenceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateResidenceRequestBuilder toBuilder() =>
      UpdateResidenceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateResidenceRequest &&
        name == other.name &&
        districtId == other.districtId &&
        exactAddress == other.exactAddress &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        description == other.description &&
        photoKeys == other.photoKeys;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, districtId.hashCode);
    _$hash = $jc(_$hash, exactAddress.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, photoKeys.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateResidenceRequest')
          ..add('name', name)
          ..add('districtId', districtId)
          ..add('exactAddress', exactAddress)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('description', description)
          ..add('photoKeys', photoKeys))
        .toString();
  }
}

class UpdateResidenceRequestBuilder
    implements Builder<UpdateResidenceRequest, UpdateResidenceRequestBuilder> {
  _$UpdateResidenceRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _districtId;
  String? get districtId => _$this._districtId;
  set districtId(String? districtId) => _$this._districtId = districtId;

  String? _exactAddress;
  String? get exactAddress => _$this._exactAddress;
  set exactAddress(String? exactAddress) => _$this._exactAddress = exactAddress;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ListBuilder<String>? _photoKeys;
  ListBuilder<String> get photoKeys =>
      _$this._photoKeys ??= ListBuilder<String>();
  set photoKeys(ListBuilder<String>? photoKeys) =>
      _$this._photoKeys = photoKeys;

  UpdateResidenceRequestBuilder() {
    UpdateResidenceRequest._defaults(this);
  }

  UpdateResidenceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _districtId = $v.districtId;
      _exactAddress = $v.exactAddress;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _description = $v.description;
      _photoKeys = $v.photoKeys?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateResidenceRequest other) {
    _$v = other as _$UpdateResidenceRequest;
  }

  @override
  void update(void Function(UpdateResidenceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateResidenceRequest build() => _build();

  _$UpdateResidenceRequest _build() {
    _$UpdateResidenceRequest _$result;
    try {
      _$result =
          _$v ??
          _$UpdateResidenceRequest._(
            name: name,
            districtId: districtId,
            exactAddress: exactAddress,
            latitude: latitude,
            longitude: longitude,
            description: description,
            photoKeys: _photoKeys?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'photoKeys';
        _photoKeys?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UpdateResidenceRequest',
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
