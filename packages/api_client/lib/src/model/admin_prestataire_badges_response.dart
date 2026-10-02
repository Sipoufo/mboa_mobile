//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/badge_award_response.dart';
import 'package:api_client/src/model/photo_verification_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_prestataire_badges_response.g.dart';

/// AdminPrestataireBadgesResponse
///
/// Properties:
/// * [accountId] 
/// * [badges] 
/// * [awards] 
/// * [verifications] 
@BuiltValue()
abstract class AdminPrestataireBadgesResponse implements Built<AdminPrestataireBadgesResponse, AdminPrestataireBadgesResponseBuilder> {
  @BuiltValueField(wireName: r'accountId')
  String? get accountId;

  @BuiltValueField(wireName: r'badges')
  BuiltList<AdminPrestataireBadgesResponseBadgesEnum>? get badges;
  // enum badgesEnum {  TRUSTED,  RECERTIFIED,  IDENTITY_VERIFIED,  PHOTOS_VERIFIED,  };

  @BuiltValueField(wireName: r'awards')
  BuiltList<BadgeAwardResponse>? get awards;

  @BuiltValueField(wireName: r'verifications')
  BuiltList<PhotoVerificationResponse>? get verifications;

  AdminPrestataireBadgesResponse._();

  factory AdminPrestataireBadgesResponse([void updates(AdminPrestataireBadgesResponseBuilder b)]) = _$AdminPrestataireBadgesResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminPrestataireBadgesResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminPrestataireBadgesResponse> get serializer => _$AdminPrestataireBadgesResponseSerializer();
}

class _$AdminPrestataireBadgesResponseSerializer implements PrimitiveSerializer<AdminPrestataireBadgesResponse> {
  @override
  final Iterable<Type> types = const [AdminPrestataireBadgesResponse, _$AdminPrestataireBadgesResponse];

  @override
  final String wireName = r'AdminPrestataireBadgesResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminPrestataireBadgesResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.accountId != null) {
      yield r'accountId';
      yield serializers.serialize(
        object.accountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.badges != null) {
      yield r'badges';
      yield serializers.serialize(
        object.badges,
        specifiedType: const FullType(BuiltList, [FullType(AdminPrestataireBadgesResponseBadgesEnum)]),
      );
    }
    if (object.awards != null) {
      yield r'awards';
      yield serializers.serialize(
        object.awards,
        specifiedType: const FullType(BuiltList, [FullType(BadgeAwardResponse)]),
      );
    }
    if (object.verifications != null) {
      yield r'verifications';
      yield serializers.serialize(
        object.verifications,
        specifiedType: const FullType(BuiltList, [FullType(PhotoVerificationResponse)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminPrestataireBadgesResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminPrestataireBadgesResponseBuilder result,
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
        case r'badges':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(AdminPrestataireBadgesResponseBadgesEnum)]),
          ) as BuiltList<AdminPrestataireBadgesResponseBadgesEnum>?;
          if (valueDes == null) continue;
          result.badges.replace(valueDes);
          break;
        case r'awards':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(BadgeAwardResponse)]),
          ) as BuiltList<BadgeAwardResponse>?;
          if (valueDes == null) continue;
          result.awards.replace(valueDes);
          break;
        case r'verifications':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(PhotoVerificationResponse)]),
          ) as BuiltList<PhotoVerificationResponse>?;
          if (valueDes == null) continue;
          result.verifications.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminPrestataireBadgesResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminPrestataireBadgesResponseBuilder();
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

class AdminPrestataireBadgesResponseBadgesEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'TRUSTED')
  static const AdminPrestataireBadgesResponseBadgesEnum TRUSTED = _$adminPrestataireBadgesResponseBadgesEnum_TRUSTED;
  @BuiltValueEnumConst(wireName: r'RECERTIFIED')
  static const AdminPrestataireBadgesResponseBadgesEnum RECERTIFIED = _$adminPrestataireBadgesResponseBadgesEnum_RECERTIFIED;
  @BuiltValueEnumConst(wireName: r'IDENTITY_VERIFIED')
  static const AdminPrestataireBadgesResponseBadgesEnum IDENTITY_VERIFIED = _$adminPrestataireBadgesResponseBadgesEnum_IDENTITY_VERIFIED;
  @BuiltValueEnumConst(wireName: r'PHOTOS_VERIFIED')
  static const AdminPrestataireBadgesResponseBadgesEnum PHOTOS_VERIFIED = _$adminPrestataireBadgesResponseBadgesEnum_PHOTOS_VERIFIED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminPrestataireBadgesResponseBadgesEnum unknownDefaultOpenApi = _$adminPrestataireBadgesResponseBadgesEnum_unknownDefaultOpenApi;

  static Serializer<AdminPrestataireBadgesResponseBadgesEnum> get serializer => _$adminPrestataireBadgesResponseBadgesEnumSerializer;

  const AdminPrestataireBadgesResponseBadgesEnum._(String name): super(name);

  static BuiltSet<AdminPrestataireBadgesResponseBadgesEnum> get values => _$adminPrestataireBadgesResponseBadgesEnumValues;
  static AdminPrestataireBadgesResponseBadgesEnum valueOf(String name) => _$adminPrestataireBadgesResponseBadgesEnumValueOf(name);
}

