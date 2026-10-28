//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/kyc_address.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'kyc_review_item.g.dart';

/// KycReviewItem
///
/// Properties:
/// * [id] 
/// * [accountId] 
/// * [status] 
/// * [submittedAt] 
/// * [idDocumentFrontUrl] 
/// * [idDocumentBackUrl] 
/// * [selfieUrl] 
/// * [role] 
/// * [displayName] 
/// * [dueAt] 
/// * [overdue] 
/// * [nui] 
/// * [address] 
/// * [idDocumentType] 
/// * [idNumber] 
/// * [issuedOn] 
/// * [expiresOn] 
/// * [issuedAt] 
@BuiltValue()
abstract class KycReviewItem implements Built<KycReviewItem, KycReviewItemBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'accountId')
  String? get accountId;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'submittedAt')
  DateTime? get submittedAt;

  @BuiltValueField(wireName: r'idDocumentFrontUrl')
  String? get idDocumentFrontUrl;

  @BuiltValueField(wireName: r'idDocumentBackUrl')
  String? get idDocumentBackUrl;

  @BuiltValueField(wireName: r'selfieUrl')
  String? get selfieUrl;

  @BuiltValueField(wireName: r'role')
  KycReviewItemRoleEnum? get role;
  // enum roleEnum {  USER,  PRESTATAIRE,  AGENT,  ADMIN,  };

  @BuiltValueField(wireName: r'displayName')
  String? get displayName;

  @BuiltValueField(wireName: r'dueAt')
  DateTime? get dueAt;

  @BuiltValueField(wireName: r'overdue')
  bool? get overdue;

  @BuiltValueField(wireName: r'nui')
  String? get nui;

  @BuiltValueField(wireName: r'address')
  KycAddress? get address;

  @BuiltValueField(wireName: r'idDocumentType')
  KycReviewItemIdDocumentTypeEnum? get idDocumentType;
  // enum idDocumentTypeEnum {  CNI,  PASSPORT,  DRIVING_LICENCE,  };

  @BuiltValueField(wireName: r'idNumber')
  String? get idNumber;

  @BuiltValueField(wireName: r'issuedOn')
  Date? get issuedOn;

  @BuiltValueField(wireName: r'expiresOn')
  Date? get expiresOn;

  @BuiltValueField(wireName: r'issuedAt')
  String? get issuedAt;

  KycReviewItem._();

  factory KycReviewItem([void updates(KycReviewItemBuilder b)]) = _$KycReviewItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KycReviewItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KycReviewItem> get serializer => _$KycReviewItemSerializer();
}

class _$KycReviewItemSerializer implements PrimitiveSerializer<KycReviewItem> {
  @override
  final Iterable<Type> types = const [KycReviewItem, _$KycReviewItem];

