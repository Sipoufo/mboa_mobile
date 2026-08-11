// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opportunity_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OpportunityItemTypeEnum _$opportunityItemTypeEnum_LISTING =
    const OpportunityItemTypeEnum._('LISTING');
const OpportunityItemTypeEnum _$opportunityItemTypeEnum_RESIDENCE =
    const OpportunityItemTypeEnum._('RESIDENCE');
const OpportunityItemTypeEnum _$opportunityItemTypeEnum_unknownDefaultOpenApi =
    const OpportunityItemTypeEnum._('unknownDefaultOpenApi');

OpportunityItemTypeEnum _$opportunityItemTypeEnumValueOf(String name) {
  switch (name) {
    case 'LISTING':
      return _$opportunityItemTypeEnum_LISTING;
    case 'RESIDENCE':
      return _$opportunityItemTypeEnum_RESIDENCE;
    case 'unknownDefaultOpenApi':
      return _$opportunityItemTypeEnum_unknownDefaultOpenApi;
    default:
      return _$opportunityItemTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OpportunityItemTypeEnum> _$opportunityItemTypeEnumValues =
    BuiltSet<OpportunityItemTypeEnum>(const <OpportunityItemTypeEnum>[
      _$opportunityItemTypeEnum_LISTING,
      _$opportunityItemTypeEnum_RESIDENCE,
      _$opportunityItemTypeEnum_unknownDefaultOpenApi,
    ]);

Serializer<OpportunityItemTypeEnum> _$opportunityItemTypeEnumSerializer =
    _$OpportunityItemTypeEnumSerializer();

class _$OpportunityItemTypeEnumSerializer
    implements PrimitiveSerializer<OpportunityItemTypeEnum> {
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
  final Iterable<Type> types = const <Type>[OpportunityItemTypeEnum];
  @override
  final String wireName = 'OpportunityItemTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    OpportunityItemTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  OpportunityItemTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => OpportunityItemTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$OpportunityItem extends OpportunityItem {
  @override
  final OpportunityItemTypeEnum? type;
  @override
  final AgentOpportunity? listing;
  @override
  final ResidenceOpportunity? residence;

  factory _$OpportunityItem([void Function(OpportunityItemBuilder)? updates]) =>
      (OpportunityItemBuilder()..update(updates))._build();

  _$OpportunityItem._({this.type, this.listing, this.residence}) : super._();
  @override
  OpportunityItem rebuild(void Function(OpportunityItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OpportunityItemBuilder toBuilder() => OpportunityItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OpportunityItem &&
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
    return (newBuiltValueToStringHelper(r'OpportunityItem')
          ..add('type', type)
          ..add('listing', listing)
          ..add('residence', residence))
        .toString();
  }
}

class OpportunityItemBuilder
    implements Builder<OpportunityItem, OpportunityItemBuilder> {
  _$OpportunityItem? _$v;

  OpportunityItemTypeEnum? _type;
  OpportunityItemTypeEnum? get type => _$this._type;
  set type(OpportunityItemTypeEnum? type) => _$this._type = type;

  AgentOpportunityBuilder? _listing;
  AgentOpportunityBuilder get listing =>
      _$this._listing ??= AgentOpportunityBuilder();
  set listing(AgentOpportunityBuilder? listing) => _$this._listing = listing;

  ResidenceOpportunityBuilder? _residence;
  ResidenceOpportunityBuilder get residence =>
      _$this._residence ??= ResidenceOpportunityBuilder();
  set residence(ResidenceOpportunityBuilder? residence) =>
      _$this._residence = residence;

  OpportunityItemBuilder() {
    OpportunityItem._defaults(this);
  }

  OpportunityItemBuilder get _$this {
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
  void replace(OpportunityItem other) {
    _$v = other as _$OpportunityItem;
  }

  @override
  void update(void Function(OpportunityItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OpportunityItem build() => _build();

  _$OpportunityItem _build() {
    _$OpportunityItem _$result;
    try {
      _$result =
          _$v ??
          _$OpportunityItem._(
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
          r'OpportunityItem',
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
