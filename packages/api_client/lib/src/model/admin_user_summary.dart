//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_user_summary.g.dart';

/// AdminUserSummary
///
/// Properties:
/// * [accountId] 
/// * [displayName] 
/// * [phoneNumber] 
/// * [email] 
/// * [role] 
/// * [status] 
/// * [tier] 
/// * [periodEnd] 
/// * [listingCount] 
/// * [createdAt] 
@BuiltValue()
abstract class AdminUserSummary implements Built<AdminUserSummary, AdminUserSummaryBuilder> {
  @BuiltValueField(wireName: r'accountId')
  String? get accountId;

  @BuiltValueField(wireName: r'displayName')
  String? get displayName;

  @BuiltValueField(wireName: r'phoneNumber')
  String? get phoneNumber;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'role')
  AdminUserSummaryRoleEnum? get role;
  // enum roleEnum {  USER,  PRESTATAIRE,  AGENT,  ADMIN,  };

  @BuiltValueField(wireName: r'status')
  AdminUserSummaryStatusEnum? get status;
  // enum statusEnum {  PENDING,  ACTIVE,  SUSPENDED,  DELETED,  };

  @BuiltValueField(wireName: r'tier')
  AdminUserSummaryTierEnum? get tier;
  // enum tierEnum {  FREE,  BASIC_PLUS,  PRO,  PRO_PLUS,  };

  @BuiltValueField(wireName: r'periodEnd')
  DateTime? get periodEnd;

  @BuiltValueField(wireName: r'listingCount')
  int? get listingCount;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  AdminUserSummary._();

  factory AdminUserSummary([void updates(AdminUserSummaryBuilder b)]) = _$AdminUserSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminUserSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminUserSummary> get serializer => _$AdminUserSummarySerializer();
}

class _$AdminUserSummarySerializer implements PrimitiveSerializer<AdminUserSummary> {
  @override
  final Iterable<Type> types = const [AdminUserSummary, _$AdminUserSummary];

  @override
  final String wireName = r'AdminUserSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminUserSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.accountId != null) {
      yield r'accountId';
      yield serializers.serialize(
        object.accountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.displayName != null) {
      yield r'displayName';
      yield serializers.serialize(
        object.displayName,
        specifiedType: const FullType(String),
      );
    }
    if (object.phoneNumber != null) {
      yield r'phoneNumber';
      yield serializers.serialize(
        object.phoneNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      );
    }
    if (object.role != null) {
      yield r'role';
      yield serializers.serialize(
        object.role,
        specifiedType: const FullType(AdminUserSummaryRoleEnum),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(AdminUserSummaryStatusEnum),
      );
    }
    if (object.tier != null) {
      yield r'tier';
      yield serializers.serialize(
        object.tier,
        specifiedType: const FullType(AdminUserSummaryTierEnum),
      );
    }
    if (object.periodEnd != null) {
      yield r'periodEnd';
      yield serializers.serialize(
        object.periodEnd,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.listingCount != null) {
      yield r'listingCount';
      yield serializers.serialize(
        object.listingCount,
        specifiedType: const FullType(int),
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
    AdminUserSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminUserSummaryBuilder result,
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
        case r'displayName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.displayName = valueDes;
          break;
        case r'phoneNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.phoneNumber = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminUserSummaryRoleEnum),
          ) as AdminUserSummaryRoleEnum?;
          if (valueDes == null) continue;
          result.role = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminUserSummaryStatusEnum),
          ) as AdminUserSummaryStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'tier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminUserSummaryTierEnum),
          ) as AdminUserSummaryTierEnum?;
          if (valueDes == null) continue;
          result.tier = valueDes;
          break;
        case r'periodEnd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.periodEnd = valueDes;
          break;
        case r'listingCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.listingCount = valueDes;
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
  AdminUserSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminUserSummaryBuilder();
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

class AdminUserSummaryRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USER')
  static const AdminUserSummaryRoleEnum USER = _$adminUserSummaryRoleEnum_USER;
  @BuiltValueEnumConst(wireName: r'PRESTATAIRE')
  static const AdminUserSummaryRoleEnum PRESTATAIRE = _$adminUserSummaryRoleEnum_PRESTATAIRE;
  @BuiltValueEnumConst(wireName: r'AGENT')
  static const AdminUserSummaryRoleEnum AGENT = _$adminUserSummaryRoleEnum_AGENT;
  @BuiltValueEnumConst(wireName: r'ADMIN')
  static const AdminUserSummaryRoleEnum ADMIN = _$adminUserSummaryRoleEnum_ADMIN;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminUserSummaryRoleEnum unknownDefaultOpenApi = _$adminUserSummaryRoleEnum_unknownDefaultOpenApi;

  static Serializer<AdminUserSummaryRoleEnum> get serializer => _$adminUserSummaryRoleEnumSerializer;

  const AdminUserSummaryRoleEnum._(String name): super(name);

  static BuiltSet<AdminUserSummaryRoleEnum> get values => _$adminUserSummaryRoleEnumValues;
  static AdminUserSummaryRoleEnum valueOf(String name) => _$adminUserSummaryRoleEnumValueOf(name);
}

class AdminUserSummaryStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const AdminUserSummaryStatusEnum PENDING = _$adminUserSummaryStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'ACTIVE')
  static const AdminUserSummaryStatusEnum ACTIVE = _$adminUserSummaryStatusEnum_ACTIVE;
  @BuiltValueEnumConst(wireName: r'SUSPENDED')
  static const AdminUserSummaryStatusEnum SUSPENDED = _$adminUserSummaryStatusEnum_SUSPENDED;
  @BuiltValueEnumConst(wireName: r'DELETED')
  static const AdminUserSummaryStatusEnum DELETED = _$adminUserSummaryStatusEnum_DELETED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminUserSummaryStatusEnum unknownDefaultOpenApi = _$adminUserSummaryStatusEnum_unknownDefaultOpenApi;

  static Serializer<AdminUserSummaryStatusEnum> get serializer => _$adminUserSummaryStatusEnumSerializer;

  const AdminUserSummaryStatusEnum._(String name): super(name);

  static BuiltSet<AdminUserSummaryStatusEnum> get values => _$adminUserSummaryStatusEnumValues;
  static AdminUserSummaryStatusEnum valueOf(String name) => _$adminUserSummaryStatusEnumValueOf(name);
}

class AdminUserSummaryTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FREE')
  static const AdminUserSummaryTierEnum FREE = _$adminUserSummaryTierEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC_PLUS')
  static const AdminUserSummaryTierEnum BASIC_PLUS = _$adminUserSummaryTierEnum_BASIC_PLUS;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const AdminUserSummaryTierEnum PRO = _$adminUserSummaryTierEnum_PRO;
  @BuiltValueEnumConst(wireName: r'PRO_PLUS')
  static const AdminUserSummaryTierEnum PRO_PLUS = _$adminUserSummaryTierEnum_PRO_PLUS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminUserSummaryTierEnum unknownDefaultOpenApi = _$adminUserSummaryTierEnum_unknownDefaultOpenApi;

  static Serializer<AdminUserSummaryTierEnum> get serializer => _$adminUserSummaryTierEnumSerializer;

  const AdminUserSummaryTierEnum._(String name): super(name);

  static BuiltSet<AdminUserSummaryTierEnum> get values => _$adminUserSummaryTierEnumValues;
  static AdminUserSummaryTierEnum valueOf(String name) => _$adminUserSummaryTierEnumValueOf(name);
}

