//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'historique_response.g.dart';

/// HistoriqueResponse
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
/// * [viewedAt] 
@BuiltValue()
abstract class HistoriqueResponse implements Built<HistoriqueResponse, HistoriqueResponseBuilder> {
  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'primaryPhotoKey')
  String? get primaryPhotoKey;

  @BuiltValueField(wireName: r'price')
  int? get price;

  @BuiltValueField(wireName: r'rentalPeriod')
  HistoriqueResponseRentalPeriodEnum? get rentalPeriod;
  // enum rentalPeriodEnum {  DAY,  WEEK,  MONTH,  QUARTER,  YEAR,  };

  @BuiltValueField(wireName: r'monthlyRent')
  int? get monthlyRent;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'district')
  String? get district;

  @BuiltValueField(wireName: r'viewedAt')
  DateTime? get viewedAt;

  HistoriqueResponse._();

  factory HistoriqueResponse([void updates(HistoriqueResponseBuilder b)]) = _$HistoriqueResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HistoriqueResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HistoriqueResponse> get serializer => _$HistoriqueResponseSerializer();
}

class _$HistoriqueResponseSerializer implements PrimitiveSerializer<HistoriqueResponse> {
  @override
  final Iterable<Type> types = const [HistoriqueResponse, _$HistoriqueResponse];

  @override
  final String wireName = r'HistoriqueResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HistoriqueResponse object, {
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
        specifiedType: const FullType(HistoriqueResponseRentalPeriodEnum),
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
    if (object.viewedAt != null) {
      yield r'viewedAt';
      yield serializers.serialize(
        object.viewedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HistoriqueResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HistoriqueResponseBuilder result,
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
            specifiedType: const FullType.nullable(HistoriqueResponseRentalPeriodEnum),
          ) as HistoriqueResponseRentalPeriodEnum?;
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
        case r'viewedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.viewedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HistoriqueResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HistoriqueResponseBuilder();
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

class HistoriqueResponseRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DAY')
  static const HistoriqueResponseRentalPeriodEnum DAY = _$historiqueResponseRentalPeriodEnum_DAY;
  @BuiltValueEnumConst(wireName: r'WEEK')
  static const HistoriqueResponseRentalPeriodEnum WEEK = _$historiqueResponseRentalPeriodEnum_WEEK;
  @BuiltValueEnumConst(wireName: r'MONTH')
  static const HistoriqueResponseRentalPeriodEnum MONTH = _$historiqueResponseRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const HistoriqueResponseRentalPeriodEnum QUARTER = _$historiqueResponseRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const HistoriqueResponseRentalPeriodEnum YEAR = _$historiqueResponseRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const HistoriqueResponseRentalPeriodEnum unknownDefaultOpenApi = _$historiqueResponseRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<HistoriqueResponseRentalPeriodEnum> get serializer => _$historiqueResponseRentalPeriodEnumSerializer;

  const HistoriqueResponseRentalPeriodEnum._(String name): super(name);

  static BuiltSet<HistoriqueResponseRentalPeriodEnum> get values => _$historiqueResponseRentalPeriodEnumValues;
  static HistoriqueResponseRentalPeriodEnum valueOf(String name) => _$historiqueResponseRentalPeriodEnumValueOf(name);
}

