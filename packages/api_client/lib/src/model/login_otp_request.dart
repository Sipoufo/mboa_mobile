//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_otp_request.g.dart';

/// LoginOtpRequest
///
/// Properties:
/// * [email] 
/// * [code] 
@BuiltValue()
abstract class LoginOtpRequest implements Built<LoginOtpRequest, LoginOtpRequestBuilder> {
  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'code')
  String get code;

  LoginOtpRequest._();

  factory LoginOtpRequest([void updates(LoginOtpRequestBuilder b)]) = _$LoginOtpRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LoginOtpRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LoginOtpRequest> get serializer => _$LoginOtpRequestSerializer();
}

class _$LoginOtpRequestSerializer implements PrimitiveSerializer<LoginOtpRequest> {
  @override
  final Iterable<Type> types = const [LoginOtpRequest, _$LoginOtpRequest];

  @override
  final String wireName = r'LoginOtpRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LoginOtpRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LoginOtpRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LoginOtpRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LoginOtpRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LoginOtpRequestBuilder();
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

