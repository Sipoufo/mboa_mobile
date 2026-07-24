//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'register_professional_request.g.dart';

/// RegisterProfessionalRequest
///
/// Properties:
/// * [role] 
/// * [email] 
/// * [password] 
/// * [phoneNumber] 
@BuiltValue()
abstract class RegisterProfessionalRequest implements Built<RegisterProfessionalRequest, RegisterProfessionalRequestBuilder> {
  @BuiltValueField(wireName: r'role')
  RegisterProfessionalRequestRoleEnum get role;
  // enum roleEnum {  USER,  PRESTATAIRE,  AGENT,  ADMIN,  };

  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'password')
  String get password;

  @BuiltValueField(wireName: r'phoneNumber')
  String get phoneNumber;

  RegisterProfessionalRequest._();

  factory RegisterProfessionalRequest([void updates(RegisterProfessionalRequestBuilder b)]) = _$RegisterProfessionalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RegisterProfessionalRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RegisterProfessionalRequest> get serializer => _$RegisterProfessionalRequestSerializer();
}

class _$RegisterProfessionalRequestSerializer implements PrimitiveSerializer<RegisterProfessionalRequest> {
  @override
  final Iterable<Type> types = const [RegisterProfessionalRequest, _$RegisterProfessionalRequest];

  @override
  final String wireName = r'RegisterProfessionalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RegisterProfessionalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(RegisterProfessionalRequestRoleEnum),
    );
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
    yield r'phoneNumber';
    yield serializers.serialize(
      object.phoneNumber,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RegisterProfessionalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RegisterProfessionalRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RegisterProfessionalRequestRoleEnum),
          ) as RegisterProfessionalRequestRoleEnum;
          result.role = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'phoneNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.phoneNumber = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RegisterProfessionalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RegisterProfessionalRequestBuilder();
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

class RegisterProfessionalRequestRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USER')
  static const RegisterProfessionalRequestRoleEnum USER = _$registerProfessionalRequestRoleEnum_USER;
  @BuiltValueEnumConst(wireName: r'PRESTATAIRE')
  static const RegisterProfessionalRequestRoleEnum PRESTATAIRE = _$registerProfessionalRequestRoleEnum_PRESTATAIRE;
  @BuiltValueEnumConst(wireName: r'AGENT')
  static const RegisterProfessionalRequestRoleEnum AGENT = _$registerProfessionalRequestRoleEnum_AGENT;
  @BuiltValueEnumConst(wireName: r'ADMIN')
  static const RegisterProfessionalRequestRoleEnum ADMIN = _$registerProfessionalRequestRoleEnum_ADMIN;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RegisterProfessionalRequestRoleEnum unknownDefaultOpenApi = _$registerProfessionalRequestRoleEnum_unknownDefaultOpenApi;

  static Serializer<RegisterProfessionalRequestRoleEnum> get serializer => _$registerProfessionalRequestRoleEnumSerializer;

  const RegisterProfessionalRequestRoleEnum._(String name): super(name);

  static BuiltSet<RegisterProfessionalRequestRoleEnum> get values => _$registerProfessionalRequestRoleEnumValues;
  static RegisterProfessionalRequestRoleEnum valueOf(String name) => _$registerProfessionalRequestRoleEnumValueOf(name);
}

