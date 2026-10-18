//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'invoice_response.g.dart';

/// InvoiceResponse
///
/// Properties:
/// * [id] 
/// * [contractId] 
/// * [annonceId] 
/// * [annonceTitle] 
/// * [kind] 
/// * [label] 
/// * [amount] 
/// * [dueDate] 
/// * [settlement] 
/// * [status] 
/// * [pastDue] 
/// * [payableInApp] 
/// * [paidAt] 
/// * [paidVia] 
/// * [paymentId] 
/// * [cancelledAt] 
/// * [createdAt] 
@BuiltValue()
abstract class InvoiceResponse implements Built<InvoiceResponse, InvoiceResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'contractId')
  String? get contractId;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'annonceTitle')
  String? get annonceTitle;

  @BuiltValueField(wireName: r'kind')
  InvoiceResponseKindEnum? get kind;
  // enum kindEnum {  WATER,  ELECTRICITY,  OTHER,  };

  @BuiltValueField(wireName: r'label')
  String? get label;

  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'dueDate')
  Date? get dueDate;

  @BuiltValueField(wireName: r'settlement')
  InvoiceResponseSettlementEnum? get settlement;
  // enum settlementEnum {  IN_APP,  MANUAL,  };

  @BuiltValueField(wireName: r'status')
  InvoiceResponseStatusEnum? get status;
  // enum statusEnum {  TO_PAY,  OVERDUE,  PAID,  CANCELLED,  };

  @BuiltValueField(wireName: r'pastDue')
  bool? get pastDue;

  @BuiltValueField(wireName: r'payableInApp')
  bool? get payableInApp;

  @BuiltValueField(wireName: r'paidAt')
  DateTime? get paidAt;

  @BuiltValueField(wireName: r'paidVia')
  InvoiceResponsePaidViaEnum? get paidVia;
  // enum paidViaEnum {  IN_APP,  MANUAL,  };

  @BuiltValueField(wireName: r'paymentId')
  String? get paymentId;

  @BuiltValueField(wireName: r'cancelledAt')
  DateTime? get cancelledAt;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  InvoiceResponse._();

  factory InvoiceResponse([void updates(InvoiceResponseBuilder b)]) = _$InvoiceResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InvoiceResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InvoiceResponse> get serializer => _$InvoiceResponseSerializer();
}

class _$InvoiceResponseSerializer implements PrimitiveSerializer<InvoiceResponse> {
  @override
  final Iterable<Type> types = const [InvoiceResponse, _$InvoiceResponse];

