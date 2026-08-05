//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_webhook_request.g.dart';

/// PaymentWebhookRequest
///
/// Properties:
/// * [providerRef] 
/// * [status] 
/// * [signature] 
@BuiltValue()
abstract class PaymentWebhookRequest implements Built<PaymentWebhookRequest, PaymentWebhookRequestBuilder> {
  @BuiltValueField(wireName: r'providerRef')
  String get providerRef;

  @BuiltValueField(wireName: r'status')
  PaymentWebhookRequestStatusEnum get status;
  // enum statusEnum {  PENDING,  CONFIRMED,  FAILED,  CANCELLED,  };

  @BuiltValueField(wireName: r'signature')
  String get signature;

  PaymentWebhookRequest._();

  factory PaymentWebhookRequest([void updates(PaymentWebhookRequestBuilder b)]) = _$PaymentWebhookRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentWebhookRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentWebhookRequest> get serializer => _$PaymentWebhookRequestSerializer();
}

class _$PaymentWebhookRequestSerializer implements PrimitiveSerializer<PaymentWebhookRequest> {
  @override
  final Iterable<Type> types = const [PaymentWebhookRequest, _$PaymentWebhookRequest];

  @override
  final String wireName = r'PaymentWebhookRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentWebhookRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'providerRef';
    yield serializers.serialize(
      object.providerRef,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(PaymentWebhookRequestStatusEnum),
    );
    yield r'signature';
    yield serializers.serialize(
      object.signature,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PaymentWebhookRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PaymentWebhookRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'providerRef':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.providerRef = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PaymentWebhookRequestStatusEnum),
          ) as PaymentWebhookRequestStatusEnum;
          result.status = valueDes;
          break;
        case r'signature':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.signature = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PaymentWebhookRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentWebhookRequestBuilder();
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

class PaymentWebhookRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const PaymentWebhookRequestStatusEnum PENDING = _$paymentWebhookRequestStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'CONFIRMED')
  static const PaymentWebhookRequestStatusEnum CONFIRMED = _$paymentWebhookRequestStatusEnum_CONFIRMED;
  @BuiltValueEnumConst(wireName: r'FAILED')
  static const PaymentWebhookRequestStatusEnum FAILED = _$paymentWebhookRequestStatusEnum_FAILED;
  @BuiltValueEnumConst(wireName: r'CANCELLED')
  static const PaymentWebhookRequestStatusEnum CANCELLED = _$paymentWebhookRequestStatusEnum_CANCELLED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PaymentWebhookRequestStatusEnum unknownDefaultOpenApi = _$paymentWebhookRequestStatusEnum_unknownDefaultOpenApi;

  static Serializer<PaymentWebhookRequestStatusEnum> get serializer => _$paymentWebhookRequestStatusEnumSerializer;

  const PaymentWebhookRequestStatusEnum._(String name): super(name);

  static BuiltSet<PaymentWebhookRequestStatusEnum> get values => _$paymentWebhookRequestStatusEnumValues;
  static PaymentWebhookRequestStatusEnum valueOf(String name) => _$paymentWebhookRequestStatusEnumValueOf(name);
}

