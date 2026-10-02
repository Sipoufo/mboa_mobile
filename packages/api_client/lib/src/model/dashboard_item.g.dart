// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DashboardItemTypeEnum _$dashboardItemTypeEnum_LISTING =
    const DashboardItemTypeEnum._('LISTING');
const DashboardItemTypeEnum _$dashboardItemTypeEnum_RESIDENCE =
    const DashboardItemTypeEnum._('RESIDENCE');
const DashboardItemTypeEnum _$dashboardItemTypeEnum_unknownDefaultOpenApi =
    const DashboardItemTypeEnum._('unknownDefaultOpenApi');

DashboardItemTypeEnum _$dashboardItemTypeEnumValueOf(String name) {
  switch (name) {
    case 'LISTING':
      return _$dashboardItemTypeEnum_LISTING;
    case 'RESIDENCE':
      return _$dashboardItemTypeEnum_RESIDENCE;
    case 'unknownDefaultOpenApi':
      return _$dashboardItemTypeEnum_unknownDefaultOpenApi;
    default:
      return _$dashboardItemTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DashboardItemTypeEnum> _$dashboardItemTypeEnumValues =
    BuiltSet<DashboardItemTypeEnum>(const <DashboardItemTypeEnum>[
      _$dashboardItemTypeEnum_LISTING,
      _$dashboardItemTypeEnum_RESIDENCE,
      _$dashboardItemTypeEnum_unknownDefaultOpenApi,
    ]);

Serializer<DashboardItemTypeEnum> _$dashboardItemTypeEnumSerializer =
    _$DashboardItemTypeEnumSerializer();

class _$DashboardItemTypeEnumSerializer
    implements PrimitiveSerializer<DashboardItemTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'LISTING': 'LISTING',
    'RESIDENCE': 'RESIDENCE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'LISTING': 'LISTING',
    'RESIDENCE': 'RESIDENCE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DashboardItemTypeEnum];
  @override
  final String wireName = 'DashboardItemTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    DashboardItemTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DashboardItemTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DashboardItemTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DashboardItem extends DashboardItem {
  @override
  final DashboardItemTypeEnum? type;
  @override
  final ListingStats? listing;
  @override
  final ResidenceStats? residence;

  factory _$DashboardItem([void Function(DashboardItemBuilder)? updates]) =>
      (DashboardItemBuilder()..update(updates))._build();

  _$DashboardItem._({this.type, this.listing, this.residence}) : super._();
  @override
  DashboardItem rebuild(void Function(DashboardItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardItemBuilder toBuilder() => DashboardItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardItem &&
        type == other.type &&
        listing == other.listing &&
        residence == other.residence;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, listing.hashCode);
    _$hash = $jc(_$hash, residence.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardItem')
          ..add('type', type)
          ..add('listing', listing)
          ..add('residence', residence))
        .toString();
  }
}

class DashboardItemBuilder
    implements Builder<DashboardItem, DashboardItemBuilder> {
  _$DashboardItem? _$v;

  DashboardItemTypeEnum? _type;
  DashboardItemTypeEnum? get type => _$this._type;
  set type(DashboardItemTypeEnum? type) => _$this._type = type;

  ListingStatsBuilder? _listing;
  ListingStatsBuilder get listing => _$this._listing ??= ListingStatsBuilder();
  set listing(ListingStatsBuilder? listing) => _$this._listing = listing;

  ResidenceStatsBuilder? _residence;
  ResidenceStatsBuilder get residence =>
      _$this._residence ??= ResidenceStatsBuilder();
  set residence(ResidenceStatsBuilder? residence) =>
      _$this._residence = residence;

  DashboardItemBuilder() {
    DashboardItem._defaults(this);
  }

  DashboardItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _listing = $v.listing?.toBuilder();
      _residence = $v.residence?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardItem other) {
    _$v = other as _$DashboardItem;
  }

  @override
  void update(void Function(DashboardItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardItem build() => _build();

  _$DashboardItem _build() {
    _$DashboardItem _$result;
    try {
      _$result =
          _$v ??
          _$DashboardItem._(
            type: type,
            listing: _listing?.build(),
            residence: _residence?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'listing';
        _listing?.build();
        _$failedField = 'residence';
        _residence?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DashboardItem',
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
