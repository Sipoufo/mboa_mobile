//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/unit_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'residence_response.g.dart';

/// ResidenceResponse
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [cityId] 
/// * [city] 
/// * [districtId] 
/// * [district] 
/// * [exactAddress] 
/// * [latitude] 
/// * [longitude] 
/// * [description] 
/// * [photoKeys] 
/// * [status] 
/// * [unitCount] 
/// * [publishedUnitCount] 
/// * [draftUnitCount] 
/// * [reserveUnitCount] 
/// * [units] 
/// * [createdAt] 
@BuiltValue()
abstract class ResidenceResponse implements Built<ResidenceResponse, ResidenceResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

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

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'photoKeys')
  BuiltList<String>? get photoKeys;

  @BuiltValueField(wireName: r'status')
  ResidenceResponseStatusEnum? get status;
  // enum statusEnum {  DRAFT,  PUBLISHED,  RESERVED,  RENTED,  ARCHIVED,  };

  @BuiltValueField(wireName: r'unitCount')
  int? get unitCount;

  @BuiltValueField(wireName: r'publishedUnitCount')
  int? get publishedUnitCount;

  @BuiltValueField(wireName: r'draftUnitCount')
  int? get draftUnitCount;

  @BuiltValueField(wireName: r'reserveUnitCount')
  int? get reserveUnitCount;

  @BuiltValueField(wireName: r'units')
  BuiltList<UnitSummary>? get units;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  ResidenceResponse._();

  factory ResidenceResponse([void updates(ResidenceResponseBuilder b)]) = _$ResidenceResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResidenceResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResidenceResponse> get serializer => _$ResidenceResponseSerializer();
}

class _$ResidenceResponseSerializer implements PrimitiveSerializer<ResidenceResponse> {
  @override
  final Iterable<Type> types = const [ResidenceResponse, _$ResidenceResponse];

  @override
  final String wireName = r'ResidenceResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResidenceResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
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
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(ResidenceResponseStatusEnum),
      );
    }
    if (object.unitCount != null) {
      yield r'unitCount';
      yield serializers.serialize(
        object.unitCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.publishedUnitCount != null) {
      yield r'publishedUnitCount';
      yield serializers.serialize(
        object.publishedUnitCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.draftUnitCount != null) {
      yield r'draftUnitCount';
      yield serializers.serialize(
        object.draftUnitCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.reserveUnitCount != null) {
      yield r'reserveUnitCount';
      yield serializers.serialize(
        object.reserveUnitCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.units != null) {
      yield r'units';
      yield serializers.serialize(
        object.units,
        specifiedType: const FullType(BuiltList, [FullType(UnitSummary)]),
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
    ResidenceResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResidenceResponseBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ResidenceResponseStatusEnum),
          ) as ResidenceResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'unitCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.unitCount = valueDes;
          break;
        case r'publishedUnitCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.publishedUnitCount = valueDes;
          break;
        case r'draftUnitCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.draftUnitCount = valueDes;
          break;
        case r'reserveUnitCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.reserveUnitCount = valueDes;
          break;
        case r'units':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(UnitSummary)]),
          ) as BuiltList<UnitSummary>?;
          if (valueDes == null) continue;
          result.units.replace(valueDes);
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
  ResidenceResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResidenceResponseBuilder();
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

class ResidenceResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DRAFT')
  static const ResidenceResponseStatusEnum DRAFT = _$residenceResponseStatusEnum_DRAFT;
  @BuiltValueEnumConst(wireName: r'PUBLISHED')
  static const ResidenceResponseStatusEnum PUBLISHED = _$residenceResponseStatusEnum_PUBLISHED;
  @BuiltValueEnumConst(wireName: r'RESERVED')
  static const ResidenceResponseStatusEnum RESERVED = _$residenceResponseStatusEnum_RESERVED;
  @BuiltValueEnumConst(wireName: r'RENTED')
  static const ResidenceResponseStatusEnum RENTED = _$residenceResponseStatusEnum_RENTED;
  @BuiltValueEnumConst(wireName: r'ARCHIVED')
  static const ResidenceResponseStatusEnum ARCHIVED = _$residenceResponseStatusEnum_ARCHIVED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ResidenceResponseStatusEnum unknownDefaultOpenApi = _$residenceResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<ResidenceResponseStatusEnum> get serializer => _$residenceResponseStatusEnumSerializer;

  const ResidenceResponseStatusEnum._(String name): super(name);

  static BuiltSet<ResidenceResponseStatusEnum> get values => _$residenceResponseStatusEnumValues;
  static ResidenceResponseStatusEnum valueOf(String name) => _$residenceResponseStatusEnumValueOf(name);
}

