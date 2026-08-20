//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'property_rating.g.dart';

/// PropertyRating
///
/// Properties:
/// * [average] 
/// * [reviewCount] 
/// * [visitCount] 
/// * [residentCount] 
@BuiltValue()
abstract class PropertyRating implements Built<PropertyRating, PropertyRatingBuilder> {
  @BuiltValueField(wireName: r'average')
  double? get average;

  @BuiltValueField(wireName: r'reviewCount')
  int? get reviewCount;

  @BuiltValueField(wireName: r'visitCount')
  int? get visitCount;

  @BuiltValueField(wireName: r'residentCount')
  int? get residentCount;

  PropertyRating._();

  factory PropertyRating([void updates(PropertyRatingBuilder b)]) = _$PropertyRating;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PropertyRatingBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PropertyRating> get serializer => _$PropertyRatingSerializer();
}

class _$PropertyRatingSerializer implements PrimitiveSerializer<PropertyRating> {
  @override
  final Iterable<Type> types = const [PropertyRating, _$PropertyRating];

  @override
  final String wireName = r'PropertyRating';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PropertyRating object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.average != null) {
      yield r'average';
      yield serializers.serialize(
        object.average,
        specifiedType: const FullType(double),
      );
    }
    if (object.reviewCount != null) {
      yield r'reviewCount';
      yield serializers.serialize(
        object.reviewCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.visitCount != null) {
      yield r'visitCount';
      yield serializers.serialize(
        object.visitCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.residentCount != null) {
      yield r'residentCount';
      yield serializers.serialize(
        object.residentCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PropertyRating object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PropertyRatingBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'average':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.average = valueDes;
          break;
        case r'reviewCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.reviewCount = valueDes;
          break;
        case r'visitCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.visitCount = valueDes;
          break;
        case r'residentCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.residentCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PropertyRating deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PropertyRatingBuilder();
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

