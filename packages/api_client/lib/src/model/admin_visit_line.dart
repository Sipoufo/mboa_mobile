//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_visit_line.g.dart';

/// AdminVisitLine
///
/// Properties:
/// * [visiteId] 
/// * [annonceId] 
/// * [annonceTitle] 
/// * [scheduledAt] 
/// * [status] 
/// * [cancellationReason] 
/// * [visitorKind] 
@BuiltValue()
abstract class AdminVisitLine implements Built<AdminVisitLine, AdminVisitLineBuilder> {
  @BuiltValueField(wireName: r'visiteId')
  String? get visiteId;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'annonceTitle')
  String? get annonceTitle;

  @BuiltValueField(wireName: r'scheduledAt')
  DateTime? get scheduledAt;

  @BuiltValueField(wireName: r'status')
  AdminVisitLineStatusEnum? get status;
  // enum statusEnum {  REQUESTED,  SCHEDULED,  CANCELLED,  COMPLETED,  NOT_FULFILLED,  };

  @BuiltValueField(wireName: r'cancellationReason')
  AdminVisitLineCancellationReasonEnum? get cancellationReason;
  // enum cancellationReasonEnum {  BY_USER,  BY_AGENT,  AGENT_UNAVAILABLE,  AGENT_REMOVED,  LISTING_UNAVAILABLE,  };

  @BuiltValueField(wireName: r'visitorKind')
  AdminVisitLineVisitorKindEnum? get visitorKind;
  // enum visitorKindEnum {  AGENT,  OWNER,  };

  AdminVisitLine._();

  factory AdminVisitLine([void updates(AdminVisitLineBuilder b)]) = _$AdminVisitLine;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminVisitLineBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminVisitLine> get serializer => _$AdminVisitLineSerializer();
}

class _$AdminVisitLineSerializer implements PrimitiveSerializer<AdminVisitLine> {
  @override
  final Iterable<Type> types = const [AdminVisitLine, _$AdminVisitLine];

  @override
  final String wireName = r'AdminVisitLine';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminVisitLine object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.visiteId != null) {
      yield r'visiteId';
      yield serializers.serialize(
        object.visiteId,
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
        specifiedType: const FullType(AdminVisitLineStatusEnum),
      );
    }
    if (object.cancellationReason != null) {
      yield r'cancellationReason';
      yield serializers.serialize(
        object.cancellationReason,
        specifiedType: const FullType(AdminVisitLineCancellationReasonEnum),
      );
    }
    if (object.visitorKind != null) {
      yield r'visitorKind';
      yield serializers.serialize(
        object.visitorKind,
        specifiedType: const FullType(AdminVisitLineVisitorKindEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminVisitLine object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminVisitLineBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'visiteId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.visiteId = valueDes;
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
            specifiedType: const FullType.nullable(AdminVisitLineStatusEnum),
          ) as AdminVisitLineStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'cancellationReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminVisitLineCancellationReasonEnum),
          ) as AdminVisitLineCancellationReasonEnum?;
          if (valueDes == null) continue;
          result.cancellationReason = valueDes;
          break;
        case r'visitorKind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminVisitLineVisitorKindEnum),
          ) as AdminVisitLineVisitorKindEnum?;
          if (valueDes == null) continue;
          result.visitorKind = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminVisitLine deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminVisitLineBuilder();
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

class AdminVisitLineStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'REQUESTED')
  static const AdminVisitLineStatusEnum REQUESTED = _$adminVisitLineStatusEnum_REQUESTED;
  @BuiltValueEnumConst(wireName: r'SCHEDULED')
  static const AdminVisitLineStatusEnum SCHEDULED = _$adminVisitLineStatusEnum_SCHEDULED;
  @BuiltValueEnumConst(wireName: r'CANCELLED')
  static const AdminVisitLineStatusEnum CANCELLED = _$adminVisitLineStatusEnum_CANCELLED;
  @BuiltValueEnumConst(wireName: r'COMPLETED')
  static const AdminVisitLineStatusEnum COMPLETED = _$adminVisitLineStatusEnum_COMPLETED;
  @BuiltValueEnumConst(wireName: r'NOT_FULFILLED')
  static const AdminVisitLineStatusEnum NOT_FULFILLED = _$adminVisitLineStatusEnum_NOT_FULFILLED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminVisitLineStatusEnum unknownDefaultOpenApi = _$adminVisitLineStatusEnum_unknownDefaultOpenApi;

  static Serializer<AdminVisitLineStatusEnum> get serializer => _$adminVisitLineStatusEnumSerializer;

  const AdminVisitLineStatusEnum._(String name): super(name);

  static BuiltSet<AdminVisitLineStatusEnum> get values => _$adminVisitLineStatusEnumValues;
  static AdminVisitLineStatusEnum valueOf(String name) => _$adminVisitLineStatusEnumValueOf(name);
}

class AdminVisitLineCancellationReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BY_USER')
  static const AdminVisitLineCancellationReasonEnum BY_USER = _$adminVisitLineCancellationReasonEnum_BY_USER;
  @BuiltValueEnumConst(wireName: r'BY_AGENT')
  static const AdminVisitLineCancellationReasonEnum BY_AGENT = _$adminVisitLineCancellationReasonEnum_BY_AGENT;
  @BuiltValueEnumConst(wireName: r'AGENT_UNAVAILABLE')
  static const AdminVisitLineCancellationReasonEnum AGENT_UNAVAILABLE = _$adminVisitLineCancellationReasonEnum_AGENT_UNAVAILABLE;
  @BuiltValueEnumConst(wireName: r'AGENT_REMOVED')
  static const AdminVisitLineCancellationReasonEnum AGENT_REMOVED = _$adminVisitLineCancellationReasonEnum_AGENT_REMOVED;
  @BuiltValueEnumConst(wireName: r'LISTING_UNAVAILABLE')
  static const AdminVisitLineCancellationReasonEnum LISTING_UNAVAILABLE = _$adminVisitLineCancellationReasonEnum_LISTING_UNAVAILABLE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminVisitLineCancellationReasonEnum unknownDefaultOpenApi = _$adminVisitLineCancellationReasonEnum_unknownDefaultOpenApi;

  static Serializer<AdminVisitLineCancellationReasonEnum> get serializer => _$adminVisitLineCancellationReasonEnumSerializer;

  const AdminVisitLineCancellationReasonEnum._(String name): super(name);

  static BuiltSet<AdminVisitLineCancellationReasonEnum> get values => _$adminVisitLineCancellationReasonEnumValues;
  static AdminVisitLineCancellationReasonEnum valueOf(String name) => _$adminVisitLineCancellationReasonEnumValueOf(name);
}

class AdminVisitLineVisitorKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'AGENT')
  static const AdminVisitLineVisitorKindEnum AGENT = _$adminVisitLineVisitorKindEnum_AGENT;
  @BuiltValueEnumConst(wireName: r'OWNER')
  static const AdminVisitLineVisitorKindEnum OWNER = _$adminVisitLineVisitorKindEnum_OWNER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminVisitLineVisitorKindEnum unknownDefaultOpenApi = _$adminVisitLineVisitorKindEnum_unknownDefaultOpenApi;

  static Serializer<AdminVisitLineVisitorKindEnum> get serializer => _$adminVisitLineVisitorKindEnumSerializer;

  const AdminVisitLineVisitorKindEnum._(String name): super(name);

  static BuiltSet<AdminVisitLineVisitorKindEnum> get values => _$adminVisitLineVisitorKindEnumValues;
  static AdminVisitLineVisitorKindEnum valueOf(String name) => _$adminVisitLineVisitorKindEnumValueOf(name);
}

