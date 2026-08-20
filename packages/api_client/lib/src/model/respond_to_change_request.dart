//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'respond_to_change_request.g.dart';

/// RespondToChangeRequest
///
/// Properties:
/// * [body] 
@BuiltValue()
abstract class RespondToChangeRequest implements Built<RespondToChangeRequest, RespondToChangeRequestBuilder> {
  @BuiltValueField(wireName: r'body')
  String get body;

  RespondToChangeRequest._();

  factory RespondToChangeRequest([void updates(RespondToChangeRequestBuilder b)]) = _$RespondToChangeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RespondToChangeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RespondToChangeRequest> get serializer => _$RespondToChangeRequestSerializer();
}

class _$RespondToChangeRequestSerializer implements PrimitiveSerializer<RespondToChangeRequest> {
  @override
  final Iterable<Type> types = const [RespondToChangeRequest, _$RespondToChangeRequest];

  @override
  final String wireName = r'RespondToChangeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RespondToChangeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'body';
    yield serializers.serialize(
      object.body,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RespondToChangeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RespondToChangeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.body = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RespondToChangeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RespondToChangeRequestBuilder();
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

