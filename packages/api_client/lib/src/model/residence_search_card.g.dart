// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'residence_search_card.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ResidenceSearchCardBadgesEnum _$residenceSearchCardBadgesEnum_TRUSTED =
    const ResidenceSearchCardBadgesEnum._('TRUSTED');
const ResidenceSearchCardBadgesEnum
_$residenceSearchCardBadgesEnum_RECERTIFIED =
    const ResidenceSearchCardBadgesEnum._('RECERTIFIED');
const ResidenceSearchCardBadgesEnum
_$residenceSearchCardBadgesEnum_IDENTITY_VERIFIED =
    const ResidenceSearchCardBadgesEnum._('IDENTITY_VERIFIED');
const ResidenceSearchCardBadgesEnum
_$residenceSearchCardBadgesEnum_PHOTOS_VERIFIED =
    const ResidenceSearchCardBadgesEnum._('PHOTOS_VERIFIED');
const ResidenceSearchCardBadgesEnum
_$residenceSearchCardBadgesEnum_unknownDefaultOpenApi =
    const ResidenceSearchCardBadgesEnum._('unknownDefaultOpenApi');

ResidenceSearchCardBadgesEnum _$residenceSearchCardBadgesEnumValueOf(
  String name,
) {
  switch (name) {
    case 'TRUSTED':
      return _$residenceSearchCardBadgesEnum_TRUSTED;
    case 'RECERTIFIED':
      return _$residenceSearchCardBadgesEnum_RECERTIFIED;
    case 'IDENTITY_VERIFIED':
      return _$residenceSearchCardBadgesEnum_IDENTITY_VERIFIED;
    case 'PHOTOS_VERIFIED':
      return _$residenceSearchCardBadgesEnum_PHOTOS_VERIFIED;
    case 'unknownDefaultOpenApi':
      return _$residenceSearchCardBadgesEnum_unknownDefaultOpenApi;
    default:
      return _$residenceSearchCardBadgesEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ResidenceSearchCardBadgesEnum>
_$residenceSearchCardBadgesEnumValues = BuiltSet<ResidenceSearchCardBadgesEnum>(
  const <ResidenceSearchCardBadgesEnum>[
    _$residenceSearchCardBadgesEnum_TRUSTED,
    _$residenceSearchCardBadgesEnum_RECERTIFIED,
    _$residenceSearchCardBadgesEnum_IDENTITY_VERIFIED,
    _$residenceSearchCardBadgesEnum_PHOTOS_VERIFIED,
    _$residenceSearchCardBadgesEnum_unknownDefaultOpenApi,
  ],
);

Serializer<ResidenceSearchCardBadgesEnum>
_$residenceSearchCardBadgesEnumSerializer =
    _$ResidenceSearchCardBadgesEnumSerializer();

class _$ResidenceSearchCardBadgesEnumSerializer
    implements PrimitiveSerializer<ResidenceSearchCardBadgesEnum> {
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
  final Iterable<Type> types = const <Type>[ResidenceSearchCardBadgesEnum];
  @override
  final String wireName = 'ResidenceSearchCardBadgesEnum';

  @override
  Object serialize(
    Serializers serializers,
    ResidenceSearchCardBadgesEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ResidenceSearchCardBadgesEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ResidenceSearchCardBadgesEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ResidenceSearchCard extends ResidenceSearchCard {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? city;
  @override
  final String? district;
  @override
  final String? primaryPhotoKey;
  @override
  final int? tierRank;
  @override
  final int? availableUnitCount;
  @override
  final int? reservedUnitCount;
  @override
  final BuiltList<TypeCount>? breakdown;
  @override
  final int? fromMonthlyRent;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final BuiltList<ResidenceSearchCardBadgesEnum>? badges;

  factory _$ResidenceSearchCard([
    void Function(ResidenceSearchCardBuilder)? updates,
  ]) => (ResidenceSearchCardBuilder()..update(updates))._build();

  _$ResidenceSearchCard._({
    this.id,
    this.name,
    this.city,
    this.district,
    this.primaryPhotoKey,
    this.tierRank,
    this.availableUnitCount,
    this.reservedUnitCount,
    this.breakdown,
    this.fromMonthlyRent,
    this.latitude,
    this.longitude,
    this.badges,
  }) : super._();
  @override
  ResidenceSearchCard rebuild(
    void Function(ResidenceSearchCardBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ResidenceSearchCardBuilder toBuilder() =>
      ResidenceSearchCardBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResidenceSearchCard &&
        id == other.id &&
        name == other.name &&
        city == other.city &&
        district == other.district &&
        primaryPhotoKey == other.primaryPhotoKey &&
        tierRank == other.tierRank &&
        availableUnitCount == other.availableUnitCount &&
        reservedUnitCount == other.reservedUnitCount &&
        breakdown == other.breakdown &&
        fromMonthlyRent == other.fromMonthlyRent &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        badges == other.badges;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, district.hashCode);
    _$hash = $jc(_$hash, primaryPhotoKey.hashCode);
    _$hash = $jc(_$hash, tierRank.hashCode);
    _$hash = $jc(_$hash, availableUnitCount.hashCode);
    _$hash = $jc(_$hash, reservedUnitCount.hashCode);
    _$hash = $jc(_$hash, breakdown.hashCode);
    _$hash = $jc(_$hash, fromMonthlyRent.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, badges.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResidenceSearchCard')
          ..add('id', id)
          ..add('name', name)
          ..add('city', city)
          ..add('district', district)
          ..add('primaryPhotoKey', primaryPhotoKey)
          ..add('tierRank', tierRank)
          ..add('availableUnitCount', availableUnitCount)
          ..add('reservedUnitCount', reservedUnitCount)
          ..add('breakdown', breakdown)
          ..add('fromMonthlyRent', fromMonthlyRent)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('badges', badges))
        .toString();
  }
}

class ResidenceSearchCardBuilder
    implements Builder<ResidenceSearchCard, ResidenceSearchCardBuilder> {
  _$ResidenceSearchCard? _$v;

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

  String? _primaryPhotoKey;
  String? get primaryPhotoKey => _$this._primaryPhotoKey;
  set primaryPhotoKey(String? primaryPhotoKey) =>
      _$this._primaryPhotoKey = primaryPhotoKey;

  int? _tierRank;
  int? get tierRank => _$this._tierRank;
  set tierRank(int? tierRank) => _$this._tierRank = tierRank;

  int? _availableUnitCount;
  int? get availableUnitCount => _$this._availableUnitCount;
  set availableUnitCount(int? availableUnitCount) =>
      _$this._availableUnitCount = availableUnitCount;

  int? _reservedUnitCount;
  int? get reservedUnitCount => _$this._reservedUnitCount;
  set reservedUnitCount(int? reservedUnitCount) =>
      _$this._reservedUnitCount = reservedUnitCount;

  ListBuilder<TypeCount>? _breakdown;
  ListBuilder<TypeCount> get breakdown =>
      _$this._breakdown ??= ListBuilder<TypeCount>();
  set breakdown(ListBuilder<TypeCount>? breakdown) =>
      _$this._breakdown = breakdown;

  int? _fromMonthlyRent;
  int? get fromMonthlyRent => _$this._fromMonthlyRent;
  set fromMonthlyRent(int? fromMonthlyRent) =>
      _$this._fromMonthlyRent = fromMonthlyRent;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  ListBuilder<ResidenceSearchCardBadgesEnum>? _badges;
  ListBuilder<ResidenceSearchCardBadgesEnum> get badges =>
      _$this._badges ??= ListBuilder<ResidenceSearchCardBadgesEnum>();
  set badges(ListBuilder<ResidenceSearchCardBadgesEnum>? badges) =>
      _$this._badges = badges;

  ResidenceSearchCardBuilder() {
    ResidenceSearchCard._defaults(this);
  }

  ResidenceSearchCardBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _city = $v.city;
      _district = $v.district;
      _primaryPhotoKey = $v.primaryPhotoKey;
      _tierRank = $v.tierRank;
      _availableUnitCount = $v.availableUnitCount;
      _reservedUnitCount = $v.reservedUnitCount;
      _breakdown = $v.breakdown?.toBuilder();
      _fromMonthlyRent = $v.fromMonthlyRent;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _badges = $v.badges?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResidenceSearchCard other) {
    _$v = other as _$ResidenceSearchCard;
  }

  @override
  void update(void Function(ResidenceSearchCardBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResidenceSearchCard build() => _build();

  _$ResidenceSearchCard _build() {
    _$ResidenceSearchCard _$result;
    try {
      _$result =
          _$v ??
          _$ResidenceSearchCard._(
            id: id,
            name: name,
            city: city,
            district: district,
            primaryPhotoKey: primaryPhotoKey,
            tierRank: tierRank,
            availableUnitCount: availableUnitCount,
            reservedUnitCount: reservedUnitCount,
            breakdown: _breakdown?.build(),
            fromMonthlyRent: fromMonthlyRent,
            latitude: latitude,
            longitude: longitude,
            badges: _badges?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'breakdown';
        _breakdown?.build();

        _$failedField = 'badges';
        _badges?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ResidenceSearchCard',
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
