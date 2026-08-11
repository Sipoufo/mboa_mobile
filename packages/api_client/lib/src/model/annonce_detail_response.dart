//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/provider_card.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'annonce_detail_response.g.dart';

/// AnnonceDetailResponse
///
/// Properties:
/// * [id] 
/// * [residenceId] 
/// * [title] 
/// * [propertyType] 
/// * [price] 
/// * [rentalPeriod] 
/// * [monthlyRent] 
/// * [chargesIncluded] 
/// * [chargesAmount] 
/// * [city] 
/// * [district] 
/// * [latitude] 
/// * [longitude] 
/// * [surfaceArea] 
/// * [roomCount] 
/// * [bathroomCount] 
/// * [furnished] 
/// * [availableFrom] 
/// * [description] 
/// * [amenities] 
/// * [photoKeys] 
/// * [status] 
/// * [provider] 
/// * [canContact] 
/// * [canPlanVisit] 
/// * [viewCount] 
@BuiltValue()
abstract class AnnonceDetailResponse implements Built<AnnonceDetailResponse, AnnonceDetailResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'residenceId')
  String? get residenceId;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'propertyType')
  AnnonceDetailResponsePropertyTypeEnum? get propertyType;
  // enum propertyTypeEnum {  APARTMENT,  STUDIO,  VILLA,  ROOM,  OFFICE,  COMMERCIAL_SPACE,  };

  @BuiltValueField(wireName: r'price')
  int? get price;

  @BuiltValueField(wireName: r'rentalPeriod')
  AnnonceDetailResponseRentalPeriodEnum? get rentalPeriod;
  // enum rentalPeriodEnum {  DAY,  WEEK,  MONTH,  QUARTER,  YEAR,  };

  @BuiltValueField(wireName: r'monthlyRent')
  int? get monthlyRent;

  @BuiltValueField(wireName: r'chargesIncluded')
  bool? get chargesIncluded;

  @BuiltValueField(wireName: r'chargesAmount')
  int? get chargesAmount;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'district')
  String? get district;

  @BuiltValueField(wireName: r'latitude')
  double? get latitude;

  @BuiltValueField(wireName: r'longitude')
  double? get longitude;

  @BuiltValueField(wireName: r'surfaceArea')
  int? get surfaceArea;

  @BuiltValueField(wireName: r'roomCount')
  int? get roomCount;

  @BuiltValueField(wireName: r'bathroomCount')
  int? get bathroomCount;

  @BuiltValueField(wireName: r'furnished')
  bool? get furnished;

  @BuiltValueField(wireName: r'availableFrom')
  Date? get availableFrom;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'amenities')
  BuiltSet<AnnonceDetailResponseAmenitiesEnum>? get amenities;
  // enum amenitiesEnum {  AIR_CONDITIONING,  HOT_WATER,  GENERATOR,  SECURITY_GUARD,  PARKING,  WIFI,  };

  @BuiltValueField(wireName: r'photoKeys')
  BuiltList<String>? get photoKeys;

  @BuiltValueField(wireName: r'status')
  AnnonceDetailResponseStatusEnum? get status;
  // enum statusEnum {  DRAFT,  PUBLISHED,  RESERVED,  RENTED,  ARCHIVED,  SUSPENDED,  };

  @BuiltValueField(wireName: r'provider')
  ProviderCard? get provider;

  @BuiltValueField(wireName: r'canContact')
  bool? get canContact;

  @BuiltValueField(wireName: r'canPlanVisit')
  bool? get canPlanVisit;

  @BuiltValueField(wireName: r'viewCount')
  int? get viewCount;

  AnnonceDetailResponse._();

  factory AnnonceDetailResponse([void updates(AnnonceDetailResponseBuilder b)]) = _$AnnonceDetailResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AnnonceDetailResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AnnonceDetailResponse> get serializer => _$AnnonceDetailResponseSerializer();
}

class _$AnnonceDetailResponseSerializer implements PrimitiveSerializer<AnnonceDetailResponse> {
  @override
  final Iterable<Type> types = const [AnnonceDetailResponse, _$AnnonceDetailResponse];

