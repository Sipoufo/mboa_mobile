// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'residence_opportunity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ResidenceOpportunityFromRentalPeriodEnum
_$residenceOpportunityFromRentalPeriodEnum_MONTH =
    const ResidenceOpportunityFromRentalPeriodEnum._('MONTH');
const ResidenceOpportunityFromRentalPeriodEnum
_$residenceOpportunityFromRentalPeriodEnum_QUARTER =
    const ResidenceOpportunityFromRentalPeriodEnum._('QUARTER');
const ResidenceOpportunityFromRentalPeriodEnum
_$residenceOpportunityFromRentalPeriodEnum_YEAR =
    const ResidenceOpportunityFromRentalPeriodEnum._('YEAR');
const ResidenceOpportunityFromRentalPeriodEnum
_$residenceOpportunityFromRentalPeriodEnum_unknownDefaultOpenApi =
    const ResidenceOpportunityFromRentalPeriodEnum._('unknownDefaultOpenApi');

ResidenceOpportunityFromRentalPeriodEnum
_$residenceOpportunityFromRentalPeriodEnumValueOf(String name) {
  switch (name) {
    case 'MONTH':
      return _$residenceOpportunityFromRentalPeriodEnum_MONTH;
    case 'QUARTER':
      return _$residenceOpportunityFromRentalPeriodEnum_QUARTER;
    case 'YEAR':
      return _$residenceOpportunityFromRentalPeriodEnum_YEAR;
    case 'unknownDefaultOpenApi':
      return _$residenceOpportunityFromRentalPeriodEnum_unknownDefaultOpenApi;
    default:
      return _$residenceOpportunityFromRentalPeriodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ResidenceOpportunityFromRentalPeriodEnum>
_$residenceOpportunityFromRentalPeriodEnumValues =
    BuiltSet<ResidenceOpportunityFromRentalPeriodEnum>(
      const <ResidenceOpportunityFromRentalPeriodEnum>[
        _$residenceOpportunityFromRentalPeriodEnum_MONTH,
        _$residenceOpportunityFromRentalPeriodEnum_QUARTER,
        _$residenceOpportunityFromRentalPeriodEnum_YEAR,
        _$residenceOpportunityFromRentalPeriodEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<ResidenceOpportunityFromRentalPeriodEnum>
_$residenceOpportunityFromRentalPeriodEnumSerializer =
    _$ResidenceOpportunityFromRentalPeriodEnumSerializer();

class _$ResidenceOpportunityFromRentalPeriodEnumSerializer
    implements PrimitiveSerializer<ResidenceOpportunityFromRentalPeriodEnum> {
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
  final Iterable<Type> types = const <Type>[
    ResidenceOpportunityFromRentalPeriodEnum,
  ];
  @override
  final String wireName = 'ResidenceOpportunityFromRentalPeriodEnum';

  @override
  Object serialize(
    Serializers serializers,
    ResidenceOpportunityFromRentalPeriodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ResidenceOpportunityFromRentalPeriodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ResidenceOpportunityFromRentalPeriodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ResidenceOpportunity extends ResidenceOpportunity {
  @override
  final String? residenceId;
  @override
  final String? residenceName;
  @override
  final String? primaryPhotoKey;
  @override
  final String? city;
  @override
  final String? district;
  @override
  final int? unitCount;
  @override
  final BuiltList<TypeCount>? breakdown;
  @override
  final int? fromPrice;
  @override
  final ResidenceOpportunityFromRentalPeriodEnum? fromRentalPeriod;
  @override
  final int? fromMonthlyRent;

  factory _$ResidenceOpportunity([
    void Function(ResidenceOpportunityBuilder)? updates,
  ]) => (ResidenceOpportunityBuilder()..update(updates))._build();

  _$ResidenceOpportunity._({
    this.residenceId,
    this.residenceName,
    this.primaryPhotoKey,
    this.city,
    this.district,
    this.unitCount,
    this.breakdown,
    this.fromPrice,
    this.fromRentalPeriod,
    this.fromMonthlyRent,
  }) : super._();
  @override
  ResidenceOpportunity rebuild(
    void Function(ResidenceOpportunityBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ResidenceOpportunityBuilder toBuilder() =>
      ResidenceOpportunityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResidenceOpportunity &&
        residenceId == other.residenceId &&
        residenceName == other.residenceName &&
        primaryPhotoKey == other.primaryPhotoKey &&
        city == other.city &&
        district == other.district &&
        unitCount == other.unitCount &&
        breakdown == other.breakdown &&
        fromPrice == other.fromPrice &&
        fromRentalPeriod == other.fromRentalPeriod &&
        fromMonthlyRent == other.fromMonthlyRent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, residenceId.hashCode);
    _$hash = $jc(_$hash, residenceName.hashCode);
    _$hash = $jc(_$hash, primaryPhotoKey.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, district.hashCode);
    _$hash = $jc(_$hash, unitCount.hashCode);
    _$hash = $jc(_$hash, breakdown.hashCode);
    _$hash = $jc(_$hash, fromPrice.hashCode);
    _$hash = $jc(_$hash, fromRentalPeriod.hashCode);
    _$hash = $jc(_$hash, fromMonthlyRent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResidenceOpportunity')
          ..add('residenceId', residenceId)
          ..add('residenceName', residenceName)
          ..add('primaryPhotoKey', primaryPhotoKey)
          ..add('city', city)
          ..add('district', district)
          ..add('unitCount', unitCount)
          ..add('breakdown', breakdown)
          ..add('fromPrice', fromPrice)
          ..add('fromRentalPeriod', fromRentalPeriod)
          ..add('fromMonthlyRent', fromMonthlyRent))
        .toString();
  }
}

class ResidenceOpportunityBuilder
    implements Builder<ResidenceOpportunity, ResidenceOpportunityBuilder> {
  _$ResidenceOpportunity? _$v;

  String? _residenceId;
  String? get residenceId => _$this._residenceId;
  set residenceId(String? residenceId) => _$this._residenceId = residenceId;

  String? _residenceName;
  String? get residenceName => _$this._residenceName;
  set residenceName(String? residenceName) =>
      _$this._residenceName = residenceName;

  String? _primaryPhotoKey;
  String? get primaryPhotoKey => _$this._primaryPhotoKey;
  set primaryPhotoKey(String? primaryPhotoKey) =>
      _$this._primaryPhotoKey = primaryPhotoKey;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _district;
  String? get district => _$this._district;
  set district(String? district) => _$this._district = district;

  int? _unitCount;
  int? get unitCount => _$this._unitCount;
  set unitCount(int? unitCount) => _$this._unitCount = unitCount;

  ListBuilder<TypeCount>? _breakdown;
  ListBuilder<TypeCount> get breakdown =>
      _$this._breakdown ??= ListBuilder<TypeCount>();
  set breakdown(ListBuilder<TypeCount>? breakdown) =>
      _$this._breakdown = breakdown;

  int? _fromPrice;
  int? get fromPrice => _$this._fromPrice;
  set fromPrice(int? fromPrice) => _$this._fromPrice = fromPrice;

  ResidenceOpportunityFromRentalPeriodEnum? _fromRentalPeriod;
  ResidenceOpportunityFromRentalPeriodEnum? get fromRentalPeriod =>
      _$this._fromRentalPeriod;
  set fromRentalPeriod(
    ResidenceOpportunityFromRentalPeriodEnum? fromRentalPeriod,
  ) => _$this._fromRentalPeriod = fromRentalPeriod;

  int? _fromMonthlyRent;
  int? get fromMonthlyRent => _$this._fromMonthlyRent;
  set fromMonthlyRent(int? fromMonthlyRent) =>
      _$this._fromMonthlyRent = fromMonthlyRent;

  ResidenceOpportunityBuilder() {
    ResidenceOpportunity._defaults(this);
  }

  ResidenceOpportunityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _residenceId = $v.residenceId;
      _residenceName = $v.residenceName;
      _primaryPhotoKey = $v.primaryPhotoKey;
      _city = $v.city;
      _district = $v.district;
      _unitCount = $v.unitCount;
      _breakdown = $v.breakdown?.toBuilder();
      _fromPrice = $v.fromPrice;
      _fromRentalPeriod = $v.fromRentalPeriod;
      _fromMonthlyRent = $v.fromMonthlyRent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResidenceOpportunity other) {
    _$v = other as _$ResidenceOpportunity;
  }

  @override
  void update(void Function(ResidenceOpportunityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResidenceOpportunity build() => _build();

  _$ResidenceOpportunity _build() {
    _$ResidenceOpportunity _$result;
    try {
      _$result =
          _$v ??
          _$ResidenceOpportunity._(
            residenceId: residenceId,
            residenceName: residenceName,
            primaryPhotoKey: primaryPhotoKey,
            city: city,
            district: district,
            unitCount: unitCount,
            breakdown: _breakdown?.build(),
            fromPrice: fromPrice,
            fromRentalPeriod: fromRentalPeriod,
            fromMonthlyRent: fromMonthlyRent,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'breakdown';
        _breakdown?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ResidenceOpportunity',
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
