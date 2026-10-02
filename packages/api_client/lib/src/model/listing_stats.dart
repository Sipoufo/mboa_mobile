//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/dashboard_figures.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'listing_stats.g.dart';

/// ListingStats
///
/// Properties:
/// * [annonceId] 
/// * [title] 
/// * [status] 
/// * [figures] 
@BuiltValue()
abstract class ListingStats implements Built<ListingStats, ListingStatsBuilder> {
  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'status')
  ListingStatsStatusEnum? get status;
  // enum statusEnum {  DRAFT,  PUBLISHED,  RESERVED,  RENTED,  ARCHIVED,  SUSPENDED,  };

  @BuiltValueField(wireName: r'figures')
  DashboardFigures? get figures;

  ListingStats._();

  factory ListingStats([void updates(ListingStatsBuilder b)]) = _$ListingStats;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ListingStatsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ListingStats> get serializer => _$ListingStatsSerializer();
}

class _$ListingStatsSerializer implements PrimitiveSerializer<ListingStats> {
  @override
  final Iterable<Type> types = const [ListingStats, _$ListingStats];

  @override
  final String wireName = r'ListingStats';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ListingStats object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.annonceId != null) {
      yield r'annonceId';
      yield serializers.serialize(
        object.annonceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(ListingStatsStatusEnum),
      );
    }
    if (object.figures != null) {
      yield r'figures';
      yield serializers.serialize(
        object.figures,
        specifiedType: const FullType(DashboardFigures),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ListingStats object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ListingStatsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'annonceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.annonceId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ListingStatsStatusEnum),
          ) as ListingStatsStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'figures':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DashboardFigures),
          ) as DashboardFigures?;
          if (valueDes == null) continue;
          result.figures.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ListingStats deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListingStatsBuilder();
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

class ListingStatsStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DRAFT')
  static const ListingStatsStatusEnum DRAFT = _$listingStatsStatusEnum_DRAFT;
  @BuiltValueEnumConst(wireName: r'PUBLISHED')
  static const ListingStatsStatusEnum PUBLISHED = _$listingStatsStatusEnum_PUBLISHED;
  @BuiltValueEnumConst(wireName: r'RESERVED')
  static const ListingStatsStatusEnum RESERVED = _$listingStatsStatusEnum_RESERVED;
  @BuiltValueEnumConst(wireName: r'RENTED')
  static const ListingStatsStatusEnum RENTED = _$listingStatsStatusEnum_RENTED;
  @BuiltValueEnumConst(wireName: r'ARCHIVED')
  static const ListingStatsStatusEnum ARCHIVED = _$listingStatsStatusEnum_ARCHIVED;
  @BuiltValueEnumConst(wireName: r'SUSPENDED')
  static const ListingStatsStatusEnum SUSPENDED = _$listingStatsStatusEnum_SUSPENDED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ListingStatsStatusEnum unknownDefaultOpenApi = _$listingStatsStatusEnum_unknownDefaultOpenApi;

  static Serializer<ListingStatsStatusEnum> get serializer => _$listingStatsStatusEnumSerializer;

  const ListingStatsStatusEnum._(String name): super(name);

  static BuiltSet<ListingStatsStatusEnum> get values => _$listingStatsStatusEnumValues;
  static ListingStatsStatusEnum valueOf(String name) => _$listingStatsStatusEnumValueOf(name);
}

