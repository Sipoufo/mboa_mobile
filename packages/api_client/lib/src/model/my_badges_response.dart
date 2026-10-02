//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/photo_verification_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'my_badges_response.g.dart';

/// MyBadgesResponse
///
/// Properties:
/// * [badges] 
/// * [verifications] 
@BuiltValue()
abstract class MyBadgesResponse implements Built<MyBadgesResponse, MyBadgesResponseBuilder> {
  @BuiltValueField(wireName: r'badges')
  BuiltList<MyBadgesResponseBadgesEnum>? get badges;
  // enum badgesEnum {  TRUSTED,  RECERTIFIED,  IDENTITY_VERIFIED,  PHOTOS_VERIFIED,  };

  @BuiltValueField(wireName: r'verifications')
  BuiltList<PhotoVerificationResponse>? get verifications;

  MyBadgesResponse._();

  factory MyBadgesResponse([void updates(MyBadgesResponseBuilder b)]) = _$MyBadgesResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MyBadgesResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MyBadgesResponse> get serializer => _$MyBadgesResponseSerializer();
}

class _$MyBadgesResponseSerializer implements PrimitiveSerializer<MyBadgesResponse> {
  @override
  final Iterable<Type> types = const [MyBadgesResponse, _$MyBadgesResponse];

  @override
  final String wireName = r'MyBadgesResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MyBadgesResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.badges != null) {
      yield r'badges';
      yield serializers.serialize(
        object.badges,
        specifiedType: const FullType(BuiltList, [FullType(MyBadgesResponseBadgesEnum)]),
      );
    }
    if (object.verifications != null) {
      yield r'verifications';
      yield serializers.serialize(
        object.verifications,
        specifiedType: const FullType(BuiltList, [FullType(PhotoVerificationResponse)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MyBadgesResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MyBadgesResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'badges':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(MyBadgesResponseBadgesEnum)]),
          ) as BuiltList<MyBadgesResponseBadgesEnum>?;
          if (valueDes == null) continue;
          result.badges.replace(valueDes);
          break;
        case r'verifications':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(PhotoVerificationResponse)]),
          ) as BuiltList<PhotoVerificationResponse>?;
          if (valueDes == null) continue;
          result.verifications.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MyBadgesResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MyBadgesResponseBuilder();
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

class MyBadgesResponseBadgesEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'TRUSTED')
  static const MyBadgesResponseBadgesEnum TRUSTED = _$myBadgesResponseBadgesEnum_TRUSTED;
  @BuiltValueEnumConst(wireName: r'RECERTIFIED')
  static const MyBadgesResponseBadgesEnum RECERTIFIED = _$myBadgesResponseBadgesEnum_RECERTIFIED;
  @BuiltValueEnumConst(wireName: r'IDENTITY_VERIFIED')
  static const MyBadgesResponseBadgesEnum IDENTITY_VERIFIED = _$myBadgesResponseBadgesEnum_IDENTITY_VERIFIED;
  @BuiltValueEnumConst(wireName: r'PHOTOS_VERIFIED')
  static const MyBadgesResponseBadgesEnum PHOTOS_VERIFIED = _$myBadgesResponseBadgesEnum_PHOTOS_VERIFIED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MyBadgesResponseBadgesEnum unknownDefaultOpenApi = _$myBadgesResponseBadgesEnum_unknownDefaultOpenApi;

  static Serializer<MyBadgesResponseBadgesEnum> get serializer => _$myBadgesResponseBadgesEnumSerializer;

  const MyBadgesResponseBadgesEnum._(String name): super(name);

  static BuiltSet<MyBadgesResponseBadgesEnum> get values => _$myBadgesResponseBadgesEnumValues;
  static MyBadgesResponseBadgesEnum valueOf(String name) => _$myBadgesResponseBadgesEnumValueOf(name);
}

