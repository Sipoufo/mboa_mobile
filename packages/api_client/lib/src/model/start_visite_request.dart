//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'start_visite_request.g.dart';

/// StartVisiteRequest
///
/// Properties:
/// * [latitude] 
/// * [longitude] 
/// * [overrideReason] 
@BuiltValue()
abstract class StartVisiteRequest implements Built<StartVisiteRequest, StartVisiteRequestBuilder> {
  @BuiltValueField(wireName: r'latitude')
  double get latitude;

  @BuiltValueField(wireName: r'longitude')
  double get longitude;

  @BuiltValueField(wireName: r'overrideReason')
  String? get overrideReason;

  StartVisiteRequest._();

  factory StartVisiteRequest([void updates(StartVisiteRequestBuilder b)]) = _$StartVisiteRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StartVisiteRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StartVisiteRequest> get serializer => _$StartVisiteRequestSerializer();
}

class _$StartVisiteRequestSerializer implements PrimitiveSerializer<StartVisiteRequest> {
  @override
  final Iterable<Type> types = const [StartVisiteRequest, _$StartVisiteRequest];

  @override
  final String wireName = r'StartVisiteRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StartVisiteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'latitude';
    yield serializers.serialize(
      object.latitude,
      specifiedType: const FullType(double),
    );
    yield r'longitude';
    yield serializers.serialize(
      object.longitude,
      specifiedType: const FullType(double),
    );
    if (object.overrideReason != null) {
      yield r'overrideReason';
      yield serializers.serialize(
        object.overrideReason,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    StartVisiteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StartVisiteRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'latitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.latitude = valueDes;
          break;
        case r'longitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.longitude = valueDes;
          break;
        case r'overrideReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.overrideReason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StartVisiteRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StartVisiteRequestBuilder();
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

