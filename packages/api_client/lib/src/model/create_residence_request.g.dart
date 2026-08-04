// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_residence_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateResidenceRequest extends CreateResidenceRequest {
  @override
  final String name;
  @override
  final String districtId;
  @override
  final String exactAddress;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final Date availableFrom;
  @override
  final String? description;
  @override
  final BuiltList<String>? photoKeys;
  @override
  final BuiltList<UnitGroup> units;

  factory _$CreateResidenceRequest([
    void Function(CreateResidenceRequestBuilder)? updates,
  ]) => (CreateResidenceRequestBuilder()..update(updates))._build();

  _$CreateResidenceRequest._({
    required this.name,
    required this.districtId,
    required this.exactAddress,
    required this.latitude,
    required this.longitude,
    required this.availableFrom,
    this.description,
    this.photoKeys,
    required this.units,
  }) : super._();
  @override
  CreateResidenceRequest rebuild(
    void Function(CreateResidenceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateResidenceRequestBuilder toBuilder() =>
      CreateResidenceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateResidenceRequest &&
        name == other.name &&
        districtId == other.districtId &&
        exactAddress == other.exactAddress &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        availableFrom == other.availableFrom &&
        description == other.description &&
        photoKeys == other.photoKeys &&
        units == other.units;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, districtId.hashCode);
    _$hash = $jc(_$hash, exactAddress.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, availableFrom.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, photoKeys.hashCode);
    _$hash = $jc(_$hash, units.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateResidenceRequest')
          ..add('name', name)
          ..add('districtId', districtId)
          ..add('exactAddress', exactAddress)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('availableFrom', availableFrom)
          ..add('description', description)
          ..add('photoKeys', photoKeys)
          ..add('units', units))
        .toString();
  }
}

class CreateResidenceRequestBuilder
    implements Builder<CreateResidenceRequest, CreateResidenceRequestBuilder> {
  _$CreateResidenceRequest? _$v;

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

  Date? _availableFrom;
  Date? get availableFrom => _$this._availableFrom;
  set availableFrom(Date? availableFrom) =>
      _$this._availableFrom = availableFrom;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ListBuilder<String>? _photoKeys;
  ListBuilder<String> get photoKeys =>
      _$this._photoKeys ??= ListBuilder<String>();
  set photoKeys(ListBuilder<String>? photoKeys) =>
      _$this._photoKeys = photoKeys;

  ListBuilder<UnitGroup>? _units;
  ListBuilder<UnitGroup> get units =>
      _$this._units ??= ListBuilder<UnitGroup>();
  set units(ListBuilder<UnitGroup>? units) => _$this._units = units;

  CreateResidenceRequestBuilder() {
    CreateResidenceRequest._defaults(this);
  }

  CreateResidenceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _districtId = $v.districtId;
      _exactAddress = $v.exactAddress;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _availableFrom = $v.availableFrom;
      _description = $v.description;
      _photoKeys = $v.photoKeys?.toBuilder();
      _units = $v.units.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateResidenceRequest other) {
    _$v = other as _$CreateResidenceRequest;
  }

  @override
  void update(void Function(CreateResidenceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateResidenceRequest build() => _build();

  _$CreateResidenceRequest _build() {
    _$CreateResidenceRequest _$result;
    try {
      _$result =
          _$v ??
          _$CreateResidenceRequest._(
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'CreateResidenceRequest',
              'name',
            ),
            districtId: BuiltValueNullFieldError.checkNotNull(
              districtId,
              r'CreateResidenceRequest',
              'districtId',
            ),
            exactAddress: BuiltValueNullFieldError.checkNotNull(
              exactAddress,
              r'CreateResidenceRequest',
              'exactAddress',
            ),
            latitude: BuiltValueNullFieldError.checkNotNull(
              latitude,
              r'CreateResidenceRequest',
              'latitude',
            ),
            longitude: BuiltValueNullFieldError.checkNotNull(
              longitude,
              r'CreateResidenceRequest',
              'longitude',
            ),
            availableFrom: BuiltValueNullFieldError.checkNotNull(
              availableFrom,
              r'CreateResidenceRequest',
              'availableFrom',
            ),
            description: description,
            photoKeys: _photoKeys?.build(),
            units: units.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'photoKeys';
        _photoKeys?.build();
        _$failedField = 'units';
        units.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CreateResidenceRequest',
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
