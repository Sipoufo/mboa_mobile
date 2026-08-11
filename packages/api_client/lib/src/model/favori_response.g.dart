// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favori_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FavoriResponseRentalPeriodEnum _$favoriResponseRentalPeriodEnum_DAY =
    const FavoriResponseRentalPeriodEnum._('DAY');
const FavoriResponseRentalPeriodEnum _$favoriResponseRentalPeriodEnum_WEEK =
    const FavoriResponseRentalPeriodEnum._('WEEK');
const FavoriResponseRentalPeriodEnum _$favoriResponseRentalPeriodEnum_MONTH =
    const FavoriResponseRentalPeriodEnum._('MONTH');
const FavoriResponseRentalPeriodEnum _$favoriResponseRentalPeriodEnum_QUARTER =
    const FavoriResponseRentalPeriodEnum._('QUARTER');
const FavoriResponseRentalPeriodEnum _$favoriResponseRentalPeriodEnum_YEAR =
    const FavoriResponseRentalPeriodEnum._('YEAR');
const FavoriResponseRentalPeriodEnum
_$favoriResponseRentalPeriodEnum_unknownDefaultOpenApi =
    const FavoriResponseRentalPeriodEnum._('unknownDefaultOpenApi');

FavoriResponseRentalPeriodEnum _$favoriResponseRentalPeriodEnumValueOf(
  String name,
) {
  switch (name) {
    case 'DAY':
      return _$favoriResponseRentalPeriodEnum_DAY;
    case 'WEEK':
      return _$favoriResponseRentalPeriodEnum_WEEK;
    case 'MONTH':
      return _$favoriResponseRentalPeriodEnum_MONTH;
    case 'QUARTER':
      return _$favoriResponseRentalPeriodEnum_QUARTER;
    case 'YEAR':
      return _$favoriResponseRentalPeriodEnum_YEAR;
    case 'unknownDefaultOpenApi':
      return _$favoriResponseRentalPeriodEnum_unknownDefaultOpenApi;
    default:
      return _$favoriResponseRentalPeriodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FavoriResponseRentalPeriodEnum>
_$favoriResponseRentalPeriodEnumValues =
    BuiltSet<FavoriResponseRentalPeriodEnum>(
      const <FavoriResponseRentalPeriodEnum>[
        _$favoriResponseRentalPeriodEnum_DAY,
        _$favoriResponseRentalPeriodEnum_WEEK,
        _$favoriResponseRentalPeriodEnum_MONTH,
        _$favoriResponseRentalPeriodEnum_QUARTER,
        _$favoriResponseRentalPeriodEnum_YEAR,
        _$favoriResponseRentalPeriodEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<FavoriResponseRentalPeriodEnum>
_$favoriResponseRentalPeriodEnumSerializer =
    _$FavoriResponseRentalPeriodEnumSerializer();

class _$FavoriResponseRentalPeriodEnumSerializer
    implements PrimitiveSerializer<FavoriResponseRentalPeriodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'DAY': 'DAY',
    'WEEK': 'WEEK',
    'MONTH': 'MONTH',
    'QUARTER': 'QUARTER',
    'YEAR': 'YEAR',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'DAY': 'DAY',
    'WEEK': 'WEEK',
    'MONTH': 'MONTH',
    'QUARTER': 'QUARTER',
    'YEAR': 'YEAR',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FavoriResponseRentalPeriodEnum];
  @override
  final String wireName = 'FavoriResponseRentalPeriodEnum';

  @override
  Object serialize(
    Serializers serializers,
    FavoriResponseRentalPeriodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FavoriResponseRentalPeriodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FavoriResponseRentalPeriodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FavoriResponse extends FavoriResponse {
  @override
  final String? annonceId;
  @override
  final String? title;
  @override
  final String? primaryPhotoKey;
  @override
  final int? price;
  @override
  final FavoriResponseRentalPeriodEnum? rentalPeriod;
  @override
  final int? monthlyRent;
  @override
  final String? city;
  @override
  final String? district;
  @override
  final bool? available;
  @override
  final DateTime? savedAt;

  factory _$FavoriResponse([void Function(FavoriResponseBuilder)? updates]) =>
      (FavoriResponseBuilder()..update(updates))._build();

  _$FavoriResponse._({
    this.annonceId,
    this.title,
    this.primaryPhotoKey,
    this.price,
    this.rentalPeriod,
    this.monthlyRent,
    this.city,
    this.district,
    this.available,
    this.savedAt,
  }) : super._();
  @override
  FavoriResponse rebuild(void Function(FavoriResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FavoriResponseBuilder toBuilder() => FavoriResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FavoriResponse &&
        annonceId == other.annonceId &&
        title == other.title &&
        primaryPhotoKey == other.primaryPhotoKey &&
        price == other.price &&
        rentalPeriod == other.rentalPeriod &&
        monthlyRent == other.monthlyRent &&
        city == other.city &&
        district == other.district &&
        available == other.available &&
        savedAt == other.savedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, primaryPhotoKey.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, rentalPeriod.hashCode);
    _$hash = $jc(_$hash, monthlyRent.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, district.hashCode);
    _$hash = $jc(_$hash, available.hashCode);
    _$hash = $jc(_$hash, savedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FavoriResponse')
          ..add('annonceId', annonceId)
          ..add('title', title)
          ..add('primaryPhotoKey', primaryPhotoKey)
          ..add('price', price)
          ..add('rentalPeriod', rentalPeriod)
          ..add('monthlyRent', monthlyRent)
          ..add('city', city)
          ..add('district', district)
          ..add('available', available)
          ..add('savedAt', savedAt))
        .toString();
  }
}

class FavoriResponseBuilder
    implements Builder<FavoriResponse, FavoriResponseBuilder> {
  _$FavoriResponse? _$v;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _primaryPhotoKey;
  String? get primaryPhotoKey => _$this._primaryPhotoKey;
  set primaryPhotoKey(String? primaryPhotoKey) =>
      _$this._primaryPhotoKey = primaryPhotoKey;

  int? _price;
  int? get price => _$this._price;
  set price(int? price) => _$this._price = price;

  FavoriResponseRentalPeriodEnum? _rentalPeriod;
  FavoriResponseRentalPeriodEnum? get rentalPeriod => _$this._rentalPeriod;
  set rentalPeriod(FavoriResponseRentalPeriodEnum? rentalPeriod) =>
      _$this._rentalPeriod = rentalPeriod;

  int? _monthlyRent;
  int? get monthlyRent => _$this._monthlyRent;
  set monthlyRent(int? monthlyRent) => _$this._monthlyRent = monthlyRent;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _district;
  String? get district => _$this._district;
  set district(String? district) => _$this._district = district;

  bool? _available;
  bool? get available => _$this._available;
  set available(bool? available) => _$this._available = available;

  DateTime? _savedAt;
  DateTime? get savedAt => _$this._savedAt;
  set savedAt(DateTime? savedAt) => _$this._savedAt = savedAt;

  FavoriResponseBuilder() {
    FavoriResponse._defaults(this);
  }

  FavoriResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _annonceId = $v.annonceId;
      _title = $v.title;
      _primaryPhotoKey = $v.primaryPhotoKey;
      _price = $v.price;
      _rentalPeriod = $v.rentalPeriod;
      _monthlyRent = $v.monthlyRent;
      _city = $v.city;
      _district = $v.district;
      _available = $v.available;
      _savedAt = $v.savedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FavoriResponse other) {
    _$v = other as _$FavoriResponse;
  }

  @override
  void update(void Function(FavoriResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FavoriResponse build() => _build();

  _$FavoriResponse _build() {
    final _$result =
        _$v ??
        _$FavoriResponse._(
          annonceId: annonceId,
          title: title,
          primaryPhotoKey: primaryPhotoKey,
          price: price,
          rentalPeriod: rentalPeriod,
          monthlyRent: monthlyRent,
          city: city,
          district: district,
          available: available,
          savedAt: savedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
