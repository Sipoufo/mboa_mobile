// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'residence_detail_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ResidenceDetailResponseBadgesEnum
_$residenceDetailResponseBadgesEnum_TRUSTED =
    const ResidenceDetailResponseBadgesEnum._('TRUSTED');
const ResidenceDetailResponseBadgesEnum
_$residenceDetailResponseBadgesEnum_RECERTIFIED =
    const ResidenceDetailResponseBadgesEnum._('RECERTIFIED');
const ResidenceDetailResponseBadgesEnum
_$residenceDetailResponseBadgesEnum_IDENTITY_VERIFIED =
    const ResidenceDetailResponseBadgesEnum._('IDENTITY_VERIFIED');
const ResidenceDetailResponseBadgesEnum
_$residenceDetailResponseBadgesEnum_PHOTOS_VERIFIED =
    const ResidenceDetailResponseBadgesEnum._('PHOTOS_VERIFIED');
const ResidenceDetailResponseBadgesEnum
_$residenceDetailResponseBadgesEnum_unknownDefaultOpenApi =
    const ResidenceDetailResponseBadgesEnum._('unknownDefaultOpenApi');

ResidenceDetailResponseBadgesEnum _$residenceDetailResponseBadgesEnumValueOf(
  String name,
) {
  switch (name) {
    case 'TRUSTED':
      return _$residenceDetailResponseBadgesEnum_TRUSTED;
    case 'RECERTIFIED':
      return _$residenceDetailResponseBadgesEnum_RECERTIFIED;
    case 'IDENTITY_VERIFIED':
      return _$residenceDetailResponseBadgesEnum_IDENTITY_VERIFIED;
    case 'PHOTOS_VERIFIED':
      return _$residenceDetailResponseBadgesEnum_PHOTOS_VERIFIED;
    case 'unknownDefaultOpenApi':
      return _$residenceDetailResponseBadgesEnum_unknownDefaultOpenApi;
    default:
      return _$residenceDetailResponseBadgesEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ResidenceDetailResponseBadgesEnum>
_$residenceDetailResponseBadgesEnumValues =
    BuiltSet<ResidenceDetailResponseBadgesEnum>(
      const <ResidenceDetailResponseBadgesEnum>[
        _$residenceDetailResponseBadgesEnum_TRUSTED,
        _$residenceDetailResponseBadgesEnum_RECERTIFIED,
        _$residenceDetailResponseBadgesEnum_IDENTITY_VERIFIED,
        _$residenceDetailResponseBadgesEnum_PHOTOS_VERIFIED,
        _$residenceDetailResponseBadgesEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<ResidenceDetailResponseBadgesEnum>
_$residenceDetailResponseBadgesEnumSerializer =
    _$ResidenceDetailResponseBadgesEnumSerializer();

class _$ResidenceDetailResponseBadgesEnumSerializer
    implements PrimitiveSerializer<ResidenceDetailResponseBadgesEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'TRUSTED': 'TRUSTED',
    'RECERTIFIED': 'RECERTIFIED',
    'IDENTITY_VERIFIED': 'IDENTITY_VERIFIED',
    'PHOTOS_VERIFIED': 'PHOTOS_VERIFIED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'TRUSTED': 'TRUSTED',
    'RECERTIFIED': 'RECERTIFIED',
    'IDENTITY_VERIFIED': 'IDENTITY_VERIFIED',
    'PHOTOS_VERIFIED': 'PHOTOS_VERIFIED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ResidenceDetailResponseBadgesEnum];
  @override
  final String wireName = 'ResidenceDetailResponseBadgesEnum';

  @override
  Object serialize(
    Serializers serializers,
    ResidenceDetailResponseBadgesEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ResidenceDetailResponseBadgesEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ResidenceDetailResponseBadgesEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ResidenceDetailResponse extends ResidenceDetailResponse {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? city;
  @override
  final String? district;
  @override
  final String? description;
  @override
  final BuiltList<String>? photoKeys;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final BuiltList<SearchResultItem>? units;
  @override
  final bool? exactLocation;
  @override
  final ProviderCard? provider;
  @override
  final BuiltList<ResidenceDetailResponseBadgesEnum>? badges;
  @override
  final PropertyRating? rating;

  factory _$ResidenceDetailResponse([
    void Function(ResidenceDetailResponseBuilder)? updates,
  ]) => (ResidenceDetailResponseBuilder()..update(updates))._build();

  _$ResidenceDetailResponse._({
    this.id,
    this.name,
    this.city,
    this.district,
    this.description,
    this.photoKeys,
    this.latitude,
    this.longitude,
    this.units,
    this.exactLocation,
    this.provider,
    this.badges,
    this.rating,
  }) : super._();
  @override
  ResidenceDetailResponse rebuild(
    void Function(ResidenceDetailResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ResidenceDetailResponseBuilder toBuilder() =>
      ResidenceDetailResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResidenceDetailResponse &&
        id == other.id &&
        name == other.name &&
        city == other.city &&
        district == other.district &&
        description == other.description &&
        photoKeys == other.photoKeys &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        units == other.units &&
        exactLocation == other.exactLocation &&
        provider == other.provider &&
        badges == other.badges &&
        rating == other.rating;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, district.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, photoKeys.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, units.hashCode);
    _$hash = $jc(_$hash, exactLocation.hashCode);
    _$hash = $jc(_$hash, provider.hashCode);
    _$hash = $jc(_$hash, badges.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResidenceDetailResponse')
          ..add('id', id)
          ..add('name', name)
          ..add('city', city)
          ..add('district', district)
          ..add('description', description)
          ..add('photoKeys', photoKeys)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('units', units)
          ..add('exactLocation', exactLocation)
          ..add('provider', provider)
          ..add('badges', badges)
          ..add('rating', rating))
        .toString();
  }
}

class ResidenceDetailResponseBuilder
    implements
        Builder<ResidenceDetailResponse, ResidenceDetailResponseBuilder> {
  _$ResidenceDetailResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _district;
  String? get district => _$this._district;
  set district(String? district) => _$this._district = district;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ListBuilder<String>? _photoKeys;
  ListBuilder<String> get photoKeys =>
      _$this._photoKeys ??= ListBuilder<String>();
  set photoKeys(ListBuilder<String>? photoKeys) =>
      _$this._photoKeys = photoKeys;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  ListBuilder<SearchResultItem>? _units;
  ListBuilder<SearchResultItem> get units =>
      _$this._units ??= ListBuilder<SearchResultItem>();
  set units(ListBuilder<SearchResultItem>? units) => _$this._units = units;

  bool? _exactLocation;
  bool? get exactLocation => _$this._exactLocation;
  set exactLocation(bool? exactLocation) =>
      _$this._exactLocation = exactLocation;

  ProviderCardBuilder? _provider;
  ProviderCardBuilder get provider =>
      _$this._provider ??= ProviderCardBuilder();
  set provider(ProviderCardBuilder? provider) => _$this._provider = provider;

  ListBuilder<ResidenceDetailResponseBadgesEnum>? _badges;
  ListBuilder<ResidenceDetailResponseBadgesEnum> get badges =>
      _$this._badges ??= ListBuilder<ResidenceDetailResponseBadgesEnum>();
  set badges(ListBuilder<ResidenceDetailResponseBadgesEnum>? badges) =>
      _$this._badges = badges;

  PropertyRatingBuilder? _rating;
  PropertyRatingBuilder get rating =>
      _$this._rating ??= PropertyRatingBuilder();
  set rating(PropertyRatingBuilder? rating) => _$this._rating = rating;

  ResidenceDetailResponseBuilder() {
    ResidenceDetailResponse._defaults(this);
  }

  ResidenceDetailResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _city = $v.city;
      _district = $v.district;
      _description = $v.description;
      _photoKeys = $v.photoKeys?.toBuilder();
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _units = $v.units?.toBuilder();
      _exactLocation = $v.exactLocation;
      _provider = $v.provider?.toBuilder();
      _badges = $v.badges?.toBuilder();
      _rating = $v.rating?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResidenceDetailResponse other) {
    _$v = other as _$ResidenceDetailResponse;
  }

  @override
  void update(void Function(ResidenceDetailResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResidenceDetailResponse build() => _build();

  _$ResidenceDetailResponse _build() {
    _$ResidenceDetailResponse _$result;
    try {
      _$result =
          _$v ??
          _$ResidenceDetailResponse._(
            id: id,
            name: name,
            city: city,
            district: district,
            description: description,
            photoKeys: _photoKeys?.build(),
            latitude: latitude,
            longitude: longitude,
            units: _units?.build(),
            exactLocation: exactLocation,
            provider: _provider?.build(),
            badges: _badges?.build(),
            rating: _rating?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'photoKeys';
        _photoKeys?.build();

        _$failedField = 'units';
        _units?.build();

        _$failedField = 'provider';
        _provider?.build();
        _$failedField = 'badges';
        _badges?.build();
        _$failedField = 'rating';
        _rating?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ResidenceDetailResponse',
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
