//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_annonce_request.g.dart';

/// UpdateAnnonceRequest
///
/// Properties:
/// * [propertyType] 
/// * [title] 
/// * [districtId] 
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
/// * [photoKeys] 
/// * [amenities] 
@BuiltValue()
abstract class UpdateAnnonceRequest implements Built<UpdateAnnonceRequest, UpdateAnnonceRequestBuilder> {
  @BuiltValueField(wireName: r'propertyType')
  UpdateAnnonceRequestPropertyTypeEnum? get propertyType;
  // enum propertyTypeEnum {  APARTMENT,  STUDIO,  VILLA,  ROOM,  OFFICE,  COMMERCIAL_SPACE,  };

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'districtId')
  String? get districtId;

  @BuiltValueField(wireName: r'exactAddress')
  String? get exactAddress;

  @BuiltValueField(wireName: r'latitude')
  double? get latitude;

  @BuiltValueField(wireName: r'longitude')
  double? get longitude;

  @BuiltValueField(wireName: r'price')
  int? get price;

  @BuiltValueField(wireName: r'rentalPeriod')
  UpdateAnnonceRequestRentalPeriodEnum? get rentalPeriod;
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

  @BuiltValueField(wireName: r'photoKeys')
  BuiltList<String>? get photoKeys;

  @BuiltValueField(wireName: r'amenities')
  BuiltSet<UpdateAnnonceRequestAmenitiesEnum>? get amenities;
  // enum amenitiesEnum {  AIR_CONDITIONING,  HOT_WATER,  GENERATOR,  SECURITY_GUARD,  PARKING,  WIFI,  };

  UpdateAnnonceRequest._();

  factory UpdateAnnonceRequest([void updates(UpdateAnnonceRequestBuilder b)]) = _$UpdateAnnonceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateAnnonceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateAnnonceRequest> get serializer => _$UpdateAnnonceRequestSerializer();
}

class _$UpdateAnnonceRequestSerializer implements PrimitiveSerializer<UpdateAnnonceRequest> {
  @override
  final Iterable<Type> types = const [UpdateAnnonceRequest, _$UpdateAnnonceRequest];

  @override
  final String wireName = r'UpdateAnnonceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateAnnonceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.propertyType != null) {
      yield r'propertyType';
      yield serializers.serialize(
        object.propertyType,
        specifiedType: const FullType(UpdateAnnonceRequestPropertyTypeEnum),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
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
        specifiedType: const FullType(UpdateAnnonceRequestRentalPeriodEnum),
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
        specifiedType: const FullType(BuiltSet, [FullType(UpdateAnnonceRequestAmenitiesEnum)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateAnnonceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateAnnonceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'propertyType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UpdateAnnonceRequestPropertyTypeEnum),
          ) as UpdateAnnonceRequestPropertyTypeEnum?;
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
        case r'districtId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.districtId = valueDes;
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
            specifiedType: const FullType.nullable(UpdateAnnonceRequestRentalPeriodEnum),
          ) as UpdateAnnonceRequestRentalPeriodEnum?;
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
            specifiedType: const FullType.nullable(BuiltSet, [FullType(UpdateAnnonceRequestAmenitiesEnum)]),
          ) as BuiltSet<UpdateAnnonceRequestAmenitiesEnum>?;
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
  UpdateAnnonceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateAnnonceRequestBuilder();
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

class UpdateAnnonceRequestPropertyTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'APARTMENT')
  static const UpdateAnnonceRequestPropertyTypeEnum APARTMENT = _$updateAnnonceRequestPropertyTypeEnum_APARTMENT;
  @BuiltValueEnumConst(wireName: r'STUDIO')
  static const UpdateAnnonceRequestPropertyTypeEnum STUDIO = _$updateAnnonceRequestPropertyTypeEnum_STUDIO;
  @BuiltValueEnumConst(wireName: r'VILLA')
  static const UpdateAnnonceRequestPropertyTypeEnum VILLA = _$updateAnnonceRequestPropertyTypeEnum_VILLA;
  @BuiltValueEnumConst(wireName: r'ROOM')
  static const UpdateAnnonceRequestPropertyTypeEnum ROOM = _$updateAnnonceRequestPropertyTypeEnum_ROOM;
  @BuiltValueEnumConst(wireName: r'OFFICE')
  static const UpdateAnnonceRequestPropertyTypeEnum OFFICE = _$updateAnnonceRequestPropertyTypeEnum_OFFICE;
  @BuiltValueEnumConst(wireName: r'COMMERCIAL_SPACE')
  static const UpdateAnnonceRequestPropertyTypeEnum COMMERCIAL_SPACE = _$updateAnnonceRequestPropertyTypeEnum_COMMERCIAL_SPACE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UpdateAnnonceRequestPropertyTypeEnum unknownDefaultOpenApi = _$updateAnnonceRequestPropertyTypeEnum_unknownDefaultOpenApi;

  static Serializer<UpdateAnnonceRequestPropertyTypeEnum> get serializer => _$updateAnnonceRequestPropertyTypeEnumSerializer;

  const UpdateAnnonceRequestPropertyTypeEnum._(String name): super(name);

  static BuiltSet<UpdateAnnonceRequestPropertyTypeEnum> get values => _$updateAnnonceRequestPropertyTypeEnumValues;
  static UpdateAnnonceRequestPropertyTypeEnum valueOf(String name) => _$updateAnnonceRequestPropertyTypeEnumValueOf(name);
}

class UpdateAnnonceRequestRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MONTH')
  static const UpdateAnnonceRequestRentalPeriodEnum MONTH = _$updateAnnonceRequestRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const UpdateAnnonceRequestRentalPeriodEnum QUARTER = _$updateAnnonceRequestRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const UpdateAnnonceRequestRentalPeriodEnum YEAR = _$updateAnnonceRequestRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UpdateAnnonceRequestRentalPeriodEnum unknownDefaultOpenApi = _$updateAnnonceRequestRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<UpdateAnnonceRequestRentalPeriodEnum> get serializer => _$updateAnnonceRequestRentalPeriodEnumSerializer;

  const UpdateAnnonceRequestRentalPeriodEnum._(String name): super(name);

  static BuiltSet<UpdateAnnonceRequestRentalPeriodEnum> get values => _$updateAnnonceRequestRentalPeriodEnumValues;
  static UpdateAnnonceRequestRentalPeriodEnum valueOf(String name) => _$updateAnnonceRequestRentalPeriodEnumValueOf(name);
}

class UpdateAnnonceRequestAmenitiesEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'AIR_CONDITIONING')
  static const UpdateAnnonceRequestAmenitiesEnum AIR_CONDITIONING = _$updateAnnonceRequestAmenitiesEnum_AIR_CONDITIONING;
  @BuiltValueEnumConst(wireName: r'HOT_WATER')
  static const UpdateAnnonceRequestAmenitiesEnum HOT_WATER = _$updateAnnonceRequestAmenitiesEnum_HOT_WATER;
  @BuiltValueEnumConst(wireName: r'GENERATOR')
  static const UpdateAnnonceRequestAmenitiesEnum GENERATOR = _$updateAnnonceRequestAmenitiesEnum_GENERATOR;
  @BuiltValueEnumConst(wireName: r'SECURITY_GUARD')
  static const UpdateAnnonceRequestAmenitiesEnum SECURITY_GUARD = _$updateAnnonceRequestAmenitiesEnum_SECURITY_GUARD;
  @BuiltValueEnumConst(wireName: r'PARKING')
  static const UpdateAnnonceRequestAmenitiesEnum PARKING = _$updateAnnonceRequestAmenitiesEnum_PARKING;
  @BuiltValueEnumConst(wireName: r'WIFI')
  static const UpdateAnnonceRequestAmenitiesEnum WIFI = _$updateAnnonceRequestAmenitiesEnum_WIFI;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UpdateAnnonceRequestAmenitiesEnum unknownDefaultOpenApi = _$updateAnnonceRequestAmenitiesEnum_unknownDefaultOpenApi;

  static Serializer<UpdateAnnonceRequestAmenitiesEnum> get serializer => _$updateAnnonceRequestAmenitiesEnumSerializer;

  const UpdateAnnonceRequestAmenitiesEnum._(String name): super(name);

  static BuiltSet<UpdateAnnonceRequestAmenitiesEnum> get values => _$updateAnnonceRequestAmenitiesEnumValues;
  static UpdateAnnonceRequestAmenitiesEnum valueOf(String name) => _$updateAnnonceRequestAmenitiesEnumValueOf(name);
}

