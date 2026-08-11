//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'favori_response.g.dart';

/// FavoriResponse
///
/// Properties:
/// * [annonceId] 
/// * [title] 
/// * [primaryPhotoKey] 
/// * [price] 
/// * [rentalPeriod] 
/// * [monthlyRent] 
/// * [city] 
/// * [district] 
/// * [available] 
/// * [savedAt] 
@BuiltValue()
abstract class FavoriResponse implements Built<FavoriResponse, FavoriResponseBuilder> {
  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'primaryPhotoKey')
  String? get primaryPhotoKey;

  @BuiltValueField(wireName: r'price')
  int? get price;

  @BuiltValueField(wireName: r'rentalPeriod')
  FavoriResponseRentalPeriodEnum? get rentalPeriod;
  // enum rentalPeriodEnum {  DAY,  WEEK,  MONTH,  QUARTER,  YEAR,  };

  @BuiltValueField(wireName: r'monthlyRent')
  int? get monthlyRent;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'district')
  String? get district;

  @BuiltValueField(wireName: r'available')
  bool? get available;

  @BuiltValueField(wireName: r'savedAt')
  DateTime? get savedAt;

  FavoriResponse._();

  factory FavoriResponse([void updates(FavoriResponseBuilder b)]) = _$FavoriResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FavoriResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FavoriResponse> get serializer => _$FavoriResponseSerializer();
}

class _$FavoriResponseSerializer implements PrimitiveSerializer<FavoriResponse> {
  @override
  final Iterable<Type> types = const [FavoriResponse, _$FavoriResponse];

  @override
  final String wireName = r'FavoriResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FavoriResponse object, {
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
    if (object.primaryPhotoKey != null) {
      yield r'primaryPhotoKey';
      yield serializers.serialize(
        object.primaryPhotoKey,
        specifiedType: const FullType(String),
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
        specifiedType: const FullType(FavoriResponseRentalPeriodEnum),
      );
    }
    if (object.monthlyRent != null) {
      yield r'monthlyRent';
      yield serializers.serialize(
        object.monthlyRent,
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
    if (object.available != null) {
      yield r'available';
      yield serializers.serialize(
        object.available,
        specifiedType: const FullType(bool),
      );
    }
    if (object.savedAt != null) {
      yield r'savedAt';
      yield serializers.serialize(
        object.savedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FavoriResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FavoriResponseBuilder result,
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
        case r'primaryPhotoKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.primaryPhotoKey = valueDes;
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
            specifiedType: const FullType.nullable(FavoriResponseRentalPeriodEnum),
          ) as FavoriResponseRentalPeriodEnum?;
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
        case r'available':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.available = valueDes;
          break;
        case r'savedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.savedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FavoriResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FavoriResponseBuilder();
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

class FavoriResponseRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DAY')
  static const FavoriResponseRentalPeriodEnum DAY = _$favoriResponseRentalPeriodEnum_DAY;
  @BuiltValueEnumConst(wireName: r'WEEK')
  static const FavoriResponseRentalPeriodEnum WEEK = _$favoriResponseRentalPeriodEnum_WEEK;
  @BuiltValueEnumConst(wireName: r'MONTH')
  static const FavoriResponseRentalPeriodEnum MONTH = _$favoriResponseRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const FavoriResponseRentalPeriodEnum QUARTER = _$favoriResponseRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const FavoriResponseRentalPeriodEnum YEAR = _$favoriResponseRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FavoriResponseRentalPeriodEnum unknownDefaultOpenApi = _$favoriResponseRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<FavoriResponseRentalPeriodEnum> get serializer => _$favoriResponseRentalPeriodEnumSerializer;

  const FavoriResponseRentalPeriodEnum._(String name): super(name);

  static BuiltSet<FavoriResponseRentalPeriodEnum> get values => _$favoriResponseRentalPeriodEnumValues;
  static FavoriResponseRentalPeriodEnum valueOf(String name) => _$favoriResponseRentalPeriodEnumValueOf(name);
}

