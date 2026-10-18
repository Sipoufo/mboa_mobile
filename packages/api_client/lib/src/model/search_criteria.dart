//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'search_criteria.g.dart';

/// SearchCriteria
///
/// Properties:
/// * [cityId] 
/// * [districtIds] 
/// * [propertyTypes] 
/// * [rentalPeriods] 
/// * [rentMin] 
/// * [rentMax] 
/// * [roomsMin] 
/// * [surfaceMin] 
/// * [surfaceMax] 
/// * [furnished] 
/// * [availableNow] 
/// * [badges] 
/// * [amenities] 
@BuiltValue()
abstract class SearchCriteria implements Built<SearchCriteria, SearchCriteriaBuilder> {
  @BuiltValueField(wireName: r'cityId')
  String? get cityId;

  @BuiltValueField(wireName: r'districtIds')
  BuiltList<String>? get districtIds;

  @BuiltValueField(wireName: r'propertyTypes')
  BuiltList<SearchCriteriaPropertyTypesEnum>? get propertyTypes;
  // enum propertyTypesEnum {  APARTMENT,  STUDIO,  VILLA,  ROOM,  OFFICE,  COMMERCIAL_SPACE,  };

  @BuiltValueField(wireName: r'rentalPeriods')
  BuiltList<SearchCriteriaRentalPeriodsEnum>? get rentalPeriods;
  // enum rentalPeriodsEnum {  DAY,  WEEK,  MONTH,  QUARTER,  YEAR,  };

  @BuiltValueField(wireName: r'rentMin')
  int? get rentMin;

  @BuiltValueField(wireName: r'rentMax')
  int? get rentMax;

  @BuiltValueField(wireName: r'roomsMin')
  int? get roomsMin;

  @BuiltValueField(wireName: r'surfaceMin')
  int? get surfaceMin;

  @BuiltValueField(wireName: r'surfaceMax')
  int? get surfaceMax;

  @BuiltValueField(wireName: r'furnished')
  bool? get furnished;

  @BuiltValueField(wireName: r'availableNow')
  bool? get availableNow;

  @BuiltValueField(wireName: r'badges')
  BuiltList<SearchCriteriaBadgesEnum>? get badges;
  // enum badgesEnum {  TRUSTED,  RECERTIFIED,  IDENTITY_VERIFIED,  PHOTOS_VERIFIED,  };

  @BuiltValueField(wireName: r'amenities')
  BuiltList<SearchCriteriaAmenitiesEnum>? get amenities;
  // enum amenitiesEnum {  AIR_CONDITIONING,  HOT_WATER,  GENERATOR,  SECURITY_GUARD,  PARKING,  WIFI,  };

  SearchCriteria._();

  factory SearchCriteria([void updates(SearchCriteriaBuilder b)]) = _$SearchCriteria;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SearchCriteriaBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SearchCriteria> get serializer => _$SearchCriteriaSerializer();
}

class _$SearchCriteriaSerializer implements PrimitiveSerializer<SearchCriteria> {
  @override
  final Iterable<Type> types = const [SearchCriteria, _$SearchCriteria];

