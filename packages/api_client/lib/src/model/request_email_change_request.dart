//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'request_email_change_request.g.dart';

/// RequestEmailChangeRequest
///
/// Properties:
/// * [newEmail] 
@BuiltValue()
abstract class RequestEmailChangeRequest implements Built<RequestEmailChangeRequest, RequestEmailChangeRequestBuilder> {
  @BuiltValueField(wireName: r'newEmail')
  String get newEmail;

  RequestEmailChangeRequest._();

  factory RequestEmailChangeRequest([void updates(RequestEmailChangeRequestBuilder b)]) = _$RequestEmailChangeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RequestEmailChangeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RequestEmailChangeRequest> get serializer => _$RequestEmailChangeRequestSerializer();
}

class _$RequestEmailChangeRequestSerializer implements PrimitiveSerializer<RequestEmailChangeRequest> {
  @override
  final Iterable<Type> types = const [RequestEmailChangeRequest, _$RequestEmailChangeRequest];

  @override
  final String wireName = r'RequestEmailChangeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RequestEmailChangeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'newEmail';
    yield serializers.serialize(
      object.newEmail,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RequestEmailChangeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RequestEmailChangeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'newEmail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newEmail = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RequestEmailChangeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RequestEmailChangeRequestBuilder();
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

