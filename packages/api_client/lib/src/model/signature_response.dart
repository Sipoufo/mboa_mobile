//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'signature_response.g.dart';

/// SignatureResponse
///
/// Properties:
/// * [signerAccountId] 
/// * [signedAt] 
/// * [current] 
@BuiltValue()
abstract class SignatureResponse implements Built<SignatureResponse, SignatureResponseBuilder> {
  @BuiltValueField(wireName: r'signerAccountId')
  String? get signerAccountId;

  @BuiltValueField(wireName: r'signedAt')
  DateTime? get signedAt;

  @BuiltValueField(wireName: r'current')
  bool? get current;

  SignatureResponse._();

  factory SignatureResponse([void updates(SignatureResponseBuilder b)]) = _$SignatureResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SignatureResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SignatureResponse> get serializer => _$SignatureResponseSerializer();
}

class _$SignatureResponseSerializer implements PrimitiveSerializer<SignatureResponse> {
  @override
  final Iterable<Type> types = const [SignatureResponse, _$SignatureResponse];

  @override
  final String wireName = r'SignatureResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SignatureResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.signerAccountId != null) {
      yield r'signerAccountId';
      yield serializers.serialize(
        object.signerAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.signedAt != null) {
      yield r'signedAt';
      yield serializers.serialize(
        object.signedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.current != null) {
      yield r'current';
      yield serializers.serialize(
        object.current,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SignatureResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SignatureResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'signerAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.signerAccountId = valueDes;
          break;
        case r'signedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.signedAt = valueDes;
          break;
        case r'current':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.current = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SignatureResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SignatureResponseBuilder();
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

