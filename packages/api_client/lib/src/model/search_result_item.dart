//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'search_result_item.g.dart';

/// SearchResultItem
///
/// Properties:
/// * [id] 
/// * [title] 
/// * [propertyType] 
/// * [city] 
/// * [district] 
/// * [monthlyRent] 
/// * [furnished] 
/// * [roomCount] 
/// * [surfaceArea] 
/// * [primaryPhotoKey] 
/// * [status] 
/// * [tierRank] 
/// * [latitude] 
/// * [longitude] 
/// * [availableFrom] 
@BuiltValue()
abstract class SearchResultItem implements Built<SearchResultItem, SearchResultItemBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'propertyType')
  SearchResultItemPropertyTypeEnum? get propertyType;
  // enum propertyTypeEnum {  APARTMENT,  STUDIO,  VILLA,  ROOM,  OFFICE,  COMMERCIAL_SPACE,  };

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'district')
  String? get district;

  @BuiltValueField(wireName: r'monthlyRent')
  int? get monthlyRent;

  @BuiltValueField(wireName: r'furnished')
  bool? get furnished;

  @BuiltValueField(wireName: r'roomCount')
  int? get roomCount;

  @BuiltValueField(wireName: r'surfaceArea')
  int? get surfaceArea;

  @BuiltValueField(wireName: r'primaryPhotoKey')
  String? get primaryPhotoKey;

  @BuiltValueField(wireName: r'status')
  SearchResultItemStatusEnum? get status;
  // enum statusEnum {  DRAFT,  PUBLISHED,  RESERVED,  RENTED,  ARCHIVED,  };

  @BuiltValueField(wireName: r'tierRank')
  int? get tierRank;

  @BuiltValueField(wireName: r'latitude')
  double? get latitude;

  @BuiltValueField(wireName: r'longitude')
  double? get longitude;

  @BuiltValueField(wireName: r'availableFrom')
  Date? get availableFrom;

  SearchResultItem._();

  factory SearchResultItem([void updates(SearchResultItemBuilder b)]) = _$SearchResultItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SearchResultItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SearchResultItem> get serializer => _$SearchResultItemSerializer();
}

class _$SearchResultItemSerializer implements PrimitiveSerializer<SearchResultItem> {
  @override
  final Iterable<Type> types = const [SearchResultItem, _$SearchResultItem];

