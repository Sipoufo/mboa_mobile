//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'home_request_event_response.g.dart';

/// HomeRequestEventResponse
///
/// Properties:
/// * [status] 
/// * [byLandlord] 
/// * [note] 
/// * [at] 
@BuiltValue()
abstract class HomeRequestEventResponse implements Built<HomeRequestEventResponse, HomeRequestEventResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  HomeRequestEventResponseStatusEnum? get status;
  // enum statusEnum {  SENT,  SEEN,  IN_PROGRESS,  RESOLVED,  CLOSED,  };

  @BuiltValueField(wireName: r'byLandlord')
  bool? get byLandlord;

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'at')
  DateTime? get at;

  HomeRequestEventResponse._();

  factory HomeRequestEventResponse([void updates(HomeRequestEventResponseBuilder b)]) = _$HomeRequestEventResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HomeRequestEventResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HomeRequestEventResponse> get serializer => _$HomeRequestEventResponseSerializer();
}

class _$HomeRequestEventResponseSerializer implements PrimitiveSerializer<HomeRequestEventResponse> {
  @override
  final Iterable<Type> types = const [HomeRequestEventResponse, _$HomeRequestEventResponse];

  @override
  final String wireName = r'HomeRequestEventResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HomeRequestEventResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(HomeRequestEventResponseStatusEnum),
      );
    }
    if (object.byLandlord != null) {
      yield r'byLandlord';
      yield serializers.serialize(
        object.byLandlord,
        specifiedType: const FullType(bool),
      );
    }
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType(String),
      );
    }
    if (object.at != null) {
      yield r'at';
      yield serializers.serialize(
        object.at,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HomeRequestEventResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HomeRequestEventResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HomeRequestEventResponseStatusEnum),
          ) as HomeRequestEventResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'byLandlord':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.byLandlord = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        case r'at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.at = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HomeRequestEventResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HomeRequestEventResponseBuilder();
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

class HomeRequestEventResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'SENT')
  static const HomeRequestEventResponseStatusEnum SENT = _$homeRequestEventResponseStatusEnum_SENT;
  @BuiltValueEnumConst(wireName: r'SEEN')
  static const HomeRequestEventResponseStatusEnum SEEN = _$homeRequestEventResponseStatusEnum_SEEN;
  @BuiltValueEnumConst(wireName: r'IN_PROGRESS')
  static const HomeRequestEventResponseStatusEnum IN_PROGRESS = _$homeRequestEventResponseStatusEnum_IN_PROGRESS;
  @BuiltValueEnumConst(wireName: r'RESOLVED')
  static const HomeRequestEventResponseStatusEnum RESOLVED = _$homeRequestEventResponseStatusEnum_RESOLVED;
  @BuiltValueEnumConst(wireName: r'CLOSED')
  static const HomeRequestEventResponseStatusEnum CLOSED = _$homeRequestEventResponseStatusEnum_CLOSED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const HomeRequestEventResponseStatusEnum unknownDefaultOpenApi = _$homeRequestEventResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<HomeRequestEventResponseStatusEnum> get serializer => _$homeRequestEventResponseStatusEnumSerializer;

  const HomeRequestEventResponseStatusEnum._(String name): super(name);

  static BuiltSet<HomeRequestEventResponseStatusEnum> get values => _$homeRequestEventResponseStatusEnumValues;
  static HomeRequestEventResponseStatusEnum valueOf(String name) => _$homeRequestEventResponseStatusEnumValueOf(name);
}

