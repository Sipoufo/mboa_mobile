//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_annonce_request.g.dart';

/// CreateAnnonceRequest
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
abstract class CreateAnnonceRequest implements Built<CreateAnnonceRequest, CreateAnnonceRequestBuilder> {
  @BuiltValueField(wireName: r'propertyType')
  CreateAnnonceRequestPropertyTypeEnum get propertyType;
  // enum propertyTypeEnum {  APARTMENT,  STUDIO,  VILLA,  ROOM,  OFFICE,  COMMERCIAL_SPACE,  };

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'districtId')
  String get districtId;

  @BuiltValueField(wireName: r'exactAddress')
  String get exactAddress;

  @BuiltValueField(wireName: r'latitude')
  double get latitude;

  @BuiltValueField(wireName: r'longitude')
  double get longitude;

  @BuiltValueField(wireName: r'price')
  int? get price;

  @BuiltValueField(wireName: r'rentalPeriod')
  CreateAnnonceRequestRentalPeriodEnum? get rentalPeriod;
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
  Date get availableFrom;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'photoKeys')
  BuiltList<String>? get photoKeys;

  @BuiltValueField(wireName: r'amenities')
  BuiltSet<CreateAnnonceRequestAmenitiesEnum>? get amenities;
  // enum amenitiesEnum {  AIR_CONDITIONING,  HOT_WATER,  GENERATOR,  SECURITY_GUARD,  PARKING,  WIFI,  };

  CreateAnnonceRequest._();

  factory CreateAnnonceRequest([void updates(CreateAnnonceRequestBuilder b)]) = _$CreateAnnonceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateAnnonceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateAnnonceRequest> get serializer => _$CreateAnnonceRequestSerializer();
}

class _$CreateAnnonceRequestSerializer implements PrimitiveSerializer<CreateAnnonceRequest> {
  @override
  final Iterable<Type> types = const [CreateAnnonceRequest, _$CreateAnnonceRequest];

  @override
  final String wireName = r'CreateAnnonceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateAnnonceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'propertyType';
    yield serializers.serialize(
      object.propertyType,
      specifiedType: const FullType(CreateAnnonceRequestPropertyTypeEnum),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'districtId';
    yield serializers.serialize(
      object.districtId,
      specifiedType: const FullType(String),
    );
    yield r'exactAddress';
    yield serializers.serialize(
      object.exactAddress,
      specifiedType: const FullType(String),
    );
    yield r'latitude';
    yield serializers.serialize(
      object.latitude,
      specifiedType: const FullType(double),
    );
    yield r'longitude';
    yield serializers.serialize(
      object.longitude,
      specifiedType: const FullType(double),
    );
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
        specifiedType: const FullType(CreateAnnonceRequestRentalPeriodEnum),
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
    yield r'availableFrom';
    yield serializers.serialize(
      object.availableFrom,
      specifiedType: const FullType(Date),
    );
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
        specifiedType: const FullType(BuiltSet, [FullType(CreateAnnonceRequestAmenitiesEnum)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateAnnonceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateAnnonceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'propertyType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateAnnonceRequestPropertyTypeEnum),
          ) as CreateAnnonceRequestPropertyTypeEnum;
          result.propertyType = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'districtId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.districtId = valueDes;
          break;
        case r'exactAddress':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.exactAddress = valueDes;
          break;
        case r'latitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.latitude = valueDes;
          break;
        case r'longitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
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
            specifiedType: const FullType.nullable(CreateAnnonceRequestRentalPeriodEnum),
          ) as CreateAnnonceRequestRentalPeriodEnum?;
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
            specifiedType: const FullType(Date),
          ) as Date;
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
            specifiedType: const FullType.nullable(BuiltSet, [FullType(CreateAnnonceRequestAmenitiesEnum)]),
          ) as BuiltSet<CreateAnnonceRequestAmenitiesEnum>?;
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
  CreateAnnonceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateAnnonceRequestBuilder();
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

class CreateAnnonceRequestPropertyTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'APARTMENT')
  static const CreateAnnonceRequestPropertyTypeEnum APARTMENT = _$createAnnonceRequestPropertyTypeEnum_APARTMENT;
  @BuiltValueEnumConst(wireName: r'STUDIO')
  static const CreateAnnonceRequestPropertyTypeEnum STUDIO = _$createAnnonceRequestPropertyTypeEnum_STUDIO;
  @BuiltValueEnumConst(wireName: r'VILLA')
  static const CreateAnnonceRequestPropertyTypeEnum VILLA = _$createAnnonceRequestPropertyTypeEnum_VILLA;
  @BuiltValueEnumConst(wireName: r'ROOM')
  static const CreateAnnonceRequestPropertyTypeEnum ROOM = _$createAnnonceRequestPropertyTypeEnum_ROOM;
  @BuiltValueEnumConst(wireName: r'OFFICE')
  static const CreateAnnonceRequestPropertyTypeEnum OFFICE = _$createAnnonceRequestPropertyTypeEnum_OFFICE;
  @BuiltValueEnumConst(wireName: r'COMMERCIAL_SPACE')
  static const CreateAnnonceRequestPropertyTypeEnum COMMERCIAL_SPACE = _$createAnnonceRequestPropertyTypeEnum_COMMERCIAL_SPACE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateAnnonceRequestPropertyTypeEnum unknownDefaultOpenApi = _$createAnnonceRequestPropertyTypeEnum_unknownDefaultOpenApi;

  static Serializer<CreateAnnonceRequestPropertyTypeEnum> get serializer => _$createAnnonceRequestPropertyTypeEnumSerializer;

  const CreateAnnonceRequestPropertyTypeEnum._(String name): super(name);

  static BuiltSet<CreateAnnonceRequestPropertyTypeEnum> get values => _$createAnnonceRequestPropertyTypeEnumValues;
  static CreateAnnonceRequestPropertyTypeEnum valueOf(String name) => _$createAnnonceRequestPropertyTypeEnumValueOf(name);
}

class CreateAnnonceRequestRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MONTH')
  static const CreateAnnonceRequestRentalPeriodEnum MONTH = _$createAnnonceRequestRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const CreateAnnonceRequestRentalPeriodEnum QUARTER = _$createAnnonceRequestRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const CreateAnnonceRequestRentalPeriodEnum YEAR = _$createAnnonceRequestRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateAnnonceRequestRentalPeriodEnum unknownDefaultOpenApi = _$createAnnonceRequestRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<CreateAnnonceRequestRentalPeriodEnum> get serializer => _$createAnnonceRequestRentalPeriodEnumSerializer;

  const CreateAnnonceRequestRentalPeriodEnum._(String name): super(name);

  static BuiltSet<CreateAnnonceRequestRentalPeriodEnum> get values => _$createAnnonceRequestRentalPeriodEnumValues;
  static CreateAnnonceRequestRentalPeriodEnum valueOf(String name) => _$createAnnonceRequestRentalPeriodEnumValueOf(name);
}

class CreateAnnonceRequestAmenitiesEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'AIR_CONDITIONING')
  static const CreateAnnonceRequestAmenitiesEnum AIR_CONDITIONING = _$createAnnonceRequestAmenitiesEnum_AIR_CONDITIONING;
  @BuiltValueEnumConst(wireName: r'HOT_WATER')
  static const CreateAnnonceRequestAmenitiesEnum HOT_WATER = _$createAnnonceRequestAmenitiesEnum_HOT_WATER;
  @BuiltValueEnumConst(wireName: r'GENERATOR')
  static const CreateAnnonceRequestAmenitiesEnum GENERATOR = _$createAnnonceRequestAmenitiesEnum_GENERATOR;
  @BuiltValueEnumConst(wireName: r'SECURITY_GUARD')
  static const CreateAnnonceRequestAmenitiesEnum SECURITY_GUARD = _$createAnnonceRequestAmenitiesEnum_SECURITY_GUARD;
  @BuiltValueEnumConst(wireName: r'PARKING')
  static const CreateAnnonceRequestAmenitiesEnum PARKING = _$createAnnonceRequestAmenitiesEnum_PARKING;
  @BuiltValueEnumConst(wireName: r'WIFI')
  static const CreateAnnonceRequestAmenitiesEnum WIFI = _$createAnnonceRequestAmenitiesEnum_WIFI;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateAnnonceRequestAmenitiesEnum unknownDefaultOpenApi = _$createAnnonceRequestAmenitiesEnum_unknownDefaultOpenApi;

  static Serializer<CreateAnnonceRequestAmenitiesEnum> get serializer => _$createAnnonceRequestAmenitiesEnumSerializer;

  const CreateAnnonceRequestAmenitiesEnum._(String name): super(name);

  static BuiltSet<CreateAnnonceRequestAmenitiesEnum> get values => _$createAnnonceRequestAmenitiesEnumValues;
  static CreateAnnonceRequestAmenitiesEnum valueOf(String name) => _$createAnnonceRequestAmenitiesEnumValueOf(name);
}

