//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'photo_verification_response.g.dart';

/// PhotoVerificationResponse
///
/// Properties:
/// * [id] 
/// * [target] 
/// * [targetId] 
/// * [status] 
/// * [requestedAt] 
/// * [dueAt] 
/// * [decidedAt] 
/// * [reason] 
@BuiltValue()
abstract class PhotoVerificationResponse implements Built<PhotoVerificationResponse, PhotoVerificationResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'target')
  PhotoVerificationResponseTargetEnum? get target;
  // enum targetEnum {  ANNONCE,  RESIDENCE,  };

  @BuiltValueField(wireName: r'targetId')
  String? get targetId;

  @BuiltValueField(wireName: r'status')
  PhotoVerificationResponseStatusEnum? get status;
  // enum statusEnum {  PENDING,  APPROVED,  REJECTED,  REVOKED,  };

  @BuiltValueField(wireName: r'requestedAt')
  DateTime? get requestedAt;

  @BuiltValueField(wireName: r'dueAt')
  DateTime? get dueAt;

  @BuiltValueField(wireName: r'decidedAt')
  DateTime? get decidedAt;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  PhotoVerificationResponse._();

  factory PhotoVerificationResponse([void updates(PhotoVerificationResponseBuilder b)]) = _$PhotoVerificationResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PhotoVerificationResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PhotoVerificationResponse> get serializer => _$PhotoVerificationResponseSerializer();
}

class _$PhotoVerificationResponseSerializer implements PrimitiveSerializer<PhotoVerificationResponse> {
  @override
  final Iterable<Type> types = const [PhotoVerificationResponse, _$PhotoVerificationResponse];

  @override
  final String wireName = r'PhotoVerificationResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PhotoVerificationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.target != null) {
      yield r'target';
      yield serializers.serialize(
        object.target,
        specifiedType: const FullType(PhotoVerificationResponseTargetEnum),
      );
    }
    if (object.targetId != null) {
      yield r'targetId';
      yield serializers.serialize(
        object.targetId,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(PhotoVerificationResponseStatusEnum),
      );
    }
    if (object.requestedAt != null) {
      yield r'requestedAt';
      yield serializers.serialize(
        object.requestedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.dueAt != null) {
      yield r'dueAt';
      yield serializers.serialize(
        object.dueAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.decidedAt != null) {
      yield r'decidedAt';
      yield serializers.serialize(
        object.decidedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PhotoVerificationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PhotoVerificationResponseBuilder result,
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
        case r'target':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PhotoVerificationResponseTargetEnum),
          ) as PhotoVerificationResponseTargetEnum?;
          if (valueDes == null) continue;
          result.target = valueDes;
          break;
        case r'targetId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.targetId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PhotoVerificationResponseStatusEnum),
          ) as PhotoVerificationResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'requestedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.requestedAt = valueDes;
          break;
        case r'dueAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.dueAt = valueDes;
          break;
        case r'decidedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.decidedAt = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PhotoVerificationResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PhotoVerificationResponseBuilder();
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

class PhotoVerificationResponseTargetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ANNONCE')
  static const PhotoVerificationResponseTargetEnum ANNONCE = _$photoVerificationResponseTargetEnum_ANNONCE;
  @BuiltValueEnumConst(wireName: r'RESIDENCE')
  static const PhotoVerificationResponseTargetEnum RESIDENCE = _$photoVerificationResponseTargetEnum_RESIDENCE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PhotoVerificationResponseTargetEnum unknownDefaultOpenApi = _$photoVerificationResponseTargetEnum_unknownDefaultOpenApi;

  static Serializer<PhotoVerificationResponseTargetEnum> get serializer => _$photoVerificationResponseTargetEnumSerializer;

  const PhotoVerificationResponseTargetEnum._(String name): super(name);

  static BuiltSet<PhotoVerificationResponseTargetEnum> get values => _$photoVerificationResponseTargetEnumValues;
  static PhotoVerificationResponseTargetEnum valueOf(String name) => _$photoVerificationResponseTargetEnumValueOf(name);
}

class PhotoVerificationResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const PhotoVerificationResponseStatusEnum PENDING = _$photoVerificationResponseStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'APPROVED')
  static const PhotoVerificationResponseStatusEnum APPROVED = _$photoVerificationResponseStatusEnum_APPROVED;
  @BuiltValueEnumConst(wireName: r'REJECTED')
  static const PhotoVerificationResponseStatusEnum REJECTED = _$photoVerificationResponseStatusEnum_REJECTED;
  @BuiltValueEnumConst(wireName: r'REVOKED')
  static const PhotoVerificationResponseStatusEnum REVOKED = _$photoVerificationResponseStatusEnum_REVOKED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PhotoVerificationResponseStatusEnum unknownDefaultOpenApi = _$photoVerificationResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<PhotoVerificationResponseStatusEnum> get serializer => _$photoVerificationResponseStatusEnumSerializer;

  const PhotoVerificationResponseStatusEnum._(String name): super(name);

  static BuiltSet<PhotoVerificationResponseStatusEnum> get values => _$photoVerificationResponseStatusEnumValues;
  static PhotoVerificationResponseStatusEnum valueOf(String name) => _$photoVerificationResponseStatusEnumValueOf(name);
}

