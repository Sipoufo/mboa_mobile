//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'request_phone_change_request.g.dart';

/// RequestPhoneChangeRequest
///
/// Properties:
/// * [newPhoneNumber] 
@BuiltValue()
abstract class RequestPhoneChangeRequest implements Built<RequestPhoneChangeRequest, RequestPhoneChangeRequestBuilder> {
  @BuiltValueField(wireName: r'newPhoneNumber')
  String get newPhoneNumber;

  RequestPhoneChangeRequest._();

  factory RequestPhoneChangeRequest([void updates(RequestPhoneChangeRequestBuilder b)]) = _$RequestPhoneChangeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RequestPhoneChangeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RequestPhoneChangeRequest> get serializer => _$RequestPhoneChangeRequestSerializer();
}

class _$RequestPhoneChangeRequestSerializer implements PrimitiveSerializer<RequestPhoneChangeRequest> {
  @override
  final Iterable<Type> types = const [RequestPhoneChangeRequest, _$RequestPhoneChangeRequest];

  @override
  final String wireName = r'RequestPhoneChangeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RequestPhoneChangeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'newPhoneNumber';
    yield serializers.serialize(
      object.newPhoneNumber,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RequestPhoneChangeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RequestPhoneChangeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'newPhoneNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newPhoneNumber = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RequestPhoneChangeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RequestPhoneChangeRequestBuilder();
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

