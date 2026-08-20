// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_prestataire_profile_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdatePrestataireProfileRequestTypeEnum
_$updatePrestataireProfileRequestTypeEnum_PARTICULIER =
    const UpdatePrestataireProfileRequestTypeEnum._('PARTICULIER');
const UpdatePrestataireProfileRequestTypeEnum
_$updatePrestataireProfileRequestTypeEnum_AGENCE =
    const UpdatePrestataireProfileRequestTypeEnum._('AGENCE');
const UpdatePrestataireProfileRequestTypeEnum
_$updatePrestataireProfileRequestTypeEnum_PROMOTEUR =
    const UpdatePrestataireProfileRequestTypeEnum._('PROMOTEUR');
const UpdatePrestataireProfileRequestTypeEnum
_$updatePrestataireProfileRequestTypeEnum_unknownDefaultOpenApi =
    const UpdatePrestataireProfileRequestTypeEnum._('unknownDefaultOpenApi');

UpdatePrestataireProfileRequestTypeEnum
_$updatePrestataireProfileRequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'PARTICULIER':
      return _$updatePrestataireProfileRequestTypeEnum_PARTICULIER;
    case 'AGENCE':
      return _$updatePrestataireProfileRequestTypeEnum_AGENCE;
    case 'PROMOTEUR':
      return _$updatePrestataireProfileRequestTypeEnum_PROMOTEUR;
    case 'unknownDefaultOpenApi':
      return _$updatePrestataireProfileRequestTypeEnum_unknownDefaultOpenApi;
    default:
      return _$updatePrestataireProfileRequestTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<UpdatePrestataireProfileRequestTypeEnum>
_$updatePrestataireProfileRequestTypeEnumValues =
    BuiltSet<UpdatePrestataireProfileRequestTypeEnum>(
      const <UpdatePrestataireProfileRequestTypeEnum>[
        _$updatePrestataireProfileRequestTypeEnum_PARTICULIER,
        _$updatePrestataireProfileRequestTypeEnum_AGENCE,
        _$updatePrestataireProfileRequestTypeEnum_PROMOTEUR,
        _$updatePrestataireProfileRequestTypeEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<UpdatePrestataireProfileRequestTypeEnum>
_$updatePrestataireProfileRequestTypeEnumSerializer =
    _$UpdatePrestataireProfileRequestTypeEnumSerializer();

class _$UpdatePrestataireProfileRequestTypeEnumSerializer
    implements PrimitiveSerializer<UpdatePrestataireProfileRequestTypeEnum> {
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
  final Iterable<Type> types = const <Type>[
    UpdatePrestataireProfileRequestTypeEnum,
  ];
  @override
  final String wireName = 'UpdatePrestataireProfileRequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdatePrestataireProfileRequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdatePrestataireProfileRequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdatePrestataireProfileRequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdatePrestataireProfileRequest
    extends UpdatePrestataireProfileRequest {
  @override
  final String? displayName;
  @override
  final String? logoObjectKey;
  @override
  final UpdatePrestataireProfileRequestTypeEnum? type;
  @override
  final String? mainCityId;
  @override
  final String? registrationNumber;

  factory _$UpdatePrestataireProfileRequest([
    void Function(UpdatePrestataireProfileRequestBuilder)? updates,
  ]) => (UpdatePrestataireProfileRequestBuilder()..update(updates))._build();

  _$UpdatePrestataireProfileRequest._({
    this.displayName,
    this.logoObjectKey,
    this.type,
    this.mainCityId,
    this.registrationNumber,
  }) : super._();
  @override
  UpdatePrestataireProfileRequest rebuild(
    void Function(UpdatePrestataireProfileRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdatePrestataireProfileRequestBuilder toBuilder() =>
      UpdatePrestataireProfileRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdatePrestataireProfileRequest &&
        displayName == other.displayName &&
        logoObjectKey == other.logoObjectKey &&
        type == other.type &&
        mainCityId == other.mainCityId &&
        registrationNumber == other.registrationNumber;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, logoObjectKey.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, mainCityId.hashCode);
    _$hash = $jc(_$hash, registrationNumber.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdatePrestataireProfileRequest')
          ..add('displayName', displayName)
          ..add('logoObjectKey', logoObjectKey)
          ..add('type', type)
          ..add('mainCityId', mainCityId)
          ..add('registrationNumber', registrationNumber))
        .toString();
  }
}

class UpdatePrestataireProfileRequestBuilder
    implements
        Builder<
          UpdatePrestataireProfileRequest,
          UpdatePrestataireProfileRequestBuilder
        > {
  _$UpdatePrestataireProfileRequest? _$v;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _logoObjectKey;
  String? get logoObjectKey => _$this._logoObjectKey;
  set logoObjectKey(String? logoObjectKey) =>
      _$this._logoObjectKey = logoObjectKey;

  UpdatePrestataireProfileRequestTypeEnum? _type;
  UpdatePrestataireProfileRequestTypeEnum? get type => _$this._type;
  set type(UpdatePrestataireProfileRequestTypeEnum? type) =>
      _$this._type = type;

  String? _mainCityId;
  String? get mainCityId => _$this._mainCityId;
  set mainCityId(String? mainCityId) => _$this._mainCityId = mainCityId;

  String? _registrationNumber;
  String? get registrationNumber => _$this._registrationNumber;
  set registrationNumber(String? registrationNumber) =>
      _$this._registrationNumber = registrationNumber;

  UpdatePrestataireProfileRequestBuilder() {
    UpdatePrestataireProfileRequest._defaults(this);
  }

  UpdatePrestataireProfileRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _displayName = $v.displayName;
      _logoObjectKey = $v.logoObjectKey;
      _type = $v.type;
      _mainCityId = $v.mainCityId;
      _registrationNumber = $v.registrationNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdatePrestataireProfileRequest other) {
    _$v = other as _$UpdatePrestataireProfileRequest;
  }

  @override
  void update(void Function(UpdatePrestataireProfileRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdatePrestataireProfileRequest build() => _build();

  _$UpdatePrestataireProfileRequest _build() {
    final _$result =
        _$v ??
        _$UpdatePrestataireProfileRequest._(
          displayName: displayName,
          logoObjectKey: logoObjectKey,
          type: type,
          mainCityId: mainCityId,
          registrationNumber: registrationNumber,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
