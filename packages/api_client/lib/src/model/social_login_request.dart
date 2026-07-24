//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'social_login_request.g.dart';

/// SocialLoginRequest
///
/// Properties:
/// * [provider] 
/// * [idToken] 
@BuiltValue()
abstract class SocialLoginRequest implements Built<SocialLoginRequest, SocialLoginRequestBuilder> {
  @BuiltValueField(wireName: r'provider')
  SocialLoginRequestProviderEnum get provider;
  // enum providerEnum {  PHONE,  GOOGLE,  APPLE,  };

  @BuiltValueField(wireName: r'idToken')
  String get idToken;

  SocialLoginRequest._();

  factory SocialLoginRequest([void updates(SocialLoginRequestBuilder b)]) = _$SocialLoginRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SocialLoginRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SocialLoginRequest> get serializer => _$SocialLoginRequestSerializer();
}

class _$SocialLoginRequestSerializer implements PrimitiveSerializer<SocialLoginRequest> {
  @override
  final Iterable<Type> types = const [SocialLoginRequest, _$SocialLoginRequest];

  @override
  final String wireName = r'SocialLoginRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SocialLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'provider';
    yield serializers.serialize(
      object.provider,
      specifiedType: const FullType(SocialLoginRequestProviderEnum),
    );
    yield r'idToken';
    yield serializers.serialize(
      object.idToken,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SocialLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SocialLoginRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'provider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SocialLoginRequestProviderEnum),
          ) as SocialLoginRequestProviderEnum;
          result.provider = valueDes;
          break;
        case r'idToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idToken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SocialLoginRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SocialLoginRequestBuilder();
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

class SocialLoginRequestProviderEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PHONE')
  static const SocialLoginRequestProviderEnum PHONE = _$socialLoginRequestProviderEnum_PHONE;
  @BuiltValueEnumConst(wireName: r'GOOGLE')
  static const SocialLoginRequestProviderEnum GOOGLE = _$socialLoginRequestProviderEnum_GOOGLE;
  @BuiltValueEnumConst(wireName: r'APPLE')
  static const SocialLoginRequestProviderEnum APPLE = _$socialLoginRequestProviderEnum_APPLE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SocialLoginRequestProviderEnum unknownDefaultOpenApi = _$socialLoginRequestProviderEnum_unknownDefaultOpenApi;

  static Serializer<SocialLoginRequestProviderEnum> get serializer => _$socialLoginRequestProviderEnumSerializer;

  const SocialLoginRequestProviderEnum._(String name): super(name);

  static BuiltSet<SocialLoginRequestProviderEnum> get values => _$socialLoginRequestProviderEnumValues;
  static SocialLoginRequestProviderEnum valueOf(String name) => _$socialLoginRequestProviderEnumValueOf(name);
}

