//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'block_day_request.g.dart';

/// BlockDayRequest
///
/// Properties:
/// * [day] 
@BuiltValue()
abstract class BlockDayRequest implements Built<BlockDayRequest, BlockDayRequestBuilder> {
  @BuiltValueField(wireName: r'day')
  Date get day;

  BlockDayRequest._();

  factory BlockDayRequest([void updates(BlockDayRequestBuilder b)]) = _$BlockDayRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BlockDayRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BlockDayRequest> get serializer => _$BlockDayRequestSerializer();
}

class _$BlockDayRequestSerializer implements PrimitiveSerializer<BlockDayRequest> {
  @override
  final Iterable<Type> types = const [BlockDayRequest, _$BlockDayRequest];

  @override
  final String wireName = r'BlockDayRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BlockDayRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'day';
    yield serializers.serialize(
      object.day,
      specifiedType: const FullType(Date),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BlockDayRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BlockDayRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'day':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.day = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BlockDayRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BlockDayRequestBuilder();
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

