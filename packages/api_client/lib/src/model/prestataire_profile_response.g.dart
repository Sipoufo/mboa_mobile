// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prestataire_profile_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PrestataireProfileResponseTypeEnum
_$prestataireProfileResponseTypeEnum_PARTICULIER =
    const PrestataireProfileResponseTypeEnum._('PARTICULIER');
const PrestataireProfileResponseTypeEnum
_$prestataireProfileResponseTypeEnum_AGENCE =
    const PrestataireProfileResponseTypeEnum._('AGENCE');
const PrestataireProfileResponseTypeEnum
_$prestataireProfileResponseTypeEnum_PROMOTEUR =
    const PrestataireProfileResponseTypeEnum._('PROMOTEUR');
const PrestataireProfileResponseTypeEnum
_$prestataireProfileResponseTypeEnum_unknownDefaultOpenApi =
    const PrestataireProfileResponseTypeEnum._('unknownDefaultOpenApi');

PrestataireProfileResponseTypeEnum _$prestataireProfileResponseTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PARTICULIER':
      return _$prestataireProfileResponseTypeEnum_PARTICULIER;
    case 'AGENCE':
      return _$prestataireProfileResponseTypeEnum_AGENCE;
    case 'PROMOTEUR':
      return _$prestataireProfileResponseTypeEnum_PROMOTEUR;
    case 'unknownDefaultOpenApi':
      return _$prestataireProfileResponseTypeEnum_unknownDefaultOpenApi;
    default:
      return _$prestataireProfileResponseTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PrestataireProfileResponseTypeEnum>
_$prestataireProfileResponseTypeEnumValues =
    BuiltSet<PrestataireProfileResponseTypeEnum>(
      const <PrestataireProfileResponseTypeEnum>[
        _$prestataireProfileResponseTypeEnum_PARTICULIER,
        _$prestataireProfileResponseTypeEnum_AGENCE,
        _$prestataireProfileResponseTypeEnum_PROMOTEUR,
        _$prestataireProfileResponseTypeEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<PrestataireProfileResponseTypeEnum>
_$prestataireProfileResponseTypeEnumSerializer =
    _$PrestataireProfileResponseTypeEnumSerializer();

class _$PrestataireProfileResponseTypeEnumSerializer
    implements PrimitiveSerializer<PrestataireProfileResponseTypeEnum> {
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
  final Iterable<Type> types = const <Type>[PrestataireProfileResponseTypeEnum];
  @override
  final String wireName = 'PrestataireProfileResponseTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    PrestataireProfileResponseTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PrestataireProfileResponseTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PrestataireProfileResponseTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PrestataireProfileResponse extends PrestataireProfileResponse {
  @override
  final String? id;
  @override
  final String? displayName;
  @override
  final String? logoObjectKey;
  @override
  final PrestataireProfileResponseTypeEnum? type;
  @override
  final String? mainCityId;
  @override
  final String? mainCity;
  @override
  final DateTime? typeChangedAt;
  @override
  final bool? profileComplete;
  @override
  final DateTime? createdAt;

  factory _$PrestataireProfileResponse([
    void Function(PrestataireProfileResponseBuilder)? updates,
  ]) => (PrestataireProfileResponseBuilder()..update(updates))._build();

  _$PrestataireProfileResponse._({
    this.id,
    this.displayName,
    this.logoObjectKey,
    this.type,
    this.mainCityId,
    this.mainCity,
    this.typeChangedAt,
    this.profileComplete,
    this.createdAt,
  }) : super._();
  @override
  PrestataireProfileResponse rebuild(
    void Function(PrestataireProfileResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PrestataireProfileResponseBuilder toBuilder() =>
      PrestataireProfileResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrestataireProfileResponse &&
        id == other.id &&
        displayName == other.displayName &&
        logoObjectKey == other.logoObjectKey &&
        type == other.type &&
        mainCityId == other.mainCityId &&
        mainCity == other.mainCity &&
        typeChangedAt == other.typeChangedAt &&
        profileComplete == other.profileComplete &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, logoObjectKey.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, mainCityId.hashCode);
    _$hash = $jc(_$hash, mainCity.hashCode);
    _$hash = $jc(_$hash, typeChangedAt.hashCode);
    _$hash = $jc(_$hash, profileComplete.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrestataireProfileResponse')
          ..add('id', id)
          ..add('displayName', displayName)
          ..add('logoObjectKey', logoObjectKey)
          ..add('type', type)
          ..add('mainCityId', mainCityId)
          ..add('mainCity', mainCity)
          ..add('typeChangedAt', typeChangedAt)
          ..add('profileComplete', profileComplete)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class PrestataireProfileResponseBuilder
    implements
        Builder<PrestataireProfileResponse, PrestataireProfileResponseBuilder> {
  _$PrestataireProfileResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _logoObjectKey;
  String? get logoObjectKey => _$this._logoObjectKey;
  set logoObjectKey(String? logoObjectKey) =>
      _$this._logoObjectKey = logoObjectKey;

  PrestataireProfileResponseTypeEnum? _type;
  PrestataireProfileResponseTypeEnum? get type => _$this._type;
  set type(PrestataireProfileResponseTypeEnum? type) => _$this._type = type;

  String? _mainCityId;
  String? get mainCityId => _$this._mainCityId;
  set mainCityId(String? mainCityId) => _$this._mainCityId = mainCityId;

  String? _mainCity;
  String? get mainCity => _$this._mainCity;
  set mainCity(String? mainCity) => _$this._mainCity = mainCity;

  DateTime? _typeChangedAt;
  DateTime? get typeChangedAt => _$this._typeChangedAt;
  set typeChangedAt(DateTime? typeChangedAt) =>
      _$this._typeChangedAt = typeChangedAt;

  bool? _profileComplete;
  bool? get profileComplete => _$this._profileComplete;
  set profileComplete(bool? profileComplete) =>
      _$this._profileComplete = profileComplete;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  PrestataireProfileResponseBuilder() {
    PrestataireProfileResponse._defaults(this);
  }

  PrestataireProfileResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _displayName = $v.displayName;
      _logoObjectKey = $v.logoObjectKey;
      _type = $v.type;
      _mainCityId = $v.mainCityId;
      _mainCity = $v.mainCity;
      _typeChangedAt = $v.typeChangedAt;
      _profileComplete = $v.profileComplete;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrestataireProfileResponse other) {
    _$v = other as _$PrestataireProfileResponse;
  }

  @override
  void update(void Function(PrestataireProfileResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrestataireProfileResponse build() => _build();

  _$PrestataireProfileResponse _build() {
    final _$result =
        _$v ??
        _$PrestataireProfileResponse._(
          id: id,
          displayName: displayName,
          logoObjectKey: logoObjectKey,
          type: type,
          mainCityId: mainCityId,
          mainCity: mainCity,
          typeChangedAt: typeChangedAt,
          profileComplete: profileComplete,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
