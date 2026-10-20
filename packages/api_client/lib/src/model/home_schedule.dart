//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/due.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'home_schedule.g.dart';

/// HomeSchedule
///
/// Properties:
/// * [dues] 
/// * [moreBefore] 
/// * [moreAfter] 
@BuiltValue()
abstract class HomeSchedule implements Built<HomeSchedule, HomeScheduleBuilder> {
  @BuiltValueField(wireName: r'dues')
  BuiltList<Due>? get dues;

  @BuiltValueField(wireName: r'moreBefore')
  bool? get moreBefore;

  @BuiltValueField(wireName: r'moreAfter')
  bool? get moreAfter;

  HomeSchedule._();

  factory HomeSchedule([void updates(HomeScheduleBuilder b)]) = _$HomeSchedule;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HomeScheduleBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HomeSchedule> get serializer => _$HomeScheduleSerializer();
}

class _$HomeScheduleSerializer implements PrimitiveSerializer<HomeSchedule> {
  @override
  final Iterable<Type> types = const [HomeSchedule, _$HomeSchedule];

  @override
  final String wireName = r'HomeSchedule';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HomeSchedule object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.dues != null) {
      yield r'dues';
      yield serializers.serialize(
        object.dues,
        specifiedType: const FullType(BuiltList, [FullType(Due)]),
      );
    }
    if (object.moreBefore != null) {
      yield r'moreBefore';
      yield serializers.serialize(
        object.moreBefore,
        specifiedType: const FullType(bool),
      );
    }
    if (object.moreAfter != null) {
      yield r'moreAfter';
      yield serializers.serialize(
        object.moreAfter,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HomeSchedule object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HomeScheduleBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'dues':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(Due)]),
          ) as BuiltList<Due>?;
          if (valueDes == null) continue;
          result.dues.replace(valueDes);
          break;
        case r'moreBefore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.moreBefore = valueDes;
          break;
        case r'moreAfter':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.moreAfter = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HomeSchedule deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HomeScheduleBuilder();
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

