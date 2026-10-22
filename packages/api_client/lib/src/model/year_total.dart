//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'year_total.g.dart';

/// YearTotal
///
/// Properties:
/// * [year] 
/// * [total] 
@BuiltValue()
abstract class YearTotal implements Built<YearTotal, YearTotalBuilder> {
  @BuiltValueField(wireName: r'year')
  int? get year;

  @BuiltValueField(wireName: r'total')
  int? get total;

  YearTotal._();

  factory YearTotal([void updates(YearTotalBuilder b)]) = _$YearTotal;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(YearTotalBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<YearTotal> get serializer => _$YearTotalSerializer();
}

class _$YearTotalSerializer implements PrimitiveSerializer<YearTotal> {
  @override
  final Iterable<Type> types = const [YearTotal, _$YearTotal];

  @override
  final String wireName = r'YearTotal';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    YearTotal object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.year != null) {
      yield r'year';
      yield serializers.serialize(
        object.year,
        specifiedType: const FullType(int),
      );
    }
    if (object.total != null) {
      yield r'total';
      yield serializers.serialize(
        object.total,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    YearTotal object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required YearTotalBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'year':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.year = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.total = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  YearTotal deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = YearTotalBuilder();
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

