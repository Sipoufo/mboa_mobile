//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_initiated_response.g.dart';

/// PaymentInitiatedResponse
///
/// Properties:
/// * [paymentId] 
/// * [providerRef] 
/// * [amount] 
/// * [status] 
@BuiltValue()
abstract class PaymentInitiatedResponse implements Built<PaymentInitiatedResponse, PaymentInitiatedResponseBuilder> {
  @BuiltValueField(wireName: r'paymentId')
  String? get paymentId;

  @BuiltValueField(wireName: r'providerRef')
  String? get providerRef;

  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'status')
  PaymentInitiatedResponseStatusEnum? get status;
  // enum statusEnum {  PENDING,  CONFIRMED,  FAILED,  CANCELLED,  };

  PaymentInitiatedResponse._();

  factory PaymentInitiatedResponse([void updates(PaymentInitiatedResponseBuilder b)]) = _$PaymentInitiatedResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentInitiatedResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentInitiatedResponse> get serializer => _$PaymentInitiatedResponseSerializer();
}

class _$PaymentInitiatedResponseSerializer implements PrimitiveSerializer<PaymentInitiatedResponse> {
  @override
  final Iterable<Type> types = const [PaymentInitiatedResponse, _$PaymentInitiatedResponse];

  @override
  final String wireName = r'PaymentInitiatedResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentInitiatedResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.paymentId != null) {
      yield r'paymentId';
      yield serializers.serialize(
        object.paymentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.providerRef != null) {
      yield r'providerRef';
      yield serializers.serialize(
        object.providerRef,
        specifiedType: const FullType(String),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(int),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(PaymentInitiatedResponseStatusEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PaymentInitiatedResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PaymentInitiatedResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'paymentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.paymentId = valueDes;
          break;
        case r'providerRef':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.providerRef = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PaymentInitiatedResponseStatusEnum),
          ) as PaymentInitiatedResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PaymentInitiatedResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentInitiatedResponseBuilder();
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

class PaymentInitiatedResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const PaymentInitiatedResponseStatusEnum PENDING = _$paymentInitiatedResponseStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'CONFIRMED')
  static const PaymentInitiatedResponseStatusEnum CONFIRMED = _$paymentInitiatedResponseStatusEnum_CONFIRMED;
  @BuiltValueEnumConst(wireName: r'FAILED')
  static const PaymentInitiatedResponseStatusEnum FAILED = _$paymentInitiatedResponseStatusEnum_FAILED;
  @BuiltValueEnumConst(wireName: r'CANCELLED')
  static const PaymentInitiatedResponseStatusEnum CANCELLED = _$paymentInitiatedResponseStatusEnum_CANCELLED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PaymentInitiatedResponseStatusEnum unknownDefaultOpenApi = _$paymentInitiatedResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<PaymentInitiatedResponseStatusEnum> get serializer => _$paymentInitiatedResponseStatusEnumSerializer;

  const PaymentInitiatedResponseStatusEnum._(String name): super(name);

  static BuiltSet<PaymentInitiatedResponseStatusEnum> get values => _$paymentInitiatedResponseStatusEnumValues;
  static PaymentInitiatedResponseStatusEnum valueOf(String name) => _$paymentInitiatedResponseStatusEnumValueOf(name);
}

