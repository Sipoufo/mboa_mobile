//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'kyc_corrections.g.dart';

/// KycCorrections
///
/// Properties:
/// * [idDocumentType] 
/// * [idNumber] 
/// * [issuedOn] 
/// * [expiresOn] 
/// * [issuedAt] 
@BuiltValue()
abstract class KycCorrections implements Built<KycCorrections, KycCorrectionsBuilder> {
  @BuiltValueField(wireName: r'idDocumentType')
  KycCorrectionsIdDocumentTypeEnum? get idDocumentType;
  // enum idDocumentTypeEnum {  CNI,  PASSPORT,  DRIVING_LICENCE,  };

  @BuiltValueField(wireName: r'idNumber')
  String? get idNumber;

  @BuiltValueField(wireName: r'issuedOn')
  Date? get issuedOn;

  @BuiltValueField(wireName: r'expiresOn')
  Date? get expiresOn;

  @BuiltValueField(wireName: r'issuedAt')
  String? get issuedAt;

  KycCorrections._();

  factory KycCorrections([void updates(KycCorrectionsBuilder b)]) = _$KycCorrections;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KycCorrectionsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KycCorrections> get serializer => _$KycCorrectionsSerializer();
}

class _$KycCorrectionsSerializer implements PrimitiveSerializer<KycCorrections> {
  @override
  final Iterable<Type> types = const [KycCorrections, _$KycCorrections];

  @override
  final String wireName = r'KycCorrections';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KycCorrections object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.idDocumentType != null) {
      yield r'idDocumentType';
      yield serializers.serialize(
        object.idDocumentType,
        specifiedType: const FullType(KycCorrectionsIdDocumentTypeEnum),
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
    KycCorrections object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KycCorrectionsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'idDocumentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(KycCorrectionsIdDocumentTypeEnum),
          ) as KycCorrectionsIdDocumentTypeEnum?;
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
  KycCorrections deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KycCorrectionsBuilder();
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

class KycCorrectionsIdDocumentTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CNI')
  static const KycCorrectionsIdDocumentTypeEnum CNI = _$kycCorrectionsIdDocumentTypeEnum_CNI;
  @BuiltValueEnumConst(wireName: r'PASSPORT')
  static const KycCorrectionsIdDocumentTypeEnum PASSPORT = _$kycCorrectionsIdDocumentTypeEnum_PASSPORT;
  @BuiltValueEnumConst(wireName: r'DRIVING_LICENCE')
  static const KycCorrectionsIdDocumentTypeEnum DRIVING_LICENCE = _$kycCorrectionsIdDocumentTypeEnum_DRIVING_LICENCE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const KycCorrectionsIdDocumentTypeEnum unknownDefaultOpenApi = _$kycCorrectionsIdDocumentTypeEnum_unknownDefaultOpenApi;

  static Serializer<KycCorrectionsIdDocumentTypeEnum> get serializer => _$kycCorrectionsIdDocumentTypeEnumSerializer;

  const KycCorrectionsIdDocumentTypeEnum._(String name): super(name);

  static BuiltSet<KycCorrectionsIdDocumentTypeEnum> get values => _$kycCorrectionsIdDocumentTypeEnumValues;
  static KycCorrectionsIdDocumentTypeEnum valueOf(String name) => _$kycCorrectionsIdDocumentTypeEnumValueOf(name);
}