  @override
  final String wireName = r'KycReviewItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KycReviewItem object, {
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
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.submittedAt != null) {
      yield r'submittedAt';
      yield serializers.serialize(
        object.submittedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.idDocumentFrontUrl != null) {
      yield r'idDocumentFrontUrl';
      yield serializers.serialize(
        object.idDocumentFrontUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.idDocumentBackUrl != null) {
      yield r'idDocumentBackUrl';
      yield serializers.serialize(
        object.idDocumentBackUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.selfieUrl != null) {
      yield r'selfieUrl';
      yield serializers.serialize(
        object.selfieUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.role != null) {
      yield r'role';
      yield serializers.serialize(
        object.role,
        specifiedType: const FullType(KycReviewItemRoleEnum),
      );
    }
    if (object.displayName != null) {
      yield r'displayName';
      yield serializers.serialize(
        object.displayName,
        specifiedType: const FullType(String),
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
    if (object.nui != null) {
      yield r'nui';
      yield serializers.serialize(
        object.nui,
        specifiedType: const FullType(String),
      );
    }
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType(KycAddress),
      );
    }
    if (object.idDocumentType != null) {
      yield r'idDocumentType';
      yield serializers.serialize(
        object.idDocumentType,
        specifiedType: const FullType(KycReviewItemIdDocumentTypeEnum),
      );
    }
    if (object.idNumber != null) {
      yield r'idNumber';
      yield serializers.serialize(
        object.idNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.issuedOn != null) {
      yield r'issuedOn';
      yield serializers.serialize(
        object.issuedOn,
        specifiedType: const FullType(Date),
      );
    }
    if (object.expiresOn != null) {
      yield r'expiresOn';
      yield serializers.serialize(
        object.expiresOn,
        specifiedType: const FullType(Date),
      );
    }
    if (object.issuedAt != null) {
      yield r'issuedAt';
      yield serializers.serialize(
        object.issuedAt,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    KycReviewItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KycReviewItemBuilder result,
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'submittedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.submittedAt = valueDes;
          break;
        case r'idDocumentFrontUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.idDocumentFrontUrl = valueDes;
          break;
        case r'idDocumentBackUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.idDocumentBackUrl = valueDes;
          break;
        case r'selfieUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.selfieUrl = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(KycReviewItemRoleEnum),
          ) as KycReviewItemRoleEnum?;
          if (valueDes == null) continue;
          result.role = valueDes;
          break;
        case r'displayName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.displayName = valueDes;
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
        case r'nui':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nui = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(KycAddress),
          ) as KycAddress?;
          if (valueDes == null) continue;
          result.address.replace(valueDes);
          break;
        case r'idDocumentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(KycReviewItemIdDocumentTypeEnum),
          ) as KycReviewItemIdDocumentTypeEnum?;
          if (valueDes == null) continue;
          result.idDocumentType = valueDes;
          break;
        case r'idNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.idNumber = valueDes;
          break;
        case r'issuedOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.issuedOn = valueDes;
          break;
        case r'expiresOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.expiresOn = valueDes;
          break;
        case r'issuedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.issuedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  KycReviewItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KycReviewItemBuilder();
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

class KycReviewItemRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USER')
  static const KycReviewItemRoleEnum USER = _$kycReviewItemRoleEnum_USER;
  @BuiltValueEnumConst(wireName: r'PRESTATAIRE')
  static const KycReviewItemRoleEnum PRESTATAIRE = _$kycReviewItemRoleEnum_PRESTATAIRE;
  @BuiltValueEnumConst(wireName: r'AGENT')
  static const KycReviewItemRoleEnum AGENT = _$kycReviewItemRoleEnum_AGENT;
  @BuiltValueEnumConst(wireName: r'ADMIN')
  static const KycReviewItemRoleEnum ADMIN = _$kycReviewItemRoleEnum_ADMIN;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const KycReviewItemRoleEnum unknownDefaultOpenApi = _$kycReviewItemRoleEnum_unknownDefaultOpenApi;

  static Serializer<KycReviewItemRoleEnum> get serializer => _$kycReviewItemRoleEnumSerializer;

  const KycReviewItemRoleEnum._(String name): super(name);

  static BuiltSet<KycReviewItemRoleEnum> get values => _$kycReviewItemRoleEnumValues;
  static KycReviewItemRoleEnum valueOf(String name) => _$kycReviewItemRoleEnumValueOf(name);
}

class KycReviewItemIdDocumentTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CNI')
  static const KycReviewItemIdDocumentTypeEnum CNI = _$kycReviewItemIdDocumentTypeEnum_CNI;
  @BuiltValueEnumConst(wireName: r'PASSPORT')
  static const KycReviewItemIdDocumentTypeEnum PASSPORT = _$kycReviewItemIdDocumentTypeEnum_PASSPORT;
  @BuiltValueEnumConst(wireName: r'DRIVING_LICENCE')
  static const KycReviewItemIdDocumentTypeEnum DRIVING_LICENCE = _$kycReviewItemIdDocumentTypeEnum_DRIVING_LICENCE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const KycReviewItemIdDocumentTypeEnum unknownDefaultOpenApi = _$kycReviewItemIdDocumentTypeEnum_unknownDefaultOpenApi;

  static Serializer<KycReviewItemIdDocumentTypeEnum> get serializer => _$kycReviewItemIdDocumentTypeEnumSerializer;

  const KycReviewItemIdDocumentTypeEnum._(String name): super(name);

  static BuiltSet<KycReviewItemIdDocumentTypeEnum> get values => _$kycReviewItemIdDocumentTypeEnumValues;
  static KycReviewItemIdDocumentTypeEnum valueOf(String name) => _$kycReviewItemIdDocumentTypeEnumValueOf(name);
}

