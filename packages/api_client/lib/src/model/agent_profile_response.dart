//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/zone_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'agent_profile_response.g.dart';

/// AgentProfileResponse
///
/// Properties:
/// * [accountId] 
/// * [firstName] 
/// * [lastName] 
/// * [photoObjectKey] 
/// * [zones] 
/// * [acceptingAssignments] 
/// * [completedVisitCount] 
/// * [averageRating] 
/// * [ratingCount] 
/// * [status] 
/// * [profileComplete] 
/// * [createdAt] 
@BuiltValue()
abstract class AgentProfileResponse implements Built<AgentProfileResponse, AgentProfileResponseBuilder> {
  @BuiltValueField(wireName: r'accountId')
  String? get accountId;

  @BuiltValueField(wireName: r'firstName')
  String? get firstName;

  @BuiltValueField(wireName: r'lastName')
  String? get lastName;

  @BuiltValueField(wireName: r'photoObjectKey')
  String? get photoObjectKey;

  @BuiltValueField(wireName: r'zones')
  BuiltList<ZoneResponse>? get zones;

  @BuiltValueField(wireName: r'acceptingAssignments')
  bool? get acceptingAssignments;

  @BuiltValueField(wireName: r'completedVisitCount')
  int? get completedVisitCount;

  @BuiltValueField(wireName: r'averageRating')
  double? get averageRating;

  @BuiltValueField(wireName: r'ratingCount')
  int? get ratingCount;

  @BuiltValueField(wireName: r'status')
  AgentProfileResponseStatusEnum? get status;
  // enum statusEnum {  PENDING,  ACTIVE,  SUSPENDED,  DELETED,  };

  @BuiltValueField(wireName: r'profileComplete')
  bool? get profileComplete;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  AgentProfileResponse._();

  factory AgentProfileResponse([void updates(AgentProfileResponseBuilder b)]) = _$AgentProfileResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AgentProfileResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AgentProfileResponse> get serializer => _$AgentProfileResponseSerializer();
}

class _$AgentProfileResponseSerializer implements PrimitiveSerializer<AgentProfileResponse> {
  @override
  final Iterable<Type> types = const [AgentProfileResponse, _$AgentProfileResponse];

  @override
  final String wireName = r'AgentProfileResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AgentProfileResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.accountId != null) {
      yield r'accountId';
      yield serializers.serialize(
        object.accountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.firstName != null) {
      yield r'firstName';
      yield serializers.serialize(
        object.firstName,
        specifiedType: const FullType(String),
      );
    }
    if (object.lastName != null) {
      yield r'lastName';
      yield serializers.serialize(
        object.lastName,
        specifiedType: const FullType(String),
      );
    }
    if (object.photoObjectKey != null) {
      yield r'photoObjectKey';
      yield serializers.serialize(
        object.photoObjectKey,
        specifiedType: const FullType(String),
      );
    }
    if (object.zones != null) {
      yield r'zones';
      yield serializers.serialize(
        object.zones,
        specifiedType: const FullType(BuiltList, [FullType(ZoneResponse)]),
      );
    }
    if (object.acceptingAssignments != null) {
      yield r'acceptingAssignments';
      yield serializers.serialize(
        object.acceptingAssignments,
        specifiedType: const FullType(bool),
      );
    }
    if (object.completedVisitCount != null) {
      yield r'completedVisitCount';
      yield serializers.serialize(
        object.completedVisitCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.averageRating != null) {
      yield r'averageRating';
      yield serializers.serialize(
        object.averageRating,
        specifiedType: const FullType(double),
      );
    }
    if (object.ratingCount != null) {
      yield r'ratingCount';
      yield serializers.serialize(
        object.ratingCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(AgentProfileResponseStatusEnum),
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
    AgentProfileResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AgentProfileResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'accountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.accountId = valueDes;
          break;
        case r'firstName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.firstName = valueDes;
          break;
        case r'lastName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.lastName = valueDes;
          break;
        case r'photoObjectKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.photoObjectKey = valueDes;
          break;
        case r'zones':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(ZoneResponse)]),
          ) as BuiltList<ZoneResponse>?;
          if (valueDes == null) continue;
          result.zones.replace(valueDes);
          break;
        case r'acceptingAssignments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.acceptingAssignments = valueDes;
          break;
        case r'completedVisitCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.completedVisitCount = valueDes;
          break;
        case r'averageRating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.averageRating = valueDes;
          break;
        case r'ratingCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.ratingCount = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AgentProfileResponseStatusEnum),
          ) as AgentProfileResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
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
  AgentProfileResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AgentProfileResponseBuilder();
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

class AgentProfileResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const AgentProfileResponseStatusEnum PENDING = _$agentProfileResponseStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'ACTIVE')
  static const AgentProfileResponseStatusEnum ACTIVE = _$agentProfileResponseStatusEnum_ACTIVE;
  @BuiltValueEnumConst(wireName: r'SUSPENDED')
  static const AgentProfileResponseStatusEnum SUSPENDED = _$agentProfileResponseStatusEnum_SUSPENDED;
  @BuiltValueEnumConst(wireName: r'DELETED')
  static const AgentProfileResponseStatusEnum DELETED = _$agentProfileResponseStatusEnum_DELETED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AgentProfileResponseStatusEnum unknownDefaultOpenApi = _$agentProfileResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<AgentProfileResponseStatusEnum> get serializer => _$agentProfileResponseStatusEnumSerializer;

  const AgentProfileResponseStatusEnum._(String name): super(name);

  static BuiltSet<AgentProfileResponseStatusEnum> get values => _$agentProfileResponseStatusEnumValues;
  static AgentProfileResponseStatusEnum valueOf(String name) => _$agentProfileResponseStatusEnumValueOf(name);
}

