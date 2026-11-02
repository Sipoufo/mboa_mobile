//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'confirm_email_change_request.g.dart';

/// ConfirmEmailChangeRequest
///
/// Properties:
/// * [newEmail] 
/// * [oldCode] 
/// * [newCode] 
@BuiltValue()
abstract class ConfirmEmailChangeRequest implements Built<ConfirmEmailChangeRequest, ConfirmEmailChangeRequestBuilder> {
  @BuiltValueField(wireName: r'newEmail')
  String get newEmail;

  @BuiltValueField(wireName: r'oldCode')
  String? get oldCode;

  @BuiltValueField(wireName: r'newCode')
  String get newCode;

  ConfirmEmailChangeRequest._();

  factory ConfirmEmailChangeRequest([void updates(ConfirmEmailChangeRequestBuilder b)]) = _$ConfirmEmailChangeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConfirmEmailChangeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConfirmEmailChangeRequest> get serializer => _$ConfirmEmailChangeRequestSerializer();
}

class _$ConfirmEmailChangeRequestSerializer implements PrimitiveSerializer<ConfirmEmailChangeRequest> {
  @override
  final Iterable<Type> types = const [ConfirmEmailChangeRequest, _$ConfirmEmailChangeRequest];

  @override
  final String wireName = r'ConfirmEmailChangeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConfirmEmailChangeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'newEmail';
    yield serializers.serialize(
      object.newEmail,
      specifiedType: const FullType(String),
    );
    if (object.oldCode != null) {
      yield r'oldCode';
      yield serializers.serialize(
        object.oldCode,
        specifiedType: const FullType(String),
      );
    }
    yield r'newCode';
    yield serializers.serialize(
      object.newCode,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ConfirmEmailChangeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ConfirmEmailChangeRequestBuilder result,
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
        case r'oldCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
  ConfirmEmailChangeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConfirmEmailChangeRequestBuilder();
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

