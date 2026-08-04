// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SearchResultTypeEnum _$searchResultTypeEnum_LISTING =
    const SearchResultTypeEnum._('LISTING');
const SearchResultTypeEnum _$searchResultTypeEnum_RESIDENCE =
    const SearchResultTypeEnum._('RESIDENCE');
const SearchResultTypeEnum _$searchResultTypeEnum_unknownDefaultOpenApi =
    const SearchResultTypeEnum._('unknownDefaultOpenApi');

SearchResultTypeEnum _$searchResultTypeEnumValueOf(String name) {
  switch (name) {
    case 'LISTING':
      return _$searchResultTypeEnum_LISTING;
    case 'RESIDENCE':
      return _$searchResultTypeEnum_RESIDENCE;
    case 'unknownDefaultOpenApi':
      return _$searchResultTypeEnum_unknownDefaultOpenApi;
    default:
      return _$searchResultTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<SearchResultTypeEnum> _$searchResultTypeEnumValues =
    BuiltSet<SearchResultTypeEnum>(const <SearchResultTypeEnum>[
      _$searchResultTypeEnum_LISTING,
      _$searchResultTypeEnum_RESIDENCE,
      _$searchResultTypeEnum_unknownDefaultOpenApi,
    ]);

Serializer<SearchResultTypeEnum> _$searchResultTypeEnumSerializer =
    _$SearchResultTypeEnumSerializer();

class _$SearchResultTypeEnumSerializer
    implements PrimitiveSerializer<SearchResultTypeEnum> {
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
  final Iterable<Type> types = const <Type>[SearchResultTypeEnum];
  @override
  final String wireName = 'SearchResultTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    SearchResultTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SearchResultTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SearchResultTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SearchResult extends SearchResult {
  @override
  final SearchResultTypeEnum? type;
  @override
  final SearchResultItem? listing;
  @override
  final ResidenceSearchCard? residence;

  factory _$SearchResult([void Function(SearchResultBuilder)? updates]) =>
      (SearchResultBuilder()..update(updates))._build();

  _$SearchResult._({this.type, this.listing, this.residence}) : super._();
  @override
  SearchResult rebuild(void Function(SearchResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchResultBuilder toBuilder() => SearchResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchResult &&
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
    return (newBuiltValueToStringHelper(r'SearchResult')
          ..add('type', type)
          ..add('listing', listing)
          ..add('residence', residence))
        .toString();
  }
}

class SearchResultBuilder
    implements Builder<SearchResult, SearchResultBuilder> {
  _$SearchResult? _$v;

  SearchResultTypeEnum? _type;
  SearchResultTypeEnum? get type => _$this._type;
  set type(SearchResultTypeEnum? type) => _$this._type = type;

  SearchResultItemBuilder? _listing;
  SearchResultItemBuilder get listing =>
      _$this._listing ??= SearchResultItemBuilder();
  set listing(SearchResultItemBuilder? listing) => _$this._listing = listing;

  ResidenceSearchCardBuilder? _residence;
  ResidenceSearchCardBuilder get residence =>
      _$this._residence ??= ResidenceSearchCardBuilder();
  set residence(ResidenceSearchCardBuilder? residence) =>
      _$this._residence = residence;

  SearchResultBuilder() {
    SearchResult._defaults(this);
  }

  SearchResultBuilder get _$this {
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
  void replace(SearchResult other) {
    _$v = other as _$SearchResult;
  }

  @override
  void update(void Function(SearchResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SearchResult build() => _build();

  _$SearchResult _build() {
    _$SearchResult _$result;
    try {
      _$result =
          _$v ??
          _$SearchResult._(
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
          r'SearchResult',
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
