//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/cohort.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'conversion.g.dart';

/// Conversion
///
/// Properties:
/// * [last90Days] 
/// * [allTime] 
@BuiltValue()
abstract class Conversion implements Built<Conversion, ConversionBuilder> {
  @BuiltValueField(wireName: r'last90Days')
  Cohort? get last90Days;

  @BuiltValueField(wireName: r'allTime')
  Cohort? get allTime;

  Conversion._();

  factory Conversion([void updates(ConversionBuilder b)]) = _$Conversion;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConversionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Conversion> get serializer => _$ConversionSerializer();
}

class _$ConversionSerializer implements PrimitiveSerializer<Conversion> {
  @override
  final Iterable<Type> types = const [Conversion, _$Conversion];

  @override
  final String wireName = r'Conversion';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Conversion object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.last90Days != null) {
      yield r'last90Days';
      yield serializers.serialize(
        object.last90Days,
        specifiedType: const FullType(Cohort),
      );
    }
    if (object.allTime != null) {
      yield r'allTime';
      yield serializers.serialize(
        object.allTime,
        specifiedType: const FullType(Cohort),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Conversion object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ConversionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'last90Days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Cohort),
          ) as Cohort?;
          if (valueDes == null) continue;
          result.last90Days.replace(valueDes);
          break;
        case r'allTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Cohort),
          ) as Cohort?;
          if (valueDes == null) continue;
          result.allTime.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Conversion deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConversionBuilder();
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

