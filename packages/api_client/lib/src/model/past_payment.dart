//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'past_payment.g.dart';

/// PastPayment
///
/// Properties:
/// * [declarationId] 
/// * [kind] 
/// * [label] 
/// * [periodStart] 
/// * [periodEnd] 
/// * [invoiceId] 
/// * [amount] 
/// * [paidOn] 
/// * [status] 
/// * [receiptId] 
/// * [receiptReady] 
@BuiltValue()
abstract class PastPayment implements Built<PastPayment, PastPaymentBuilder> {
  @BuiltValueField(wireName: r'declarationId')
  String? get declarationId;

  @BuiltValueField(wireName: r'kind')
  PastPaymentKindEnum? get kind;
  // enum kindEnum {  RENT,  DEPOSIT,  INVOICE,  };

  @BuiltValueField(wireName: r'label')
  String? get label;

  @BuiltValueField(wireName: r'periodStart')
  Date? get periodStart;

  @BuiltValueField(wireName: r'periodEnd')
  Date? get periodEnd;

  @BuiltValueField(wireName: r'invoiceId')
  String? get invoiceId;

  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'paidOn')
  Date? get paidOn;

  @BuiltValueField(wireName: r'status')
  PastPaymentStatusEnum? get status;
  // enum statusEnum {  DECLARED,  UNCONFIRMED,  CONFIRMED,  CONTESTED,  };

  @BuiltValueField(wireName: r'receiptId')
  String? get receiptId;

  @BuiltValueField(wireName: r'receiptReady')
  bool? get receiptReady;

  PastPayment._();

  factory PastPayment([void updates(PastPaymentBuilder b)]) = _$PastPayment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PastPaymentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PastPayment> get serializer => _$PastPaymentSerializer();
}

class _$PastPaymentSerializer implements PrimitiveSerializer<PastPayment> {
  @override
  final Iterable<Type> types = const [PastPayment, _$PastPayment];

  @override
  final String wireName = r'PastPayment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PastPayment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.declarationId != null) {
      yield r'declarationId';
      yield serializers.serialize(
        object.declarationId,
        specifiedType: const FullType(String),
      );
    }
    if (object.kind != null) {
      yield r'kind';
      yield serializers.serialize(
        object.kind,
        specifiedType: const FullType(PastPaymentKindEnum),
      );
    }
    if (object.label != null) {
      yield r'label';
      yield serializers.serialize(
        object.label,
        specifiedType: const FullType(String),
      );
    }
    if (object.periodStart != null) {
      yield r'periodStart';
      yield serializers.serialize(
        object.periodStart,
        specifiedType: const FullType(Date),
      );
    }
    if (object.periodEnd != null) {
      yield r'periodEnd';
      yield serializers.serialize(
        object.periodEnd,
        specifiedType: const FullType(Date),
      );
    }
    if (object.invoiceId != null) {
      yield r'invoiceId';
      yield serializers.serialize(
        object.invoiceId,
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
    if (object.paidOn != null) {
      yield r'paidOn';
      yield serializers.serialize(
        object.paidOn,
        specifiedType: const FullType(Date),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(PastPaymentStatusEnum),
      );
    }
    if (object.receiptId != null) {
      yield r'receiptId';
      yield serializers.serialize(
        object.receiptId,
        specifiedType: const FullType(String),
      );
    }
    if (object.receiptReady != null) {
      yield r'receiptReady';
      yield serializers.serialize(
        object.receiptReady,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PastPayment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PastPaymentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'declarationId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.declarationId = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PastPaymentKindEnum),
          ) as PastPaymentKindEnum?;
          if (valueDes == null) continue;
          result.kind = valueDes;
          break;
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.label = valueDes;
          break;
        case r'periodStart':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.periodStart = valueDes;
          break;
        case r'periodEnd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.periodEnd = valueDes;
          break;
        case r'invoiceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.invoiceId = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'paidOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.paidOn = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PastPaymentStatusEnum),
          ) as PastPaymentStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'receiptId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.receiptId = valueDes;
          break;
        case r'receiptReady':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.receiptReady = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PastPayment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PastPaymentBuilder();
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

class PastPaymentKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'RENT')
  static const PastPaymentKindEnum RENT = _$pastPaymentKindEnum_RENT;
  @BuiltValueEnumConst(wireName: r'DEPOSIT')
  static const PastPaymentKindEnum DEPOSIT = _$pastPaymentKindEnum_DEPOSIT;
  @BuiltValueEnumConst(wireName: r'INVOICE')
  static const PastPaymentKindEnum INVOICE = _$pastPaymentKindEnum_INVOICE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PastPaymentKindEnum unknownDefaultOpenApi = _$pastPaymentKindEnum_unknownDefaultOpenApi;

  static Serializer<PastPaymentKindEnum> get serializer => _$pastPaymentKindEnumSerializer;

  const PastPaymentKindEnum._(String name): super(name);

  static BuiltSet<PastPaymentKindEnum> get values => _$pastPaymentKindEnumValues;
  static PastPaymentKindEnum valueOf(String name) => _$pastPaymentKindEnumValueOf(name);
}

class PastPaymentStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DECLARED')
  static const PastPaymentStatusEnum DECLARED = _$pastPaymentStatusEnum_DECLARED;
  @BuiltValueEnumConst(wireName: r'UNCONFIRMED')
  static const PastPaymentStatusEnum UNCONFIRMED = _$pastPaymentStatusEnum_UNCONFIRMED;
  @BuiltValueEnumConst(wireName: r'CONFIRMED')
  static const PastPaymentStatusEnum CONFIRMED = _$pastPaymentStatusEnum_CONFIRMED;
  @BuiltValueEnumConst(wireName: r'CONTESTED')
  static const PastPaymentStatusEnum CONTESTED = _$pastPaymentStatusEnum_CONTESTED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PastPaymentStatusEnum unknownDefaultOpenApi = _$pastPaymentStatusEnum_unknownDefaultOpenApi;

  static Serializer<PastPaymentStatusEnum> get serializer => _$pastPaymentStatusEnumSerializer;

  const PastPaymentStatusEnum._(String name): super(name);

  static BuiltSet<PastPaymentStatusEnum> get values => _$pastPaymentStatusEnumValues;
  static PastPaymentStatusEnum valueOf(String name) => _$pastPaymentStatusEnumValueOf(name);
}

