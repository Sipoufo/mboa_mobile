//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'conversation_response.g.dart';

/// ConversationResponse
///
/// Properties:
/// * [id] 
/// * [annonceId] 
/// * [annonceTitle] 
/// * [peerAccountId] 
/// * [peerName] 
/// * [peerPhotoKey] 
/// * [lastMessageAt] 
/// * [lastMessage] 
/// * [unreadCount] 
/// * [readOnly] 
@BuiltValue()
abstract class ConversationResponse implements Built<ConversationResponse, ConversationResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'annonceTitle')
  String? get annonceTitle;

  @BuiltValueField(wireName: r'peerAccountId')
  String? get peerAccountId;

  @BuiltValueField(wireName: r'peerName')
  String? get peerName;

  @BuiltValueField(wireName: r'peerPhotoKey')
  String? get peerPhotoKey;

  @BuiltValueField(wireName: r'lastMessageAt')
  DateTime? get lastMessageAt;

  @BuiltValueField(wireName: r'lastMessage')
  String? get lastMessage;

  @BuiltValueField(wireName: r'unreadCount')
  int? get unreadCount;

  @BuiltValueField(wireName: r'readOnly')
  bool? get readOnly;

  ConversationResponse._();

  factory ConversationResponse([void updates(ConversationResponseBuilder b)]) = _$ConversationResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConversationResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConversationResponse> get serializer => _$ConversationResponseSerializer();
}

class _$ConversationResponseSerializer implements PrimitiveSerializer<ConversationResponse> {
  @override
  final Iterable<Type> types = const [ConversationResponse, _$ConversationResponse];

  @override
  final String wireName = r'ConversationResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConversationResponse object, {
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
    if (object.peerAccountId != null) {
      yield r'peerAccountId';
      yield serializers.serialize(
        object.peerAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.peerName != null) {
      yield r'peerName';
      yield serializers.serialize(
        object.peerName,
        specifiedType: const FullType(String),
      );
    }
    if (object.peerPhotoKey != null) {
      yield r'peerPhotoKey';
      yield serializers.serialize(
        object.peerPhotoKey,
        specifiedType: const FullType(String),
      );
    }
    if (object.lastMessageAt != null) {
      yield r'lastMessageAt';
      yield serializers.serialize(
        object.lastMessageAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.lastMessage != null) {
      yield r'lastMessage';
      yield serializers.serialize(
        object.lastMessage,
        specifiedType: const FullType(String),
      );
    }
    if (object.unreadCount != null) {
      yield r'unreadCount';
      yield serializers.serialize(
        object.unreadCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.readOnly != null) {
      yield r'readOnly';
      yield serializers.serialize(
        object.readOnly,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ConversationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ConversationResponseBuilder result,
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
        case r'peerAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.peerAccountId = valueDes;
          break;
        case r'peerName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.peerName = valueDes;
          break;
        case r'peerPhotoKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.peerPhotoKey = valueDes;
          break;
        case r'lastMessageAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastMessageAt = valueDes;
          break;
        case r'lastMessage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.lastMessage = valueDes;
          break;
        case r'unreadCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.unreadCount = valueDes;
          break;
        case r'readOnly':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.readOnly = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ConversationResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConversationResponseBuilder();
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

