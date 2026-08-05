// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annonce_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AnnonceResponsePropertyTypeEnum
_$annonceResponsePropertyTypeEnum_APARTMENT =
    const AnnonceResponsePropertyTypeEnum._('APARTMENT');
const AnnonceResponsePropertyTypeEnum _$annonceResponsePropertyTypeEnum_STUDIO =
    const AnnonceResponsePropertyTypeEnum._('STUDIO');
const AnnonceResponsePropertyTypeEnum _$annonceResponsePropertyTypeEnum_VILLA =
    const AnnonceResponsePropertyTypeEnum._('VILLA');
const AnnonceResponsePropertyTypeEnum _$annonceResponsePropertyTypeEnum_ROOM =
    const AnnonceResponsePropertyTypeEnum._('ROOM');
const AnnonceResponsePropertyTypeEnum _$annonceResponsePropertyTypeEnum_OFFICE =
    const AnnonceResponsePropertyTypeEnum._('OFFICE');
const AnnonceResponsePropertyTypeEnum
_$annonceResponsePropertyTypeEnum_COMMERCIAL_SPACE =
    const AnnonceResponsePropertyTypeEnum._('COMMERCIAL_SPACE');
const AnnonceResponsePropertyTypeEnum
_$annonceResponsePropertyTypeEnum_unknownDefaultOpenApi =
    const AnnonceResponsePropertyTypeEnum._('unknownDefaultOpenApi');

AnnonceResponsePropertyTypeEnum _$annonceResponsePropertyTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'APARTMENT':
      return _$annonceResponsePropertyTypeEnum_APARTMENT;
    case 'STUDIO':
      return _$annonceResponsePropertyTypeEnum_STUDIO;
    case 'VILLA':
      return _$annonceResponsePropertyTypeEnum_VILLA;
    case 'ROOM':
      return _$annonceResponsePropertyTypeEnum_ROOM;
    case 'OFFICE':
      return _$annonceResponsePropertyTypeEnum_OFFICE;
    case 'COMMERCIAL_SPACE':
      return _$annonceResponsePropertyTypeEnum_COMMERCIAL_SPACE;
    case 'unknownDefaultOpenApi':
      return _$annonceResponsePropertyTypeEnum_unknownDefaultOpenApi;
    default:
      return _$annonceResponsePropertyTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AnnonceResponsePropertyTypeEnum>
_$annonceResponsePropertyTypeEnumValues =
    BuiltSet<AnnonceResponsePropertyTypeEnum>(
      const <AnnonceResponsePropertyTypeEnum>[
        _$annonceResponsePropertyTypeEnum_APARTMENT,
        _$annonceResponsePropertyTypeEnum_STUDIO,
        _$annonceResponsePropertyTypeEnum_VILLA,
        _$annonceResponsePropertyTypeEnum_ROOM,
        _$annonceResponsePropertyTypeEnum_OFFICE,
        _$annonceResponsePropertyTypeEnum_COMMERCIAL_SPACE,
        _$annonceResponsePropertyTypeEnum_unknownDefaultOpenApi,
      ],
    );

const AnnonceResponseStatusEnum _$annonceResponseStatusEnum_DRAFT =
    const AnnonceResponseStatusEnum._('DRAFT');
const AnnonceResponseStatusEnum _$annonceResponseStatusEnum_PUBLISHED =
    const AnnonceResponseStatusEnum._('PUBLISHED');
const AnnonceResponseStatusEnum _$annonceResponseStatusEnum_RESERVED =
    const AnnonceResponseStatusEnum._('RESERVED');
const AnnonceResponseStatusEnum _$annonceResponseStatusEnum_RENTED =
    const AnnonceResponseStatusEnum._('RENTED');
const AnnonceResponseStatusEnum _$annonceResponseStatusEnum_ARCHIVED =
    const AnnonceResponseStatusEnum._('ARCHIVED');
const AnnonceResponseStatusEnum
_$annonceResponseStatusEnum_unknownDefaultOpenApi =
    const AnnonceResponseStatusEnum._('unknownDefaultOpenApi');

