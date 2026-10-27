//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tenant_rating_response.g.dart';

/// TenantRatingResponse
///
/// Properties:
/// * [contractId] 
/// * [stars] 
/// * [ratedAt] 
@BuiltValue()
abstract class TenantRatingResponse implements Built<TenantRatingResponse, TenantRatingResponseBuilder> {
  @BuiltValueField(wireName: r'contractId')
  String? get contractId;

  @BuiltValueField(wireName: r'stars')
  int? get stars;

  @BuiltValueField(wireName: r'ratedAt')
  DateTime? get ratedAt;

  TenantRatingResponse._();

  factory TenantRatingResponse([void updates(TenantRatingResponseBuilder b)]) = _$TenantRatingResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TenantRatingResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TenantRatingResponse> get serializer => _$TenantRatingResponseSerializer();
}

class _$TenantRatingResponseSerializer implements PrimitiveSerializer<TenantRatingResponse> {
  @override
  final Iterable<Type> types = const [TenantRatingResponse, _$TenantRatingResponse];

  @override
  final String wireName = r'TenantRatingResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TenantRatingResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.contractId != null) {
      yield r'contractId';
      yield serializers.serialize(
        object.contractId,
        specifiedType: const FullType(String),
      );
    }
    if (object.stars != null) {
      yield r'stars';
      yield serializers.serialize(
        object.stars,
        specifiedType: const FullType(int),
      );
    }
    if (object.ratedAt != null) {
      yield r'ratedAt';
      yield serializers.serialize(
        object.ratedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TenantRatingResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TenantRatingResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'contractId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contractId = valueDes;
          break;
        case r'stars':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.stars = valueDes;
          break;
        case r'ratedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.ratedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TenantRatingResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TenantRatingResponseBuilder();
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

