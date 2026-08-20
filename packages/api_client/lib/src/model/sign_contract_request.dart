//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sign_contract_request.g.dart';

/// SignContractRequest
///
/// Properties:
/// * [sessionId] 
@BuiltValue()
abstract class SignContractRequest implements Built<SignContractRequest, SignContractRequestBuilder> {
  @BuiltValueField(wireName: r'sessionId')
  String? get sessionId;

  SignContractRequest._();

  factory SignContractRequest([void updates(SignContractRequestBuilder b)]) = _$SignContractRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SignContractRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SignContractRequest> get serializer => _$SignContractRequestSerializer();
}

class _$SignContractRequestSerializer implements PrimitiveSerializer<SignContractRequest> {
  @override
  final Iterable<Type> types = const [SignContractRequest, _$SignContractRequest];

  @override
  final String wireName = r'SignContractRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SignContractRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.sessionId != null) {
      yield r'sessionId';
      yield serializers.serialize(
        object.sessionId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SignContractRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SignContractRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'sessionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.sessionId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SignContractRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SignContractRequestBuilder();
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

