//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/reservation_request_snapshot.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'message_response.g.dart';

/// MessageResponse
///
/// Properties:
/// * [id] 
/// * [senderAccountId] 
/// * [mine] 
/// * [body] 
/// * [attachmentKeys] 
/// * [sentAt] 
/// * [readAt] 
/// * [kind] 
/// * [systemEvent] 
/// * [reservation] 
@BuiltValue()
abstract class MessageResponse implements Built<MessageResponse, MessageResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'senderAccountId')
  String? get senderAccountId;

  @BuiltValueField(wireName: r'mine')
  bool? get mine;

  @BuiltValueField(wireName: r'body')
  String? get body;

  @BuiltValueField(wireName: r'attachmentKeys')
  BuiltList<String>? get attachmentKeys;

  @BuiltValueField(wireName: r'sentAt')
  DateTime? get sentAt;

  @BuiltValueField(wireName: r'readAt')
  DateTime? get readAt;

  @BuiltValueField(wireName: r'kind')
  MessageResponseKindEnum? get kind;
  // enum kindEnum {  USER,  SYSTEM,  };

  @BuiltValueField(wireName: r'systemEvent')
  MessageResponseSystemEventEnum? get systemEvent;
  // enum systemEventEnum {  RESERVATION_REQUESTED,  };

  @BuiltValueField(wireName: r'reservation')
  ReservationRequestSnapshot? get reservation;

  MessageResponse._();

  factory MessageResponse([void updates(MessageResponseBuilder b)]) = _$MessageResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MessageResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MessageResponse> get serializer => _$MessageResponseSerializer();
}

class _$MessageResponseSerializer implements PrimitiveSerializer<MessageResponse> {
  @override
  final Iterable<Type> types = const [MessageResponse, _$MessageResponse];

  @override
  final String wireName = r'MessageResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MessageResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.senderAccountId != null) {
      yield r'senderAccountId';
      yield serializers.serialize(
        object.senderAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.mine != null) {
      yield r'mine';
      yield serializers.serialize(
        object.mine,
        specifiedType: const FullType(bool),
      );
    }
    if (object.body != null) {
      yield r'body';
      yield serializers.serialize(
        object.body,
        specifiedType: const FullType(String),
      );
    }
    if (object.attachmentKeys != null) {
      yield r'attachmentKeys';
      yield serializers.serialize(
        object.attachmentKeys,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.sentAt != null) {
      yield r'sentAt';
      yield serializers.serialize(
        object.sentAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.readAt != null) {
      yield r'readAt';
      yield serializers.serialize(
        object.readAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.kind != null) {
      yield r'kind';
      yield serializers.serialize(
        object.kind,
        specifiedType: const FullType(MessageResponseKindEnum),
      );
    }
    if (object.systemEvent != null) {
      yield r'systemEvent';
      yield serializers.serialize(
        object.systemEvent,
        specifiedType: const FullType(MessageResponseSystemEventEnum),
      );
    }
    if (object.reservation != null) {
      yield r'reservation';
      yield serializers.serialize(
        object.reservation,
        specifiedType: const FullType(ReservationRequestSnapshot),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MessageResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MessageResponseBuilder result,
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
        case r'senderAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.senderAccountId = valueDes;
          break;
        case r'mine':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.mine = valueDes;
          break;
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.body = valueDes;
          break;
        case r'attachmentKeys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.attachmentKeys.replace(valueDes);
          break;
        case r'sentAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.sentAt = valueDes;
          break;
        case r'readAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.readAt = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(MessageResponseKindEnum),
          ) as MessageResponseKindEnum?;
          if (valueDes == null) continue;
          result.kind = valueDes;
          break;
        case r'systemEvent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(MessageResponseSystemEventEnum),
          ) as MessageResponseSystemEventEnum?;
          if (valueDes == null) continue;
          result.systemEvent = valueDes;
          break;
        case r'reservation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ReservationRequestSnapshot),
          ) as ReservationRequestSnapshot?;
          if (valueDes == null) continue;
          result.reservation.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MessageResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MessageResponseBuilder();
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

class MessageResponseKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USER')
  static const MessageResponseKindEnum USER = _$messageResponseKindEnum_USER;
  @BuiltValueEnumConst(wireName: r'SYSTEM')
  static const MessageResponseKindEnum SYSTEM = _$messageResponseKindEnum_SYSTEM;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MessageResponseKindEnum unknownDefaultOpenApi = _$messageResponseKindEnum_unknownDefaultOpenApi;

  static Serializer<MessageResponseKindEnum> get serializer => _$messageResponseKindEnumSerializer;

  const MessageResponseKindEnum._(String name): super(name);

  static BuiltSet<MessageResponseKindEnum> get values => _$messageResponseKindEnumValues;
  static MessageResponseKindEnum valueOf(String name) => _$messageResponseKindEnumValueOf(name);
}

class MessageResponseSystemEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'RESERVATION_REQUESTED')
  static const MessageResponseSystemEventEnum RESERVATION_REQUESTED = _$messageResponseSystemEventEnum_RESERVATION_REQUESTED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MessageResponseSystemEventEnum unknownDefaultOpenApi = _$messageResponseSystemEventEnum_unknownDefaultOpenApi;

  static Serializer<MessageResponseSystemEventEnum> get serializer => _$messageResponseSystemEventEnumSerializer;

  const MessageResponseSystemEventEnum._(String name): super(name);

  static BuiltSet<MessageResponseSystemEventEnum> get values => _$messageResponseSystemEventEnumValues;
  static MessageResponseSystemEventEnum valueOf(String name) => _$messageResponseSystemEventEnumValueOf(name);
}

