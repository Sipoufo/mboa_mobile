//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reject_type_change_request.g.dart';

/// RejectTypeChangeRequest
///
/// Properties:
/// * [reason] 
@BuiltValue()
abstract class RejectTypeChangeRequest implements Built<RejectTypeChangeRequest, RejectTypeChangeRequestBuilder> {
  @BuiltValueField(wireName: r'reason')
  String get reason;

  RejectTypeChangeRequest._();

  factory RejectTypeChangeRequest([void updates(RejectTypeChangeRequestBuilder b)]) = _$RejectTypeChangeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RejectTypeChangeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RejectTypeChangeRequest> get serializer => _$RejectTypeChangeRequestSerializer();
}

class _$RejectTypeChangeRequestSerializer implements PrimitiveSerializer<RejectTypeChangeRequest> {
  @override
  final Iterable<Type> types = const [RejectTypeChangeRequest, _$RejectTypeChangeRequest];

  @override
  final String wireName = r'RejectTypeChangeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RejectTypeChangeRequest object, {
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
    RejectTypeChangeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RejectTypeChangeRequestBuilder result,
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
  RejectTypeChangeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RejectTypeChangeRequestBuilder();
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

