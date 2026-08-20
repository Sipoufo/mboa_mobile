//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'agent_visite_detail.g.dart';

/// AgentVisiteDetail
///
/// Properties:
/// * [id] 
/// * [annonceId] 
/// * [annonceTitle] 
/// * [exactAddress] 
/// * [latitude] 
/// * [longitude] 
/// * [scheduledAt] 
/// * [status] 
/// * [userName] 
/// * [userPhone] 
/// * [prestataireName] 
/// * [prestatairePhone] 
/// * [visitorConfirmedAt] 
/// * [clientConfirmedAt] 
/// * [canConfirm] 
@BuiltValue()
abstract class AgentVisiteDetail implements Built<AgentVisiteDetail, AgentVisiteDetailBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'annonceTitle')
  String? get annonceTitle;

  @BuiltValueField(wireName: r'exactAddress')
  String? get exactAddress;

  @BuiltValueField(wireName: r'latitude')
  double? get latitude;

  @BuiltValueField(wireName: r'longitude')
  double? get longitude;

  @BuiltValueField(wireName: r'scheduledAt')
  DateTime? get scheduledAt;

  @BuiltValueField(wireName: r'status')
  AgentVisiteDetailStatusEnum? get status;
  // enum statusEnum {  REQUESTED,  SCHEDULED,  CANCELLED,  COMPLETED,  NOT_FULFILLED,  };

  @BuiltValueField(wireName: r'userName')
  String? get userName;

  @BuiltValueField(wireName: r'userPhone')
  String? get userPhone;

  @BuiltValueField(wireName: r'prestataireName')
  String? get prestataireName;

  @BuiltValueField(wireName: r'prestatairePhone')
  String? get prestatairePhone;

  @BuiltValueField(wireName: r'visitorConfirmedAt')
  DateTime? get visitorConfirmedAt;

  @BuiltValueField(wireName: r'clientConfirmedAt')
  DateTime? get clientConfirmedAt;

  @BuiltValueField(wireName: r'canConfirm')
  bool? get canConfirm;

  AgentVisiteDetail._();

  factory AgentVisiteDetail([void updates(AgentVisiteDetailBuilder b)]) = _$AgentVisiteDetail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AgentVisiteDetailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AgentVisiteDetail> get serializer => _$AgentVisiteDetailSerializer();
}

class _$AgentVisiteDetailSerializer implements PrimitiveSerializer<AgentVisiteDetail> {
  @override
  final Iterable<Type> types = const [AgentVisiteDetail, _$AgentVisiteDetail];

  @override
  final String wireName = r'AgentVisiteDetail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AgentVisiteDetail object, {
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
    if (object.exactAddress != null) {
      yield r'exactAddress';
      yield serializers.serialize(
        object.exactAddress,
        specifiedType: const FullType(String),
      );
    }
    if (object.latitude != null) {
      yield r'latitude';
      yield serializers.serialize(
        object.latitude,
        specifiedType: const FullType(double),
      );
    }
    if (object.longitude != null) {
      yield r'longitude';
      yield serializers.serialize(
        object.longitude,
        specifiedType: const FullType(double),
      );
    }
    if (object.scheduledAt != null) {
      yield r'scheduledAt';
      yield serializers.serialize(
        object.scheduledAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(AgentVisiteDetailStatusEnum),
      );
    }
    if (object.userName != null) {
      yield r'userName';
      yield serializers.serialize(
        object.userName,
        specifiedType: const FullType(String),
      );
    }
    if (object.userPhone != null) {
      yield r'userPhone';
      yield serializers.serialize(
        object.userPhone,
        specifiedType: const FullType(String),
      );
    }
    if (object.prestataireName != null) {
      yield r'prestataireName';
      yield serializers.serialize(
        object.prestataireName,
        specifiedType: const FullType(String),
      );
    }
    if (object.prestatairePhone != null) {
      yield r'prestatairePhone';
      yield serializers.serialize(
        object.prestatairePhone,
        specifiedType: const FullType(String),
      );
    }
    if (object.visitorConfirmedAt != null) {
      yield r'visitorConfirmedAt';
      yield serializers.serialize(
        object.visitorConfirmedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.clientConfirmedAt != null) {
      yield r'clientConfirmedAt';
      yield serializers.serialize(
        object.clientConfirmedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.canConfirm != null) {
      yield r'canConfirm';
      yield serializers.serialize(
        object.canConfirm,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AgentVisiteDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AgentVisiteDetailBuilder result,
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
        case r'exactAddress':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.exactAddress = valueDes;
          break;
        case r'latitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.latitude = valueDes;
          break;
        case r'longitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.longitude = valueDes;
          break;
        case r'scheduledAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.scheduledAt = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AgentVisiteDetailStatusEnum),
          ) as AgentVisiteDetailStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'userName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.userName = valueDes;
          break;
        case r'userPhone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.userPhone = valueDes;
          break;
        case r'prestataireName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.prestataireName = valueDes;
          break;
        case r'prestatairePhone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.prestatairePhone = valueDes;
          break;
        case r'visitorConfirmedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.visitorConfirmedAt = valueDes;
          break;
        case r'clientConfirmedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.clientConfirmedAt = valueDes;
          break;
        case r'canConfirm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canConfirm = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AgentVisiteDetail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AgentVisiteDetailBuilder();
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

class AgentVisiteDetailStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'REQUESTED')
  static const AgentVisiteDetailStatusEnum REQUESTED = _$agentVisiteDetailStatusEnum_REQUESTED;
  @BuiltValueEnumConst(wireName: r'SCHEDULED')
  static const AgentVisiteDetailStatusEnum SCHEDULED = _$agentVisiteDetailStatusEnum_SCHEDULED;
  @BuiltValueEnumConst(wireName: r'CANCELLED')
  static const AgentVisiteDetailStatusEnum CANCELLED = _$agentVisiteDetailStatusEnum_CANCELLED;
  @BuiltValueEnumConst(wireName: r'COMPLETED')
  static const AgentVisiteDetailStatusEnum COMPLETED = _$agentVisiteDetailStatusEnum_COMPLETED;
  @BuiltValueEnumConst(wireName: r'NOT_FULFILLED')
  static const AgentVisiteDetailStatusEnum NOT_FULFILLED = _$agentVisiteDetailStatusEnum_NOT_FULFILLED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AgentVisiteDetailStatusEnum unknownDefaultOpenApi = _$agentVisiteDetailStatusEnum_unknownDefaultOpenApi;

  static Serializer<AgentVisiteDetailStatusEnum> get serializer => _$agentVisiteDetailStatusEnumSerializer;

  const AgentVisiteDetailStatusEnum._(String name): super(name);

  static BuiltSet<AgentVisiteDetailStatusEnum> get values => _$agentVisiteDetailStatusEnumValues;
  static AgentVisiteDetailStatusEnum valueOf(String name) => _$agentVisiteDetailStatusEnumValueOf(name);
}

