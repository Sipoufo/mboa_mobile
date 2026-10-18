//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pay_invoice_request.g.dart';

/// PayInvoiceRequest
///
/// Properties:
/// * [method] 
@BuiltValue()
abstract class PayInvoiceRequest implements Built<PayInvoiceRequest, PayInvoiceRequestBuilder> {
  @BuiltValueField(wireName: r'method')
  PayInvoiceRequestMethodEnum get method;
  // enum methodEnum {  MTN_MOMO,  ORANGE_MONEY,  };

  PayInvoiceRequest._();

  factory PayInvoiceRequest([void updates(PayInvoiceRequestBuilder b)]) = _$PayInvoiceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PayInvoiceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PayInvoiceRequest> get serializer => _$PayInvoiceRequestSerializer();
}

class _$PayInvoiceRequestSerializer implements PrimitiveSerializer<PayInvoiceRequest> {
  @override
  final Iterable<Type> types = const [PayInvoiceRequest, _$PayInvoiceRequest];

  @override
  final String wireName = r'PayInvoiceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PayInvoiceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'method';
    yield serializers.serialize(
      object.method,
      specifiedType: const FullType(PayInvoiceRequestMethodEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PayInvoiceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PayInvoiceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PayInvoiceRequestMethodEnum),
          ) as PayInvoiceRequestMethodEnum;
          result.method = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PayInvoiceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PayInvoiceRequestBuilder();
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

class PayInvoiceRequestMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MTN_MOMO')
  static const PayInvoiceRequestMethodEnum MTN_MOMO = _$payInvoiceRequestMethodEnum_MTN_MOMO;
  @BuiltValueEnumConst(wireName: r'ORANGE_MONEY')
  static const PayInvoiceRequestMethodEnum ORANGE_MONEY = _$payInvoiceRequestMethodEnum_ORANGE_MONEY;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PayInvoiceRequestMethodEnum unknownDefaultOpenApi = _$payInvoiceRequestMethodEnum_unknownDefaultOpenApi;

  static Serializer<PayInvoiceRequestMethodEnum> get serializer => _$payInvoiceRequestMethodEnumSerializer;

  const PayInvoiceRequestMethodEnum._(String name): super(name);

  static BuiltSet<PayInvoiceRequestMethodEnum> get values => _$payInvoiceRequestMethodEnumValues;
  static PayInvoiceRequestMethodEnum valueOf(String name) => _$payInvoiceRequestMethodEnumValueOf(name);
}

