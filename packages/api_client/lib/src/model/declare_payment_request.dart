//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'declare_payment_request.g.dart';

/// DeclarePaymentRequest
///
/// Properties:
/// * [kind] 
/// * [dueIndexes] 
/// * [amount] 
/// * [paidOn] 
/// * [method] 
/// * [reference] 
/// * [note] 
/// * [proofKeys] 
@BuiltValue()
abstract class DeclarePaymentRequest implements Built<DeclarePaymentRequest, DeclarePaymentRequestBuilder> {
  @BuiltValueField(wireName: r'kind')
  DeclarePaymentRequestKindEnum get kind;
  // enum kindEnum {  RENT,  DEPOSIT,  };

  @BuiltValueField(wireName: r'dueIndexes')
  BuiltList<int>? get dueIndexes;

  @BuiltValueField(wireName: r'amount')
  int get amount;

  @BuiltValueField(wireName: r'paidOn')
  Date get paidOn;

  @BuiltValueField(wireName: r'method')
  DeclarePaymentRequestMethodEnum get method;
  // enum methodEnum {  MOBILE_MONEY,  ORANGE_MONEY,  CASH,  TRANSFER,  OTHER,  };

  @BuiltValueField(wireName: r'reference')
  String? get reference;

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'proofKeys')
  BuiltList<String>? get proofKeys;

  DeclarePaymentRequest._();

  factory DeclarePaymentRequest([void updates(DeclarePaymentRequestBuilder b)]) = _$DeclarePaymentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeclarePaymentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeclarePaymentRequest> get serializer => _$DeclarePaymentRequestSerializer();
}

class _$DeclarePaymentRequestSerializer implements PrimitiveSerializer<DeclarePaymentRequest> {
  @override
  final Iterable<Type> types = const [DeclarePaymentRequest, _$DeclarePaymentRequest];

  @override
  final String wireName = r'DeclarePaymentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeclarePaymentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(DeclarePaymentRequestKindEnum),
    );
    if (object.dueIndexes != null) {
      yield r'dueIndexes';
      yield serializers.serialize(
        object.dueIndexes,
        specifiedType: const FullType(BuiltList, [FullType(int)]),
      );
    }
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
      specifiedType: const FullType(DeclarePaymentRequestMethodEnum),
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
    DeclarePaymentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeclarePaymentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DeclarePaymentRequestKindEnum),
          ) as DeclarePaymentRequestKindEnum;
          result.kind = valueDes;
          break;
        case r'dueIndexes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(int)]),
          ) as BuiltList<int>?;
          if (valueDes == null) continue;
          result.dueIndexes.replace(valueDes);
          break;
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
            specifiedType: const FullType(DeclarePaymentRequestMethodEnum),
          ) as DeclarePaymentRequestMethodEnum;
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
  DeclarePaymentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeclarePaymentRequestBuilder();
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

class DeclarePaymentRequestKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'RENT')
  static const DeclarePaymentRequestKindEnum RENT = _$declarePaymentRequestKindEnum_RENT;
  @BuiltValueEnumConst(wireName: r'DEPOSIT')
  static const DeclarePaymentRequestKindEnum DEPOSIT = _$declarePaymentRequestKindEnum_DEPOSIT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DeclarePaymentRequestKindEnum unknownDefaultOpenApi = _$declarePaymentRequestKindEnum_unknownDefaultOpenApi;

  static Serializer<DeclarePaymentRequestKindEnum> get serializer => _$declarePaymentRequestKindEnumSerializer;

  const DeclarePaymentRequestKindEnum._(String name): super(name);

  static BuiltSet<DeclarePaymentRequestKindEnum> get values => _$declarePaymentRequestKindEnumValues;
  static DeclarePaymentRequestKindEnum valueOf(String name) => _$declarePaymentRequestKindEnumValueOf(name);
}

class DeclarePaymentRequestMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MOBILE_MONEY')
  static const DeclarePaymentRequestMethodEnum MOBILE_MONEY = _$declarePaymentRequestMethodEnum_MOBILE_MONEY;
  @BuiltValueEnumConst(wireName: r'ORANGE_MONEY')
  static const DeclarePaymentRequestMethodEnum ORANGE_MONEY = _$declarePaymentRequestMethodEnum_ORANGE_MONEY;
  @BuiltValueEnumConst(wireName: r'CASH')
  static const DeclarePaymentRequestMethodEnum CASH = _$declarePaymentRequestMethodEnum_CASH;
  @BuiltValueEnumConst(wireName: r'TRANSFER')
  static const DeclarePaymentRequestMethodEnum TRANSFER = _$declarePaymentRequestMethodEnum_TRANSFER;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const DeclarePaymentRequestMethodEnum OTHER = _$declarePaymentRequestMethodEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DeclarePaymentRequestMethodEnum unknownDefaultOpenApi = _$declarePaymentRequestMethodEnum_unknownDefaultOpenApi;

  static Serializer<DeclarePaymentRequestMethodEnum> get serializer => _$declarePaymentRequestMethodEnumSerializer;

  const DeclarePaymentRequestMethodEnum._(String name): super(name);

  static BuiltSet<DeclarePaymentRequestMethodEnum> get values => _$declarePaymentRequestMethodEnumValues;
  static DeclarePaymentRequestMethodEnum valueOf(String name) => _$declarePaymentRequestMethodEnumValueOf(name);
}

