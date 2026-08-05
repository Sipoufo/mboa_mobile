//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_summary.g.dart';

/// PaymentSummary
///
/// Properties:
/// * [paymentId] 
/// * [tier] 
/// * [amount] 
/// * [method] 
/// * [status] 
/// * [hasReceipt] 
/// * [paidAt] 
/// * [createdAt] 
@BuiltValue()
abstract class PaymentSummary implements Built<PaymentSummary, PaymentSummaryBuilder> {
  @BuiltValueField(wireName: r'paymentId')
  String? get paymentId;

  @BuiltValueField(wireName: r'tier')
  PaymentSummaryTierEnum? get tier;
  // enum tierEnum {  FREE,  BASIC_PLUS,  PRO,  PRO_PLUS,  };

  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'method')
  PaymentSummaryMethodEnum? get method;
  // enum methodEnum {  MTN_MOMO,  ORANGE_MONEY,  };

  @BuiltValueField(wireName: r'status')
  PaymentSummaryStatusEnum? get status;
  // enum statusEnum {  PENDING,  CONFIRMED,  FAILED,  CANCELLED,  };

  @BuiltValueField(wireName: r'hasReceipt')
  bool? get hasReceipt;

  @BuiltValueField(wireName: r'paidAt')
  DateTime? get paidAt;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  PaymentSummary._();

  factory PaymentSummary([void updates(PaymentSummaryBuilder b)]) = _$PaymentSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentSummary> get serializer => _$PaymentSummarySerializer();
}

class _$PaymentSummarySerializer implements PrimitiveSerializer<PaymentSummary> {
  @override
  final Iterable<Type> types = const [PaymentSummary, _$PaymentSummary];

  @override
  final String wireName = r'PaymentSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.paymentId != null) {
      yield r'paymentId';
      yield serializers.serialize(
        object.paymentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.tier != null) {
      yield r'tier';
      yield serializers.serialize(
        object.tier,
        specifiedType: const FullType(PaymentSummaryTierEnum),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(int),
      );
    }
    if (object.method != null) {
      yield r'method';
      yield serializers.serialize(
        object.method,
        specifiedType: const FullType(PaymentSummaryMethodEnum),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(PaymentSummaryStatusEnum),
      );
    }
    if (object.hasReceipt != null) {
      yield r'hasReceipt';
      yield serializers.serialize(
        object.hasReceipt,
        specifiedType: const FullType(bool),
      );
    }
    if (object.paidAt != null) {
      yield r'paidAt';
      yield serializers.serialize(
        object.paidAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PaymentSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PaymentSummaryBuilder result,
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
        case r'tier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PaymentSummaryTierEnum),
          ) as PaymentSummaryTierEnum?;
          if (valueDes == null) continue;
          result.tier = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PaymentSummaryMethodEnum),
          ) as PaymentSummaryMethodEnum?;
          if (valueDes == null) continue;
          result.method = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PaymentSummaryStatusEnum),
          ) as PaymentSummaryStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'hasReceipt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.hasReceipt = valueDes;
          break;
        case r'paidAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.paidAt = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PaymentSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentSummaryBuilder();
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

class PaymentSummaryTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FREE')
  static const PaymentSummaryTierEnum FREE = _$paymentSummaryTierEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC_PLUS')
  static const PaymentSummaryTierEnum BASIC_PLUS = _$paymentSummaryTierEnum_BASIC_PLUS;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const PaymentSummaryTierEnum PRO = _$paymentSummaryTierEnum_PRO;
  @BuiltValueEnumConst(wireName: r'PRO_PLUS')
  static const PaymentSummaryTierEnum PRO_PLUS = _$paymentSummaryTierEnum_PRO_PLUS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PaymentSummaryTierEnum unknownDefaultOpenApi = _$paymentSummaryTierEnum_unknownDefaultOpenApi;

  static Serializer<PaymentSummaryTierEnum> get serializer => _$paymentSummaryTierEnumSerializer;

  const PaymentSummaryTierEnum._(String name): super(name);

  static BuiltSet<PaymentSummaryTierEnum> get values => _$paymentSummaryTierEnumValues;
  static PaymentSummaryTierEnum valueOf(String name) => _$paymentSummaryTierEnumValueOf(name);
}

class PaymentSummaryMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MTN_MOMO')
  static const PaymentSummaryMethodEnum MTN_MOMO = _$paymentSummaryMethodEnum_MTN_MOMO;
  @BuiltValueEnumConst(wireName: r'ORANGE_MONEY')
  static const PaymentSummaryMethodEnum ORANGE_MONEY = _$paymentSummaryMethodEnum_ORANGE_MONEY;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PaymentSummaryMethodEnum unknownDefaultOpenApi = _$paymentSummaryMethodEnum_unknownDefaultOpenApi;

  static Serializer<PaymentSummaryMethodEnum> get serializer => _$paymentSummaryMethodEnumSerializer;

  const PaymentSummaryMethodEnum._(String name): super(name);

  static BuiltSet<PaymentSummaryMethodEnum> get values => _$paymentSummaryMethodEnumValues;
  static PaymentSummaryMethodEnum valueOf(String name) => _$paymentSummaryMethodEnumValueOf(name);
}

class PaymentSummaryStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const PaymentSummaryStatusEnum PENDING = _$paymentSummaryStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'CONFIRMED')
  static const PaymentSummaryStatusEnum CONFIRMED = _$paymentSummaryStatusEnum_CONFIRMED;
  @BuiltValueEnumConst(wireName: r'FAILED')
  static const PaymentSummaryStatusEnum FAILED = _$paymentSummaryStatusEnum_FAILED;
  @BuiltValueEnumConst(wireName: r'CANCELLED')
  static const PaymentSummaryStatusEnum CANCELLED = _$paymentSummaryStatusEnum_CANCELLED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PaymentSummaryStatusEnum unknownDefaultOpenApi = _$paymentSummaryStatusEnum_unknownDefaultOpenApi;

  static Serializer<PaymentSummaryStatusEnum> get serializer => _$paymentSummaryStatusEnumSerializer;

  const PaymentSummaryStatusEnum._(String name): super(name);

  static BuiltSet<PaymentSummaryStatusEnum> get values => _$paymentSummaryStatusEnumValues;
  static PaymentSummaryStatusEnum valueOf(String name) => _$paymentSummaryStatusEnumValueOf(name);
}

