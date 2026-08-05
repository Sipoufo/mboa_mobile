//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'start_conversation_request.g.dart';

/// StartConversationRequest
///
/// Properties:
/// * [annonceId] 
/// * [body] 
/// * [attachmentKeys] 
@BuiltValue()
abstract class StartConversationRequest implements Built<StartConversationRequest, StartConversationRequestBuilder> {
  @BuiltValueField(wireName: r'annonceId')
  String get annonceId;

  @BuiltValueField(wireName: r'body')
  String? get body;

  @BuiltValueField(wireName: r'attachmentKeys')
  BuiltList<String>? get attachmentKeys;

  StartConversationRequest._();

  factory StartConversationRequest([void updates(StartConversationRequestBuilder b)]) = _$StartConversationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StartConversationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StartConversationRequest> get serializer => _$StartConversationRequestSerializer();
}

class _$StartConversationRequestSerializer implements PrimitiveSerializer<StartConversationRequest> {
  @override
  final Iterable<Type> types = const [StartConversationRequest, _$StartConversationRequest];

  @override
  final String wireName = r'StartConversationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StartConversationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'annonceId';
    yield serializers.serialize(
      object.annonceId,
      specifiedType: const FullType(String),
    );
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
    StartConversationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StartConversationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'annonceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.annonceId = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StartConversationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StartConversationRequestBuilder();
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

