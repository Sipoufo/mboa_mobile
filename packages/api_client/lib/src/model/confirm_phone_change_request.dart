//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'confirm_phone_change_request.g.dart';

/// ConfirmPhoneChangeRequest
///
/// Properties:
/// * [newPhoneNumber] 
/// * [oldCode] 
/// * [newCode] 
@BuiltValue()
abstract class ConfirmPhoneChangeRequest implements Built<ConfirmPhoneChangeRequest, ConfirmPhoneChangeRequestBuilder> {
  @BuiltValueField(wireName: r'newPhoneNumber')
  String get newPhoneNumber;

  @BuiltValueField(wireName: r'oldCode')
  String get oldCode;

  @BuiltValueField(wireName: r'newCode')
  String get newCode;

  ConfirmPhoneChangeRequest._();

  factory ConfirmPhoneChangeRequest([void updates(ConfirmPhoneChangeRequestBuilder b)]) = _$ConfirmPhoneChangeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConfirmPhoneChangeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConfirmPhoneChangeRequest> get serializer => _$ConfirmPhoneChangeRequestSerializer();
}

class _$ConfirmPhoneChangeRequestSerializer implements PrimitiveSerializer<ConfirmPhoneChangeRequest> {
  @override
  final Iterable<Type> types = const [ConfirmPhoneChangeRequest, _$ConfirmPhoneChangeRequest];

  @override
  final String wireName = r'ConfirmPhoneChangeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConfirmPhoneChangeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'newPhoneNumber';
    yield serializers.serialize(
      object.newPhoneNumber,
      specifiedType: const FullType(String),
    );
    yield r'oldCode';
    yield serializers.serialize(
      object.oldCode,
      specifiedType: const FullType(String),
    );
    yield r'newCode';
    yield serializers.serialize(
      object.newCode,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ConfirmPhoneChangeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ConfirmPhoneChangeRequestBuilder result,
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
        case r'oldCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.oldCode = valueDes;
          break;
        case r'newCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ConfirmPhoneChangeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConfirmPhoneChangeRequestBuilder();
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

