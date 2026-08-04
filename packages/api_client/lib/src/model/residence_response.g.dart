// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'residence_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ResidenceResponseStatusEnum _$residenceResponseStatusEnum_DRAFT =
    const ResidenceResponseStatusEnum._('DRAFT');
const ResidenceResponseStatusEnum _$residenceResponseStatusEnum_PUBLISHED =
    const ResidenceResponseStatusEnum._('PUBLISHED');
const ResidenceResponseStatusEnum _$residenceResponseStatusEnum_RESERVED =
    const ResidenceResponseStatusEnum._('RESERVED');
const ResidenceResponseStatusEnum _$residenceResponseStatusEnum_RENTED =
    const ResidenceResponseStatusEnum._('RENTED');
const ResidenceResponseStatusEnum _$residenceResponseStatusEnum_ARCHIVED =
    const ResidenceResponseStatusEnum._('ARCHIVED');
const ResidenceResponseStatusEnum
_$residenceResponseStatusEnum_unknownDefaultOpenApi =
    const ResidenceResponseStatusEnum._('unknownDefaultOpenApi');

ResidenceResponseStatusEnum _$residenceResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'DRAFT':
      return _$residenceResponseStatusEnum_DRAFT;
    case 'PUBLISHED':
      return _$residenceResponseStatusEnum_PUBLISHED;
    case 'RESERVED':
      return _$residenceResponseStatusEnum_RESERVED;
    case 'RENTED':
      return _$residenceResponseStatusEnum_RENTED;
    case 'ARCHIVED':
      return _$residenceResponseStatusEnum_ARCHIVED;
    case 'unknownDefaultOpenApi':
      return _$residenceResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$residenceResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ResidenceResponseStatusEnum>
_$residenceResponseStatusEnumValues =
    BuiltSet<ResidenceResponseStatusEnum>(const <ResidenceResponseStatusEnum>[
      _$residenceResponseStatusEnum_DRAFT,
      _$residenceResponseStatusEnum_PUBLISHED,
      _$residenceResponseStatusEnum_RESERVED,
      _$residenceResponseStatusEnum_RENTED,
      _$residenceResponseStatusEnum_ARCHIVED,
      _$residenceResponseStatusEnum_unknownDefaultOpenApi,
    ]);

Serializer<ResidenceResponseStatusEnum>
_$residenceResponseStatusEnumSerializer =
    _$ResidenceResponseStatusEnumSerializer();

