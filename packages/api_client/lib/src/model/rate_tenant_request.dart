//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'rate_tenant_request.g.dart';

/// RateTenantRequest
///
/// Properties:
/// * [stars] 
/// * [comment] 
@BuiltValue()
abstract class RateTenantRequest implements Built<RateTenantRequest, RateTenantRequestBuilder> {
  @BuiltValueField(wireName: r'stars')
  int get stars;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  RateTenantRequest._();

  factory RateTenantRequest([void updates(RateTenantRequestBuilder b)]) = _$RateTenantRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RateTenantRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RateTenantRequest> get serializer => _$RateTenantRequestSerializer();
}

class _$RateTenantRequestSerializer implements PrimitiveSerializer<RateTenantRequest> {
  @override
  final Iterable<Type> types = const [RateTenantRequest, _$RateTenantRequest];

  @override
  final String wireName = r'RateTenantRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RateTenantRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'stars';
    yield serializers.serialize(
      object.stars,
      specifiedType: const FullType(int),
    );
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RateTenantRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RateTenantRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'stars':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.stars = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RateTenantRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RateTenantRequestBuilder();
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

