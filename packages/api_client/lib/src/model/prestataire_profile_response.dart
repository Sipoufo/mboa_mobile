//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'prestataire_profile_response.g.dart';

/// PrestataireProfileResponse
///
/// Properties:
/// * [id] 
/// * [displayName] 
/// * [logoObjectKey] 
/// * [type] 
/// * [mainCityId] 
/// * [mainCity] 
/// * [registrationNumber] 
/// * [typeChangedAt] 
/// * [profileComplete] 
/// * [createdAt] 
@BuiltValue()
abstract class PrestataireProfileResponse implements Built<PrestataireProfileResponse, PrestataireProfileResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'displayName')
  String? get displayName;

  @BuiltValueField(wireName: r'logoObjectKey')
  String? get logoObjectKey;

  @BuiltValueField(wireName: r'type')
  PrestataireProfileResponseTypeEnum? get type;
  // enum typeEnum {  PARTICULIER,  AGENCE,  PROMOTEUR,  };

  @BuiltValueField(wireName: r'mainCityId')
  String? get mainCityId;

  @BuiltValueField(wireName: r'mainCity')
  String? get mainCity;

  @BuiltValueField(wireName: r'registrationNumber')
  String? get registrationNumber;

  @BuiltValueField(wireName: r'typeChangedAt')
  DateTime? get typeChangedAt;

  @BuiltValueField(wireName: r'profileComplete')
  bool? get profileComplete;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  PrestataireProfileResponse._();

  factory PrestataireProfileResponse([void updates(PrestataireProfileResponseBuilder b)]) = _$PrestataireProfileResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrestataireProfileResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrestataireProfileResponse> get serializer => _$PrestataireProfileResponseSerializer();
}

class _$PrestataireProfileResponseSerializer implements PrimitiveSerializer<PrestataireProfileResponse> {
  @override
  final Iterable<Type> types = const [PrestataireProfileResponse, _$PrestataireProfileResponse];

  @override
  final String wireName = r'PrestataireProfileResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrestataireProfileResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.displayName != null) {
      yield r'displayName';
      yield serializers.serialize(
        object.displayName,
        specifiedType: const FullType(String),
      );
    }
    if (object.logoObjectKey != null) {
      yield r'logoObjectKey';
      yield serializers.serialize(
        object.logoObjectKey,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(PrestataireProfileResponseTypeEnum),
      );
    }
    if (object.mainCityId != null) {
      yield r'mainCityId';
      yield serializers.serialize(
        object.mainCityId,
        specifiedType: const FullType(String),
      );
    }
    if (object.mainCity != null) {
      yield r'mainCity';
      yield serializers.serialize(
        object.mainCity,
        specifiedType: const FullType(String),
      );
    }
    if (object.registrationNumber != null) {
      yield r'registrationNumber';
      yield serializers.serialize(
        object.registrationNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.typeChangedAt != null) {
      yield r'typeChangedAt';
      yield serializers.serialize(
        object.typeChangedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.profileComplete != null) {
      yield r'profileComplete';
      yield serializers.serialize(
        object.profileComplete,
        specifiedType: const FullType(bool),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PrestataireProfileResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PrestataireProfileResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.id = valueDes;
          break;
        case r'displayName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.displayName = valueDes;
          break;
        case r'logoObjectKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.logoObjectKey = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PrestataireProfileResponseTypeEnum),
          ) as PrestataireProfileResponseTypeEnum?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
        case r'mainCityId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.mainCityId = valueDes;
          break;
        case r'mainCity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.mainCity = valueDes;
          break;
        case r'registrationNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.registrationNumber = valueDes;
          break;
        case r'typeChangedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.typeChangedAt = valueDes;
          break;
        case r'profileComplete':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.profileComplete = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrestataireProfileResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrestataireProfileResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class PrestataireProfileResponseTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PARTICULIER')
  static const PrestataireProfileResponseTypeEnum PARTICULIER = _$prestataireProfileResponseTypeEnum_PARTICULIER;
  @BuiltValueEnumConst(wireName: r'AGENCE')
  static const PrestataireProfileResponseTypeEnum AGENCE = _$prestataireProfileResponseTypeEnum_AGENCE;
  @BuiltValueEnumConst(wireName: r'PROMOTEUR')
  static const PrestataireProfileResponseTypeEnum PROMOTEUR = _$prestataireProfileResponseTypeEnum_PROMOTEUR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PrestataireProfileResponseTypeEnum unknownDefaultOpenApi = _$prestataireProfileResponseTypeEnum_unknownDefaultOpenApi;

  static Serializer<PrestataireProfileResponseTypeEnum> get serializer => _$prestataireProfileResponseTypeEnumSerializer;

  const PrestataireProfileResponseTypeEnum._(String name): super(name);

  static BuiltSet<PrestataireProfileResponseTypeEnum> get values => _$prestataireProfileResponseTypeEnumValues;
  static PrestataireProfileResponseTypeEnum valueOf(String name) => _$prestataireProfileResponseTypeEnumValueOf(name);
}

