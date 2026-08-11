//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'annonce_response.g.dart';

/// AnnonceResponse
///
/// Properties:
/// * [id] 
/// * [residenceId] 
/// * [propertyType] 
/// * [title] 
/// * [cityId] 
/// * [city] 
/// * [districtId] 
/// * [district] 
/// * [exactAddress] 
/// * [latitude] 
/// * [longitude] 
/// * [price] 
/// * [rentalPeriod] 
/// * [monthlyRent] 
/// * [chargesIncluded] 
/// * [chargesAmount] 
/// * [surfaceArea] 
/// * [roomCount] 
/// * [bathroomCount] 
/// * [furnished] 
/// * [availableFrom] 
/// * [description] 
/// * [status] 
/// * [suspensionReason] 
/// * [tierRank] 
/// * [photoKeys] 
/// * [amenities] 
/// * [viewCount] 
/// * [publishedAt] 
/// * [expiresAt] 
/// * [createdAt] 
@BuiltValue()
abstract class AnnonceResponse implements Built<AnnonceResponse, AnnonceResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'residenceId')
  String? get residenceId;

  @BuiltValueField(wireName: r'propertyType')
  AnnonceResponsePropertyTypeEnum? get propertyType;
  // enum propertyTypeEnum {  APARTMENT,  STUDIO,  VILLA,  ROOM,  OFFICE,  COMMERCIAL_SPACE,  };

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'cityId')
  String? get cityId;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'districtId')
  String? get districtId;

  @BuiltValueField(wireName: r'district')
  String? get district;

  @BuiltValueField(wireName: r'exactAddress')
  String? get exactAddress;

  @BuiltValueField(wireName: r'latitude')
  double? get latitude;

  @BuiltValueField(wireName: r'longitude')
  double? get longitude;

  @BuiltValueField(wireName: r'price')
  int? get price;

  @BuiltValueField(wireName: r'rentalPeriod')
  AnnonceResponseRentalPeriodEnum? get rentalPeriod;
  // enum rentalPeriodEnum {  MONTH,  QUARTER,  YEAR,  };

  @BuiltValueField(wireName: r'monthlyRent')
  int? get monthlyRent;

  @BuiltValueField(wireName: r'chargesIncluded')
  bool? get chargesIncluded;

  @BuiltValueField(wireName: r'chargesAmount')
  int? get chargesAmount;

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

  @BuiltValueField(wireName: r'status')
  AnnonceResponseStatusEnum? get status;
  // enum statusEnum {  DRAFT,  PUBLISHED,  RESERVED,  RENTED,  ARCHIVED,  SUSPENDED,  };

  @BuiltValueField(wireName: r'suspensionReason')
  String? get suspensionReason;

  @BuiltValueField(wireName: r'tierRank')
  int? get tierRank;

  @BuiltValueField(wireName: r'photoKeys')
  BuiltList<String>? get photoKeys;

  @BuiltValueField(wireName: r'amenities')
  BuiltSet<AnnonceResponseAmenitiesEnum>? get amenities;
  // enum amenitiesEnum {  AIR_CONDITIONING,  HOT_WATER,  GENERATOR,  SECURITY_GUARD,  PARKING,  WIFI,  };

  @BuiltValueField(wireName: r'viewCount')
  int? get viewCount;

  @BuiltValueField(wireName: r'publishedAt')
  DateTime? get publishedAt;

  @BuiltValueField(wireName: r'expiresAt')
  DateTime? get expiresAt;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  AnnonceResponse._();

  factory AnnonceResponse([void updates(AnnonceResponseBuilder b)]) = _$AnnonceResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AnnonceResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AnnonceResponse> get serializer => _$AnnonceResponseSerializer();
}

class _$AnnonceResponseSerializer implements PrimitiveSerializer<AnnonceResponse> {
  @override
  final Iterable<Type> types = const [AnnonceResponse, _$AnnonceResponse];

