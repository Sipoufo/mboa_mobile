//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'signing_identity_request.g.dart';

/// SigningIdentityRequest
///
/// Properties:
/// * [idDocumentType] 
/// * [idNumber] 
/// * [issuedOn] 
/// * [expiresOn] 
/// * [issuedAt] 
@BuiltValue()
abstract class SigningIdentityRequest implements Built<SigningIdentityRequest, SigningIdentityRequestBuilder> {
  @BuiltValueField(wireName: r'idDocumentType')
  SigningIdentityRequestIdDocumentTypeEnum get idDocumentType;
  // enum idDocumentTypeEnum {  CNI,  PASSPORT,  DRIVING_LICENCE,  };

  @BuiltValueField(wireName: r'idNumber')
  String get idNumber;

  @BuiltValueField(wireName: r'issuedOn')
  Date get issuedOn;

  @BuiltValueField(wireName: r'expiresOn')
  Date get expiresOn;

  @BuiltValueField(wireName: r'issuedAt')
  String get issuedAt;

  SigningIdentityRequest._();

  factory SigningIdentityRequest([void updates(SigningIdentityRequestBuilder b)]) = _$SigningIdentityRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SigningIdentityRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SigningIdentityRequest> get serializer => _$SigningIdentityRequestSerializer();
}

class _$SigningIdentityRequestSerializer implements PrimitiveSerializer<SigningIdentityRequest> {
  @override
  final Iterable<Type> types = const [SigningIdentityRequest, _$SigningIdentityRequest];

  @override
  final String wireName = r'SigningIdentityRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SigningIdentityRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'idDocumentType';
    yield serializers.serialize(
      object.idDocumentType,
      specifiedType: const FullType(SigningIdentityRequestIdDocumentTypeEnum),
    );
    yield r'idNumber';
    yield serializers.serialize(
      object.idNumber,
      specifiedType: const FullType(String),
    );
    yield r'issuedOn';
    yield serializers.serialize(
      object.issuedOn,
      specifiedType: const FullType(Date),
    );
    yield r'expiresOn';
    yield serializers.serialize(
      object.expiresOn,
      specifiedType: const FullType(Date),
    );
    yield r'issuedAt';
    yield serializers.serialize(
      object.issuedAt,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SigningIdentityRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SigningIdentityRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'idDocumentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SigningIdentityRequestIdDocumentTypeEnum),
          ) as SigningIdentityRequestIdDocumentTypeEnum;
          result.idDocumentType = valueDes;
          break;
        case r'idNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idNumber = valueDes;
          break;
        case r'issuedOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.issuedOn = valueDes;
          break;
        case r'expiresOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.expiresOn = valueDes;
          break;
        case r'issuedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  SigningIdentityRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SigningIdentityRequestBuilder();
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

class SigningIdentityRequestIdDocumentTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CNI')
  static const SigningIdentityRequestIdDocumentTypeEnum CNI = _$signingIdentityRequestIdDocumentTypeEnum_CNI;
  @BuiltValueEnumConst(wireName: r'PASSPORT')
  static const SigningIdentityRequestIdDocumentTypeEnum PASSPORT = _$signingIdentityRequestIdDocumentTypeEnum_PASSPORT;
  @BuiltValueEnumConst(wireName: r'DRIVING_LICENCE')
  static const SigningIdentityRequestIdDocumentTypeEnum DRIVING_LICENCE = _$signingIdentityRequestIdDocumentTypeEnum_DRIVING_LICENCE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SigningIdentityRequestIdDocumentTypeEnum unknownDefaultOpenApi = _$signingIdentityRequestIdDocumentTypeEnum_unknownDefaultOpenApi;

  static Serializer<SigningIdentityRequestIdDocumentTypeEnum> get serializer => _$signingIdentityRequestIdDocumentTypeEnumSerializer;

  const SigningIdentityRequestIdDocumentTypeEnum._(String name): super(name);

  static BuiltSet<SigningIdentityRequestIdDocumentTypeEnum> get values => _$signingIdentityRequestIdDocumentTypeEnumValues;
  static SigningIdentityRequestIdDocumentTypeEnum valueOf(String name) => _$signingIdentityRequestIdDocumentTypeEnumValueOf(name);
}

