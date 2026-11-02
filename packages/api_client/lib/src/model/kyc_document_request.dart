//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'kyc_document_request.g.dart';

/// KycDocumentRequest
///
/// Properties:
/// * [idDocumentType] 
/// * [idNumber] 
/// * [issuedOn] 
/// * [expiresOn] 
/// * [issuedAt] 
@BuiltValue()
abstract class KycDocumentRequest implements Built<KycDocumentRequest, KycDocumentRequestBuilder> {
  @BuiltValueField(wireName: r'idDocumentType')
  KycDocumentRequestIdDocumentTypeEnum get idDocumentType;
  // enum idDocumentTypeEnum {  CNI,  PASSPORT,  DRIVING_LICENCE,  };

  @BuiltValueField(wireName: r'idNumber')
  String get idNumber;

  @BuiltValueField(wireName: r'issuedOn')
  Date get issuedOn;

  @BuiltValueField(wireName: r'expiresOn')
  Date get expiresOn;

  @BuiltValueField(wireName: r'issuedAt')
  String get issuedAt;

  KycDocumentRequest._();

  factory KycDocumentRequest([void updates(KycDocumentRequestBuilder b)]) = _$KycDocumentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KycDocumentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KycDocumentRequest> get serializer => _$KycDocumentRequestSerializer();
}

class _$KycDocumentRequestSerializer implements PrimitiveSerializer<KycDocumentRequest> {
  @override
  final Iterable<Type> types = const [KycDocumentRequest, _$KycDocumentRequest];

  @override
  final String wireName = r'KycDocumentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KycDocumentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'idDocumentType';
    yield serializers.serialize(
      object.idDocumentType,
      specifiedType: const FullType(KycDocumentRequestIdDocumentTypeEnum),
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
    KycDocumentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KycDocumentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'idDocumentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(KycDocumentRequestIdDocumentTypeEnum),
          ) as KycDocumentRequestIdDocumentTypeEnum;
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
  KycDocumentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KycDocumentRequestBuilder();
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

class KycDocumentRequestIdDocumentTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CNI')
  static const KycDocumentRequestIdDocumentTypeEnum CNI = _$kycDocumentRequestIdDocumentTypeEnum_CNI;
  @BuiltValueEnumConst(wireName: r'PASSPORT')
  static const KycDocumentRequestIdDocumentTypeEnum PASSPORT = _$kycDocumentRequestIdDocumentTypeEnum_PASSPORT;
  @BuiltValueEnumConst(wireName: r'DRIVING_LICENCE')
  static const KycDocumentRequestIdDocumentTypeEnum DRIVING_LICENCE = _$kycDocumentRequestIdDocumentTypeEnum_DRIVING_LICENCE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const KycDocumentRequestIdDocumentTypeEnum unknownDefaultOpenApi = _$kycDocumentRequestIdDocumentTypeEnum_unknownDefaultOpenApi;

  static Serializer<KycDocumentRequestIdDocumentTypeEnum> get serializer => _$kycDocumentRequestIdDocumentTypeEnumSerializer;

  const KycDocumentRequestIdDocumentTypeEnum._(String name): super(name);

  static BuiltSet<KycDocumentRequestIdDocumentTypeEnum> get values => _$kycDocumentRequestIdDocumentTypeEnumValues;
  static KycDocumentRequestIdDocumentTypeEnum valueOf(String name) => _$kycDocumentRequestIdDocumentTypeEnumValueOf(name);
}

