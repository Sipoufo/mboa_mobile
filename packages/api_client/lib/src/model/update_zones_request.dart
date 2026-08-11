//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_zones_request.g.dart';

/// UpdateZonesRequest
///
/// Properties:
/// * [cityIds] 
/// * [districtIds] 
@BuiltValue()
abstract class UpdateZonesRequest implements Built<UpdateZonesRequest, UpdateZonesRequestBuilder> {
  @BuiltValueField(wireName: r'cityIds')
  BuiltList<String> get cityIds;

  @BuiltValueField(wireName: r'districtIds')
  BuiltList<String> get districtIds;

  UpdateZonesRequest._();

  factory UpdateZonesRequest([void updates(UpdateZonesRequestBuilder b)]) = _$UpdateZonesRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateZonesRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateZonesRequest> get serializer => _$UpdateZonesRequestSerializer();
}

class _$UpdateZonesRequestSerializer implements PrimitiveSerializer<UpdateZonesRequest> {
  @override
  final Iterable<Type> types = const [UpdateZonesRequest, _$UpdateZonesRequest];

  @override
  final String wireName = r'UpdateZonesRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateZonesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'cityIds';
    yield serializers.serialize(
      object.cityIds,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'districtIds';
    yield serializers.serialize(
      object.districtIds,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateZonesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateZonesRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'cityIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.cityIds.replace(valueDes);
          break;
        case r'districtIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.districtIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateZonesRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateZonesRequestBuilder();
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

