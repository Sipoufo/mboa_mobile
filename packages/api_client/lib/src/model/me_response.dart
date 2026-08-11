//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'me_response.g.dart';

/// MeResponse
///
/// Properties:
/// * [id] 
/// * [phoneNumber] 
/// * [email] 
/// * [role] 
/// * [status] 
/// * [authProvider] 
/// * [emailVerified] 
/// * [tier] 
/// * [createdAt] 
@BuiltValue()
abstract class MeResponse implements Built<MeResponse, MeResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'phoneNumber')
  String? get phoneNumber;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'role')
  MeResponseRoleEnum? get role;
  // enum roleEnum {  USER,  PRESTATAIRE,  AGENT,  ADMIN,  };

  @BuiltValueField(wireName: r'status')
  MeResponseStatusEnum? get status;
  // enum statusEnum {  PENDING,  ACTIVE,  SUSPENDED,  DELETED,  };

  @BuiltValueField(wireName: r'authProvider')
  MeResponseAuthProviderEnum? get authProvider;
  // enum authProviderEnum {  PHONE,  GOOGLE,  APPLE,  };

  @BuiltValueField(wireName: r'emailVerified')
  bool? get emailVerified;

  @BuiltValueField(wireName: r'tier')
  MeResponseTierEnum? get tier;
  // enum tierEnum {  FREE,  BASIC_PLUS,  PRO,  PRO_PLUS,  };

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  MeResponse._();

  factory MeResponse([void updates(MeResponseBuilder b)]) = _$MeResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MeResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MeResponse> get serializer => _$MeResponseSerializer();
}

class _$MeResponseSerializer implements PrimitiveSerializer<MeResponse> {
  @override
  final Iterable<Type> types = const [MeResponse, _$MeResponse];

  @override
  final String wireName = r'MeResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
        specifiedType: const FullType(MeResponseRoleEnum),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(MeResponseStatusEnum),
      );
    }
    if (object.authProvider != null) {
      yield r'authProvider';
      yield serializers.serialize(
        object.authProvider,
        specifiedType: const FullType(MeResponseAuthProviderEnum),
      );
    }
    if (object.emailVerified != null) {
      yield r'emailVerified';
      yield serializers.serialize(
        object.emailVerified,
        specifiedType: const FullType(bool),
      );
    }
    if (object.tier != null) {
      yield r'tier';
      yield serializers.serialize(
        object.tier,
        specifiedType: const FullType(MeResponseTierEnum),
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
    MeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MeResponseBuilder result,
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
            specifiedType: const FullType.nullable(MeResponseRoleEnum),
          ) as MeResponseRoleEnum?;
          if (valueDes == null) continue;
          result.role = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(MeResponseStatusEnum),
          ) as MeResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'authProvider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(MeResponseAuthProviderEnum),
          ) as MeResponseAuthProviderEnum?;
          if (valueDes == null) continue;
          result.authProvider = valueDes;
          break;
        case r'emailVerified':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.emailVerified = valueDes;
          break;
        case r'tier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(MeResponseTierEnum),
          ) as MeResponseTierEnum?;
          if (valueDes == null) continue;
          result.tier = valueDes;
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
  MeResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MeResponseBuilder();
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

class MeResponseRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USER')
  static const MeResponseRoleEnum USER = _$meResponseRoleEnum_USER;
  @BuiltValueEnumConst(wireName: r'PRESTATAIRE')
  static const MeResponseRoleEnum PRESTATAIRE = _$meResponseRoleEnum_PRESTATAIRE;
  @BuiltValueEnumConst(wireName: r'AGENT')
  static const MeResponseRoleEnum AGENT = _$meResponseRoleEnum_AGENT;
  @BuiltValueEnumConst(wireName: r'ADMIN')
  static const MeResponseRoleEnum ADMIN = _$meResponseRoleEnum_ADMIN;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MeResponseRoleEnum unknownDefaultOpenApi = _$meResponseRoleEnum_unknownDefaultOpenApi;

  static Serializer<MeResponseRoleEnum> get serializer => _$meResponseRoleEnumSerializer;

  const MeResponseRoleEnum._(String name): super(name);

  static BuiltSet<MeResponseRoleEnum> get values => _$meResponseRoleEnumValues;
  static MeResponseRoleEnum valueOf(String name) => _$meResponseRoleEnumValueOf(name);
}

class MeResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const MeResponseStatusEnum PENDING = _$meResponseStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'ACTIVE')
  static const MeResponseStatusEnum ACTIVE = _$meResponseStatusEnum_ACTIVE;
  @BuiltValueEnumConst(wireName: r'SUSPENDED')
  static const MeResponseStatusEnum SUSPENDED = _$meResponseStatusEnum_SUSPENDED;
  @BuiltValueEnumConst(wireName: r'DELETED')
  static const MeResponseStatusEnum DELETED = _$meResponseStatusEnum_DELETED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MeResponseStatusEnum unknownDefaultOpenApi = _$meResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<MeResponseStatusEnum> get serializer => _$meResponseStatusEnumSerializer;

  const MeResponseStatusEnum._(String name): super(name);

  static BuiltSet<MeResponseStatusEnum> get values => _$meResponseStatusEnumValues;
  static MeResponseStatusEnum valueOf(String name) => _$meResponseStatusEnumValueOf(name);
}

class MeResponseAuthProviderEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PHONE')
  static const MeResponseAuthProviderEnum PHONE = _$meResponseAuthProviderEnum_PHONE;
  @BuiltValueEnumConst(wireName: r'GOOGLE')
  static const MeResponseAuthProviderEnum GOOGLE = _$meResponseAuthProviderEnum_GOOGLE;
  @BuiltValueEnumConst(wireName: r'APPLE')
  static const MeResponseAuthProviderEnum APPLE = _$meResponseAuthProviderEnum_APPLE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MeResponseAuthProviderEnum unknownDefaultOpenApi = _$meResponseAuthProviderEnum_unknownDefaultOpenApi;

  static Serializer<MeResponseAuthProviderEnum> get serializer => _$meResponseAuthProviderEnumSerializer;

  const MeResponseAuthProviderEnum._(String name): super(name);

  static BuiltSet<MeResponseAuthProviderEnum> get values => _$meResponseAuthProviderEnumValues;
  static MeResponseAuthProviderEnum valueOf(String name) => _$meResponseAuthProviderEnumValueOf(name);
}

class MeResponseTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FREE')
  static const MeResponseTierEnum FREE = _$meResponseTierEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC_PLUS')
  static const MeResponseTierEnum BASIC_PLUS = _$meResponseTierEnum_BASIC_PLUS;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const MeResponseTierEnum PRO = _$meResponseTierEnum_PRO;
  @BuiltValueEnumConst(wireName: r'PRO_PLUS')
  static const MeResponseTierEnum PRO_PLUS = _$meResponseTierEnum_PRO_PLUS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MeResponseTierEnum unknownDefaultOpenApi = _$meResponseTierEnum_unknownDefaultOpenApi;

  static Serializer<MeResponseTierEnum> get serializer => _$meResponseTierEnumSerializer;

  const MeResponseTierEnum._(String name): super(name);

  static BuiltSet<MeResponseTierEnum> get values => _$meResponseTierEnumValues;
  static MeResponseTierEnum valueOf(String name) => _$meResponseTierEnumValueOf(name);
}

