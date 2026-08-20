//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/bookable_slot.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'visitor_slots.g.dart';

/// VisitorSlots
///
/// Properties:
/// * [visitorAccountId] 
/// * [visitorKind] 
/// * [displayName] 
/// * [photoObjectKey] 
/// * [completedVisitCount] 
/// * [averageRating] 
/// * [ratingCount] 
/// * [mode] 
/// * [slots] 
/// * [reason] 
@BuiltValue()
abstract class VisitorSlots implements Built<VisitorSlots, VisitorSlotsBuilder> {
  @BuiltValueField(wireName: r'visitorAccountId')
  String? get visitorAccountId;

  @BuiltValueField(wireName: r'visitorKind')
  VisitorSlotsVisitorKindEnum? get visitorKind;
  // enum visitorKindEnum {  AGENT,  OWNER,  };

  @BuiltValueField(wireName: r'displayName')
  String? get displayName;

  @BuiltValueField(wireName: r'photoObjectKey')
  String? get photoObjectKey;

  @BuiltValueField(wireName: r'completedVisitCount')
  int? get completedVisitCount;

  @BuiltValueField(wireName: r'averageRating')
  double? get averageRating;

  @BuiltValueField(wireName: r'ratingCount')
  int? get ratingCount;

  @BuiltValueField(wireName: r'mode')
  VisitorSlotsModeEnum? get mode;
  // enum modeEnum {  SLOTS,  ON_REQUEST,  };

  @BuiltValueField(wireName: r'slots')
  BuiltList<BookableSlot>? get slots;

  @BuiltValueField(wireName: r'reason')
  VisitorSlotsReasonEnum? get reason;
  // enum reasonEnum {  AGENT_NO_AVAILABILITY,  ALL_DAYS_BLOCKED,  FULLY_BOOKED,  };

  VisitorSlots._();

  factory VisitorSlots([void updates(VisitorSlotsBuilder b)]) = _$VisitorSlots;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VisitorSlotsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<VisitorSlots> get serializer => _$VisitorSlotsSerializer();
}

class _$VisitorSlotsSerializer implements PrimitiveSerializer<VisitorSlots> {
  @override
  final Iterable<Type> types = const [VisitorSlots, _$VisitorSlots];

  @override
  final String wireName = r'VisitorSlots';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VisitorSlots object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
        specifiedType: const FullType(VisitorSlotsVisitorKindEnum),
      );
    }
    if (object.displayName != null) {
      yield r'displayName';
      yield serializers.serialize(
        object.displayName,
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
    if (object.mode != null) {
      yield r'mode';
      yield serializers.serialize(
        object.mode,
        specifiedType: const FullType(VisitorSlotsModeEnum),
      );
    }
    if (object.slots != null) {
      yield r'slots';
      yield serializers.serialize(
        object.slots,
        specifiedType: const FullType(BuiltList, [FullType(BookableSlot)]),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(VisitorSlotsReasonEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    VisitorSlots object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VisitorSlotsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType.nullable(VisitorSlotsVisitorKindEnum),
          ) as VisitorSlotsVisitorKindEnum?;
          if (valueDes == null) continue;
          result.visitorKind = valueDes;
          break;
        case r'displayName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.displayName = valueDes;
          break;
        case r'photoObjectKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.photoObjectKey = valueDes;
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
        case r'mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(VisitorSlotsModeEnum),
          ) as VisitorSlotsModeEnum?;
          if (valueDes == null) continue;
          result.mode = valueDes;
          break;
        case r'slots':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(BookableSlot)]),
          ) as BuiltList<BookableSlot>?;
          if (valueDes == null) continue;
          result.slots.replace(valueDes);
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(VisitorSlotsReasonEnum),
          ) as VisitorSlotsReasonEnum?;
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
  VisitorSlots deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VisitorSlotsBuilder();
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

class VisitorSlotsVisitorKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'AGENT')
  static const VisitorSlotsVisitorKindEnum AGENT = _$visitorSlotsVisitorKindEnum_AGENT;
  @BuiltValueEnumConst(wireName: r'OWNER')
  static const VisitorSlotsVisitorKindEnum OWNER = _$visitorSlotsVisitorKindEnum_OWNER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const VisitorSlotsVisitorKindEnum unknownDefaultOpenApi = _$visitorSlotsVisitorKindEnum_unknownDefaultOpenApi;

  static Serializer<VisitorSlotsVisitorKindEnum> get serializer => _$visitorSlotsVisitorKindEnumSerializer;

  const VisitorSlotsVisitorKindEnum._(String name): super(name);

  static BuiltSet<VisitorSlotsVisitorKindEnum> get values => _$visitorSlotsVisitorKindEnumValues;
  static VisitorSlotsVisitorKindEnum valueOf(String name) => _$visitorSlotsVisitorKindEnumValueOf(name);
}

class VisitorSlotsModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'SLOTS')
  static const VisitorSlotsModeEnum SLOTS = _$visitorSlotsModeEnum_SLOTS;
  @BuiltValueEnumConst(wireName: r'ON_REQUEST')
  static const VisitorSlotsModeEnum ON_REQUEST = _$visitorSlotsModeEnum_ON_REQUEST;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const VisitorSlotsModeEnum unknownDefaultOpenApi = _$visitorSlotsModeEnum_unknownDefaultOpenApi;

  static Serializer<VisitorSlotsModeEnum> get serializer => _$visitorSlotsModeEnumSerializer;

  const VisitorSlotsModeEnum._(String name): super(name);

  static BuiltSet<VisitorSlotsModeEnum> get values => _$visitorSlotsModeEnumValues;
  static VisitorSlotsModeEnum valueOf(String name) => _$visitorSlotsModeEnumValueOf(name);
}

class VisitorSlotsReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'AGENT_NO_AVAILABILITY')
  static const VisitorSlotsReasonEnum AGENT_NO_AVAILABILITY = _$visitorSlotsReasonEnum_AGENT_NO_AVAILABILITY;
  @BuiltValueEnumConst(wireName: r'ALL_DAYS_BLOCKED')
  static const VisitorSlotsReasonEnum ALL_DAYS_BLOCKED = _$visitorSlotsReasonEnum_ALL_DAYS_BLOCKED;
  @BuiltValueEnumConst(wireName: r'FULLY_BOOKED')
  static const VisitorSlotsReasonEnum FULLY_BOOKED = _$visitorSlotsReasonEnum_FULLY_BOOKED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const VisitorSlotsReasonEnum unknownDefaultOpenApi = _$visitorSlotsReasonEnum_unknownDefaultOpenApi;

  static Serializer<VisitorSlotsReasonEnum> get serializer => _$visitorSlotsReasonEnumSerializer;

  const VisitorSlotsReasonEnum._(String name): super(name);

  static BuiltSet<VisitorSlotsReasonEnum> get values => _$visitorSlotsReasonEnumValues;
  static VisitorSlotsReasonEnum valueOf(String name) => _$visitorSlotsReasonEnumValueOf(name);
}