  @override
  final String wireName = r'AnnonceResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AnnonceResponse object, {
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
    if (object.propertyType != null) {
      yield r'propertyType';
      yield serializers.serialize(
        object.propertyType,
        specifiedType: const FullType(AnnonceResponsePropertyTypeEnum),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.cityId != null) {
      yield r'cityId';
      yield serializers.serialize(
        object.cityId,
        specifiedType: const FullType(String),
      );
    }
    if (object.city != null) {
      yield r'city';
      yield serializers.serialize(
        object.city,
        specifiedType: const FullType(String),
      );
    }
    if (object.districtId != null) {
      yield r'districtId';
      yield serializers.serialize(
        object.districtId,
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
    if (object.exactAddress != null) {
      yield r'exactAddress';
      yield serializers.serialize(
        object.exactAddress,
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
        specifiedType: const FullType(AnnonceResponseRentalPeriodEnum),
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
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(AnnonceResponseStatusEnum),
      );
    }
    if (object.suspensionReason != null) {
      yield r'suspensionReason';
      yield serializers.serialize(
        object.suspensionReason,
        specifiedType: const FullType(String),
      );
    }
    if (object.tierRank != null) {
      yield r'tierRank';
      yield serializers.serialize(
        object.tierRank,
        specifiedType: const FullType(int),
      );
    }
    if (object.photoKeys != null) {
      yield r'photoKeys';
      yield serializers.serialize(
        object.photoKeys,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.amenities != null) {
      yield r'amenities';
      yield serializers.serialize(
        object.amenities,
        specifiedType: const FullType(BuiltSet, [FullType(AnnonceResponseAmenitiesEnum)]),
      );
    }
    if (object.viewCount != null) {
      yield r'viewCount';
      yield serializers.serialize(
        object.viewCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.publishedAt != null) {
      yield r'publishedAt';
      yield serializers.serialize(
        object.publishedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.expiresAt != null) {
      yield r'expiresAt';
      yield serializers.serialize(
        object.expiresAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AnnonceResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AnnonceResponseBuilder result,
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
        case r'propertyType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AnnonceResponsePropertyTypeEnum),
          ) as AnnonceResponsePropertyTypeEnum?;
          if (valueDes == null) continue;
          result.propertyType = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'cityId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.cityId = valueDes;
          break;
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.city = valueDes;
          break;
        case r'districtId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.districtId = valueDes;
          break;
        case r'district':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.district = valueDes;
          break;
        case r'exactAddress':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.exactAddress = valueDes;
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
            specifiedType: const FullType.nullable(AnnonceResponseRentalPeriodEnum),
          ) as AnnonceResponseRentalPeriodEnum?;
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AnnonceResponseStatusEnum),
          ) as AnnonceResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'suspensionReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.suspensionReason = valueDes;
          break;
        case r'tierRank':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.tierRank = valueDes;
          break;
        case r'photoKeys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.photoKeys.replace(valueDes);
          break;
        case r'amenities':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltSet, [FullType(AnnonceResponseAmenitiesEnum)]),
          ) as BuiltSet<AnnonceResponseAmenitiesEnum>?;
          if (valueDes == null) continue;
          result.amenities.replace(valueDes);
          break;
        case r'viewCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.viewCount = valueDes;
          break;
        case r'publishedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.publishedAt = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.expiresAt = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AnnonceResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AnnonceResponseBuilder();
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

class AnnonceResponsePropertyTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'APARTMENT')
  static const AnnonceResponsePropertyTypeEnum APARTMENT = _$annonceResponsePropertyTypeEnum_APARTMENT;
  @BuiltValueEnumConst(wireName: r'STUDIO')
  static const AnnonceResponsePropertyTypeEnum STUDIO = _$annonceResponsePropertyTypeEnum_STUDIO;
  @BuiltValueEnumConst(wireName: r'VILLA')
  static const AnnonceResponsePropertyTypeEnum VILLA = _$annonceResponsePropertyTypeEnum_VILLA;
  @BuiltValueEnumConst(wireName: r'ROOM')
  static const AnnonceResponsePropertyTypeEnum ROOM = _$annonceResponsePropertyTypeEnum_ROOM;
  @BuiltValueEnumConst(wireName: r'OFFICE')
  static const AnnonceResponsePropertyTypeEnum OFFICE = _$annonceResponsePropertyTypeEnum_OFFICE;
  @BuiltValueEnumConst(wireName: r'COMMERCIAL_SPACE')
  static const AnnonceResponsePropertyTypeEnum COMMERCIAL_SPACE = _$annonceResponsePropertyTypeEnum_COMMERCIAL_SPACE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AnnonceResponsePropertyTypeEnum unknownDefaultOpenApi = _$annonceResponsePropertyTypeEnum_unknownDefaultOpenApi;

  static Serializer<AnnonceResponsePropertyTypeEnum> get serializer => _$annonceResponsePropertyTypeEnumSerializer;

  const AnnonceResponsePropertyTypeEnum._(String name): super(name);

  static BuiltSet<AnnonceResponsePropertyTypeEnum> get values => _$annonceResponsePropertyTypeEnumValues;
  static AnnonceResponsePropertyTypeEnum valueOf(String name) => _$annonceResponsePropertyTypeEnumValueOf(name);
}

class AnnonceResponseRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MONTH')
  static const AnnonceResponseRentalPeriodEnum MONTH = _$annonceResponseRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const AnnonceResponseRentalPeriodEnum QUARTER = _$annonceResponseRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const AnnonceResponseRentalPeriodEnum YEAR = _$annonceResponseRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AnnonceResponseRentalPeriodEnum unknownDefaultOpenApi = _$annonceResponseRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<AnnonceResponseRentalPeriodEnum> get serializer => _$annonceResponseRentalPeriodEnumSerializer;

