//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_subscription_item.g.dart';

/// AdminSubscriptionItem
///
/// Properties:
/// * [accountId] 
/// * [tier] 
/// * [effectiveTier] 
/// * [status] 
/// * [currentPeriodStart] 
/// * [currentPeriodEnd] 
/// * [paid] 
/// * [currentPaymentId] 
/// * [paidSince] 
@BuiltValue()
abstract class AdminSubscriptionItem implements Built<AdminSubscriptionItem, AdminSubscriptionItemBuilder> {
  @BuiltValueField(wireName: r'accountId')
  String? get accountId;

  @BuiltValueField(wireName: r'tier')
  AdminSubscriptionItemTierEnum? get tier;
  // enum tierEnum {  FREE,  BASIC_PLUS,  PRO,  PRO_PLUS,  };

  @BuiltValueField(wireName: r'effectiveTier')
  AdminSubscriptionItemEffectiveTierEnum? get effectiveTier;
  // enum effectiveTierEnum {  FREE,  BASIC_PLUS,  PRO,  PRO_PLUS,  };

  @BuiltValueField(wireName: r'status')
  AdminSubscriptionItemStatusEnum? get status;
  // enum statusEnum {  ACTIVE,  EXPIRED,  };

  @BuiltValueField(wireName: r'currentPeriodStart')
  DateTime? get currentPeriodStart;

  @BuiltValueField(wireName: r'currentPeriodEnd')
  DateTime? get currentPeriodEnd;

  @BuiltValueField(wireName: r'paid')
  bool? get paid;

  @BuiltValueField(wireName: r'currentPaymentId')
  String? get currentPaymentId;

  @BuiltValueField(wireName: r'paidSince')
  DateTime? get paidSince;

  AdminSubscriptionItem._();

  factory AdminSubscriptionItem([void updates(AdminSubscriptionItemBuilder b)]) = _$AdminSubscriptionItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminSubscriptionItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminSubscriptionItem> get serializer => _$AdminSubscriptionItemSerializer();
}

class _$AdminSubscriptionItemSerializer implements PrimitiveSerializer<AdminSubscriptionItem> {
  @override
  final Iterable<Type> types = const [AdminSubscriptionItem, _$AdminSubscriptionItem];

  @override
  final String wireName = r'AdminSubscriptionItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminSubscriptionItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
        specifiedType: const FullType(AdminSubscriptionItemTierEnum),
      );
    }
    if (object.effectiveTier != null) {
      yield r'effectiveTier';
      yield serializers.serialize(
        object.effectiveTier,
        specifiedType: const FullType(AdminSubscriptionItemEffectiveTierEnum),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(AdminSubscriptionItemStatusEnum),
      );
    }
    if (object.currentPeriodStart != null) {
      yield r'currentPeriodStart';
      yield serializers.serialize(
        object.currentPeriodStart,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.currentPeriodEnd != null) {
      yield r'currentPeriodEnd';
      yield serializers.serialize(
        object.currentPeriodEnd,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.paid != null) {
      yield r'paid';
      yield serializers.serialize(
        object.paid,
        specifiedType: const FullType(bool),
      );
    }
    if (object.currentPaymentId != null) {
      yield r'currentPaymentId';
      yield serializers.serialize(
        object.currentPaymentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.paidSince != null) {
      yield r'paidSince';
      yield serializers.serialize(
        object.paidSince,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminSubscriptionItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminSubscriptionItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType.nullable(AdminSubscriptionItemTierEnum),
          ) as AdminSubscriptionItemTierEnum?;
          if (valueDes == null) continue;
          result.tier = valueDes;
          break;
        case r'effectiveTier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminSubscriptionItemEffectiveTierEnum),
          ) as AdminSubscriptionItemEffectiveTierEnum?;
          if (valueDes == null) continue;
          result.effectiveTier = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminSubscriptionItemStatusEnum),
          ) as AdminSubscriptionItemStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'currentPeriodStart':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.currentPeriodStart = valueDes;
          break;
        case r'currentPeriodEnd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.currentPeriodEnd = valueDes;
          break;
        case r'paid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.paid = valueDes;
          break;
        case r'currentPaymentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.currentPaymentId = valueDes;
          break;
        case r'paidSince':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.paidSince = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminSubscriptionItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminSubscriptionItemBuilder();
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

class AdminSubscriptionItemTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FREE')
  static const AdminSubscriptionItemTierEnum FREE = _$adminSubscriptionItemTierEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC_PLUS')
  static const AdminSubscriptionItemTierEnum BASIC_PLUS = _$adminSubscriptionItemTierEnum_BASIC_PLUS;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const AdminSubscriptionItemTierEnum PRO = _$adminSubscriptionItemTierEnum_PRO;
  @BuiltValueEnumConst(wireName: r'PRO_PLUS')
  static const AdminSubscriptionItemTierEnum PRO_PLUS = _$adminSubscriptionItemTierEnum_PRO_PLUS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminSubscriptionItemTierEnum unknownDefaultOpenApi = _$adminSubscriptionItemTierEnum_unknownDefaultOpenApi;

  static Serializer<AdminSubscriptionItemTierEnum> get serializer => _$adminSubscriptionItemTierEnumSerializer;

  const AdminSubscriptionItemTierEnum._(String name): super(name);

  static BuiltSet<AdminSubscriptionItemTierEnum> get values => _$adminSubscriptionItemTierEnumValues;
  static AdminSubscriptionItemTierEnum valueOf(String name) => _$adminSubscriptionItemTierEnumValueOf(name);
}

class AdminSubscriptionItemEffectiveTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FREE')
  static const AdminSubscriptionItemEffectiveTierEnum FREE = _$adminSubscriptionItemEffectiveTierEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC_PLUS')
  static const AdminSubscriptionItemEffectiveTierEnum BASIC_PLUS = _$adminSubscriptionItemEffectiveTierEnum_BASIC_PLUS;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const AdminSubscriptionItemEffectiveTierEnum PRO = _$adminSubscriptionItemEffectiveTierEnum_PRO;
  @BuiltValueEnumConst(wireName: r'PRO_PLUS')
  static const AdminSubscriptionItemEffectiveTierEnum PRO_PLUS = _$adminSubscriptionItemEffectiveTierEnum_PRO_PLUS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminSubscriptionItemEffectiveTierEnum unknownDefaultOpenApi = _$adminSubscriptionItemEffectiveTierEnum_unknownDefaultOpenApi;

  static Serializer<AdminSubscriptionItemEffectiveTierEnum> get serializer => _$adminSubscriptionItemEffectiveTierEnumSerializer;

  const AdminSubscriptionItemEffectiveTierEnum._(String name): super(name);

  static BuiltSet<AdminSubscriptionItemEffectiveTierEnum> get values => _$adminSubscriptionItemEffectiveTierEnumValues;
  static AdminSubscriptionItemEffectiveTierEnum valueOf(String name) => _$adminSubscriptionItemEffectiveTierEnumValueOf(name);
}

class AdminSubscriptionItemStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ACTIVE')
  static const AdminSubscriptionItemStatusEnum ACTIVE = _$adminSubscriptionItemStatusEnum_ACTIVE;
  @BuiltValueEnumConst(wireName: r'EXPIRED')
  static const AdminSubscriptionItemStatusEnum EXPIRED = _$adminSubscriptionItemStatusEnum_EXPIRED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminSubscriptionItemStatusEnum unknownDefaultOpenApi = _$adminSubscriptionItemStatusEnum_unknownDefaultOpenApi;

  static Serializer<AdminSubscriptionItemStatusEnum> get serializer => _$adminSubscriptionItemStatusEnumSerializer;

  const AdminSubscriptionItemStatusEnum._(String name): super(name);

  static BuiltSet<AdminSubscriptionItemStatusEnum> get values => _$adminSubscriptionItemStatusEnumValues;
  static AdminSubscriptionItemStatusEnum valueOf(String name) => _$adminSubscriptionItemStatusEnumValueOf(name);
}

