//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'badge_award_response.g.dart';

/// BadgeAwardResponse
///
/// Properties:
/// * [badge] 
/// * [grantedAt] 
/// * [revokedAt] 
/// * [revokedBy] 
/// * [reason] 
@BuiltValue()
abstract class BadgeAwardResponse implements Built<BadgeAwardResponse, BadgeAwardResponseBuilder> {
  @BuiltValueField(wireName: r'badge')
  BadgeAwardResponseBadgeEnum? get badge;
  // enum badgeEnum {  TRUSTED,  RECERTIFIED,  IDENTITY_VERIFIED,  PHOTOS_VERIFIED,  };

  @BuiltValueField(wireName: r'grantedAt')
  DateTime? get grantedAt;

  @BuiltValueField(wireName: r'revokedAt')
  DateTime? get revokedAt;

  @BuiltValueField(wireName: r'revokedBy')
  String? get revokedBy;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  BadgeAwardResponse._();

  factory BadgeAwardResponse([void updates(BadgeAwardResponseBuilder b)]) = _$BadgeAwardResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BadgeAwardResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BadgeAwardResponse> get serializer => _$BadgeAwardResponseSerializer();
}

class _$BadgeAwardResponseSerializer implements PrimitiveSerializer<BadgeAwardResponse> {
  @override
  final Iterable<Type> types = const [BadgeAwardResponse, _$BadgeAwardResponse];

  @override
  final String wireName = r'BadgeAwardResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BadgeAwardResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.badge != null) {
      yield r'badge';
      yield serializers.serialize(
        object.badge,
        specifiedType: const FullType(BadgeAwardResponseBadgeEnum),
      );
    }
    if (object.grantedAt != null) {
      yield r'grantedAt';
      yield serializers.serialize(
        object.grantedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.revokedAt != null) {
      yield r'revokedAt';
      yield serializers.serialize(
        object.revokedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.revokedBy != null) {
      yield r'revokedBy';
      yield serializers.serialize(
        object.revokedBy,
        specifiedType: const FullType(String),
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
    BadgeAwardResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BadgeAwardResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'badge':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BadgeAwardResponseBadgeEnum),
          ) as BadgeAwardResponseBadgeEnum?;
          if (valueDes == null) continue;
          result.badge = valueDes;
          break;
        case r'grantedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.grantedAt = valueDes;
          break;
        case r'revokedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.revokedAt = valueDes;
          break;
        case r'revokedBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.revokedBy = valueDes;
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
  BadgeAwardResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BadgeAwardResponseBuilder();
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

class BadgeAwardResponseBadgeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'TRUSTED')
  static const BadgeAwardResponseBadgeEnum TRUSTED = _$badgeAwardResponseBadgeEnum_TRUSTED;
  @BuiltValueEnumConst(wireName: r'RECERTIFIED')
  static const BadgeAwardResponseBadgeEnum RECERTIFIED = _$badgeAwardResponseBadgeEnum_RECERTIFIED;
  @BuiltValueEnumConst(wireName: r'IDENTITY_VERIFIED')
  static const BadgeAwardResponseBadgeEnum IDENTITY_VERIFIED = _$badgeAwardResponseBadgeEnum_IDENTITY_VERIFIED;
  @BuiltValueEnumConst(wireName: r'PHOTOS_VERIFIED')
  static const BadgeAwardResponseBadgeEnum PHOTOS_VERIFIED = _$badgeAwardResponseBadgeEnum_PHOTOS_VERIFIED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BadgeAwardResponseBadgeEnum unknownDefaultOpenApi = _$badgeAwardResponseBadgeEnum_unknownDefaultOpenApi;

  static Serializer<BadgeAwardResponseBadgeEnum> get serializer => _$badgeAwardResponseBadgeEnumSerializer;

  const BadgeAwardResponseBadgeEnum._(String name): super(name);

  static BuiltSet<BadgeAwardResponseBadgeEnum> get values => _$badgeAwardResponseBadgeEnumValues;
  static BadgeAwardResponseBadgeEnum valueOf(String name) => _$badgeAwardResponseBadgeEnumValueOf(name);
}

