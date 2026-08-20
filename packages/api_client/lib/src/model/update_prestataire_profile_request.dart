//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_prestataire_profile_request.g.dart';

/// UpdatePrestataireProfileRequest
///
/// Properties:
/// * [displayName] 
/// * [logoObjectKey] 
/// * [type] 
/// * [mainCityId] 
/// * [registrationNumber] 
@BuiltValue()
abstract class UpdatePrestataireProfileRequest implements Built<UpdatePrestataireProfileRequest, UpdatePrestataireProfileRequestBuilder> {
  @BuiltValueField(wireName: r'displayName')
  String? get displayName;

  @BuiltValueField(wireName: r'logoObjectKey')
  String? get logoObjectKey;

  @BuiltValueField(wireName: r'type')
  UpdatePrestataireProfileRequestTypeEnum? get type;
  // enum typeEnum {  PARTICULIER,  AGENCE,  PROMOTEUR,  };

  @BuiltValueField(wireName: r'mainCityId')
  String? get mainCityId;

  @BuiltValueField(wireName: r'registrationNumber')
  String? get registrationNumber;

  UpdatePrestataireProfileRequest._();

  factory UpdatePrestataireProfileRequest([void updates(UpdatePrestataireProfileRequestBuilder b)]) = _$UpdatePrestataireProfileRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdatePrestataireProfileRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdatePrestataireProfileRequest> get serializer => _$UpdatePrestataireProfileRequestSerializer();
}

class _$UpdatePrestataireProfileRequestSerializer implements PrimitiveSerializer<UpdatePrestataireProfileRequest> {
  @override
  final Iterable<Type> types = const [UpdatePrestataireProfileRequest, _$UpdatePrestataireProfileRequest];

  @override
  final String wireName = r'UpdatePrestataireProfileRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdatePrestataireProfileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
        specifiedType: const FullType(UpdatePrestataireProfileRequestTypeEnum),
      );
    }
    if (object.mainCityId != null) {
      yield r'mainCityId';
      yield serializers.serialize(
        object.mainCityId,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdatePrestataireProfileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdatePrestataireProfileRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType.nullable(UpdatePrestataireProfileRequestTypeEnum),
          ) as UpdatePrestataireProfileRequestTypeEnum?;
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
        case r'registrationNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.registrationNumber = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdatePrestataireProfileRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdatePrestataireProfileRequestBuilder();
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

class UpdatePrestataireProfileRequestTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PARTICULIER')
  static const UpdatePrestataireProfileRequestTypeEnum PARTICULIER = _$updatePrestataireProfileRequestTypeEnum_PARTICULIER;
  @BuiltValueEnumConst(wireName: r'AGENCE')
  static const UpdatePrestataireProfileRequestTypeEnum AGENCE = _$updatePrestataireProfileRequestTypeEnum_AGENCE;
  @BuiltValueEnumConst(wireName: r'PROMOTEUR')
  static const UpdatePrestataireProfileRequestTypeEnum PROMOTEUR = _$updatePrestataireProfileRequestTypeEnum_PROMOTEUR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UpdatePrestataireProfileRequestTypeEnum unknownDefaultOpenApi = _$updatePrestataireProfileRequestTypeEnum_unknownDefaultOpenApi;

  static Serializer<UpdatePrestataireProfileRequestTypeEnum> get serializer => _$updatePrestataireProfileRequestTypeEnumSerializer;

  const UpdatePrestataireProfileRequestTypeEnum._(String name): super(name);

  static BuiltSet<UpdatePrestataireProfileRequestTypeEnum> get values => _$updatePrestataireProfileRequestTypeEnumValues;
  static UpdatePrestataireProfileRequestTypeEnum valueOf(String name) => _$updatePrestataireProfileRequestTypeEnumValueOf(name);
}

