//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'cohort.g.dart';

/// Cohort
///
/// Properties:
/// * [registered] 
/// * [converted] 
/// * [rate] 
@BuiltValue()
abstract class Cohort implements Built<Cohort, CohortBuilder> {
  @BuiltValueField(wireName: r'registered')
  int? get registered;

  @BuiltValueField(wireName: r'converted')
  int? get converted;

  @BuiltValueField(wireName: r'rate')
  double? get rate;

  Cohort._();

  factory Cohort([void updates(CohortBuilder b)]) = _$Cohort;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CohortBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Cohort> get serializer => _$CohortSerializer();
}

class _$CohortSerializer implements PrimitiveSerializer<Cohort> {
  @override
  final Iterable<Type> types = const [Cohort, _$Cohort];

  @override
  final String wireName = r'Cohort';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Cohort object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.registered != null) {
      yield r'registered';
      yield serializers.serialize(
        object.registered,
        specifiedType: const FullType(int),
      );
    }
    if (object.converted != null) {
      yield r'converted';
      yield serializers.serialize(
        object.converted,
        specifiedType: const FullType(int),
      );
    }
    if (object.rate != null) {
      yield r'rate';
      yield serializers.serialize(
        object.rate,
        specifiedType: const FullType(double),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Cohort object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CohortBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'registered':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.registered = valueDes;
          break;
        case r'converted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.converted = valueDes;
          break;
        case r'rate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.rate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Cohort deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CohortBuilder();
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

