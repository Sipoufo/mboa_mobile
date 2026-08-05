//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_message_request.g.dart';

/// SendMessageRequest
///
/// Properties:
/// * [body] 
/// * [attachmentKeys] 
@BuiltValue()
abstract class SendMessageRequest implements Built<SendMessageRequest, SendMessageRequestBuilder> {
  @BuiltValueField(wireName: r'body')
  String? get body;

  @BuiltValueField(wireName: r'attachmentKeys')
  BuiltList<String>? get attachmentKeys;

  SendMessageRequest._();

  factory SendMessageRequest([void updates(SendMessageRequestBuilder b)]) = _$SendMessageRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendMessageRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendMessageRequest> get serializer => _$SendMessageRequestSerializer();
}

class _$SendMessageRequestSerializer implements PrimitiveSerializer<SendMessageRequest> {
  @override
  final Iterable<Type> types = const [SendMessageRequest, _$SendMessageRequest];

  @override
  final String wireName = r'SendMessageRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendMessageRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    SendMessageRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SendMessageRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SendMessageRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendMessageRequestBuilder();
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

