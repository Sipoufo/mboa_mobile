//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/bookable_slot.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bookable_slots_response.g.dart';

/// BookableSlotsResponse
///
/// Properties:
/// * [slots] 
/// * [reason] 
@BuiltValue()
abstract class BookableSlotsResponse implements Built<BookableSlotsResponse, BookableSlotsResponseBuilder> {
  @BuiltValueField(wireName: r'slots')
  BuiltList<BookableSlot>? get slots;

  @BuiltValueField(wireName: r'reason')
  BookableSlotsResponseReasonEnum? get reason;
  // enum reasonEnum {  AGENT_NO_AVAILABILITY,  ALL_DAYS_BLOCKED,  FULLY_BOOKED,  };

  BookableSlotsResponse._();

  factory BookableSlotsResponse([void updates(BookableSlotsResponseBuilder b)]) = _$BookableSlotsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BookableSlotsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BookableSlotsResponse> get serializer => _$BookableSlotsResponseSerializer();
}

class _$BookableSlotsResponseSerializer implements PrimitiveSerializer<BookableSlotsResponse> {
  @override
  final Iterable<Type> types = const [BookableSlotsResponse, _$BookableSlotsResponse];

  @override
  final String wireName = r'BookableSlotsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BookableSlotsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
        specifiedType: const FullType(BookableSlotsResponseReasonEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BookableSlotsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BookableSlotsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType.nullable(BookableSlotsResponseReasonEnum),
          ) as BookableSlotsResponseReasonEnum?;
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
  BookableSlotsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BookableSlotsResponseBuilder();
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

class BookableSlotsResponseReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'AGENT_NO_AVAILABILITY')
  static const BookableSlotsResponseReasonEnum AGENT_NO_AVAILABILITY = _$bookableSlotsResponseReasonEnum_AGENT_NO_AVAILABILITY;
  @BuiltValueEnumConst(wireName: r'ALL_DAYS_BLOCKED')
  static const BookableSlotsResponseReasonEnum ALL_DAYS_BLOCKED = _$bookableSlotsResponseReasonEnum_ALL_DAYS_BLOCKED;
  @BuiltValueEnumConst(wireName: r'FULLY_BOOKED')
  static const BookableSlotsResponseReasonEnum FULLY_BOOKED = _$bookableSlotsResponseReasonEnum_FULLY_BOOKED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BookableSlotsResponseReasonEnum unknownDefaultOpenApi = _$bookableSlotsResponseReasonEnum_unknownDefaultOpenApi;

  static Serializer<BookableSlotsResponseReasonEnum> get serializer => _$bookableSlotsResponseReasonEnumSerializer;

  const BookableSlotsResponseReasonEnum._(String name): super(name);

  static BuiltSet<BookableSlotsResponseReasonEnum> get values => _$bookableSlotsResponseReasonEnumValues;
  static BookableSlotsResponseReasonEnum valueOf(String name) => _$bookableSlotsResponseReasonEnumValueOf(name);
}

