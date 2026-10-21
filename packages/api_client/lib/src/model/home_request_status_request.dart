//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'home_request_status_request.g.dart';

/// HomeRequestStatusRequest
///
/// Properties:
/// * [status] 
/// * [note] 
@BuiltValue()
abstract class HomeRequestStatusRequest implements Built<HomeRequestStatusRequest, HomeRequestStatusRequestBuilder> {
  @BuiltValueField(wireName: r'status')
  HomeRequestStatusRequestStatusEnum get status;
  // enum statusEnum {  SENT,  SEEN,  IN_PROGRESS,  RESOLVED,  CLOSED,  };

  @BuiltValueField(wireName: r'note')
  String? get note;

  HomeRequestStatusRequest._();

  factory HomeRequestStatusRequest([void updates(HomeRequestStatusRequestBuilder b)]) = _$HomeRequestStatusRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HomeRequestStatusRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HomeRequestStatusRequest> get serializer => _$HomeRequestStatusRequestSerializer();
}

class _$HomeRequestStatusRequestSerializer implements PrimitiveSerializer<HomeRequestStatusRequest> {
  @override
  final Iterable<Type> types = const [HomeRequestStatusRequest, _$HomeRequestStatusRequest];

  @override
  final String wireName = r'HomeRequestStatusRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HomeRequestStatusRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(HomeRequestStatusRequestStatusEnum),
    );
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HomeRequestStatusRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HomeRequestStatusRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HomeRequestStatusRequestStatusEnum),
          ) as HomeRequestStatusRequestStatusEnum;
          result.status = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HomeRequestStatusRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HomeRequestStatusRequestBuilder();
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

class HomeRequestStatusRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'SENT')
  static const HomeRequestStatusRequestStatusEnum SENT = _$homeRequestStatusRequestStatusEnum_SENT;
  @BuiltValueEnumConst(wireName: r'SEEN')
  static const HomeRequestStatusRequestStatusEnum SEEN = _$homeRequestStatusRequestStatusEnum_SEEN;
  @BuiltValueEnumConst(wireName: r'IN_PROGRESS')
  static const HomeRequestStatusRequestStatusEnum IN_PROGRESS = _$homeRequestStatusRequestStatusEnum_IN_PROGRESS;
  @BuiltValueEnumConst(wireName: r'RESOLVED')
  static const HomeRequestStatusRequestStatusEnum RESOLVED = _$homeRequestStatusRequestStatusEnum_RESOLVED;
  @BuiltValueEnumConst(wireName: r'CLOSED')
  static const HomeRequestStatusRequestStatusEnum CLOSED = _$homeRequestStatusRequestStatusEnum_CLOSED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const HomeRequestStatusRequestStatusEnum unknownDefaultOpenApi = _$homeRequestStatusRequestStatusEnum_unknownDefaultOpenApi;

  static Serializer<HomeRequestStatusRequestStatusEnum> get serializer => _$homeRequestStatusRequestStatusEnumSerializer;

  const HomeRequestStatusRequestStatusEnum._(String name): super(name);

  static BuiltSet<HomeRequestStatusRequestStatusEnum> get values => _$homeRequestStatusRequestStatusEnumValues;
  static HomeRequestStatusRequestStatusEnum valueOf(String name) => _$homeRequestStatusRequestStatusEnumValueOf(name);
}

