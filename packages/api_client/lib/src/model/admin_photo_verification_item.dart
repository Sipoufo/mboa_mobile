//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_photo_verification_item.g.dart';

/// AdminPhotoVerificationItem
///
/// Properties:
/// * [id] 
/// * [accountId] 
/// * [target] 
/// * [targetId] 
/// * [status] 
/// * [requestedAt] 
/// * [dueAt] 
/// * [overdue] 
/// * [photoUrls] 
/// * [decidedBy] 
/// * [decidedAt] 
/// * [reason] 
@BuiltValue()
abstract class AdminPhotoVerificationItem implements Built<AdminPhotoVerificationItem, AdminPhotoVerificationItemBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'accountId')
  String? get accountId;

  @BuiltValueField(wireName: r'target')
  AdminPhotoVerificationItemTargetEnum? get target;
  // enum targetEnum {  ANNONCE,  RESIDENCE,  };

  @BuiltValueField(wireName: r'targetId')
  String? get targetId;

  @BuiltValueField(wireName: r'status')
  AdminPhotoVerificationItemStatusEnum? get status;
  // enum statusEnum {  PENDING,  APPROVED,  REJECTED,  REVOKED,  };

  @BuiltValueField(wireName: r'requestedAt')
  DateTime? get requestedAt;

  @BuiltValueField(wireName: r'dueAt')
  DateTime? get dueAt;

  @BuiltValueField(wireName: r'overdue')
  bool? get overdue;

  @BuiltValueField(wireName: r'photoUrls')
  BuiltList<String>? get photoUrls;

  @BuiltValueField(wireName: r'decidedBy')
  String? get decidedBy;

  @BuiltValueField(wireName: r'decidedAt')
  DateTime? get decidedAt;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  AdminPhotoVerificationItem._();

  factory AdminPhotoVerificationItem([void updates(AdminPhotoVerificationItemBuilder b)]) = _$AdminPhotoVerificationItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminPhotoVerificationItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminPhotoVerificationItem> get serializer => _$AdminPhotoVerificationItemSerializer();
}

class _$AdminPhotoVerificationItemSerializer implements PrimitiveSerializer<AdminPhotoVerificationItem> {
  @override
  final Iterable<Type> types = const [AdminPhotoVerificationItem, _$AdminPhotoVerificationItem];

  @override
  final String wireName = r'AdminPhotoVerificationItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminPhotoVerificationItem object, {
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
    if (object.target != null) {
      yield r'target';
      yield serializers.serialize(
        object.target,
        specifiedType: const FullType(AdminPhotoVerificationItemTargetEnum),
      );
    }
    if (object.targetId != null) {
      yield r'targetId';
      yield serializers.serialize(
        object.targetId,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(AdminPhotoVerificationItemStatusEnum),
      );
    }
    if (object.requestedAt != null) {
      yield r'requestedAt';
      yield serializers.serialize(
        object.requestedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.dueAt != null) {
      yield r'dueAt';
      yield serializers.serialize(
        object.dueAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.overdue != null) {
      yield r'overdue';
      yield serializers.serialize(
        object.overdue,
        specifiedType: const FullType(bool),
      );
    }
    if (object.photoUrls != null) {
      yield r'photoUrls';
      yield serializers.serialize(
        object.photoUrls,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.decidedBy != null) {
      yield r'decidedBy';
      yield serializers.serialize(
        object.decidedBy,
        specifiedType: const FullType(String),
      );
    }
    if (object.decidedAt != null) {
      yield r'decidedAt';
      yield serializers.serialize(
        object.decidedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminPhotoVerificationItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminPhotoVerificationItemBuilder result,
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
        case r'target':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminPhotoVerificationItemTargetEnum),
          ) as AdminPhotoVerificationItemTargetEnum?;
          if (valueDes == null) continue;
          result.target = valueDes;
          break;
        case r'targetId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.targetId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminPhotoVerificationItemStatusEnum),
          ) as AdminPhotoVerificationItemStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'requestedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.requestedAt = valueDes;
          break;
        case r'dueAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.dueAt = valueDes;
          break;
        case r'overdue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.overdue = valueDes;
          break;
        case r'photoUrls':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.photoUrls.replace(valueDes);
          break;
        case r'decidedBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.decidedBy = valueDes;
          break;
        case r'decidedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.decidedAt = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminPhotoVerificationItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminPhotoVerificationItemBuilder();
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

class AdminPhotoVerificationItemTargetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ANNONCE')
  static const AdminPhotoVerificationItemTargetEnum ANNONCE = _$adminPhotoVerificationItemTargetEnum_ANNONCE;
  @BuiltValueEnumConst(wireName: r'RESIDENCE')
  static const AdminPhotoVerificationItemTargetEnum RESIDENCE = _$adminPhotoVerificationItemTargetEnum_RESIDENCE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminPhotoVerificationItemTargetEnum unknownDefaultOpenApi = _$adminPhotoVerificationItemTargetEnum_unknownDefaultOpenApi;

  static Serializer<AdminPhotoVerificationItemTargetEnum> get serializer => _$adminPhotoVerificationItemTargetEnumSerializer;

  const AdminPhotoVerificationItemTargetEnum._(String name): super(name);

  static BuiltSet<AdminPhotoVerificationItemTargetEnum> get values => _$adminPhotoVerificationItemTargetEnumValues;
  static AdminPhotoVerificationItemTargetEnum valueOf(String name) => _$adminPhotoVerificationItemTargetEnumValueOf(name);
}

class AdminPhotoVerificationItemStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const AdminPhotoVerificationItemStatusEnum PENDING = _$adminPhotoVerificationItemStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'APPROVED')
  static const AdminPhotoVerificationItemStatusEnum APPROVED = _$adminPhotoVerificationItemStatusEnum_APPROVED;
  @BuiltValueEnumConst(wireName: r'REJECTED')
  static const AdminPhotoVerificationItemStatusEnum REJECTED = _$adminPhotoVerificationItemStatusEnum_REJECTED;
  @BuiltValueEnumConst(wireName: r'REVOKED')
  static const AdminPhotoVerificationItemStatusEnum REVOKED = _$adminPhotoVerificationItemStatusEnum_REVOKED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminPhotoVerificationItemStatusEnum unknownDefaultOpenApi = _$adminPhotoVerificationItemStatusEnum_unknownDefaultOpenApi;

  static Serializer<AdminPhotoVerificationItemStatusEnum> get serializer => _$adminPhotoVerificationItemStatusEnumSerializer;

  const AdminPhotoVerificationItemStatusEnum._(String name): super(name);

  static BuiltSet<AdminPhotoVerificationItemStatusEnum> get values => _$adminPhotoVerificationItemStatusEnumValues;
  static AdminPhotoVerificationItemStatusEnum valueOf(String name) => _$adminPhotoVerificationItemStatusEnumValueOf(name);
}

