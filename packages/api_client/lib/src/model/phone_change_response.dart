//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'phone_change_response.g.dart';

/// PhoneChangeResponse
///
/// Properties:
/// * [phoneNumber] 
@BuiltValue()
abstract class PhoneChangeResponse implements Built<PhoneChangeResponse, PhoneChangeResponseBuilder> {
  @BuiltValueField(wireName: r'phoneNumber')
  String? get phoneNumber;

  PhoneChangeResponse._();

  factory PhoneChangeResponse([void updates(PhoneChangeResponseBuilder b)]) = _$PhoneChangeResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PhoneChangeResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PhoneChangeResponse> get serializer => _$PhoneChangeResponseSerializer();
}

class _$PhoneChangeResponseSerializer implements PrimitiveSerializer<PhoneChangeResponse> {
  @override
  final Iterable<Type> types = const [PhoneChangeResponse, _$PhoneChangeResponse];

  @override
  final String wireName = r'PhoneChangeResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PhoneChangeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.phoneNumber != null) {
      yield r'phoneNumber';
      yield serializers.serialize(
        object.phoneNumber,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PhoneChangeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PhoneChangeResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'phoneNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.phoneNumber = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PhoneChangeResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PhoneChangeResponseBuilder();
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