  @override
  final String wireName = r'SearchCriteria';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SearchCriteria object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.cityId != null) {
      yield r'cityId';
      yield serializers.serialize(
        object.cityId,
        specifiedType: const FullType(String),
      );
    }
    if (object.districtIds != null) {
      yield r'districtIds';
      yield serializers.serialize(
        object.districtIds,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.propertyTypes != null) {
      yield r'propertyTypes';
      yield serializers.serialize(
        object.propertyTypes,
        specifiedType: const FullType(BuiltList, [FullType(SearchCriteriaPropertyTypesEnum)]),
      );
    }
    if (object.rentalPeriods != null) {
      yield r'rentalPeriods';
      yield serializers.serialize(
        object.rentalPeriods,
        specifiedType: const FullType(BuiltList, [FullType(SearchCriteriaRentalPeriodsEnum)]),
      );
    }
    if (object.rentMin != null) {
      yield r'rentMin';
      yield serializers.serialize(
        object.rentMin,
        specifiedType: const FullType(int),
      );
    }
    if (object.rentMax != null) {
      yield r'rentMax';
      yield serializers.serialize(
        object.rentMax,
        specifiedType: const FullType(int),
      );
    }
    if (object.roomsMin != null) {
      yield r'roomsMin';
      yield serializers.serialize(
        object.roomsMin,
        specifiedType: const FullType(int),
      );
    }
    if (object.surfaceMin != null) {
      yield r'surfaceMin';
      yield serializers.serialize(
        object.surfaceMin,
        specifiedType: const FullType(int),
      );
    }
    if (object.surfaceMax != null) {
      yield r'surfaceMax';
      yield serializers.serialize(
        object.surfaceMax,
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
    if (object.availableNow != null) {
      yield r'availableNow';
      yield serializers.serialize(
        object.availableNow,
        specifiedType: const FullType(bool),
      );
    }
    if (object.badges != null) {
      yield r'badges';
      yield serializers.serialize(
        object.badges,
        specifiedType: const FullType(BuiltList, [FullType(SearchCriteriaBadgesEnum)]),
      );
    }
    if (object.amenities != null) {
      yield r'amenities';
      yield serializers.serialize(
        object.amenities,
        specifiedType: const FullType(BuiltList, [FullType(SearchCriteriaAmenitiesEnum)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SearchCriteria object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SearchCriteriaBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'cityId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.cityId = valueDes;
          break;
        case r'districtIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.districtIds.replace(valueDes);
          break;
        case r'propertyTypes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SearchCriteriaPropertyTypesEnum)]),
          ) as BuiltList<SearchCriteriaPropertyTypesEnum>?;
          if (valueDes == null) continue;
          result.propertyTypes.replace(valueDes);
          break;
        case r'rentalPeriods':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SearchCriteriaRentalPeriodsEnum)]),
          ) as BuiltList<SearchCriteriaRentalPeriodsEnum>?;
          if (valueDes == null) continue;
          result.rentalPeriods.replace(valueDes);
          break;
        case r'rentMin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.rentMin = valueDes;
          break;
        case r'rentMax':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.rentMax = valueDes;
          break;
        case r'roomsMin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.roomsMin = valueDes;
          break;
        case r'surfaceMin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.surfaceMin = valueDes;
          break;
        case r'surfaceMax':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.surfaceMax = valueDes;
          break;
        case r'furnished':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.furnished = valueDes;
          break;
        case r'availableNow':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.availableNow = valueDes;
          break;
        case r'badges':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SearchCriteriaBadgesEnum)]),
          ) as BuiltList<SearchCriteriaBadgesEnum>?;
          if (valueDes == null) continue;
          result.badges.replace(valueDes);
          break;
        case r'amenities':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SearchCriteriaAmenitiesEnum)]),
          ) as BuiltList<SearchCriteriaAmenitiesEnum>?;
          if (valueDes == null) continue;
          result.amenities.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SearchCriteria deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SearchCriteriaBuilder();
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

class SearchCriteriaPropertyTypesEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'APARTMENT')
  static const SearchCriteriaPropertyTypesEnum APARTMENT = _$searchCriteriaPropertyTypesEnum_APARTMENT;
  @BuiltValueEnumConst(wireName: r'STUDIO')
  static const SearchCriteriaPropertyTypesEnum STUDIO = _$searchCriteriaPropertyTypesEnum_STUDIO;
  @BuiltValueEnumConst(wireName: r'VILLA')
  static const SearchCriteriaPropertyTypesEnum VILLA = _$searchCriteriaPropertyTypesEnum_VILLA;
  @BuiltValueEnumConst(wireName: r'ROOM')
  static const SearchCriteriaPropertyTypesEnum ROOM = _$searchCriteriaPropertyTypesEnum_ROOM;
  @BuiltValueEnumConst(wireName: r'OFFICE')
  static const SearchCriteriaPropertyTypesEnum OFFICE = _$searchCriteriaPropertyTypesEnum_OFFICE;
  @BuiltValueEnumConst(wireName: r'COMMERCIAL_SPACE')
  static const SearchCriteriaPropertyTypesEnum COMMERCIAL_SPACE = _$searchCriteriaPropertyTypesEnum_COMMERCIAL_SPACE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SearchCriteriaPropertyTypesEnum unknownDefaultOpenApi = _$searchCriteriaPropertyTypesEnum_unknownDefaultOpenApi;

  static Serializer<SearchCriteriaPropertyTypesEnum> get serializer => _$searchCriteriaPropertyTypesEnumSerializer;

  const SearchCriteriaPropertyTypesEnum._(String name): super(name);

  static BuiltSet<SearchCriteriaPropertyTypesEnum> get values => _$searchCriteriaPropertyTypesEnumValues;
  static SearchCriteriaPropertyTypesEnum valueOf(String name) => _$searchCriteriaPropertyTypesEnumValueOf(name);
}

class SearchCriteriaRentalPeriodsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DAY')
  static const SearchCriteriaRentalPeriodsEnum DAY = _$searchCriteriaRentalPeriodsEnum_DAY;
  @BuiltValueEnumConst(wireName: r'WEEK')
  static const SearchCriteriaRentalPeriodsEnum WEEK = _$searchCriteriaRentalPeriodsEnum_WEEK;
  @BuiltValueEnumConst(wireName: r'MONTH')
  static const SearchCriteriaRentalPeriodsEnum MONTH = _$searchCriteriaRentalPeriodsEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const SearchCriteriaRentalPeriodsEnum QUARTER = _$searchCriteriaRentalPeriodsEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const SearchCriteriaRentalPeriodsEnum YEAR = _$searchCriteriaRentalPeriodsEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SearchCriteriaRentalPeriodsEnum unknownDefaultOpenApi = _$searchCriteriaRentalPeriodsEnum_unknownDefaultOpenApi;

  static Serializer<SearchCriteriaRentalPeriodsEnum> get serializer => _$searchCriteriaRentalPeriodsEnumSerializer;

  const SearchCriteriaRentalPeriodsEnum._(String name): super(name);

  static BuiltSet<SearchCriteriaRentalPeriodsEnum> get values => _$searchCriteriaRentalPeriodsEnumValues;
  static SearchCriteriaRentalPeriodsEnum valueOf(String name) => _$searchCriteriaRentalPeriodsEnumValueOf(name);
}

class SearchCriteriaBadgesEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'TRUSTED')
  static const SearchCriteriaBadgesEnum TRUSTED = _$searchCriteriaBadgesEnum_TRUSTED;
  @BuiltValueEnumConst(wireName: r'RECERTIFIED')
  static const SearchCriteriaBadgesEnum RECERTIFIED = _$searchCriteriaBadgesEnum_RECERTIFIED;
  @BuiltValueEnumConst(wireName: r'IDENTITY_VERIFIED')
  static const SearchCriteriaBadgesEnum IDENTITY_VERIFIED = _$searchCriteriaBadgesEnum_IDENTITY_VERIFIED;
  @BuiltValueEnumConst(wireName: r'PHOTOS_VERIFIED')
  static const SearchCriteriaBadgesEnum PHOTOS_VERIFIED = _$searchCriteriaBadgesEnum_PHOTOS_VERIFIED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SearchCriteriaBadgesEnum unknownDefaultOpenApi = _$searchCriteriaBadgesEnum_unknownDefaultOpenApi;

  static Serializer<SearchCriteriaBadgesEnum> get serializer => _$searchCriteriaBadgesEnumSerializer;

  const SearchCriteriaBadgesEnum._(String name): super(name);

  static BuiltSet<SearchCriteriaBadgesEnum> get values => _$searchCriteriaBadgesEnumValues;
  static SearchCriteriaBadgesEnum valueOf(String name) => _$searchCriteriaBadgesEnumValueOf(name);
}

class SearchCriteriaAmenitiesEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'AIR_CONDITIONING')
  static const SearchCriteriaAmenitiesEnum AIR_CONDITIONING = _$searchCriteriaAmenitiesEnum_AIR_CONDITIONING;
  @BuiltValueEnumConst(wireName: r'HOT_WATER')
  static const SearchCriteriaAmenitiesEnum HOT_WATER = _$searchCriteriaAmenitiesEnum_HOT_WATER;
  @BuiltValueEnumConst(wireName: r'GENERATOR')
  static const SearchCriteriaAmenitiesEnum GENERATOR = _$searchCriteriaAmenitiesEnum_GENERATOR;
  @BuiltValueEnumConst(wireName: r'SECURITY_GUARD')
  static const SearchCriteriaAmenitiesEnum SECURITY_GUARD = _$searchCriteriaAmenitiesEnum_SECURITY_GUARD;
  @BuiltValueEnumConst(wireName: r'PARKING')
  static const SearchCriteriaAmenitiesEnum PARKING = _$searchCriteriaAmenitiesEnum_PARKING;
  @BuiltValueEnumConst(wireName: r'WIFI')
  static const SearchCriteriaAmenitiesEnum WIFI = _$searchCriteriaAmenitiesEnum_WIFI;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SearchCriteriaAmenitiesEnum unknownDefaultOpenApi = _$searchCriteriaAmenitiesEnum_unknownDefaultOpenApi;

  static Serializer<SearchCriteriaAmenitiesEnum> get serializer => _$searchCriteriaAmenitiesEnumSerializer;

  const SearchCriteriaAmenitiesEnum._(String name): super(name);

  static BuiltSet<SearchCriteriaAmenitiesEnum> get values => _$searchCriteriaAmenitiesEnumValues;
  static SearchCriteriaAmenitiesEnum valueOf(String name) => _$searchCriteriaAmenitiesEnumValueOf(name);
}

