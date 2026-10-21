//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'declare_invoice_payment_request.g.dart';

/// DeclareInvoicePaymentRequest
///
/// Properties:
/// * [amount] 
/// * [paidOn] 
/// * [method] 
/// * [reference] 
/// * [note] 
/// * [proofKeys] 
@BuiltValue()
abstract class DeclareInvoicePaymentRequest implements Built<DeclareInvoicePaymentRequest, DeclareInvoicePaymentRequestBuilder> {
  @BuiltValueField(wireName: r'amount')
  int get amount;

  @BuiltValueField(wireName: r'paidOn')
  Date get paidOn;

  @BuiltValueField(wireName: r'method')
  DeclareInvoicePaymentRequestMethodEnum get method;
  // enum methodEnum {  MOBILE_MONEY,  ORANGE_MONEY,  CASH,  TRANSFER,  OTHER,  };

  @BuiltValueField(wireName: r'reference')
  String? get reference;

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'proofKeys')
  BuiltList<String>? get proofKeys;

  DeclareInvoicePaymentRequest._();

  factory DeclareInvoicePaymentRequest([void updates(DeclareInvoicePaymentRequestBuilder b)]) = _$DeclareInvoicePaymentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeclareInvoicePaymentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeclareInvoicePaymentRequest> get serializer => _$DeclareInvoicePaymentRequestSerializer();
}

class _$DeclareInvoicePaymentRequestSerializer implements PrimitiveSerializer<DeclareInvoicePaymentRequest> {
  @override
  final Iterable<Type> types = const [DeclareInvoicePaymentRequest, _$DeclareInvoicePaymentRequest];

  @override
  final String wireName = r'DeclareInvoicePaymentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeclareInvoicePaymentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(int),
    );
    yield r'paidOn';
    yield serializers.serialize(
      object.paidOn,
      specifiedType: const FullType(Date),
    );
    yield r'method';
    yield serializers.serialize(
      object.method,
      specifiedType: const FullType(DeclareInvoicePaymentRequestMethodEnum),
    );
    if (object.reference != null) {
      yield r'reference';
      yield serializers.serialize(
        object.reference,
        specifiedType: const FullType(String),
      );
    }
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType(String),
      );
    }
    if (object.proofKeys != null) {
      yield r'proofKeys';
      yield serializers.serialize(
        object.proofKeys,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DeclareInvoicePaymentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeclareInvoicePaymentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.amount = valueDes;
          break;
        case r'paidOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.paidOn = valueDes;
          break;
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DeclareInvoicePaymentRequestMethodEnum),
          ) as DeclareInvoicePaymentRequestMethodEnum;
          result.method = valueDes;
          break;
        case r'reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reference = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        case r'proofKeys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.proofKeys.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeclareInvoicePaymentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeclareInvoicePaymentRequestBuilder();
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

class DeclareInvoicePaymentRequestMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MOBILE_MONEY')
  static const DeclareInvoicePaymentRequestMethodEnum MOBILE_MONEY = _$declareInvoicePaymentRequestMethodEnum_MOBILE_MONEY;
  @BuiltValueEnumConst(wireName: r'ORANGE_MONEY')
  static const DeclareInvoicePaymentRequestMethodEnum ORANGE_MONEY = _$declareInvoicePaymentRequestMethodEnum_ORANGE_MONEY;
  @BuiltValueEnumConst(wireName: r'CASH')
  static const DeclareInvoicePaymentRequestMethodEnum CASH = _$declareInvoicePaymentRequestMethodEnum_CASH;
  @BuiltValueEnumConst(wireName: r'TRANSFER')
  static const DeclareInvoicePaymentRequestMethodEnum TRANSFER = _$declareInvoicePaymentRequestMethodEnum_TRANSFER;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const DeclareInvoicePaymentRequestMethodEnum OTHER = _$declareInvoicePaymentRequestMethodEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DeclareInvoicePaymentRequestMethodEnum unknownDefaultOpenApi = _$declareInvoicePaymentRequestMethodEnum_unknownDefaultOpenApi;

  static Serializer<DeclareInvoicePaymentRequestMethodEnum> get serializer => _$declareInvoicePaymentRequestMethodEnumSerializer;

  const DeclareInvoicePaymentRequestMethodEnum._(String name): super(name);

  static BuiltSet<DeclareInvoicePaymentRequestMethodEnum> get values => _$declareInvoicePaymentRequestMethodEnumValues;
  static DeclareInvoicePaymentRequestMethodEnum valueOf(String name) => _$declareInvoicePaymentRequestMethodEnumValueOf(name);
}

