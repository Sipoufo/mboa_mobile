//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'visite_response.g.dart';

/// VisiteResponse
///
/// Properties:
/// * [id] 
/// * [annonceId] 
/// * [annonceTitle] 
/// * [visitorAccountId] 
/// * [visitorKind] 
/// * [scheduledAt] 
/// * [status] 
/// * [visitorConfirmedAt] 
/// * [clientConfirmedAt] 
/// * [cancellationReason] 
/// * [createdAt] 
@BuiltValue()
abstract class VisiteResponse implements Built<VisiteResponse, VisiteResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'annonceTitle')
  String? get annonceTitle;

  @BuiltValueField(wireName: r'visitorAccountId')
  String? get visitorAccountId;

  @BuiltValueField(wireName: r'visitorKind')
  VisiteResponseVisitorKindEnum? get visitorKind;
  // enum visitorKindEnum {  AGENT,  OWNER,  };

  @BuiltValueField(wireName: r'scheduledAt')
  DateTime? get scheduledAt;

  @BuiltValueField(wireName: r'status')
  VisiteResponseStatusEnum? get status;
  // enum statusEnum {  REQUESTED,  SCHEDULED,  CANCELLED,  COMPLETED,  NOT_FULFILLED,  };

  @BuiltValueField(wireName: r'visitorConfirmedAt')
  DateTime? get visitorConfirmedAt;

  @BuiltValueField(wireName: r'clientConfirmedAt')
  DateTime? get clientConfirmedAt;

  @BuiltValueField(wireName: r'cancellationReason')
  VisiteResponseCancellationReasonEnum? get cancellationReason;
  // enum cancellationReasonEnum {  BY_USER,  BY_AGENT,  AGENT_UNAVAILABLE,  AGENT_REMOVED,  };

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  VisiteResponse._();

  factory VisiteResponse([void updates(VisiteResponseBuilder b)]) = _$VisiteResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VisiteResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<VisiteResponse> get serializer => _$VisiteResponseSerializer();
}

class _$VisiteResponseSerializer implements PrimitiveSerializer<VisiteResponse> {
  @override
  final Iterable<Type> types = const [VisiteResponse, _$VisiteResponse];

  @override
  final String wireName = r'VisiteResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VisiteResponse object, {
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
    if (object.visitorAccountId != null) {
      yield r'visitorAccountId';
      yield serializers.serialize(
        object.visitorAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.visitorKind != null) {
      yield r'visitorKind';
      yield serializers.serialize(
        object.visitorKind,
        specifiedType: const FullType(VisiteResponseVisitorKindEnum),
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
        specifiedType: const FullType(VisiteResponseStatusEnum),
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
    if (object.cancellationReason != null) {
      yield r'cancellationReason';
      yield serializers.serialize(
        object.cancellationReason,
        specifiedType: const FullType(VisiteResponseCancellationReasonEnum),
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
    VisiteResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VisiteResponseBuilder result,
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
        case r'visitorAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.visitorAccountId = valueDes;
          break;
        case r'visitorKind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(VisiteResponseVisitorKindEnum),
          ) as VisiteResponseVisitorKindEnum?;
          if (valueDes == null) continue;
          result.visitorKind = valueDes;
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
            specifiedType: const FullType.nullable(VisiteResponseStatusEnum),
          ) as VisiteResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
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
        case r'cancellationReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(VisiteResponseCancellationReasonEnum),
          ) as VisiteResponseCancellationReasonEnum?;
          if (valueDes == null) continue;
          result.cancellationReason = valueDes;
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
  VisiteResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VisiteResponseBuilder();
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

class VisiteResponseVisitorKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'AGENT')
  static const VisiteResponseVisitorKindEnum AGENT = _$visiteResponseVisitorKindEnum_AGENT;
  @BuiltValueEnumConst(wireName: r'OWNER')
  static const VisiteResponseVisitorKindEnum OWNER = _$visiteResponseVisitorKindEnum_OWNER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const VisiteResponseVisitorKindEnum unknownDefaultOpenApi = _$visiteResponseVisitorKindEnum_unknownDefaultOpenApi;

  static Serializer<VisiteResponseVisitorKindEnum> get serializer => _$visiteResponseVisitorKindEnumSerializer;

  const VisiteResponseVisitorKindEnum._(String name): super(name);

  static BuiltSet<VisiteResponseVisitorKindEnum> get values => _$visiteResponseVisitorKindEnumValues;
  static VisiteResponseVisitorKindEnum valueOf(String name) => _$visiteResponseVisitorKindEnumValueOf(name);
}

class VisiteResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'REQUESTED')
  static const VisiteResponseStatusEnum REQUESTED = _$visiteResponseStatusEnum_REQUESTED;
  @BuiltValueEnumConst(wireName: r'SCHEDULED')
  static const VisiteResponseStatusEnum SCHEDULED = _$visiteResponseStatusEnum_SCHEDULED;
  @BuiltValueEnumConst(wireName: r'CANCELLED')
  static const VisiteResponseStatusEnum CANCELLED = _$visiteResponseStatusEnum_CANCELLED;
  @BuiltValueEnumConst(wireName: r'COMPLETED')
  static const VisiteResponseStatusEnum COMPLETED = _$visiteResponseStatusEnum_COMPLETED;
  @BuiltValueEnumConst(wireName: r'NOT_FULFILLED')
  static const VisiteResponseStatusEnum NOT_FULFILLED = _$visiteResponseStatusEnum_NOT_FULFILLED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const VisiteResponseStatusEnum unknownDefaultOpenApi = _$visiteResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<VisiteResponseStatusEnum> get serializer => _$visiteResponseStatusEnumSerializer;

  const VisiteResponseStatusEnum._(String name): super(name);

  static BuiltSet<VisiteResponseStatusEnum> get values => _$visiteResponseStatusEnumValues;
  static VisiteResponseStatusEnum valueOf(String name) => _$visiteResponseStatusEnumValueOf(name);
}

class VisiteResponseCancellationReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BY_USER')
  static const VisiteResponseCancellationReasonEnum BY_USER = _$visiteResponseCancellationReasonEnum_BY_USER;
  @BuiltValueEnumConst(wireName: r'BY_AGENT')
  static const VisiteResponseCancellationReasonEnum BY_AGENT = _$visiteResponseCancellationReasonEnum_BY_AGENT;
  @BuiltValueEnumConst(wireName: r'AGENT_UNAVAILABLE')
  static const VisiteResponseCancellationReasonEnum AGENT_UNAVAILABLE = _$visiteResponseCancellationReasonEnum_AGENT_UNAVAILABLE;
  @BuiltValueEnumConst(wireName: r'AGENT_REMOVED')
  static const VisiteResponseCancellationReasonEnum AGENT_REMOVED = _$visiteResponseCancellationReasonEnum_AGENT_REMOVED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const VisiteResponseCancellationReasonEnum unknownDefaultOpenApi = _$visiteResponseCancellationReasonEnum_unknownDefaultOpenApi;

  static Serializer<VisiteResponseCancellationReasonEnum> get serializer => _$visiteResponseCancellationReasonEnumSerializer;

  const VisiteResponseCancellationReasonEnum._(String name): super(name);

  static BuiltSet<VisiteResponseCancellationReasonEnum> get values => _$visiteResponseCancellationReasonEnumValues;
  static VisiteResponseCancellationReasonEnum valueOf(String name) => _$visiteResponseCancellationReasonEnumValueOf(name);
}