  @override
  final String wireName = r'SearchResultItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SearchResultItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
    if (object.propertyType != null) {
      yield r'propertyType';
      yield serializers.serialize(
        object.propertyType,
        specifiedType: const FullType(SearchResultItemPropertyTypeEnum),
      );
    }
    if (object.city != null) {
      yield r'city';
      yield serializers.serialize(
        object.city,
        specifiedType: const FullType(String),
      );
    }
    if (object.district != null) {
      yield r'district';
      yield serializers.serialize(
        object.district,
        specifiedType: const FullType(String),
      );
    }
    if (object.monthlyRent != null) {
      yield r'monthlyRent';
      yield serializers.serialize(
        object.monthlyRent,
        specifiedType: const FullType(int),
      );
    }
    if (object.furnished != null) {
      yield r'furnished';
      yield serializers.serialize(
        object.furnished,
        specifiedType: const FullType(bool),
      );
    }
    if (object.roomCount != null) {
      yield r'roomCount';
      yield serializers.serialize(
        object.roomCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.surfaceArea != null) {
      yield r'surfaceArea';
      yield serializers.serialize(
        object.surfaceArea,
        specifiedType: const FullType(int),
      );
    }
    if (object.primaryPhotoKey != null) {
      yield r'primaryPhotoKey';
      yield serializers.serialize(
        object.primaryPhotoKey,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(SearchResultItemStatusEnum),
      );
    }
    if (object.tierRank != null) {
      yield r'tierRank';
      yield serializers.serialize(
        object.tierRank,
        specifiedType: const FullType(int),
      );
    }
    if (object.latitude != null) {
      yield r'latitude';
      yield serializers.serialize(
        object.latitude,
        specifiedType: const FullType(double),
      );
    }
    if (object.longitude != null) {
      yield r'longitude';
      yield serializers.serialize(
        object.longitude,
        specifiedType: const FullType(double),
      );
    }
    if (object.availableFrom != null) {
      yield r'availableFrom';
      yield serializers.serialize(
        object.availableFrom,
        specifiedType: const FullType(Date),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SearchResultItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SearchResultItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.id = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'propertyType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SearchResultItemPropertyTypeEnum),
          ) as SearchResultItemPropertyTypeEnum?;
          if (valueDes == null) continue;
          result.propertyType = valueDes;
          break;
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.city = valueDes;
          break;
        case r'district':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.district = valueDes;
          break;
        case r'monthlyRent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.monthlyRent = valueDes;
          break;
        case r'furnished':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.furnished = valueDes;
          break;
        case r'roomCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.roomCount = valueDes;
          break;
        case r'surfaceArea':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.surfaceArea = valueDes;
          break;
        case r'primaryPhotoKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.primaryPhotoKey = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SearchResultItemStatusEnum),
          ) as SearchResultItemStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'tierRank':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.tierRank = valueDes;
          break;
        case r'latitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.latitude = valueDes;
          break;
        case r'longitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.longitude = valueDes;
          break;
        case r'availableFrom':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.availableFrom = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SearchResultItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SearchResultItemBuilder();
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

class SearchResultItemPropertyTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'APARTMENT')
  static const SearchResultItemPropertyTypeEnum APARTMENT = _$searchResultItemPropertyTypeEnum_APARTMENT;
  @BuiltValueEnumConst(wireName: r'STUDIO')
  static const SearchResultItemPropertyTypeEnum STUDIO = _$searchResultItemPropertyTypeEnum_STUDIO;
  @BuiltValueEnumConst(wireName: r'VILLA')
  static const SearchResultItemPropertyTypeEnum VILLA = _$searchResultItemPropertyTypeEnum_VILLA;
  @BuiltValueEnumConst(wireName: r'ROOM')
  static const SearchResultItemPropertyTypeEnum ROOM = _$searchResultItemPropertyTypeEnum_ROOM;
  @BuiltValueEnumConst(wireName: r'OFFICE')
  static const SearchResultItemPropertyTypeEnum OFFICE = _$searchResultItemPropertyTypeEnum_OFFICE;
  @BuiltValueEnumConst(wireName: r'COMMERCIAL_SPACE')
  static const SearchResultItemPropertyTypeEnum COMMERCIAL_SPACE = _$searchResultItemPropertyTypeEnum_COMMERCIAL_SPACE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SearchResultItemPropertyTypeEnum unknownDefaultOpenApi = _$searchResultItemPropertyTypeEnum_unknownDefaultOpenApi;

  static Serializer<SearchResultItemPropertyTypeEnum> get serializer => _$searchResultItemPropertyTypeEnumSerializer;

  const SearchResultItemPropertyTypeEnum._(String name): super(name);

  static BuiltSet<SearchResultItemPropertyTypeEnum> get values => _$searchResultItemPropertyTypeEnumValues;
  static SearchResultItemPropertyTypeEnum valueOf(String name) => _$searchResultItemPropertyTypeEnumValueOf(name);
}

class SearchResultItemStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DRAFT')
  static const SearchResultItemStatusEnum DRAFT = _$searchResultItemStatusEnum_DRAFT;
  @BuiltValueEnumConst(wireName: r'PUBLISHED')
  static const SearchResultItemStatusEnum PUBLISHED = _$searchResultItemStatusEnum_PUBLISHED;
  @BuiltValueEnumConst(wireName: r'RESERVED')
  static const SearchResultItemStatusEnum RESERVED = _$searchResultItemStatusEnum_RESERVED;
  @BuiltValueEnumConst(wireName: r'RENTED')
  static const SearchResultItemStatusEnum RENTED = _$searchResultItemStatusEnum_RENTED;
  @BuiltValueEnumConst(wireName: r'ARCHIVED')
  static const SearchResultItemStatusEnum ARCHIVED = _$searchResultItemStatusEnum_ARCHIVED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SearchResultItemStatusEnum unknownDefaultOpenApi = _$searchResultItemStatusEnum_unknownDefaultOpenApi;

  static Serializer<SearchResultItemStatusEnum> get serializer => _$searchResultItemStatusEnumSerializer;

  const SearchResultItemStatusEnum._(String name): super(name);

  static BuiltSet<SearchResultItemStatusEnum> get values => _$searchResultItemStatusEnumValues;
  static SearchResultItemStatusEnum valueOf(String name) => _$searchResultItemStatusEnumValueOf(name);
}

