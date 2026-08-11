//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'assignment_response.g.dart';

/// AssignmentResponse
///
/// Properties:
/// * [id] 
/// * [annonceId] 
/// * [annonceTitle] 
/// * [agentAccountId] 
/// * [agentName] 
/// * [status] 
/// * [initiatedBy] 
/// * [residenceId] 
/// * [respondedAt] 
/// * [createdAt] 
@BuiltValue()
abstract class AssignmentResponse implements Built<AssignmentResponse, AssignmentResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'annonceTitle')
  String? get annonceTitle;

  @BuiltValueField(wireName: r'agentAccountId')
  String? get agentAccountId;

  @BuiltValueField(wireName: r'agentName')
  String? get agentName;

  @BuiltValueField(wireName: r'status')
  AssignmentResponseStatusEnum? get status;
  // enum statusEnum {  APPLIED,  PENDING,  ACCEPTED,  DECLINED,  WITHDRAWN,  REVOKED,  RESIGNED,  };

  @BuiltValueField(wireName: r'initiatedBy')
  AssignmentResponseInitiatedByEnum? get initiatedBy;
  // enum initiatedByEnum {  PRESTATAIRE,  AGENT,  };

  @BuiltValueField(wireName: r'residenceId')
  String? get residenceId;

  @BuiltValueField(wireName: r'respondedAt')
  DateTime? get respondedAt;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  AssignmentResponse._();

  factory AssignmentResponse([void updates(AssignmentResponseBuilder b)]) = _$AssignmentResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AssignmentResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AssignmentResponse> get serializer => _$AssignmentResponseSerializer();
}

class _$AssignmentResponseSerializer implements PrimitiveSerializer<AssignmentResponse> {
  @override
  final Iterable<Type> types = const [AssignmentResponse, _$AssignmentResponse];

  @override
  final String wireName = r'AssignmentResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AssignmentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.annonceId != null) {
      yield r'annonceId';
      yield serializers.serialize(
        object.annonceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.annonceTitle != null) {
      yield r'annonceTitle';
      yield serializers.serialize(
        object.annonceTitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.agentAccountId != null) {
      yield r'agentAccountId';
      yield serializers.serialize(
        object.agentAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.agentName != null) {
      yield r'agentName';
      yield serializers.serialize(
        object.agentName,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(AssignmentResponseStatusEnum),
      );
    }
    if (object.initiatedBy != null) {
      yield r'initiatedBy';
      yield serializers.serialize(
        object.initiatedBy,
        specifiedType: const FullType(AssignmentResponseInitiatedByEnum),
      );
    }
    if (object.residenceId != null) {
      yield r'residenceId';
      yield serializers.serialize(
        object.residenceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.respondedAt != null) {
      yield r'respondedAt';
      yield serializers.serialize(
        object.respondedAt,
        specifiedType: const FullType(DateTime),
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
    AssignmentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AssignmentResponseBuilder result,
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
        case r'annonceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.annonceId = valueDes;
          break;
        case r'annonceTitle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.annonceTitle = valueDes;
          break;
        case r'agentAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.agentAccountId = valueDes;
          break;
        case r'agentName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.agentName = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AssignmentResponseStatusEnum),
          ) as AssignmentResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'initiatedBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AssignmentResponseInitiatedByEnum),
          ) as AssignmentResponseInitiatedByEnum?;
          if (valueDes == null) continue;
          result.initiatedBy = valueDes;
          break;
        case r'residenceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.residenceId = valueDes;
          break;
        case r'respondedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.respondedAt = valueDes;
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
  AssignmentResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AssignmentResponseBuilder();
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

class AssignmentResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'APPLIED')
  static const AssignmentResponseStatusEnum APPLIED = _$assignmentResponseStatusEnum_APPLIED;
  @BuiltValueEnumConst(wireName: r'PENDING')
  static const AssignmentResponseStatusEnum PENDING = _$assignmentResponseStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'ACCEPTED')
  static const AssignmentResponseStatusEnum ACCEPTED = _$assignmentResponseStatusEnum_ACCEPTED;
  @BuiltValueEnumConst(wireName: r'DECLINED')
  static const AssignmentResponseStatusEnum DECLINED = _$assignmentResponseStatusEnum_DECLINED;
  @BuiltValueEnumConst(wireName: r'WITHDRAWN')
  static const AssignmentResponseStatusEnum WITHDRAWN = _$assignmentResponseStatusEnum_WITHDRAWN;
  @BuiltValueEnumConst(wireName: r'REVOKED')
  static const AssignmentResponseStatusEnum REVOKED = _$assignmentResponseStatusEnum_REVOKED;
  @BuiltValueEnumConst(wireName: r'RESIGNED')
  static const AssignmentResponseStatusEnum RESIGNED = _$assignmentResponseStatusEnum_RESIGNED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AssignmentResponseStatusEnum unknownDefaultOpenApi = _$assignmentResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<AssignmentResponseStatusEnum> get serializer => _$assignmentResponseStatusEnumSerializer;

  const AssignmentResponseStatusEnum._(String name): super(name);

  static BuiltSet<AssignmentResponseStatusEnum> get values => _$assignmentResponseStatusEnumValues;
  static AssignmentResponseStatusEnum valueOf(String name) => _$assignmentResponseStatusEnumValueOf(name);
}

class AssignmentResponseInitiatedByEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PRESTATAIRE')
  static const AssignmentResponseInitiatedByEnum PRESTATAIRE = _$assignmentResponseInitiatedByEnum_PRESTATAIRE;
  @BuiltValueEnumConst(wireName: r'AGENT')
  static const AssignmentResponseInitiatedByEnum AGENT = _$assignmentResponseInitiatedByEnum_AGENT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AssignmentResponseInitiatedByEnum unknownDefaultOpenApi = _$assignmentResponseInitiatedByEnum_unknownDefaultOpenApi;

  static Serializer<AssignmentResponseInitiatedByEnum> get serializer => _$assignmentResponseInitiatedByEnumSerializer;

  const AssignmentResponseInitiatedByEnum._(String name): super(name);

  static BuiltSet<AssignmentResponseInitiatedByEnum> get values => _$assignmentResponseInitiatedByEnumValues;
  static AssignmentResponseInitiatedByEnum valueOf(String name) => _$assignmentResponseInitiatedByEnumValueOf(name);
}

