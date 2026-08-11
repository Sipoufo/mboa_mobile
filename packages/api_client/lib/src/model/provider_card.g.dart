// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_card.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProviderCardTypeEnum _$providerCardTypeEnum_PARTICULIER =
    const ProviderCardTypeEnum._('PARTICULIER');
const ProviderCardTypeEnum _$providerCardTypeEnum_AGENCE =
    const ProviderCardTypeEnum._('AGENCE');
const ProviderCardTypeEnum _$providerCardTypeEnum_PROMOTEUR =
    const ProviderCardTypeEnum._('PROMOTEUR');
const ProviderCardTypeEnum _$providerCardTypeEnum_unknownDefaultOpenApi =
    const ProviderCardTypeEnum._('unknownDefaultOpenApi');

ProviderCardTypeEnum _$providerCardTypeEnumValueOf(String name) {
  switch (name) {
    case 'PARTICULIER':
      return _$providerCardTypeEnum_PARTICULIER;
    case 'AGENCE':
      return _$providerCardTypeEnum_AGENCE;
    case 'PROMOTEUR':
      return _$providerCardTypeEnum_PROMOTEUR;
    case 'unknownDefaultOpenApi':
      return _$providerCardTypeEnum_unknownDefaultOpenApi;
    default:
      return _$providerCardTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ProviderCardTypeEnum> _$providerCardTypeEnumValues =
    BuiltSet<ProviderCardTypeEnum>(const <ProviderCardTypeEnum>[
      _$providerCardTypeEnum_PARTICULIER,
      _$providerCardTypeEnum_AGENCE,
      _$providerCardTypeEnum_PROMOTEUR,
      _$providerCardTypeEnum_unknownDefaultOpenApi,
    ]);

Serializer<ProviderCardTypeEnum> _$providerCardTypeEnumSerializer =
    _$ProviderCardTypeEnumSerializer();

class _$ProviderCardTypeEnumSerializer
    implements PrimitiveSerializer<ProviderCardTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PARTICULIER': 'PARTICULIER',
    'AGENCE': 'AGENCE',
    'PROMOTEUR': 'PROMOTEUR',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PARTICULIER': 'PARTICULIER',
    'AGENCE': 'AGENCE',
    'PROMOTEUR': 'PROMOTEUR',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ProviderCardTypeEnum];
  @override
  final String wireName = 'ProviderCardTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    ProviderCardTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ProviderCardTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ProviderCardTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ProviderCard extends ProviderCard {
  @override
  final String? accountId;
  @override
  final String? displayName;
  @override
  final String? logoObjectKey;
  @override
  final ProviderCardTypeEnum? type;
  @override
  final int? tierRank;
  @override
  final BuiltList<String>? badges;

  factory _$ProviderCard([void Function(ProviderCardBuilder)? updates]) =>
      (ProviderCardBuilder()..update(updates))._build();

  _$ProviderCard._({
    this.accountId,
    this.displayName,
    this.logoObjectKey,
    this.type,
    this.tierRank,
    this.badges,
  }) : super._();
  @override
  ProviderCard rebuild(void Function(ProviderCardBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProviderCardBuilder toBuilder() => ProviderCardBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProviderCard &&
        accountId == other.accountId &&
        displayName == other.displayName &&
        logoObjectKey == other.logoObjectKey &&
        type == other.type &&
        tierRank == other.tierRank &&
        badges == other.badges;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, logoObjectKey.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, tierRank.hashCode);
    _$hash = $jc(_$hash, badges.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProviderCard')
          ..add('accountId', accountId)
          ..add('displayName', displayName)
          ..add('logoObjectKey', logoObjectKey)
          ..add('type', type)
          ..add('tierRank', tierRank)
          ..add('badges', badges))
        .toString();
  }
}

class ProviderCardBuilder
    implements Builder<ProviderCard, ProviderCardBuilder> {
  _$ProviderCard? _$v;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _logoObjectKey;
  String? get logoObjectKey => _$this._logoObjectKey;
  set logoObjectKey(String? logoObjectKey) =>
      _$this._logoObjectKey = logoObjectKey;

  ProviderCardTypeEnum? _type;
  ProviderCardTypeEnum? get type => _$this._type;
  set type(ProviderCardTypeEnum? type) => _$this._type = type;

  int? _tierRank;
  int? get tierRank => _$this._tierRank;
  set tierRank(int? tierRank) => _$this._tierRank = tierRank;

  ListBuilder<String>? _badges;
  ListBuilder<String> get badges => _$this._badges ??= ListBuilder<String>();
  set badges(ListBuilder<String>? badges) => _$this._badges = badges;

  ProviderCardBuilder() {
    ProviderCard._defaults(this);
  }

  ProviderCardBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountId = $v.accountId;
      _displayName = $v.displayName;
      _logoObjectKey = $v.logoObjectKey;
      _type = $v.type;
      _tierRank = $v.tierRank;
      _badges = $v.badges?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProviderCard other) {
    _$v = other as _$ProviderCard;
  }

  @override
  void update(void Function(ProviderCardBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProviderCard build() => _build();

  _$ProviderCard _build() {
    _$ProviderCard _$result;
    try {
      _$result =
          _$v ??
          _$ProviderCard._(
            accountId: accountId,
            displayName: displayName,
            logoObjectKey: logoObjectKey,
            type: type,
            tierRank: tierRank,
            badges: _badges?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'badges';
        _badges?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ProviderCard',
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
