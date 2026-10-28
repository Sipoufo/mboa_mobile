//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'signature_identity_response.g.dart';

/// SignatureIdentityResponse
///
/// Properties:
/// * [idDocumentType] 
/// * [idNumber] 
/// * [issuedOn] 
/// * [expiresOn] 
/// * [issuedAt] 
/// * [verified] 
@BuiltValue()
abstract class SignatureIdentityResponse implements Built<SignatureIdentityResponse, SignatureIdentityResponseBuilder> {
  @BuiltValueField(wireName: r'idDocumentType')
  SignatureIdentityResponseIdDocumentTypeEnum? get idDocumentType;
  // enum idDocumentTypeEnum {  CNI,  PASSPORT,  DRIVING_LICENCE,  };

  @BuiltValueField(wireName: r'idNumber')
  String? get idNumber;

  @BuiltValueField(wireName: r'issuedOn')
  Date? get issuedOn;

  @BuiltValueField(wireName: r'expiresOn')
  Date? get expiresOn;

  @BuiltValueField(wireName: r'issuedAt')
  String? get issuedAt;

  @BuiltValueField(wireName: r'verified')
  bool? get verified;

  SignatureIdentityResponse._();

  factory SignatureIdentityResponse([void updates(SignatureIdentityResponseBuilder b)]) = _$SignatureIdentityResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SignatureIdentityResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SignatureIdentityResponse> get serializer => _$SignatureIdentityResponseSerializer();
}

class _$SignatureIdentityResponseSerializer implements PrimitiveSerializer<SignatureIdentityResponse> {
  @override
  final Iterable<Type> types = const [SignatureIdentityResponse, _$SignatureIdentityResponse];

  @override
  final String wireName = r'SignatureIdentityResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SignatureIdentityResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.idDocumentType != null) {
      yield r'idDocumentType';
      yield serializers.serialize(
        object.idDocumentType,
        specifiedType: const FullType(SignatureIdentityResponseIdDocumentTypeEnum),
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
    if (object.verified != null) {
      yield r'verified';
      yield serializers.serialize(
        object.verified,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SignatureIdentityResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SignatureIdentityResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'idDocumentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SignatureIdentityResponseIdDocumentTypeEnum),
          ) as SignatureIdentityResponseIdDocumentTypeEnum?;
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
        case r'verified':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.verified = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SignatureIdentityResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SignatureIdentityResponseBuilder();
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

class SignatureIdentityResponseIdDocumentTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CNI')
  static const SignatureIdentityResponseIdDocumentTypeEnum CNI = _$signatureIdentityResponseIdDocumentTypeEnum_CNI;
  @BuiltValueEnumConst(wireName: r'PASSPORT')
  static const SignatureIdentityResponseIdDocumentTypeEnum PASSPORT = _$signatureIdentityResponseIdDocumentTypeEnum_PASSPORT;
  @BuiltValueEnumConst(wireName: r'DRIVING_LICENCE')
  static const SignatureIdentityResponseIdDocumentTypeEnum DRIVING_LICENCE = _$signatureIdentityResponseIdDocumentTypeEnum_DRIVING_LICENCE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SignatureIdentityResponseIdDocumentTypeEnum unknownDefaultOpenApi = _$signatureIdentityResponseIdDocumentTypeEnum_unknownDefaultOpenApi;

  static Serializer<SignatureIdentityResponseIdDocumentTypeEnum> get serializer => _$signatureIdentityResponseIdDocumentTypeEnumSerializer;

  const SignatureIdentityResponseIdDocumentTypeEnum._(String name): super(name);

  static BuiltSet<SignatureIdentityResponseIdDocumentTypeEnum> get values => _$signatureIdentityResponseIdDocumentTypeEnumValues;
  static SignatureIdentityResponseIdDocumentTypeEnum valueOf(String name) => _$signatureIdentityResponseIdDocumentTypeEnumValueOf(name);
}