AnnonceResponseStatusEnum _$annonceResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'DRAFT':
      return _$annonceResponseStatusEnum_DRAFT;
    case 'PUBLISHED':
      return _$annonceResponseStatusEnum_PUBLISHED;
    case 'RESERVED':
      return _$annonceResponseStatusEnum_RESERVED;
    case 'RENTED':
      return _$annonceResponseStatusEnum_RENTED;
    case 'ARCHIVED':
      return _$annonceResponseStatusEnum_ARCHIVED;
    case 'unknownDefaultOpenApi':
      return _$annonceResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$annonceResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AnnonceResponseStatusEnum> _$annonceResponseStatusEnumValues =
    BuiltSet<AnnonceResponseStatusEnum>(const <AnnonceResponseStatusEnum>[
      _$annonceResponseStatusEnum_DRAFT,
      _$annonceResponseStatusEnum_PUBLISHED,
      _$annonceResponseStatusEnum_RESERVED,
      _$annonceResponseStatusEnum_RENTED,
      _$annonceResponseStatusEnum_ARCHIVED,
      _$annonceResponseStatusEnum_unknownDefaultOpenApi,
    ]);

Serializer<AnnonceResponsePropertyTypeEnum>
_$annonceResponsePropertyTypeEnumSerializer =
    _$AnnonceResponsePropertyTypeEnumSerializer();
Serializer<AnnonceResponseStatusEnum> _$annonceResponseStatusEnumSerializer =
    _$AnnonceResponseStatusEnumSerializer();

