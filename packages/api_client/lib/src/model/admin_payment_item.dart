//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_payment_item.g.dart';

/// AdminPaymentItem
///
/// Properties:
/// * [id] 
/// * [accountId] 
/// * [tier] 
/// * [amount] 
/// * [method] 
/// * [provider] 
/// * [status] 
/// * [createdAt] 
/// * [confirmedAt] 
/// * [refundedAt] 
/// * [refundedBy] 
/// * [refundReason] 
/// * [purpose] 
@BuiltValue()
abstract class AdminPaymentItem implements Built<AdminPaymentItem, AdminPaymentItemBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'accountId')
  String? get accountId;

  @BuiltValueField(wireName: r'tier')
  AdminPaymentItemTierEnum? get tier;
  // enum tierEnum {  FREE,  BASIC_PLUS,  PRO,  PRO_PLUS,  };

  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'method')
  AdminPaymentItemMethodEnum? get method;
  // enum methodEnum {  MTN_MOMO,  ORANGE_MONEY,  };

  @BuiltValueField(wireName: r'provider')
  String? get provider;

  @BuiltValueField(wireName: r'status')
  AdminPaymentItemStatusEnum? get status;
  // enum statusEnum {  PENDING,  CONFIRMED,  FAILED,  CANCELLED,  REFUNDED,  };

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'confirmedAt')
  DateTime? get confirmedAt;

  @BuiltValueField(wireName: r'refundedAt')
  DateTime? get refundedAt;

  @BuiltValueField(wireName: r'refundedBy')
  String? get refundedBy;

  @BuiltValueField(wireName: r'refundReason')
  String? get refundReason;

  @BuiltValueField(wireName: r'purpose')
  AdminPaymentItemPurposeEnum? get purpose;
  // enum purposeEnum {  SUBSCRIPTION,  FINANCE_ADDON,  };

  AdminPaymentItem._();

  factory AdminPaymentItem([void updates(AdminPaymentItemBuilder b)]) = _$AdminPaymentItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminPaymentItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminPaymentItem> get serializer => _$AdminPaymentItemSerializer();
}

class _$AdminPaymentItemSerializer implements PrimitiveSerializer<AdminPaymentItem> {
  @override
  final Iterable<Type> types = const [AdminPaymentItem, _$AdminPaymentItem];

  @override
  final String wireName = r'AdminPaymentItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminPaymentItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.accountId != null) {
      yield r'accountId';
      yield serializers.serialize(
        object.accountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.tier != null) {
      yield r'tier';
      yield serializers.serialize(
        object.tier,
        specifiedType: const FullType(AdminPaymentItemTierEnum),
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
        specifiedType: const FullType(AdminPaymentItemMethodEnum),
      );
    }
    if (object.provider != null) {
      yield r'provider';
      yield serializers.serialize(
        object.provider,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(AdminPaymentItemStatusEnum),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.confirmedAt != null) {
      yield r'confirmedAt';
      yield serializers.serialize(
        object.confirmedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.refundedAt != null) {
      yield r'refundedAt';
      yield serializers.serialize(
        object.refundedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.refundedBy != null) {
      yield r'refundedBy';
      yield serializers.serialize(
        object.refundedBy,
        specifiedType: const FullType(String),
      );
    }
    if (object.refundReason != null) {
      yield r'refundReason';
      yield serializers.serialize(
        object.refundReason,
        specifiedType: const FullType(String),
      );
    }
    if (object.purpose != null) {
      yield r'purpose';
      yield serializers.serialize(
        object.purpose,
        specifiedType: const FullType(AdminPaymentItemPurposeEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminPaymentItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminPaymentItemBuilder result,
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
        case r'accountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.accountId = valueDes;
          break;
        case r'tier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminPaymentItemTierEnum),
          ) as AdminPaymentItemTierEnum?;
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
            specifiedType: const FullType.nullable(AdminPaymentItemMethodEnum),
          ) as AdminPaymentItemMethodEnum?;
          if (valueDes == null) continue;
          result.method = valueDes;
          break;
        case r'provider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.provider = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminPaymentItemStatusEnum),
          ) as AdminPaymentItemStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'confirmedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.confirmedAt = valueDes;
          break;
        case r'refundedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.refundedAt = valueDes;
          break;
        case r'refundedBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.refundedBy = valueDes;
          break;
        case r'refundReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.refundReason = valueDes;
          break;
        case r'purpose':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminPaymentItemPurposeEnum),
          ) as AdminPaymentItemPurposeEnum?;
          if (valueDes == null) continue;
          result.purpose = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminPaymentItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminPaymentItemBuilder();
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

class AdminPaymentItemTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FREE')
  static const AdminPaymentItemTierEnum FREE = _$adminPaymentItemTierEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC_PLUS')
  static const AdminPaymentItemTierEnum BASIC_PLUS = _$adminPaymentItemTierEnum_BASIC_PLUS;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const AdminPaymentItemTierEnum PRO = _$adminPaymentItemTierEnum_PRO;
  @BuiltValueEnumConst(wireName: r'PRO_PLUS')
  static const AdminPaymentItemTierEnum PRO_PLUS = _$adminPaymentItemTierEnum_PRO_PLUS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminPaymentItemTierEnum unknownDefaultOpenApi = _$adminPaymentItemTierEnum_unknownDefaultOpenApi;

  static Serializer<AdminPaymentItemTierEnum> get serializer => _$adminPaymentItemTierEnumSerializer;

  const AdminPaymentItemTierEnum._(String name): super(name);

  static BuiltSet<AdminPaymentItemTierEnum> get values => _$adminPaymentItemTierEnumValues;
  static AdminPaymentItemTierEnum valueOf(String name) => _$adminPaymentItemTierEnumValueOf(name);
}

class AdminPaymentItemMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MTN_MOMO')
  static const AdminPaymentItemMethodEnum MTN_MOMO = _$adminPaymentItemMethodEnum_MTN_MOMO;
  @BuiltValueEnumConst(wireName: r'ORANGE_MONEY')
  static const AdminPaymentItemMethodEnum ORANGE_MONEY = _$adminPaymentItemMethodEnum_ORANGE_MONEY;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminPaymentItemMethodEnum unknownDefaultOpenApi = _$adminPaymentItemMethodEnum_unknownDefaultOpenApi;

