//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_invoice_request.g.dart';

/// CreateInvoiceRequest
///
/// Properties:
/// * [contractId] 
/// * [kind] 
/// * [label] 
/// * [amount] 
/// * [dueDate] 
/// * [settlement] 
@BuiltValue()
abstract class CreateInvoiceRequest implements Built<CreateInvoiceRequest, CreateInvoiceRequestBuilder> {
  @BuiltValueField(wireName: r'contractId')
  String get contractId;

  @BuiltValueField(wireName: r'kind')
  CreateInvoiceRequestKindEnum get kind;
  // enum kindEnum {  WATER,  ELECTRICITY,  OTHER,  };

  @BuiltValueField(wireName: r'label')
  String? get label;

  @BuiltValueField(wireName: r'amount')
  int get amount;

  @BuiltValueField(wireName: r'dueDate')
  Date get dueDate;

  @BuiltValueField(wireName: r'settlement')
  CreateInvoiceRequestSettlementEnum? get settlement;
  // enum settlementEnum {  IN_APP,  MANUAL,  };

  CreateInvoiceRequest._();

  factory CreateInvoiceRequest([void updates(CreateInvoiceRequestBuilder b)]) = _$CreateInvoiceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateInvoiceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateInvoiceRequest> get serializer => _$CreateInvoiceRequestSerializer();
}

class _$CreateInvoiceRequestSerializer implements PrimitiveSerializer<CreateInvoiceRequest> {
  @override
  final Iterable<Type> types = const [CreateInvoiceRequest, _$CreateInvoiceRequest];

  @override
  final String wireName = r'CreateInvoiceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateInvoiceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'contractId';
    yield serializers.serialize(
      object.contractId,
      specifiedType: const FullType(String),
    );
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(CreateInvoiceRequestKindEnum),
    );
    if (object.label != null) {
      yield r'label';
      yield serializers.serialize(
        object.label,
        specifiedType: const FullType(String),
      );
    }
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(int),
    );
    yield r'dueDate';
    yield serializers.serialize(
      object.dueDate,
      specifiedType: const FullType(Date),
    );
    if (object.settlement != null) {
      yield r'settlement';
      yield serializers.serialize(
        object.settlement,
        specifiedType: const FullType(CreateInvoiceRequestSettlementEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateInvoiceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateInvoiceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'contractId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.contractId = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateInvoiceRequestKindEnum),
          ) as CreateInvoiceRequestKindEnum;
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
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.amount = valueDes;
          break;
        case r'dueDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.dueDate = valueDes;
          break;
        case r'settlement':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(CreateInvoiceRequestSettlementEnum),
          ) as CreateInvoiceRequestSettlementEnum?;
          if (valueDes == null) continue;
          result.settlement = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateInvoiceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateInvoiceRequestBuilder();
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

class CreateInvoiceRequestKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'WATER')
  static const CreateInvoiceRequestKindEnum WATER = _$createInvoiceRequestKindEnum_WATER;
  @BuiltValueEnumConst(wireName: r'ELECTRICITY')
  static const CreateInvoiceRequestKindEnum ELECTRICITY = _$createInvoiceRequestKindEnum_ELECTRICITY;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const CreateInvoiceRequestKindEnum OTHER = _$createInvoiceRequestKindEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateInvoiceRequestKindEnum unknownDefaultOpenApi = _$createInvoiceRequestKindEnum_unknownDefaultOpenApi;

  static Serializer<CreateInvoiceRequestKindEnum> get serializer => _$createInvoiceRequestKindEnumSerializer;

  const CreateInvoiceRequestKindEnum._(String name): super(name);

  static BuiltSet<CreateInvoiceRequestKindEnum> get values => _$createInvoiceRequestKindEnumValues;
  static CreateInvoiceRequestKindEnum valueOf(String name) => _$createInvoiceRequestKindEnumValueOf(name);
}

class CreateInvoiceRequestSettlementEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'IN_APP')
  static const CreateInvoiceRequestSettlementEnum IN_APP = _$createInvoiceRequestSettlementEnum_IN_APP;
  @BuiltValueEnumConst(wireName: r'MANUAL')
  static const CreateInvoiceRequestSettlementEnum MANUAL = _$createInvoiceRequestSettlementEnum_MANUAL;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateInvoiceRequestSettlementEnum unknownDefaultOpenApi = _$createInvoiceRequestSettlementEnum_unknownDefaultOpenApi;

  static Serializer<CreateInvoiceRequestSettlementEnum> get serializer => _$createInvoiceRequestSettlementEnumSerializer;

  const CreateInvoiceRequestSettlementEnum._(String name): super(name);

  static BuiltSet<CreateInvoiceRequestSettlementEnum> get values => _$createInvoiceRequestSettlementEnumValues;
  static CreateInvoiceRequestSettlementEnum valueOf(String name) => _$createInvoiceRequestSettlementEnumValueOf(name);
}

