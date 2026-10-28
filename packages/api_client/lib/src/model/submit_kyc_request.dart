//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/kyc_address_request.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'submit_kyc_request.g.dart';

/// SubmitKycRequest
///
/// Properties:
/// * [idDocumentFrontKey] 
/// * [idDocumentBackKey] 
/// * [selfieKey] 
/// * [nui] 
/// * [address] 
/// * [idDocumentType] 
/// * [idNumber] 
/// * [issuedOn] 
/// * [expiresOn] 
/// * [issuedAt] 
@BuiltValue()
abstract class SubmitKycRequest implements Built<SubmitKycRequest, SubmitKycRequestBuilder> {
  @BuiltValueField(wireName: r'idDocumentFrontKey')
  String get idDocumentFrontKey;

  @BuiltValueField(wireName: r'idDocumentBackKey')
  String? get idDocumentBackKey;

  @BuiltValueField(wireName: r'selfieKey')
  String get selfieKey;

  @BuiltValueField(wireName: r'nui')
  String? get nui;

  @BuiltValueField(wireName: r'address')
  KycAddressRequest? get address;

  @BuiltValueField(wireName: r'idDocumentType')
  SubmitKycRequestIdDocumentTypeEnum get idDocumentType;
  // enum idDocumentTypeEnum {  CNI,  PASSPORT,  DRIVING_LICENCE,  };

  @BuiltValueField(wireName: r'idNumber')
  String get idNumber;

  @BuiltValueField(wireName: r'issuedOn')
  Date get issuedOn;

  @BuiltValueField(wireName: r'expiresOn')
  Date get expiresOn;

  @BuiltValueField(wireName: r'issuedAt')
  String get issuedAt;

  SubmitKycRequest._();

  factory SubmitKycRequest([void updates(SubmitKycRequestBuilder b)]) = _$SubmitKycRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubmitKycRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubmitKycRequest> get serializer => _$SubmitKycRequestSerializer();
}

class _$SubmitKycRequestSerializer implements PrimitiveSerializer<SubmitKycRequest> {
  @override
  final Iterable<Type> types = const [SubmitKycRequest, _$SubmitKycRequest];

  @override
  final String wireName = r'SubmitKycRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubmitKycRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'idDocumentFrontKey';
    yield serializers.serialize(
      object.idDocumentFrontKey,
      specifiedType: const FullType(String),
    );
    if (object.idDocumentBackKey != null) {
      yield r'idDocumentBackKey';
      yield serializers.serialize(
        object.idDocumentBackKey,
        specifiedType: const FullType(String),
      );
    }
    yield r'selfieKey';
    yield serializers.serialize(
      object.selfieKey,
      specifiedType: const FullType(String),
    );
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
        specifiedType: const FullType(KycAddressRequest),
      );
    }
    yield r'idDocumentType';
    yield serializers.serialize(
      object.idDocumentType,
      specifiedType: const FullType(SubmitKycRequestIdDocumentTypeEnum),
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
    SubmitKycRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SubmitKycRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'idDocumentFrontKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idDocumentFrontKey = valueDes;
          break;
        case r'idDocumentBackKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.idDocumentBackKey = valueDes;
          break;
        case r'selfieKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.selfieKey = valueDes;
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
            specifiedType: const FullType.nullable(KycAddressRequest),
          ) as KycAddressRequest?;
          if (valueDes == null) continue;
          result.address.replace(valueDes);
          break;
        case r'idDocumentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SubmitKycRequestIdDocumentTypeEnum),
          ) as SubmitKycRequestIdDocumentTypeEnum;
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
  SubmitKycRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubmitKycRequestBuilder();
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

class SubmitKycRequestIdDocumentTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CNI')
  static const SubmitKycRequestIdDocumentTypeEnum CNI = _$submitKycRequestIdDocumentTypeEnum_CNI;
  @BuiltValueEnumConst(wireName: r'PASSPORT')
  static const SubmitKycRequestIdDocumentTypeEnum PASSPORT = _$submitKycRequestIdDocumentTypeEnum_PASSPORT;
  @BuiltValueEnumConst(wireName: r'DRIVING_LICENCE')
  static const SubmitKycRequestIdDocumentTypeEnum DRIVING_LICENCE = _$submitKycRequestIdDocumentTypeEnum_DRIVING_LICENCE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SubmitKycRequestIdDocumentTypeEnum unknownDefaultOpenApi = _$submitKycRequestIdDocumentTypeEnum_unknownDefaultOpenApi;

  static Serializer<SubmitKycRequestIdDocumentTypeEnum> get serializer => _$submitKycRequestIdDocumentTypeEnumSerializer;

  const SubmitKycRequestIdDocumentTypeEnum._(String name): super(name);

  static BuiltSet<SubmitKycRequestIdDocumentTypeEnum> get values => _$submitKycRequestIdDocumentTypeEnumValues;
  static SubmitKycRequestIdDocumentTypeEnum valueOf(String name) => _$submitKycRequestIdDocumentTypeEnumValueOf(name);
}