  const AnnonceResponseRentalPeriodEnum._(String name): super(name);

  static BuiltSet<AnnonceResponseRentalPeriodEnum> get values => _$annonceResponseRentalPeriodEnumValues;
  static AnnonceResponseRentalPeriodEnum valueOf(String name) => _$annonceResponseRentalPeriodEnumValueOf(name);
}

class AnnonceResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DRAFT')
  static const AnnonceResponseStatusEnum DRAFT = _$annonceResponseStatusEnum_DRAFT;
  @BuiltValueEnumConst(wireName: r'PUBLISHED')
  static const AnnonceResponseStatusEnum PUBLISHED = _$annonceResponseStatusEnum_PUBLISHED;
  @BuiltValueEnumConst(wireName: r'RESERVED')
  static const AnnonceResponseStatusEnum RESERVED = _$annonceResponseStatusEnum_RESERVED;
  @BuiltValueEnumConst(wireName: r'RENTED')
  static const AnnonceResponseStatusEnum RENTED = _$annonceResponseStatusEnum_RENTED;
  @BuiltValueEnumConst(wireName: r'ARCHIVED')
  static const AnnonceResponseStatusEnum ARCHIVED = _$annonceResponseStatusEnum_ARCHIVED;
  @BuiltValueEnumConst(wireName: r'SUSPENDED')
  static const AnnonceResponseStatusEnum SUSPENDED = _$annonceResponseStatusEnum_SUSPENDED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AnnonceResponseStatusEnum unknownDefaultOpenApi = _$annonceResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<AnnonceResponseStatusEnum> get serializer => _$annonceResponseStatusEnumSerializer;

  const AnnonceResponseStatusEnum._(String name): super(name);

  static BuiltSet<AnnonceResponseStatusEnum> get values => _$annonceResponseStatusEnumValues;
  static AnnonceResponseStatusEnum valueOf(String name) => _$annonceResponseStatusEnumValueOf(name);
}

class AnnonceResponseAmenitiesEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'AIR_CONDITIONING')
  static const AnnonceResponseAmenitiesEnum AIR_CONDITIONING = _$annonceResponseAmenitiesEnum_AIR_CONDITIONING;
  @BuiltValueEnumConst(wireName: r'HOT_WATER')
  static const AnnonceResponseAmenitiesEnum HOT_WATER = _$annonceResponseAmenitiesEnum_HOT_WATER;
  @BuiltValueEnumConst(wireName: r'GENERATOR')
  static const AnnonceResponseAmenitiesEnum GENERATOR = _$annonceResponseAmenitiesEnum_GENERATOR;
  @BuiltValueEnumConst(wireName: r'SECURITY_GUARD')
  static const AnnonceResponseAmenitiesEnum SECURITY_GUARD = _$annonceResponseAmenitiesEnum_SECURITY_GUARD;
  @BuiltValueEnumConst(wireName: r'PARKING')
  static const AnnonceResponseAmenitiesEnum PARKING = _$annonceResponseAmenitiesEnum_PARKING;
  @BuiltValueEnumConst(wireName: r'WIFI')
  static const AnnonceResponseAmenitiesEnum WIFI = _$annonceResponseAmenitiesEnum_WIFI;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AnnonceResponseAmenitiesEnum unknownDefaultOpenApi = _$annonceResponseAmenitiesEnum_unknownDefaultOpenApi;

  static Serializer<AnnonceResponseAmenitiesEnum> get serializer => _$annonceResponseAmenitiesEnumSerializer;

  const AnnonceResponseAmenitiesEnum._(String name): super(name);

  static BuiltSet<AnnonceResponseAmenitiesEnum> get values => _$annonceResponseAmenitiesEnumValues;
  static AnnonceResponseAmenitiesEnum valueOf(String name) => _$annonceResponseAmenitiesEnumValueOf(name);
}

