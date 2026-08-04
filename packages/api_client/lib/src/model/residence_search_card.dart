//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/type_count.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'residence_search_card.g.dart';

/// ResidenceSearchCard
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [city] 
/// * [district] 
/// * [primaryPhotoKey] 
/// * [tierRank] 
/// * [availableUnitCount] 
/// * [reservedUnitCount] 
/// * [breakdown] 
/// * [fromMonthlyRent] 
/// * [latitude] 
/// * [longitude] 
@BuiltValue()
abstract class ResidenceSearchCard implements Built<ResidenceSearchCard, ResidenceSearchCardBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'district')
  String? get district;

  @BuiltValueField(wireName: r'primaryPhotoKey')
  String? get primaryPhotoKey;

  @BuiltValueField(wireName: r'tierRank')
  int? get tierRank;

  @BuiltValueField(wireName: r'availableUnitCount')
  int? get availableUnitCount;

  @BuiltValueField(wireName: r'reservedUnitCount')
  int? get reservedUnitCount;

  @BuiltValueField(wireName: r'breakdown')
  BuiltList<TypeCount>? get breakdown;

  @BuiltValueField(wireName: r'fromMonthlyRent')
  int? get fromMonthlyRent;

  @BuiltValueField(wireName: r'latitude')
  double? get latitude;

  @BuiltValueField(wireName: r'longitude')
  double? get longitude;

  ResidenceSearchCard._();

  factory ResidenceSearchCard([void updates(ResidenceSearchCardBuilder b)]) = _$ResidenceSearchCard;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResidenceSearchCardBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResidenceSearchCard> get serializer => _$ResidenceSearchCardSerializer();
}

class _$ResidenceSearchCardSerializer implements PrimitiveSerializer<ResidenceSearchCard> {
  @override
  final Iterable<Type> types = const [ResidenceSearchCard, _$ResidenceSearchCard];

  @override
  final String wireName = r'ResidenceSearchCard';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResidenceSearchCard object, {
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
    if (object.primaryPhotoKey != null) {
      yield r'primaryPhotoKey';
      yield serializers.serialize(
        object.primaryPhotoKey,
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
    if (object.availableUnitCount != null) {
      yield r'availableUnitCount';
      yield serializers.serialize(
        object.availableUnitCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.reservedUnitCount != null) {
      yield r'reservedUnitCount';
      yield serializers.serialize(
        object.reservedUnitCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.breakdown != null) {
      yield r'breakdown';
      yield serializers.serialize(
        object.breakdown,
        specifiedType: const FullType(BuiltList, [FullType(TypeCount)]),
      );
    }
    if (object.fromMonthlyRent != null) {
      yield r'fromMonthlyRent';
      yield serializers.serialize(
        object.fromMonthlyRent,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ResidenceSearchCard object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResidenceSearchCardBuilder result,
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
        case r'primaryPhotoKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.primaryPhotoKey = valueDes;
          break;
        case r'tierRank':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.tierRank = valueDes;
          break;
        case r'availableUnitCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.availableUnitCount = valueDes;
          break;
        case r'reservedUnitCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.reservedUnitCount = valueDes;
          break;
        case r'breakdown':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(TypeCount)]),
          ) as BuiltList<TypeCount>?;
          if (valueDes == null) continue;
          result.breakdown.replace(valueDes);
          break;
        case r'fromMonthlyRent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.fromMonthlyRent = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResidenceSearchCard deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResidenceSearchCardBuilder();
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

