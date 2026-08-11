//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'zone_response.g.dart';

/// ZoneResponse
///
/// Properties:
/// * [cityId] 
/// * [districtId] 
@BuiltValue()
abstract class ZoneResponse implements Built<ZoneResponse, ZoneResponseBuilder> {
  @BuiltValueField(wireName: r'cityId')
  String? get cityId;

  @BuiltValueField(wireName: r'districtId')
  String? get districtId;

  ZoneResponse._();

  factory ZoneResponse([void updates(ZoneResponseBuilder b)]) = _$ZoneResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ZoneResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ZoneResponse> get serializer => _$ZoneResponseSerializer();
}

class _$ZoneResponseSerializer implements PrimitiveSerializer<ZoneResponse> {
  @override
  final Iterable<Type> types = const [ZoneResponse, _$ZoneResponse];

  @override
  final String wireName = r'ZoneResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ZoneResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.cityId != null) {
      yield r'cityId';
      yield serializers.serialize(
        object.cityId,
        specifiedType: const FullType(String),
      );
    }
    if (object.districtId != null) {
      yield r'districtId';
      yield serializers.serialize(
        object.districtId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ZoneResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ZoneResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'cityId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.cityId = valueDes;
          break;
        case r'districtId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.districtId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ZoneResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ZoneResponseBuilder();
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

