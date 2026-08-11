//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'subscription_response.g.dart';

/// SubscriptionResponse
///
/// Properties:
/// * [tier] 
/// * [periodEnd] 
/// * [activeListingLimit] 
/// * [currentPaymentId] 
/// * [currentPaymentHasReceipt] 
@BuiltValue()
abstract class SubscriptionResponse implements Built<SubscriptionResponse, SubscriptionResponseBuilder> {
  @BuiltValueField(wireName: r'tier')
  SubscriptionResponseTierEnum? get tier;
  // enum tierEnum {  FREE,  BASIC_PLUS,  PRO,  PRO_PLUS,  };

  @BuiltValueField(wireName: r'periodEnd')
  DateTime? get periodEnd;

  @BuiltValueField(wireName: r'activeListingLimit')
  int? get activeListingLimit;

  @BuiltValueField(wireName: r'currentPaymentId')
  String? get currentPaymentId;

  @BuiltValueField(wireName: r'currentPaymentHasReceipt')
  bool? get currentPaymentHasReceipt;

  SubscriptionResponse._();

  factory SubscriptionResponse([void updates(SubscriptionResponseBuilder b)]) = _$SubscriptionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubscriptionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubscriptionResponse> get serializer => _$SubscriptionResponseSerializer();
}

class _$SubscriptionResponseSerializer implements PrimitiveSerializer<SubscriptionResponse> {
  @override
  final Iterable<Type> types = const [SubscriptionResponse, _$SubscriptionResponse];

  @override
  final String wireName = r'SubscriptionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubscriptionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.tier != null) {
      yield r'tier';
      yield serializers.serialize(
        object.tier,
        specifiedType: const FullType(SubscriptionResponseTierEnum),
      );
    }
    if (object.periodEnd != null) {
      yield r'periodEnd';
      yield serializers.serialize(
        object.periodEnd,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.activeListingLimit != null) {
      yield r'activeListingLimit';
      yield serializers.serialize(
        object.activeListingLimit,
        specifiedType: const FullType(int),
      );
    }
    if (object.currentPaymentId != null) {
      yield r'currentPaymentId';
      yield serializers.serialize(
        object.currentPaymentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.currentPaymentHasReceipt != null) {
      yield r'currentPaymentHasReceipt';
      yield serializers.serialize(
        object.currentPaymentHasReceipt,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SubscriptionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SubscriptionResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'tier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SubscriptionResponseTierEnum),
          ) as SubscriptionResponseTierEnum?;
          if (valueDes == null) continue;
          result.tier = valueDes;
          break;
        case r'periodEnd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.periodEnd = valueDes;
          break;
        case r'activeListingLimit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.activeListingLimit = valueDes;
          break;
        case r'currentPaymentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.currentPaymentId = valueDes;
          break;
        case r'currentPaymentHasReceipt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.currentPaymentHasReceipt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SubscriptionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubscriptionResponseBuilder();
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

class SubscriptionResponseTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FREE')
  static const SubscriptionResponseTierEnum FREE = _$subscriptionResponseTierEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC_PLUS')
  static const SubscriptionResponseTierEnum BASIC_PLUS = _$subscriptionResponseTierEnum_BASIC_PLUS;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const SubscriptionResponseTierEnum PRO = _$subscriptionResponseTierEnum_PRO;
  @BuiltValueEnumConst(wireName: r'PRO_PLUS')
  static const SubscriptionResponseTierEnum PRO_PLUS = _$subscriptionResponseTierEnum_PRO_PLUS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SubscriptionResponseTierEnum unknownDefaultOpenApi = _$subscriptionResponseTierEnum_unknownDefaultOpenApi;

  static Serializer<SubscriptionResponseTierEnum> get serializer => _$subscriptionResponseTierEnumSerializer;

  const SubscriptionResponseTierEnum._(String name): super(name);

  static BuiltSet<SubscriptionResponseTierEnum> get values => _$subscriptionResponseTierEnumValues;
  static SubscriptionResponseTierEnum valueOf(String name) => _$subscriptionResponseTierEnumValueOf(name);
}