  @override
  final String wireName = r'AnnonceDetailResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AnnonceDetailResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.residenceId != null) {
      yield r'residenceId';
      yield serializers.serialize(
        object.residenceId,
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
        specifiedType: const FullType(AnnonceDetailResponsePropertyTypeEnum),
      );
    }
    if (object.price != null) {
      yield r'price';
      yield serializers.serialize(
        object.price,
        specifiedType: const FullType(int),
      );
    }
    if (object.rentalPeriod != null) {
      yield r'rentalPeriod';
      yield serializers.serialize(
        object.rentalPeriod,
        specifiedType: const FullType(AnnonceDetailResponseRentalPeriodEnum),
      );
    }
    if (object.monthlyRent != null) {
      yield r'monthlyRent';
      yield serializers.serialize(
        object.monthlyRent,
        specifiedType: const FullType(int),
      );
    }
    if (object.chargesIncluded != null) {
      yield r'chargesIncluded';
      yield serializers.serialize(
        object.chargesIncluded,
        specifiedType: const FullType(bool),
      );
    }
    if (object.chargesAmount != null) {
      yield r'chargesAmount';
      yield serializers.serialize(
        object.chargesAmount,
        specifiedType: const FullType(int),
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
    if (object.surfaceArea != null) {
      yield r'surfaceArea';
      yield serializers.serialize(
        object.surfaceArea,
        specifiedType: const FullType(int),
      );
    }
    if (object.roomCount != null) {
      yield r'roomCount';
      yield serializers.serialize(
        object.roomCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.bathroomCount != null) {
      yield r'bathroomCount';
      yield serializers.serialize(
        object.bathroomCount,
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
    if (object.availableFrom != null) {
      yield r'availableFrom';
      yield serializers.serialize(
        object.availableFrom,
        specifiedType: const FullType(Date),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.amenities != null) {
      yield r'amenities';
      yield serializers.serialize(
        object.amenities,
        specifiedType: const FullType(BuiltSet, [FullType(AnnonceDetailResponseAmenitiesEnum)]),
      );
    }
    if (object.photoKeys != null) {
      yield r'photoKeys';
      yield serializers.serialize(
        object.photoKeys,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(AnnonceDetailResponseStatusEnum),
      );
    }
    if (object.provider != null) {
      yield r'provider';
      yield serializers.serialize(
        object.provider,
        specifiedType: const FullType(ProviderCard),
      );
    }
    if (object.canContact != null) {
      yield r'canContact';
      yield serializers.serialize(
        object.canContact,
        specifiedType: const FullType(bool),
      );
    }
    if (object.canPlanVisit != null) {
      yield r'canPlanVisit';
      yield serializers.serialize(
        object.canPlanVisit,
        specifiedType: const FullType(bool),
      );
    }
    if (object.viewCount != null) {
      yield r'viewCount';
      yield serializers.serialize(
        object.viewCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AnnonceDetailResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AnnonceDetailResponseBuilder result,
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
        case r'residenceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.residenceId = valueDes;
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
            specifiedType: const FullType.nullable(AnnonceDetailResponsePropertyTypeEnum),
          ) as AnnonceDetailResponsePropertyTypeEnum?;
          if (valueDes == null) continue;
          result.propertyType = valueDes;
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.price = valueDes;
          break;
        case r'rentalPeriod':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AnnonceDetailResponseRentalPeriodEnum),
          ) as AnnonceDetailResponseRentalPeriodEnum?;
          if (valueDes == null) continue;
          result.rentalPeriod = valueDes;
          break;
        case r'monthlyRent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.monthlyRent = valueDes;
          break;
        case r'chargesIncluded':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.chargesIncluded = valueDes;
          break;
        case r'chargesAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.chargesAmount = valueDes;
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
        case r'surfaceArea':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.surfaceArea = valueDes;
          break;
        case r'roomCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.roomCount = valueDes;
          break;
        case r'bathroomCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.bathroomCount = valueDes;
          break;
        case r'furnished':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.furnished = valueDes;
          break;
        case r'availableFrom':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.availableFrom = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'amenities':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltSet, [FullType(AnnonceDetailResponseAmenitiesEnum)]),
          ) as BuiltSet<AnnonceDetailResponseAmenitiesEnum>?;
          if (valueDes == null) continue;
          result.amenities.replace(valueDes);
          break;
        case r'photoKeys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.photoKeys.replace(valueDes);
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AnnonceDetailResponseStatusEnum),
          ) as AnnonceDetailResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'provider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ProviderCard),
          ) as ProviderCard?;
          if (valueDes == null) continue;
          result.provider.replace(valueDes);
          break;
        case r'canContact':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canContact = valueDes;
          break;
        case r'canPlanVisit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canPlanVisit = valueDes;
          break;
        case r'viewCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.viewCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AnnonceDetailResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AnnonceDetailResponseBuilder();
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

class AnnonceDetailResponsePropertyTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'APARTMENT')
  static const AnnonceDetailResponsePropertyTypeEnum APARTMENT = _$annonceDetailResponsePropertyTypeEnum_APARTMENT;
  @BuiltValueEnumConst(wireName: r'STUDIO')
  static const AnnonceDetailResponsePropertyTypeEnum STUDIO = _$annonceDetailResponsePropertyTypeEnum_STUDIO;
  @BuiltValueEnumConst(wireName: r'VILLA')
  static const AnnonceDetailResponsePropertyTypeEnum VILLA = _$annonceDetailResponsePropertyTypeEnum_VILLA;
  @BuiltValueEnumConst(wireName: r'ROOM')
  static const AnnonceDetailResponsePropertyTypeEnum ROOM = _$annonceDetailResponsePropertyTypeEnum_ROOM;
  @BuiltValueEnumConst(wireName: r'OFFICE')
  static const AnnonceDetailResponsePropertyTypeEnum OFFICE = _$annonceDetailResponsePropertyTypeEnum_OFFICE;
  @BuiltValueEnumConst(wireName: r'COMMERCIAL_SPACE')
  static const AnnonceDetailResponsePropertyTypeEnum COMMERCIAL_SPACE = _$annonceDetailResponsePropertyTypeEnum_COMMERCIAL_SPACE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AnnonceDetailResponsePropertyTypeEnum unknownDefaultOpenApi = _$annonceDetailResponsePropertyTypeEnum_unknownDefaultOpenApi;

  static Serializer<AnnonceDetailResponsePropertyTypeEnum> get serializer => _$annonceDetailResponsePropertyTypeEnumSerializer;

  const AnnonceDetailResponsePropertyTypeEnum._(String name): super(name);

  static BuiltSet<AnnonceDetailResponsePropertyTypeEnum> get values => _$annonceDetailResponsePropertyTypeEnumValues;
  static AnnonceDetailResponsePropertyTypeEnum valueOf(String name) => _$annonceDetailResponsePropertyTypeEnumValueOf(name);
}

class AnnonceDetailResponseRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DAY')
  static const AnnonceDetailResponseRentalPeriodEnum DAY = _$annonceDetailResponseRentalPeriodEnum_DAY;
  @BuiltValueEnumConst(wireName: r'WEEK')
  static const AnnonceDetailResponseRentalPeriodEnum WEEK = _$annonceDetailResponseRentalPeriodEnum_WEEK;
  @BuiltValueEnumConst(wireName: r'MONTH')
  static const AnnonceDetailResponseRentalPeriodEnum MONTH = _$annonceDetailResponseRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const AnnonceDetailResponseRentalPeriodEnum QUARTER = _$annonceDetailResponseRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const AnnonceDetailResponseRentalPeriodEnum YEAR = _$annonceDetailResponseRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AnnonceDetailResponseRentalPeriodEnum unknownDefaultOpenApi = _$annonceDetailResponseRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<AnnonceDetailResponseRentalPeriodEnum> get serializer => _$annonceDetailResponseRentalPeriodEnumSerializer;

  const AnnonceDetailResponseRentalPeriodEnum._(String name): super(name);

  static BuiltSet<AnnonceDetailResponseRentalPeriodEnum> get values => _$annonceDetailResponseRentalPeriodEnumValues;
  static AnnonceDetailResponseRentalPeriodEnum valueOf(String name) => _$annonceDetailResponseRentalPeriodEnumValueOf(name);
}

class AnnonceDetailResponseAmenitiesEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'AIR_CONDITIONING')
  static const AnnonceDetailResponseAmenitiesEnum AIR_CONDITIONING = _$annonceDetailResponseAmenitiesEnum_AIR_CONDITIONING;
  @BuiltValueEnumConst(wireName: r'HOT_WATER')
  static const AnnonceDetailResponseAmenitiesEnum HOT_WATER = _$annonceDetailResponseAmenitiesEnum_HOT_WATER;
  @BuiltValueEnumConst(wireName: r'GENERATOR')
  static const AnnonceDetailResponseAmenitiesEnum GENERATOR = _$annonceDetailResponseAmenitiesEnum_GENERATOR;
  @BuiltValueEnumConst(wireName: r'SECURITY_GUARD')
  static const AnnonceDetailResponseAmenitiesEnum SECURITY_GUARD = _$annonceDetailResponseAmenitiesEnum_SECURITY_GUARD;
  @BuiltValueEnumConst(wireName: r'PARKING')
  static const AnnonceDetailResponseAmenitiesEnum PARKING = _$annonceDetailResponseAmenitiesEnum_PARKING;
  @BuiltValueEnumConst(wireName: r'WIFI')
  static const AnnonceDetailResponseAmenitiesEnum WIFI = _$annonceDetailResponseAmenitiesEnum_WIFI;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AnnonceDetailResponseAmenitiesEnum unknownDefaultOpenApi = _$annonceDetailResponseAmenitiesEnum_unknownDefaultOpenApi;

  static Serializer<AnnonceDetailResponseAmenitiesEnum> get serializer => _$annonceDetailResponseAmenitiesEnumSerializer;

  const AnnonceDetailResponseAmenitiesEnum._(String name): super(name);

  static BuiltSet<AnnonceDetailResponseAmenitiesEnum> get values => _$annonceDetailResponseAmenitiesEnumValues;
  static AnnonceDetailResponseAmenitiesEnum valueOf(String name) => _$annonceDetailResponseAmenitiesEnumValueOf(name);
}

class AnnonceDetailResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DRAFT')
  static const AnnonceDetailResponseStatusEnum DRAFT = _$annonceDetailResponseStatusEnum_DRAFT;
  @BuiltValueEnumConst(wireName: r'PUBLISHED')
  static const AnnonceDetailResponseStatusEnum PUBLISHED = _$annonceDetailResponseStatusEnum_PUBLISHED;
  @BuiltValueEnumConst(wireName: r'RESERVED')
  static const AnnonceDetailResponseStatusEnum RESERVED = _$annonceDetailResponseStatusEnum_RESERVED;
  @BuiltValueEnumConst(wireName: r'RENTED')
  static const AnnonceDetailResponseStatusEnum RENTED = _$annonceDetailResponseStatusEnum_RENTED;
  @BuiltValueEnumConst(wireName: r'ARCHIVED')
  static const AnnonceDetailResponseStatusEnum ARCHIVED = _$annonceDetailResponseStatusEnum_ARCHIVED;
  @BuiltValueEnumConst(wireName: r'SUSPENDED')
  static const AnnonceDetailResponseStatusEnum SUSPENDED = _$annonceDetailResponseStatusEnum_SUSPENDED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AnnonceDetailResponseStatusEnum unknownDefaultOpenApi = _$annonceDetailResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<AnnonceDetailResponseStatusEnum> get serializer => _$annonceDetailResponseStatusEnumSerializer;

  const AnnonceDetailResponseStatusEnum._(String name): super(name);

  static BuiltSet<AnnonceDetailResponseStatusEnum> get values => _$annonceDetailResponseStatusEnumValues;
  static AnnonceDetailResponseStatusEnum valueOf(String name) => _$annonceDetailResponseStatusEnumValueOf(name);
}

