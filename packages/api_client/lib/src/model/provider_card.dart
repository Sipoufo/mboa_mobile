//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'provider_card.g.dart';

/// ProviderCard
///
/// Properties:
/// * [accountId] 
/// * [displayName] 
/// * [logoObjectKey] 
/// * [type] 
/// * [tierRank] 
/// * [badges] 
@BuiltValue()
abstract class ProviderCard implements Built<ProviderCard, ProviderCardBuilder> {
  @BuiltValueField(wireName: r'accountId')
  String? get accountId;

  @BuiltValueField(wireName: r'displayName')
  String? get displayName;

  @BuiltValueField(wireName: r'logoObjectKey')
  String? get logoObjectKey;

  @BuiltValueField(wireName: r'type')
  ProviderCardTypeEnum? get type;
  // enum typeEnum {  PARTICULIER,  AGENCE,  PROMOTEUR,  };

  @BuiltValueField(wireName: r'tierRank')
  int? get tierRank;

  @BuiltValueField(wireName: r'badges')
  BuiltList<String>? get badges;

  ProviderCard._();

  factory ProviderCard([void updates(ProviderCardBuilder b)]) = _$ProviderCard;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProviderCardBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProviderCard> get serializer => _$ProviderCardSerializer();
}

class _$ProviderCardSerializer implements PrimitiveSerializer<ProviderCard> {
  @override
  final Iterable<Type> types = const [ProviderCard, _$ProviderCard];

  @override
  final String wireName = r'ProviderCard';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProviderCard object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.accountId != null) {
      yield r'accountId';
      yield serializers.serialize(
        object.accountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.displayName != null) {
      yield r'displayName';
      yield serializers.serialize(
        object.displayName,
        specifiedType: const FullType(String),
      );
    }
    if (object.logoObjectKey != null) {
      yield r'logoObjectKey';
      yield serializers.serialize(
        object.logoObjectKey,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(ProviderCardTypeEnum),
      );
    }
    if (object.tierRank != null) {
      yield r'tierRank';
      yield serializers.serialize(
        object.tierRank,
        specifiedType: const FullType(int),
      );
    }
    if (object.badges != null) {
      yield r'badges';
      yield serializers.serialize(
        object.badges,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ProviderCard object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProviderCardBuilder result,
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
        case r'displayName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.displayName = valueDes;
          break;
        case r'logoObjectKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.logoObjectKey = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ProviderCardTypeEnum),
          ) as ProviderCardTypeEnum?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
        case r'tierRank':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.tierRank = valueDes;
          break;
        case r'badges':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.badges.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProviderCard deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProviderCardBuilder();
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

class ProviderCardTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PARTICULIER')
  static const ProviderCardTypeEnum PARTICULIER = _$providerCardTypeEnum_PARTICULIER;
  @BuiltValueEnumConst(wireName: r'AGENCE')
  static const ProviderCardTypeEnum AGENCE = _$providerCardTypeEnum_AGENCE;
  @BuiltValueEnumConst(wireName: r'PROMOTEUR')
  static const ProviderCardTypeEnum PROMOTEUR = _$providerCardTypeEnum_PROMOTEUR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ProviderCardTypeEnum unknownDefaultOpenApi = _$providerCardTypeEnum_unknownDefaultOpenApi;

  static Serializer<ProviderCardTypeEnum> get serializer => _$providerCardTypeEnumSerializer;

  const ProviderCardTypeEnum._(String name): super(name);

  static BuiltSet<ProviderCardTypeEnum> get values => _$providerCardTypeEnumValues;
  static ProviderCardTypeEnum valueOf(String name) => _$providerCardTypeEnumValueOf(name);
}

