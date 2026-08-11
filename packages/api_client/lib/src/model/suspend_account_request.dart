//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'suspend_account_request.g.dart';

/// SuspendAccountRequest
///
/// Properties:
/// * [reason] 
@BuiltValue()
abstract class SuspendAccountRequest implements Built<SuspendAccountRequest, SuspendAccountRequestBuilder> {
  @BuiltValueField(wireName: r'reason')
  String get reason;

  SuspendAccountRequest._();

  factory SuspendAccountRequest([void updates(SuspendAccountRequestBuilder b)]) = _$SuspendAccountRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SuspendAccountRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SuspendAccountRequest> get serializer => _$SuspendAccountRequestSerializer();
}

class _$SuspendAccountRequestSerializer implements PrimitiveSerializer<SuspendAccountRequest> {
  @override
  final Iterable<Type> types = const [SuspendAccountRequest, _$SuspendAccountRequest];

  @override
  final String wireName = r'SuspendAccountRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SuspendAccountRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SuspendAccountRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SuspendAccountRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SuspendAccountRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SuspendAccountRequestBuilder();
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

