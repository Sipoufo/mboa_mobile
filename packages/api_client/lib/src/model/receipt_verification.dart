//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'receipt_verification.g.dart';

/// ReceiptVerification
///
/// Properties:
/// * [receiptId] 
/// * [kind] 
/// * [periodStart] 
/// * [periodEnd] 
/// * [amount] 
/// * [issuedAt] 
/// * [city] 
/// * [district] 
@BuiltValue()
abstract class ReceiptVerification implements Built<ReceiptVerification, ReceiptVerificationBuilder> {
  @BuiltValueField(wireName: r'receiptId')
  String? get receiptId;

  @BuiltValueField(wireName: r'kind')
  ReceiptVerificationKindEnum? get kind;
  // enum kindEnum {  RENT,  RENT_PARTIAL,  DEPOSIT,  INVOICE,  };

  @BuiltValueField(wireName: r'periodStart')
  Date? get periodStart;

  @BuiltValueField(wireName: r'periodEnd')
  Date? get periodEnd;

  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'issuedAt')
  DateTime? get issuedAt;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'district')
  String? get district;

  ReceiptVerification._();

  factory ReceiptVerification([void updates(ReceiptVerificationBuilder b)]) = _$ReceiptVerification;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReceiptVerificationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReceiptVerification> get serializer => _$ReceiptVerificationSerializer();
}

class _$ReceiptVerificationSerializer implements PrimitiveSerializer<ReceiptVerification> {
  @override
  final Iterable<Type> types = const [ReceiptVerification, _$ReceiptVerification];

  @override
  final String wireName = r'ReceiptVerification';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReceiptVerification object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.receiptId != null) {
      yield r'receiptId';
      yield serializers.serialize(
        object.receiptId,
        specifiedType: const FullType(String),
      );
    }
    if (object.kind != null) {
      yield r'kind';
      yield serializers.serialize(
        object.kind,
        specifiedType: const FullType(ReceiptVerificationKindEnum),
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
    if (object.city != null) {
      yield r'city';
      yield serializers.serialize(
        object.city,
        specifiedType: const FullType(String),
      );
    }
    if (object.district != null) {
      yield r'district';
      yield serializers.serialize(
        object.district,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReceiptVerification object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReceiptVerificationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'receiptId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.receiptId = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ReceiptVerificationKindEnum),
          ) as ReceiptVerificationKindEnum?;
          if (valueDes == null) continue;
          result.kind = valueDes;
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
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.city = valueDes;
          break;
        case r'district':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.district = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReceiptVerification deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReceiptVerificationBuilder();
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

class ReceiptVerificationKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'RENT')
  static const ReceiptVerificationKindEnum RENT = _$receiptVerificationKindEnum_RENT;
  @BuiltValueEnumConst(wireName: r'RENT_PARTIAL')
  static const ReceiptVerificationKindEnum RENT_PARTIAL = _$receiptVerificationKindEnum_RENT_PARTIAL;
  @BuiltValueEnumConst(wireName: r'DEPOSIT')
  static const ReceiptVerificationKindEnum DEPOSIT = _$receiptVerificationKindEnum_DEPOSIT;
  @BuiltValueEnumConst(wireName: r'INVOICE')
  static const ReceiptVerificationKindEnum INVOICE = _$receiptVerificationKindEnum_INVOICE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ReceiptVerificationKindEnum unknownDefaultOpenApi = _$receiptVerificationKindEnum_unknownDefaultOpenApi;

  static Serializer<ReceiptVerificationKindEnum> get serializer => _$receiptVerificationKindEnumSerializer;

  const ReceiptVerificationKindEnum._(String name): super(name);

  static BuiltSet<ReceiptVerificationKindEnum> get values => _$receiptVerificationKindEnumValues;
  static ReceiptVerificationKindEnum valueOf(String name) => _$receiptVerificationKindEnumValueOf(name);
}