class _$ResidenceResponseStatusEnumSerializer
    implements PrimitiveSerializer<ResidenceResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'DRAFT': 'DRAFT',
    'PUBLISHED': 'PUBLISHED',
    'RESERVED': 'RESERVED',
    'RENTED': 'RENTED',
    'ARCHIVED': 'ARCHIVED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'DRAFT': 'DRAFT',
    'PUBLISHED': 'PUBLISHED',
    'RESERVED': 'RESERVED',
    'RENTED': 'RENTED',
    'ARCHIVED': 'ARCHIVED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ResidenceResponseStatusEnum];
  @override
  final String wireName = 'ResidenceResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    ResidenceResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ResidenceResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ResidenceResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ResidenceResponse extends ResidenceResponse {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? cityId;
  @override
  final String? city;
  @override
  final String? districtId;
  @override
  final String? district;
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
  @override
  final ResidenceResponseStatusEnum? status;
  @override
  final int? unitCount;
  @override
  final int? publishedUnitCount;
  @override
  final int? draftUnitCount;
  @override
  final int? reserveUnitCount;
  @override
  final BuiltList<UnitSummary>? units;
  @override
  final DateTime? createdAt;

  factory _$ResidenceResponse([
    void Function(ResidenceResponseBuilder)? updates,
  ]) => (ResidenceResponseBuilder()..update(updates))._build();

  _$ResidenceResponse._({
    this.id,
    this.name,
    this.cityId,
    this.city,
    this.districtId,
    this.district,
    this.exactAddress,
    this.latitude,
    this.longitude,
    this.description,
    this.photoKeys,
    this.status,
    this.unitCount,
    this.publishedUnitCount,
    this.draftUnitCount,
    this.reserveUnitCount,
    this.units,
    this.createdAt,
  }) : super._();
  @override
  ResidenceResponse rebuild(void Function(ResidenceResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResidenceResponseBuilder toBuilder() =>
      ResidenceResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResidenceResponse &&
        id == other.id &&
        name == other.name &&
        cityId == other.cityId &&
        city == other.city &&
        districtId == other.districtId &&
        district == other.district &&
        exactAddress == other.exactAddress &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        description == other.description &&
        photoKeys == other.photoKeys &&
        status == other.status &&
        unitCount == other.unitCount &&
        publishedUnitCount == other.publishedUnitCount &&
        draftUnitCount == other.draftUnitCount &&
        reserveUnitCount == other.reserveUnitCount &&
        units == other.units &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, cityId.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, districtId.hashCode);
    _$hash = $jc(_$hash, district.hashCode);
    _$hash = $jc(_$hash, exactAddress.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, photoKeys.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, unitCount.hashCode);
    _$hash = $jc(_$hash, publishedUnitCount.hashCode);
    _$hash = $jc(_$hash, draftUnitCount.hashCode);
    _$hash = $jc(_$hash, reserveUnitCount.hashCode);
    _$hash = $jc(_$hash, units.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResidenceResponse')
          ..add('id', id)
          ..add('name', name)
          ..add('cityId', cityId)
          ..add('city', city)
          ..add('districtId', districtId)
          ..add('district', district)
          ..add('exactAddress', exactAddress)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('description', description)
          ..add('photoKeys', photoKeys)
          ..add('status', status)
          ..add('unitCount', unitCount)
          ..add('publishedUnitCount', publishedUnitCount)
          ..add('draftUnitCount', draftUnitCount)
          ..add('reserveUnitCount', reserveUnitCount)
          ..add('units', units)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ResidenceResponseBuilder
    implements Builder<ResidenceResponse, ResidenceResponseBuilder> {
  _$ResidenceResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _cityId;
  String? get cityId => _$this._cityId;
  set cityId(String? cityId) => _$this._cityId = cityId;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _districtId;
  String? get districtId => _$this._districtId;
  set districtId(String? districtId) => _$this._districtId = districtId;

  String? _district;
  String? get district => _$this._district;
  set district(String? district) => _$this._district = district;

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

  ResidenceResponseStatusEnum? _status;
  ResidenceResponseStatusEnum? get status => _$this._status;
  set status(ResidenceResponseStatusEnum? status) => _$this._status = status;

  int? _unitCount;
  int? get unitCount => _$this._unitCount;
  set unitCount(int? unitCount) => _$this._unitCount = unitCount;

  int? _publishedUnitCount;
  int? get publishedUnitCount => _$this._publishedUnitCount;
  set publishedUnitCount(int? publishedUnitCount) =>
      _$this._publishedUnitCount = publishedUnitCount;

  int? _draftUnitCount;
  int? get draftUnitCount => _$this._draftUnitCount;
  set draftUnitCount(int? draftUnitCount) =>
      _$this._draftUnitCount = draftUnitCount;

  int? _reserveUnitCount;
  int? get reserveUnitCount => _$this._reserveUnitCount;
  set reserveUnitCount(int? reserveUnitCount) =>
      _$this._reserveUnitCount = reserveUnitCount;

  ListBuilder<UnitSummary>? _units;
  ListBuilder<UnitSummary> get units =>
      _$this._units ??= ListBuilder<UnitSummary>();
  set units(ListBuilder<UnitSummary>? units) => _$this._units = units;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ResidenceResponseBuilder() {
    ResidenceResponse._defaults(this);
  }

  ResidenceResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _cityId = $v.cityId;
      _city = $v.city;
      _districtId = $v.districtId;
      _district = $v.district;
      _exactAddress = $v.exactAddress;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _description = $v.description;
      _photoKeys = $v.photoKeys?.toBuilder();
      _status = $v.status;
      _unitCount = $v.unitCount;
      _publishedUnitCount = $v.publishedUnitCount;
      _draftUnitCount = $v.draftUnitCount;
      _reserveUnitCount = $v.reserveUnitCount;
      _units = $v.units?.toBuilder();
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResidenceResponse other) {
    _$v = other as _$ResidenceResponse;
  }

  @override
  void update(void Function(ResidenceResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResidenceResponse build() => _build();

  _$ResidenceResponse _build() {
    _$ResidenceResponse _$result;
    try {
      _$result =
          _$v ??
          _$ResidenceResponse._(
            id: id,
            name: name,
            cityId: cityId,
            city: city,
            districtId: districtId,
            district: district,
            exactAddress: exactAddress,
            latitude: latitude,
            longitude: longitude,
            description: description,
            photoKeys: _photoKeys?.build(),
            status: status,
            unitCount: unitCount,
            publishedUnitCount: publishedUnitCount,
            draftUnitCount: draftUnitCount,
            reserveUnitCount: reserveUnitCount,
            units: _units?.build(),
            createdAt: createdAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'photoKeys';
        _photoKeys?.build();

        _$failedField = 'units';
        _units?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ResidenceResponse',
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