  static Serializer<AdminPaymentItemMethodEnum> get serializer => _$adminPaymentItemMethodEnumSerializer;

  const AdminPaymentItemMethodEnum._(String name): super(name);

  static BuiltSet<AdminPaymentItemMethodEnum> get values => _$adminPaymentItemMethodEnumValues;
  static AdminPaymentItemMethodEnum valueOf(String name) => _$adminPaymentItemMethodEnumValueOf(name);
}

class AdminPaymentItemStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const AdminPaymentItemStatusEnum PENDING = _$adminPaymentItemStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'CONFIRMED')
  static const AdminPaymentItemStatusEnum CONFIRMED = _$adminPaymentItemStatusEnum_CONFIRMED;
  @BuiltValueEnumConst(wireName: r'FAILED')
  static const AdminPaymentItemStatusEnum FAILED = _$adminPaymentItemStatusEnum_FAILED;
  @BuiltValueEnumConst(wireName: r'CANCELLED')
  static const AdminPaymentItemStatusEnum CANCELLED = _$adminPaymentItemStatusEnum_CANCELLED;
  @BuiltValueEnumConst(wireName: r'REFUNDED')
  static const AdminPaymentItemStatusEnum REFUNDED = _$adminPaymentItemStatusEnum_REFUNDED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminPaymentItemStatusEnum unknownDefaultOpenApi = _$adminPaymentItemStatusEnum_unknownDefaultOpenApi;

  static Serializer<AdminPaymentItemStatusEnum> get serializer => _$adminPaymentItemStatusEnumSerializer;

  const AdminPaymentItemStatusEnum._(String name): super(name);

  static BuiltSet<AdminPaymentItemStatusEnum> get values => _$adminPaymentItemStatusEnumValues;
  static AdminPaymentItemStatusEnum valueOf(String name) => _$adminPaymentItemStatusEnumValueOf(name);
}

class AdminPaymentItemPurposeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'SUBSCRIPTION')
  static const AdminPaymentItemPurposeEnum SUBSCRIPTION = _$adminPaymentItemPurposeEnum_SUBSCRIPTION;
  @BuiltValueEnumConst(wireName: r'FINANCE_ADDON')
  static const AdminPaymentItemPurposeEnum FINANCE_ADDON = _$adminPaymentItemPurposeEnum_FINANCE_ADDON;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminPaymentItemPurposeEnum unknownDefaultOpenApi = _$adminPaymentItemPurposeEnum_unknownDefaultOpenApi;

  static Serializer<AdminPaymentItemPurposeEnum> get serializer => _$adminPaymentItemPurposeEnumSerializer;

  const AdminPaymentItemPurposeEnum._(String name): super(name);

  static BuiltSet<AdminPaymentItemPurposeEnum> get values => _$adminPaymentItemPurposeEnumValues;
  static AdminPaymentItemPurposeEnum valueOf(String name) => _$adminPaymentItemPurposeEnumValueOf(name);
}

