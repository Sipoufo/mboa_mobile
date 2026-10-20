//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/home_schedule.dart';
import 'package:api_client/src/model/home_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'home_detail.g.dart';

/// HomeDetail
///
/// Properties:
/// * [home] 
/// * [schedule] 
@BuiltValue()
abstract class HomeDetail implements Built<HomeDetail, HomeDetailBuilder> {
  @BuiltValueField(wireName: r'home')
  HomeSummary? get home;

  @BuiltValueField(wireName: r'schedule')
  HomeSchedule? get schedule;

  HomeDetail._();

  factory HomeDetail([void updates(HomeDetailBuilder b)]) = _$HomeDetail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HomeDetailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HomeDetail> get serializer => _$HomeDetailSerializer();
}

class _$HomeDetailSerializer implements PrimitiveSerializer<HomeDetail> {
  @override
  final Iterable<Type> types = const [HomeDetail, _$HomeDetail];

  @override
  final String wireName = r'HomeDetail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HomeDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.home != null) {
      yield r'home';
      yield serializers.serialize(
        object.home,
        specifiedType: const FullType(HomeSummary),
      );
    }
    if (object.schedule != null) {
      yield r'schedule';
      yield serializers.serialize(
        object.schedule,
        specifiedType: const FullType(HomeSchedule),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HomeDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HomeDetailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'home':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HomeSummary),
          ) as HomeSummary?;
          if (valueDes == null) continue;
          result.home.replace(valueDes);
          break;
        case r'schedule':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HomeSchedule),
          ) as HomeSchedule?;
          if (valueDes == null) continue;
          result.schedule.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HomeDetail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HomeDetailBuilder();
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

