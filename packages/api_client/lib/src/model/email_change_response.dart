//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'email_change_response.g.dart';

/// EmailChangeResponse
///
/// Properties:
/// * [email] 
@BuiltValue()
abstract class EmailChangeResponse implements Built<EmailChangeResponse, EmailChangeResponseBuilder> {
  @BuiltValueField(wireName: r'email')
  String? get email;

  EmailChangeResponse._();

  factory EmailChangeResponse([void updates(EmailChangeResponseBuilder b)]) = _$EmailChangeResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EmailChangeResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EmailChangeResponse> get serializer => _$EmailChangeResponseSerializer();
}

class _$EmailChangeResponseSerializer implements PrimitiveSerializer<EmailChangeResponse> {
  @override
  final Iterable<Type> types = const [EmailChangeResponse, _$EmailChangeResponse];

  @override
  final String wireName = r'EmailChangeResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EmailChangeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    EmailChangeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EmailChangeResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EmailChangeResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EmailChangeResponseBuilder();
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