  @override
  final String wireName = r'InvoiceResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InvoiceResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.contractId != null) {
      yield r'contractId';
      yield serializers.serialize(
        object.contractId,
        specifiedType: const FullType(String),
      );
    }
    if (object.annonceId != null) {
      yield r'annonceId';
      yield serializers.serialize(
        object.annonceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.annonceTitle != null) {
      yield r'annonceTitle';
      yield serializers.serialize(
        object.annonceTitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.kind != null) {
      yield r'kind';
      yield serializers.serialize(
        object.kind,
        specifiedType: const FullType(InvoiceResponseKindEnum),
      );
    }
    if (object.label != null) {
      yield r'label';
      yield serializers.serialize(
        object.label,
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
    if (object.dueDate != null) {
      yield r'dueDate';
      yield serializers.serialize(
        object.dueDate,
        specifiedType: const FullType(Date),
      );
    }
    if (object.settlement != null) {
      yield r'settlement';
      yield serializers.serialize(
        object.settlement,
        specifiedType: const FullType(InvoiceResponseSettlementEnum),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(InvoiceResponseStatusEnum),
      );
    }
    if (object.pastDue != null) {
      yield r'pastDue';
      yield serializers.serialize(
        object.pastDue,
        specifiedType: const FullType(bool),
      );
    }
    if (object.payableInApp != null) {
      yield r'payableInApp';
      yield serializers.serialize(
        object.payableInApp,
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
    if (object.paidVia != null) {
      yield r'paidVia';
      yield serializers.serialize(
        object.paidVia,
        specifiedType: const FullType(InvoiceResponsePaidViaEnum),
      );
    }
    if (object.paymentId != null) {
      yield r'paymentId';
      yield serializers.serialize(
        object.paymentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.cancelledAt != null) {
      yield r'cancelledAt';
      yield serializers.serialize(
        object.cancelledAt,
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
    InvoiceResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InvoiceResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.id = valueDes;
          break;
        case r'contractId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contractId = valueDes;
          break;
        case r'annonceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.annonceId = valueDes;
          break;
        case r'annonceTitle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.annonceTitle = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(InvoiceResponseKindEnum),
          ) as InvoiceResponseKindEnum?;
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
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'dueDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.dueDate = valueDes;
          break;
        case r'settlement':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(InvoiceResponseSettlementEnum),
          ) as InvoiceResponseSettlementEnum?;
          if (valueDes == null) continue;
          result.settlement = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(InvoiceResponseStatusEnum),
          ) as InvoiceResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'pastDue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.pastDue = valueDes;
          break;
        case r'payableInApp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.payableInApp = valueDes;
          break;
        case r'paidAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.paidAt = valueDes;
          break;
        case r'paidVia':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(InvoiceResponsePaidViaEnum),
          ) as InvoiceResponsePaidViaEnum?;
          if (valueDes == null) continue;
          result.paidVia = valueDes;
          break;
        case r'paymentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.paymentId = valueDes;
          break;
        case r'cancelledAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.cancelledAt = valueDes;
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
  InvoiceResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InvoiceResponseBuilder();
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

class InvoiceResponseKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'WATER')
  static const InvoiceResponseKindEnum WATER = _$invoiceResponseKindEnum_WATER;
  @BuiltValueEnumConst(wireName: r'ELECTRICITY')
  static const InvoiceResponseKindEnum ELECTRICITY = _$invoiceResponseKindEnum_ELECTRICITY;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const InvoiceResponseKindEnum OTHER = _$invoiceResponseKindEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const InvoiceResponseKindEnum unknownDefaultOpenApi = _$invoiceResponseKindEnum_unknownDefaultOpenApi;

  static Serializer<InvoiceResponseKindEnum> get serializer => _$invoiceResponseKindEnumSerializer;

  const InvoiceResponseKindEnum._(String name): super(name);

  static BuiltSet<InvoiceResponseKindEnum> get values => _$invoiceResponseKindEnumValues;
  static InvoiceResponseKindEnum valueOf(String name) => _$invoiceResponseKindEnumValueOf(name);
}

class InvoiceResponseSettlementEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'IN_APP')
  static const InvoiceResponseSettlementEnum IN_APP = _$invoiceResponseSettlementEnum_IN_APP;
  @BuiltValueEnumConst(wireName: r'MANUAL')
  static const InvoiceResponseSettlementEnum MANUAL = _$invoiceResponseSettlementEnum_MANUAL;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const InvoiceResponseSettlementEnum unknownDefaultOpenApi = _$invoiceResponseSettlementEnum_unknownDefaultOpenApi;

  static Serializer<InvoiceResponseSettlementEnum> get serializer => _$invoiceResponseSettlementEnumSerializer;

  const InvoiceResponseSettlementEnum._(String name): super(name);

  static BuiltSet<InvoiceResponseSettlementEnum> get values => _$invoiceResponseSettlementEnumValues;
  static InvoiceResponseSettlementEnum valueOf(String name) => _$invoiceResponseSettlementEnumValueOf(name);
}

class InvoiceResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'TO_PAY')
  static const InvoiceResponseStatusEnum TO_PAY = _$invoiceResponseStatusEnum_TO_PAY;
  @BuiltValueEnumConst(wireName: r'OVERDUE')
  static const InvoiceResponseStatusEnum OVERDUE = _$invoiceResponseStatusEnum_OVERDUE;
  @BuiltValueEnumConst(wireName: r'PAID')
  static const InvoiceResponseStatusEnum PAID = _$invoiceResponseStatusEnum_PAID;
  @BuiltValueEnumConst(wireName: r'CANCELLED')
  static const InvoiceResponseStatusEnum CANCELLED = _$invoiceResponseStatusEnum_CANCELLED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const InvoiceResponseStatusEnum unknownDefaultOpenApi = _$invoiceResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<InvoiceResponseStatusEnum> get serializer => _$invoiceResponseStatusEnumSerializer;

  const InvoiceResponseStatusEnum._(String name): super(name);

  static BuiltSet<InvoiceResponseStatusEnum> get values => _$invoiceResponseStatusEnumValues;
  static InvoiceResponseStatusEnum valueOf(String name) => _$invoiceResponseStatusEnumValueOf(name);
}

class InvoiceResponsePaidViaEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'IN_APP')
  static const InvoiceResponsePaidViaEnum IN_APP = _$invoiceResponsePaidViaEnum_IN_APP;
  @BuiltValueEnumConst(wireName: r'MANUAL')
  static const InvoiceResponsePaidViaEnum MANUAL = _$invoiceResponsePaidViaEnum_MANUAL;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const InvoiceResponsePaidViaEnum unknownDefaultOpenApi = _$invoiceResponsePaidViaEnum_unknownDefaultOpenApi;

  static Serializer<InvoiceResponsePaidViaEnum> get serializer => _$invoiceResponsePaidViaEnumSerializer;

  const InvoiceResponsePaidViaEnum._(String name): super(name);

  static BuiltSet<InvoiceResponsePaidViaEnum> get values => _$invoiceResponsePaidViaEnumValues;
  static InvoiceResponsePaidViaEnum valueOf(String name) => _$invoiceResponsePaidViaEnumValueOf(name);
}

