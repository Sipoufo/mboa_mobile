//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_contract_request.g.dart';

/// UpdateContractRequest
///
/// Properties:
/// * [price] 
/// * [rentalPeriod] 
/// * [depositAmount] 
/// * [chargesIncluded] 
/// * [startDate] 
/// * [durationUnits] 
/// * [tacitRenewal] 
@BuiltValue()
abstract class UpdateContractRequest implements Built<UpdateContractRequest, UpdateContractRequestBuilder> {
  @BuiltValueField(wireName: r'price')
  int? get price;

  @BuiltValueField(wireName: r'rentalPeriod')
  UpdateContractRequestRentalPeriodEnum? get rentalPeriod;
  // enum rentalPeriodEnum {  DAY,  WEEK,  MONTH,  QUARTER,  YEAR,  };

  @BuiltValueField(wireName: r'depositAmount')
  int? get depositAmount;

  @BuiltValueField(wireName: r'chargesIncluded')
  bool? get chargesIncluded;

  @BuiltValueField(wireName: r'startDate')
  Date? get startDate;

  @BuiltValueField(wireName: r'durationUnits')
  int? get durationUnits;

  @BuiltValueField(wireName: r'tacitRenewal')
  bool? get tacitRenewal;

  UpdateContractRequest._();

  factory UpdateContractRequest([void updates(UpdateContractRequestBuilder b)]) = _$UpdateContractRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateContractRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateContractRequest> get serializer => _$UpdateContractRequestSerializer();
}

class _$UpdateContractRequestSerializer implements PrimitiveSerializer<UpdateContractRequest> {
  @override
  final Iterable<Type> types = const [UpdateContractRequest, _$UpdateContractRequest];

  @override
  final String wireName = r'UpdateContractRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateContractRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
        specifiedType: const FullType(UpdateContractRequestRentalPeriodEnum),
      );
    }
    if (object.depositAmount != null) {
      yield r'depositAmount';
      yield serializers.serialize(
        object.depositAmount,
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
    if (object.startDate != null) {
      yield r'startDate';
      yield serializers.serialize(
        object.startDate,
        specifiedType: const FullType(Date),
      );
    }
    if (object.durationUnits != null) {
      yield r'durationUnits';
      yield serializers.serialize(
        object.durationUnits,
        specifiedType: const FullType(int),
      );
    }
    if (object.tacitRenewal != null) {
      yield r'tacitRenewal';
      yield serializers.serialize(
        object.tacitRenewal,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateContractRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateContractRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType.nullable(UpdateContractRequestRentalPeriodEnum),
          ) as UpdateContractRequestRentalPeriodEnum?;
          if (valueDes == null) continue;
          result.rentalPeriod = valueDes;
          break;
        case r'depositAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.depositAmount = valueDes;
          break;
        case r'chargesIncluded':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.chargesIncluded = valueDes;
          break;
        case r'startDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.startDate = valueDes;
          break;
        case r'durationUnits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.durationUnits = valueDes;
          break;
        case r'tacitRenewal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.tacitRenewal = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateContractRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateContractRequestBuilder();
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

class UpdateContractRequestRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DAY')
  static const UpdateContractRequestRentalPeriodEnum DAY = _$updateContractRequestRentalPeriodEnum_DAY;
  @BuiltValueEnumConst(wireName: r'WEEK')
  static const UpdateContractRequestRentalPeriodEnum WEEK = _$updateContractRequestRentalPeriodEnum_WEEK;
  @BuiltValueEnumConst(wireName: r'MONTH')
  static const UpdateContractRequestRentalPeriodEnum MONTH = _$updateContractRequestRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const UpdateContractRequestRentalPeriodEnum QUARTER = _$updateContractRequestRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const UpdateContractRequestRentalPeriodEnum YEAR = _$updateContractRequestRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UpdateContractRequestRentalPeriodEnum unknownDefaultOpenApi = _$updateContractRequestRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<UpdateContractRequestRentalPeriodEnum> get serializer => _$updateContractRequestRentalPeriodEnumSerializer;

  const UpdateContractRequestRentalPeriodEnum._(String name): super(name);

  static BuiltSet<UpdateContractRequestRentalPeriodEnum> get values => _$updateContractRequestRentalPeriodEnumValues;
  static UpdateContractRequestRentalPeriodEnum valueOf(String name) => _$updateContractRequestRentalPeriodEnumValueOf(name);
}