class _$AnnonceResponsePropertyTypeEnumSerializer
    implements PrimitiveSerializer<AnnonceResponsePropertyTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'APARTMENT': 'APARTMENT',
    'STUDIO': 'STUDIO',
    'VILLA': 'VILLA',
    'ROOM': 'ROOM',
    'OFFICE': 'OFFICE',
    'COMMERCIAL_SPACE': 'COMMERCIAL_SPACE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'APARTMENT': 'APARTMENT',
    'STUDIO': 'STUDIO',
    'VILLA': 'VILLA',
    'ROOM': 'ROOM',
    'OFFICE': 'OFFICE',
    'COMMERCIAL_SPACE': 'COMMERCIAL_SPACE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AnnonceResponsePropertyTypeEnum];
  @override
  final String wireName = 'AnnonceResponsePropertyTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AnnonceResponsePropertyTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AnnonceResponsePropertyTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AnnonceResponsePropertyTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AnnonceResponseStatusEnumSerializer
    implements PrimitiveSerializer<AnnonceResponseStatusEnum> {
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
  final Iterable<Type> types = const <Type>[AnnonceResponseStatusEnum];
  @override
  final String wireName = 'AnnonceResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    AnnonceResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AnnonceResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AnnonceResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AnnonceResponse extends AnnonceResponse {
  @override
  final String? id;
  @override
  final String? residenceId;
  @override
  final AnnonceResponsePropertyTypeEnum? propertyType;
  @override
  final String? title;
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
  final int? monthlyRent;
  @override
  final bool? chargesIncluded;
  @override
  final int? chargesAmount;
  @override
  final int? surfaceArea;
  @override
  final int? roomCount;
  @override
  final int? bathroomCount;
  @override
  final bool? furnished;
  @override
  final Date? availableFrom;
  @override
  final String? description;
  @override
  final AnnonceResponseStatusEnum? status;
  @override
  final int? tierRank;
  @override
  final BuiltList<String>? photoKeys;
  @override
  final DateTime? publishedAt;
  @override
  final DateTime? expiresAt;
  @override
  final DateTime? createdAt;

  factory _$AnnonceResponse([void Function(AnnonceResponseBuilder)? updates]) =>
      (AnnonceResponseBuilder()..update(updates))._build();

  _$AnnonceResponse._({
    this.id,
    this.residenceId,
    this.propertyType,
    this.title,
    this.cityId,
    this.city,
    this.districtId,
    this.district,
    this.exactAddress,
    this.latitude,
    this.longitude,
    this.monthlyRent,
    this.chargesIncluded,
    this.chargesAmount,
    this.surfaceArea,
    this.roomCount,
    this.bathroomCount,
    this.furnished,
    this.availableFrom,
    this.description,
    this.status,
    this.tierRank,
    this.photoKeys,
    this.publishedAt,
    this.expiresAt,
    this.createdAt,
  }) : super._();
  @override
  AnnonceResponse rebuild(void Function(AnnonceResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AnnonceResponseBuilder toBuilder() => AnnonceResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AnnonceResponse &&
        id == other.id &&
        residenceId == other.residenceId &&
        propertyType == other.propertyType &&
        title == other.title &&
        cityId == other.cityId &&
        city == other.city &&
        districtId == other.districtId &&
        district == other.district &&
        exactAddress == other.exactAddress &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        monthlyRent == other.monthlyRent &&
        chargesIncluded == other.chargesIncluded &&
        chargesAmount == other.chargesAmount &&
        surfaceArea == other.surfaceArea &&
        roomCount == other.roomCount &&
        bathroomCount == other.bathroomCount &&
        furnished == other.furnished &&
        availableFrom == other.availableFrom &&
        description == other.description &&
        status == other.status &&
        tierRank == other.tierRank &&
        photoKeys == other.photoKeys &&
        publishedAt == other.publishedAt &&
        expiresAt == other.expiresAt &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, residenceId.hashCode);
    _$hash = $jc(_$hash, propertyType.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, cityId.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, districtId.hashCode);
    _$hash = $jc(_$hash, district.hashCode);
    _$hash = $jc(_$hash, exactAddress.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, monthlyRent.hashCode);
    _$hash = $jc(_$hash, chargesIncluded.hashCode);
    _$hash = $jc(_$hash, chargesAmount.hashCode);
    _$hash = $jc(_$hash, surfaceArea.hashCode);
    _$hash = $jc(_$hash, roomCount.hashCode);
    _$hash = $jc(_$hash, bathroomCount.hashCode);
    _$hash = $jc(_$hash, furnished.hashCode);
    _$hash = $jc(_$hash, availableFrom.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, tierRank.hashCode);
    _$hash = $jc(_$hash, photoKeys.hashCode);
    _$hash = $jc(_$hash, publishedAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AnnonceResponse')
          ..add('id', id)
          ..add('residenceId', residenceId)
          ..add('propertyType', propertyType)
          ..add('title', title)
          ..add('cityId', cityId)
          ..add('city', city)
          ..add('districtId', districtId)
          ..add('district', district)
          ..add('exactAddress', exactAddress)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('monthlyRent', monthlyRent)
          ..add('chargesIncluded', chargesIncluded)
          ..add('chargesAmount', chargesAmount)
          ..add('surfaceArea', surfaceArea)
          ..add('roomCount', roomCount)
          ..add('bathroomCount', bathroomCount)
          ..add('furnished', furnished)
          ..add('availableFrom', availableFrom)
          ..add('description', description)
          ..add('status', status)
          ..add('tierRank', tierRank)
          ..add('photoKeys', photoKeys)
          ..add('publishedAt', publishedAt)
          ..add('expiresAt', expiresAt)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class AnnonceResponseBuilder
    implements Builder<AnnonceResponse, AnnonceResponseBuilder> {
  _$AnnonceResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _residenceId;
  String? get residenceId => _$this._residenceId;
  set residenceId(String? residenceId) => _$this._residenceId = residenceId;

  AnnonceResponsePropertyTypeEnum? _propertyType;
  AnnonceResponsePropertyTypeEnum? get propertyType => _$this._propertyType;
  set propertyType(AnnonceResponsePropertyTypeEnum? propertyType) =>
      _$this._propertyType = propertyType;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

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

  int? _monthlyRent;
  int? get monthlyRent => _$this._monthlyRent;
  set monthlyRent(int? monthlyRent) => _$this._monthlyRent = monthlyRent;

  bool? _chargesIncluded;
  bool? get chargesIncluded => _$this._chargesIncluded;
  set chargesIncluded(bool? chargesIncluded) =>
      _$this._chargesIncluded = chargesIncluded;

  int? _chargesAmount;
  int? get chargesAmount => _$this._chargesAmount;
  set chargesAmount(int? chargesAmount) =>
      _$this._chargesAmount = chargesAmount;

  int? _surfaceArea;
  int? get surfaceArea => _$this._surfaceArea;
  set surfaceArea(int? surfaceArea) => _$this._surfaceArea = surfaceArea;

  int? _roomCount;
  int? get roomCount => _$this._roomCount;
  set roomCount(int? roomCount) => _$this._roomCount = roomCount;

  int? _bathroomCount;
  int? get bathroomCount => _$this._bathroomCount;
  set bathroomCount(int? bathroomCount) =>
      _$this._bathroomCount = bathroomCount;

  bool? _furnished;
  bool? get furnished => _$this._furnished;
  set furnished(bool? furnished) => _$this._furnished = furnished;

  Date? _availableFrom;
  Date? get availableFrom => _$this._availableFrom;
  set availableFrom(Date? availableFrom) =>
      _$this._availableFrom = availableFrom;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  AnnonceResponseStatusEnum? _status;
  AnnonceResponseStatusEnum? get status => _$this._status;
  set status(AnnonceResponseStatusEnum? status) => _$this._status = status;

  int? _tierRank;
  int? get tierRank => _$this._tierRank;
  set tierRank(int? tierRank) => _$this._tierRank = tierRank;

  ListBuilder<String>? _photoKeys;
  ListBuilder<String> get photoKeys =>
      _$this._photoKeys ??= ListBuilder<String>();
  set photoKeys(ListBuilder<String>? photoKeys) =>
      _$this._photoKeys = photoKeys;

  DateTime? _publishedAt;
  DateTime? get publishedAt => _$this._publishedAt;
  set publishedAt(DateTime? publishedAt) => _$this._publishedAt = publishedAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  AnnonceResponseBuilder() {
    AnnonceResponse._defaults(this);
  }

  AnnonceResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _residenceId = $v.residenceId;
      _propertyType = $v.propertyType;
      _title = $v.title;
      _cityId = $v.cityId;
      _city = $v.city;
      _districtId = $v.districtId;
      _district = $v.district;
      _exactAddress = $v.exactAddress;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _monthlyRent = $v.monthlyRent;
      _chargesIncluded = $v.chargesIncluded;
      _chargesAmount = $v.chargesAmount;
      _surfaceArea = $v.surfaceArea;
      _roomCount = $v.roomCount;
      _bathroomCount = $v.bathroomCount;
      _furnished = $v.furnished;
      _availableFrom = $v.availableFrom;
      _description = $v.description;
      _status = $v.status;
      _tierRank = $v.tierRank;
      _photoKeys = $v.photoKeys?.toBuilder();
      _publishedAt = $v.publishedAt;
      _expiresAt = $v.expiresAt;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AnnonceResponse other) {
    _$v = other as _$AnnonceResponse;
  }

  @override
  void update(void Function(AnnonceResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AnnonceResponse build() => _build();

  _$AnnonceResponse _build() {
    _$AnnonceResponse _$result;
    try {
      _$result =
          _$v ??
          _$AnnonceResponse._(
            id: id,
            residenceId: residenceId,
            propertyType: propertyType,
            title: title,
            cityId: cityId,
            city: city,
            districtId: districtId,
            district: district,
            exactAddress: exactAddress,
            latitude: latitude,
            longitude: longitude,
            monthlyRent: monthlyRent,
            chargesIncluded: chargesIncluded,
            chargesAmount: chargesAmount,
            surfaceArea: surfaceArea,
            roomCount: roomCount,
            bathroomCount: bathroomCount,
            furnished: furnished,
            availableFrom: availableFrom,
            description: description,
            status: status,
            tierRank: tierRank,
            photoKeys: _photoKeys?.build(),
            publishedAt: publishedAt,
            expiresAt: expiresAt,
            createdAt: createdAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'photoKeys';
        _photoKeys?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AnnonceResponse',
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
