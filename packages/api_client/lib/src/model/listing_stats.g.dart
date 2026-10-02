// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_stats.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ListingStatsStatusEnum _$listingStatsStatusEnum_DRAFT =
    const ListingStatsStatusEnum._('DRAFT');
const ListingStatsStatusEnum _$listingStatsStatusEnum_PUBLISHED =
    const ListingStatsStatusEnum._('PUBLISHED');
const ListingStatsStatusEnum _$listingStatsStatusEnum_RESERVED =
    const ListingStatsStatusEnum._('RESERVED');
const ListingStatsStatusEnum _$listingStatsStatusEnum_RENTED =
    const ListingStatsStatusEnum._('RENTED');
const ListingStatsStatusEnum _$listingStatsStatusEnum_ARCHIVED =
    const ListingStatsStatusEnum._('ARCHIVED');
const ListingStatsStatusEnum _$listingStatsStatusEnum_SUSPENDED =
    const ListingStatsStatusEnum._('SUSPENDED');
const ListingStatsStatusEnum _$listingStatsStatusEnum_unknownDefaultOpenApi =
    const ListingStatsStatusEnum._('unknownDefaultOpenApi');

ListingStatsStatusEnum _$listingStatsStatusEnumValueOf(String name) {
  switch (name) {
    case 'DRAFT':
      return _$listingStatsStatusEnum_DRAFT;
    case 'PUBLISHED':
      return _$listingStatsStatusEnum_PUBLISHED;
    case 'RESERVED':
      return _$listingStatsStatusEnum_RESERVED;
    case 'RENTED':
      return _$listingStatsStatusEnum_RENTED;
    case 'ARCHIVED':
      return _$listingStatsStatusEnum_ARCHIVED;
    case 'SUSPENDED':
      return _$listingStatsStatusEnum_SUSPENDED;
    case 'unknownDefaultOpenApi':
      return _$listingStatsStatusEnum_unknownDefaultOpenApi;
    default:
      return _$listingStatsStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ListingStatsStatusEnum> _$listingStatsStatusEnumValues =
    BuiltSet<ListingStatsStatusEnum>(const <ListingStatsStatusEnum>[
      _$listingStatsStatusEnum_DRAFT,
      _$listingStatsStatusEnum_PUBLISHED,
      _$listingStatsStatusEnum_RESERVED,
      _$listingStatsStatusEnum_RENTED,
      _$listingStatsStatusEnum_ARCHIVED,
      _$listingStatsStatusEnum_SUSPENDED,
      _$listingStatsStatusEnum_unknownDefaultOpenApi,
    ]);

Serializer<ListingStatsStatusEnum> _$listingStatsStatusEnumSerializer =
    _$ListingStatsStatusEnumSerializer();

class _$ListingStatsStatusEnumSerializer
    implements PrimitiveSerializer<ListingStatsStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'DRAFT': 'DRAFT',
    'PUBLISHED': 'PUBLISHED',
    'RESERVED': 'RESERVED',
    'RENTED': 'RENTED',
    'ARCHIVED': 'ARCHIVED',
    'SUSPENDED': 'SUSPENDED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'DRAFT': 'DRAFT',
    'PUBLISHED': 'PUBLISHED',
    'RESERVED': 'RESERVED',
    'RENTED': 'RENTED',
    'ARCHIVED': 'ARCHIVED',
    'SUSPENDED': 'SUSPENDED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ListingStatsStatusEnum];
  @override
  final String wireName = 'ListingStatsStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    ListingStatsStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ListingStatsStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ListingStatsStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ListingStats extends ListingStats {
  @override
  final String? annonceId;
  @override
  final String? title;
  @override
  final ListingStatsStatusEnum? status;
  @override
  final DashboardFigures? figures;

  factory _$ListingStats([void Function(ListingStatsBuilder)? updates]) =>
      (ListingStatsBuilder()..update(updates))._build();

  _$ListingStats._({this.annonceId, this.title, this.status, this.figures})
    : super._();
  @override
  ListingStats rebuild(void Function(ListingStatsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListingStatsBuilder toBuilder() => ListingStatsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListingStats &&
        annonceId == other.annonceId &&
        title == other.title &&
        status == other.status &&
        figures == other.figures;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, figures.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ListingStats')
          ..add('annonceId', annonceId)
          ..add('title', title)
          ..add('status', status)
          ..add('figures', figures))
        .toString();
  }
}

class ListingStatsBuilder
    implements Builder<ListingStats, ListingStatsBuilder> {
  _$ListingStats? _$v;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  ListingStatsStatusEnum? _status;
  ListingStatsStatusEnum? get status => _$this._status;
  set status(ListingStatsStatusEnum? status) => _$this._status = status;

  DashboardFiguresBuilder? _figures;
  DashboardFiguresBuilder get figures =>
      _$this._figures ??= DashboardFiguresBuilder();
  set figures(DashboardFiguresBuilder? figures) => _$this._figures = figures;

  ListingStatsBuilder() {
    ListingStats._defaults(this);
  }

  ListingStatsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _annonceId = $v.annonceId;
      _title = $v.title;
      _status = $v.status;
      _figures = $v.figures?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListingStats other) {
    _$v = other as _$ListingStats;
  }

  @override
  void update(void Function(ListingStatsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListingStats build() => _build();

  _$ListingStats _build() {
    _$ListingStats _$result;
    try {
      _$result =
          _$v ??
          _$ListingStats._(
            annonceId: annonceId,
            title: title,
            status: status,
            figures: _figures?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'figures';
        _figures?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ListingStats',
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
