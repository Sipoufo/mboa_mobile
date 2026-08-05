//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'grant_subscription_request.g.dart';

/// GrantSubscriptionRequest
///
/// Properties:
/// * [accountId] 
/// * [tier] 
/// * [days] 
@BuiltValue()
abstract class GrantSubscriptionRequest implements Built<GrantSubscriptionRequest, GrantSubscriptionRequestBuilder> {
  @BuiltValueField(wireName: r'accountId')
  String get accountId;

  @BuiltValueField(wireName: r'tier')
  GrantSubscriptionRequestTierEnum get tier;
  // enum tierEnum {  FREE,  BASIC_PLUS,  PRO,  PRO_PLUS,  };

  @BuiltValueField(wireName: r'days')
  int get days;

  GrantSubscriptionRequest._();

  factory GrantSubscriptionRequest([void updates(GrantSubscriptionRequestBuilder b)]) = _$GrantSubscriptionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GrantSubscriptionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GrantSubscriptionRequest> get serializer => _$GrantSubscriptionRequestSerializer();
}

class _$GrantSubscriptionRequestSerializer implements PrimitiveSerializer<GrantSubscriptionRequest> {
  @override
  final Iterable<Type> types = const [GrantSubscriptionRequest, _$GrantSubscriptionRequest];

  @override
  final String wireName = r'GrantSubscriptionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GrantSubscriptionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'accountId';
    yield serializers.serialize(
      object.accountId,
      specifiedType: const FullType(String),
    );
    yield r'tier';
    yield serializers.serialize(
      object.tier,
      specifiedType: const FullType(GrantSubscriptionRequestTierEnum),
    );
    yield r'days';
    yield serializers.serialize(
      object.days,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GrantSubscriptionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GrantSubscriptionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'accountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountId = valueDes;
          break;
        case r'tier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GrantSubscriptionRequestTierEnum),
          ) as GrantSubscriptionRequestTierEnum;
          result.tier = valueDes;
          break;
        case r'days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.days = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GrantSubscriptionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GrantSubscriptionRequestBuilder();
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

class GrantSubscriptionRequestTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FREE')
  static const GrantSubscriptionRequestTierEnum FREE = _$grantSubscriptionRequestTierEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC_PLUS')
  static const GrantSubscriptionRequestTierEnum BASIC_PLUS = _$grantSubscriptionRequestTierEnum_BASIC_PLUS;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const GrantSubscriptionRequestTierEnum PRO = _$grantSubscriptionRequestTierEnum_PRO;
  @BuiltValueEnumConst(wireName: r'PRO_PLUS')
  static const GrantSubscriptionRequestTierEnum PRO_PLUS = _$grantSubscriptionRequestTierEnum_PRO_PLUS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const GrantSubscriptionRequestTierEnum unknownDefaultOpenApi = _$grantSubscriptionRequestTierEnum_unknownDefaultOpenApi;

  static Serializer<GrantSubscriptionRequestTierEnum> get serializer => _$grantSubscriptionRequestTierEnumSerializer;

  const GrantSubscriptionRequestTierEnum._(String name): super(name);

  static BuiltSet<GrantSubscriptionRequestTierEnum> get values => _$grantSubscriptionRequestTierEnumValues;
  static GrantSubscriptionRequestTierEnum valueOf(String name) => _$grantSubscriptionRequestTierEnumValueOf(name);
}

