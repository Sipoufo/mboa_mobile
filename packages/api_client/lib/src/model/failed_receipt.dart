//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'failed_receipt.g.dart';

/// FailedReceipt
///
/// Properties:
/// * [id] 
/// * [declarationId] 
/// * [contractId] 
/// * [kind] 
/// * [amount] 
/// * [issuedAt] 
/// * [pdfAttempts] 
/// * [pdfFailedAt] 
@BuiltValue()
abstract class FailedReceipt implements Built<FailedReceipt, FailedReceiptBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'declarationId')
  String? get declarationId;

  @BuiltValueField(wireName: r'contractId')
  String? get contractId;

  @BuiltValueField(wireName: r'kind')
  FailedReceiptKindEnum? get kind;
  // enum kindEnum {  RENT,  RENT_PARTIAL,  DEPOSIT,  INVOICE,  };

  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'issuedAt')
  DateTime? get issuedAt;

  @BuiltValueField(wireName: r'pdfAttempts')
  int? get pdfAttempts;

  @BuiltValueField(wireName: r'pdfFailedAt')
  DateTime? get pdfFailedAt;

  FailedReceipt._();

  factory FailedReceipt([void updates(FailedReceiptBuilder b)]) = _$FailedReceipt;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FailedReceiptBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FailedReceipt> get serializer => _$FailedReceiptSerializer();
}

class _$FailedReceiptSerializer implements PrimitiveSerializer<FailedReceipt> {
  @override
  final Iterable<Type> types = const [FailedReceipt, _$FailedReceipt];

  @override
  final String wireName = r'FailedReceipt';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FailedReceipt object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.declarationId != null) {
      yield r'declarationId';
      yield serializers.serialize(
        object.declarationId,
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
    if (object.kind != null) {
      yield r'kind';
      yield serializers.serialize(
        object.kind,
        specifiedType: const FullType(FailedReceiptKindEnum),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(int),
      );
    }
    if (object.issuedAt != null) {
      yield r'issuedAt';
      yield serializers.serialize(
        object.issuedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.pdfAttempts != null) {
      yield r'pdfAttempts';
      yield serializers.serialize(
        object.pdfAttempts,
        specifiedType: const FullType(int),
      );
    }
    if (object.pdfFailedAt != null) {
      yield r'pdfFailedAt';
      yield serializers.serialize(
        object.pdfFailedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FailedReceipt object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FailedReceiptBuilder result,
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
        case r'declarationId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.declarationId = valueDes;
          break;
        case r'contractId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contractId = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(FailedReceiptKindEnum),
          ) as FailedReceiptKindEnum?;
          if (valueDes == null) continue;
          result.kind = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'issuedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.issuedAt = valueDes;
          break;
        case r'pdfAttempts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.pdfAttempts = valueDes;
          break;
        case r'pdfFailedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.pdfFailedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FailedReceipt deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FailedReceiptBuilder();
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

class FailedReceiptKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'RENT')
  static const FailedReceiptKindEnum RENT = _$failedReceiptKindEnum_RENT;
  @BuiltValueEnumConst(wireName: r'RENT_PARTIAL')
  static const FailedReceiptKindEnum RENT_PARTIAL = _$failedReceiptKindEnum_RENT_PARTIAL;
  @BuiltValueEnumConst(wireName: r'DEPOSIT')
  static const FailedReceiptKindEnum DEPOSIT = _$failedReceiptKindEnum_DEPOSIT;
  @BuiltValueEnumConst(wireName: r'INVOICE')
  static const FailedReceiptKindEnum INVOICE = _$failedReceiptKindEnum_INVOICE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FailedReceiptKindEnum unknownDefaultOpenApi = _$failedReceiptKindEnum_unknownDefaultOpenApi;

  static Serializer<FailedReceiptKindEnum> get serializer => _$failedReceiptKindEnumSerializer;

  const FailedReceiptKindEnum._(String name): super(name);

  static BuiltSet<FailedReceiptKindEnum> get values => _$failedReceiptKindEnumValues;
  static FailedReceiptKindEnum valueOf(String name) => _$failedReceiptKindEnumValueOf(name);
}

