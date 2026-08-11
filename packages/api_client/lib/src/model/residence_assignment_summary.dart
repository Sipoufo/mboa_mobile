//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'residence_assignment_summary.g.dart';

/// ResidenceAssignmentSummary
///
/// Properties:
/// * [residenceId] 
/// * [residenceName] 
/// * [agentAccountId] 
/// * [agentName] 
/// * [agentPhotoObjectKey] 
/// * [status] 
/// * [initiatedBy] 
/// * [unitCount] 
/// * [createdAt] 
/// * [respondedAt] 
@BuiltValue()
abstract class ResidenceAssignmentSummary implements Built<ResidenceAssignmentSummary, ResidenceAssignmentSummaryBuilder> {
  @BuiltValueField(wireName: r'residenceId')
  String? get residenceId;

  @BuiltValueField(wireName: r'residenceName')
  String? get residenceName;

  @BuiltValueField(wireName: r'agentAccountId')
  String? get agentAccountId;

  @BuiltValueField(wireName: r'agentName')
  String? get agentName;

  @BuiltValueField(wireName: r'agentPhotoObjectKey')
  String? get agentPhotoObjectKey;

  @BuiltValueField(wireName: r'status')
  ResidenceAssignmentSummaryStatusEnum? get status;
  // enum statusEnum {  APPLIED,  PENDING,  ACCEPTED,  DECLINED,  WITHDRAWN,  REVOKED,  RESIGNED,  };

  @BuiltValueField(wireName: r'initiatedBy')
  ResidenceAssignmentSummaryInitiatedByEnum? get initiatedBy;
  // enum initiatedByEnum {  PRESTATAIRE,  AGENT,  };

  @BuiltValueField(wireName: r'unitCount')
  int? get unitCount;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'respondedAt')
  DateTime? get respondedAt;

  ResidenceAssignmentSummary._();

  factory ResidenceAssignmentSummary([void updates(ResidenceAssignmentSummaryBuilder b)]) = _$ResidenceAssignmentSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResidenceAssignmentSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResidenceAssignmentSummary> get serializer => _$ResidenceAssignmentSummarySerializer();
}

class _$ResidenceAssignmentSummarySerializer implements PrimitiveSerializer<ResidenceAssignmentSummary> {
  @override
  final Iterable<Type> types = const [ResidenceAssignmentSummary, _$ResidenceAssignmentSummary];

  @override
  final String wireName = r'ResidenceAssignmentSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResidenceAssignmentSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.residenceId != null) {
      yield r'residenceId';
      yield serializers.serialize(
        object.residenceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.residenceName != null) {
      yield r'residenceName';
      yield serializers.serialize(
        object.residenceName,
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
    if (object.agentPhotoObjectKey != null) {
      yield r'agentPhotoObjectKey';
      yield serializers.serialize(
        object.agentPhotoObjectKey,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(ResidenceAssignmentSummaryStatusEnum),
      );
    }
    if (object.initiatedBy != null) {
      yield r'initiatedBy';
      yield serializers.serialize(
        object.initiatedBy,
        specifiedType: const FullType(ResidenceAssignmentSummaryInitiatedByEnum),
      );
    }
    if (object.unitCount != null) {
      yield r'unitCount';
      yield serializers.serialize(
        object.unitCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.respondedAt != null) {
      yield r'respondedAt';
      yield serializers.serialize(
        object.respondedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ResidenceAssignmentSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResidenceAssignmentSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'residenceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.residenceId = valueDes;
          break;
        case r'residenceName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.residenceName = valueDes;
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
        case r'agentPhotoObjectKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.agentPhotoObjectKey = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ResidenceAssignmentSummaryStatusEnum),
          ) as ResidenceAssignmentSummaryStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'initiatedBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ResidenceAssignmentSummaryInitiatedByEnum),
          ) as ResidenceAssignmentSummaryInitiatedByEnum?;
          if (valueDes == null) continue;
          result.initiatedBy = valueDes;
          break;
        case r'unitCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.unitCount = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'respondedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.respondedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResidenceAssignmentSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResidenceAssignmentSummaryBuilder();
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

class ResidenceAssignmentSummaryStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'APPLIED')
  static const ResidenceAssignmentSummaryStatusEnum APPLIED = _$residenceAssignmentSummaryStatusEnum_APPLIED;
  @BuiltValueEnumConst(wireName: r'PENDING')
  static const ResidenceAssignmentSummaryStatusEnum PENDING = _$residenceAssignmentSummaryStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'ACCEPTED')
  static const ResidenceAssignmentSummaryStatusEnum ACCEPTED = _$residenceAssignmentSummaryStatusEnum_ACCEPTED;
  @BuiltValueEnumConst(wireName: r'DECLINED')
  static const ResidenceAssignmentSummaryStatusEnum DECLINED = _$residenceAssignmentSummaryStatusEnum_DECLINED;
  @BuiltValueEnumConst(wireName: r'WITHDRAWN')
  static const ResidenceAssignmentSummaryStatusEnum WITHDRAWN = _$residenceAssignmentSummaryStatusEnum_WITHDRAWN;
  @BuiltValueEnumConst(wireName: r'REVOKED')
  static const ResidenceAssignmentSummaryStatusEnum REVOKED = _$residenceAssignmentSummaryStatusEnum_REVOKED;
  @BuiltValueEnumConst(wireName: r'RESIGNED')
  static const ResidenceAssignmentSummaryStatusEnum RESIGNED = _$residenceAssignmentSummaryStatusEnum_RESIGNED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ResidenceAssignmentSummaryStatusEnum unknownDefaultOpenApi = _$residenceAssignmentSummaryStatusEnum_unknownDefaultOpenApi;

  static Serializer<ResidenceAssignmentSummaryStatusEnum> get serializer => _$residenceAssignmentSummaryStatusEnumSerializer;

  const ResidenceAssignmentSummaryStatusEnum._(String name): super(name);

  static BuiltSet<ResidenceAssignmentSummaryStatusEnum> get values => _$residenceAssignmentSummaryStatusEnumValues;
  static ResidenceAssignmentSummaryStatusEnum valueOf(String name) => _$residenceAssignmentSummaryStatusEnumValueOf(name);
}

class ResidenceAssignmentSummaryInitiatedByEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PRESTATAIRE')
  static const ResidenceAssignmentSummaryInitiatedByEnum PRESTATAIRE = _$residenceAssignmentSummaryInitiatedByEnum_PRESTATAIRE;
  @BuiltValueEnumConst(wireName: r'AGENT')
  static const ResidenceAssignmentSummaryInitiatedByEnum AGENT = _$residenceAssignmentSummaryInitiatedByEnum_AGENT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ResidenceAssignmentSummaryInitiatedByEnum unknownDefaultOpenApi = _$residenceAssignmentSummaryInitiatedByEnum_unknownDefaultOpenApi;

  static Serializer<ResidenceAssignmentSummaryInitiatedByEnum> get serializer => _$residenceAssignmentSummaryInitiatedByEnumSerializer;

  const ResidenceAssignmentSummaryInitiatedByEnum._(String name): super(name);

  static BuiltSet<ResidenceAssignmentSummaryInitiatedByEnum> get values => _$residenceAssignmentSummaryInitiatedByEnumValues;
  static ResidenceAssignmentSummaryInitiatedByEnum valueOf(String name) => _$residenceAssignmentSummaryInitiatedByEnumValueOf(name);
}

