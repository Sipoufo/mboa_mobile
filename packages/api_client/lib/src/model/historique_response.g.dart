// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historique_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HistoriqueResponseRentalPeriodEnum
_$historiqueResponseRentalPeriodEnum_MONTH =
    const HistoriqueResponseRentalPeriodEnum._('MONTH');
const HistoriqueResponseRentalPeriodEnum
_$historiqueResponseRentalPeriodEnum_QUARTER =
    const HistoriqueResponseRentalPeriodEnum._('QUARTER');
const HistoriqueResponseRentalPeriodEnum
_$historiqueResponseRentalPeriodEnum_YEAR =
    const HistoriqueResponseRentalPeriodEnum._('YEAR');
const HistoriqueResponseRentalPeriodEnum
_$historiqueResponseRentalPeriodEnum_unknownDefaultOpenApi =
    const HistoriqueResponseRentalPeriodEnum._('unknownDefaultOpenApi');

HistoriqueResponseRentalPeriodEnum _$historiqueResponseRentalPeriodEnumValueOf(
  String name,
) {
  switch (name) {
    case 'MONTH':
      return _$historiqueResponseRentalPeriodEnum_MONTH;
    case 'QUARTER':
      return _$historiqueResponseRentalPeriodEnum_QUARTER;
    case 'YEAR':
      return _$historiqueResponseRentalPeriodEnum_YEAR;
    case 'unknownDefaultOpenApi':
      return _$historiqueResponseRentalPeriodEnum_unknownDefaultOpenApi;
    default:
      return _$historiqueResponseRentalPeriodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<HistoriqueResponseRentalPeriodEnum>
_$historiqueResponseRentalPeriodEnumValues =
    BuiltSet<HistoriqueResponseRentalPeriodEnum>(
      const <HistoriqueResponseRentalPeriodEnum>[
        _$historiqueResponseRentalPeriodEnum_MONTH,
        _$historiqueResponseRentalPeriodEnum_QUARTER,
        _$historiqueResponseRentalPeriodEnum_YEAR,
        _$historiqueResponseRentalPeriodEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<HistoriqueResponseRentalPeriodEnum>
_$historiqueResponseRentalPeriodEnumSerializer =
    _$HistoriqueResponseRentalPeriodEnumSerializer();

class _$HistoriqueResponseRentalPeriodEnumSerializer
    implements PrimitiveSerializer<HistoriqueResponseRentalPeriodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MONTH': 'MONTH',
    'QUARTER': 'QUARTER',
    'YEAR': 'YEAR',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MONTH': 'MONTH',
    'QUARTER': 'QUARTER',
    'YEAR': 'YEAR',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[HistoriqueResponseRentalPeriodEnum];
  @override
  final String wireName = 'HistoriqueResponseRentalPeriodEnum';

  @override
  Object serialize(
    Serializers serializers,
    HistoriqueResponseRentalPeriodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HistoriqueResponseRentalPeriodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HistoriqueResponseRentalPeriodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HistoriqueResponse extends HistoriqueResponse {
  @override
  final String? annonceId;
  @override
  final String? title;
  @override
  final String? primaryPhotoKey;
  @override
  final int? price;
  @override
  final HistoriqueResponseRentalPeriodEnum? rentalPeriod;
  @override
  final int? monthlyRent;
  @override
  final String? city;
  @override
  final String? district;
  @override
  final DateTime? viewedAt;

  factory _$HistoriqueResponse([
    void Function(HistoriqueResponseBuilder)? updates,
  ]) => (HistoriqueResponseBuilder()..update(updates))._build();

  _$HistoriqueResponse._({
    this.annonceId,
    this.title,
    this.primaryPhotoKey,
    this.price,
    this.rentalPeriod,
    this.monthlyRent,
    this.city,
    this.district,
    this.viewedAt,
  }) : super._();
  @override
  HistoriqueResponse rebuild(
    void Function(HistoriqueResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HistoriqueResponseBuilder toBuilder() =>
      HistoriqueResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HistoriqueResponse &&
        annonceId == other.annonceId &&
        title == other.title &&
        primaryPhotoKey == other.primaryPhotoKey &&
        price == other.price &&
        rentalPeriod == other.rentalPeriod &&
        monthlyRent == other.monthlyRent &&
        city == other.city &&
        district == other.district &&
        viewedAt == other.viewedAt;
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
    _$hash = $jc(_$hash, viewedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HistoriqueResponse')
          ..add('annonceId', annonceId)
          ..add('title', title)
          ..add('primaryPhotoKey', primaryPhotoKey)
          ..add('price', price)
          ..add('rentalPeriod', rentalPeriod)
          ..add('monthlyRent', monthlyRent)
          ..add('city', city)
          ..add('district', district)
          ..add('viewedAt', viewedAt))
        .toString();
  }
}

class HistoriqueResponseBuilder
    implements Builder<HistoriqueResponse, HistoriqueResponseBuilder> {
  _$HistoriqueResponse? _$v;

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

  HistoriqueResponseRentalPeriodEnum? _rentalPeriod;
  HistoriqueResponseRentalPeriodEnum? get rentalPeriod => _$this._rentalPeriod;
  set rentalPeriod(HistoriqueResponseRentalPeriodEnum? rentalPeriod) =>
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

  DateTime? _viewedAt;
  DateTime? get viewedAt => _$this._viewedAt;
  set viewedAt(DateTime? viewedAt) => _$this._viewedAt = viewedAt;

  HistoriqueResponseBuilder() {
    HistoriqueResponse._defaults(this);
  }

  HistoriqueResponseBuilder get _$this {
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
      _viewedAt = $v.viewedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HistoriqueResponse other) {
    _$v = other as _$HistoriqueResponse;
  }

  @override
  void update(void Function(HistoriqueResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HistoriqueResponse build() => _build();

  _$HistoriqueResponse _build() {
    final _$result =
        _$v ??
        _$HistoriqueResponse._(
          annonceId: annonceId,
          title: title,
          primaryPhotoKey: primaryPhotoKey,
          price: price,
          rentalPeriod: rentalPeriod,
          monthlyRent: monthlyRent,
          city: city,
          district: district,
          viewedAt: viewedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
