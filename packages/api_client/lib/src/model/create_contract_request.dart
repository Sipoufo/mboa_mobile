//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_contract_request.g.dart';

/// CreateContractRequest
///
/// Properties:
/// * [annonceId] 
/// * [tenantAccountId] 
/// * [tenantPhone] 
/// * [price] 
/// * [rentalPeriod] 
/// * [depositAmount] 
/// * [chargesIncluded] 
/// * [startDate] 
/// * [durationUnits] 
/// * [tacitRenewal] 
/// * [reservationRequestId] 
@BuiltValue()
abstract class CreateContractRequest implements Built<CreateContractRequest, CreateContractRequestBuilder> {
  @BuiltValueField(wireName: r'annonceId')
  String get annonceId;

  @BuiltValueField(wireName: r'tenantAccountId')
  String? get tenantAccountId;

  @BuiltValueField(wireName: r'tenantPhone')
  String? get tenantPhone;

  @BuiltValueField(wireName: r'price')
  int? get price;

  @BuiltValueField(wireName: r'rentalPeriod')
  CreateContractRequestRentalPeriodEnum? get rentalPeriod;
  // enum rentalPeriodEnum {  DAY,  WEEK,  MONTH,  QUARTER,  YEAR,  };

  @BuiltValueField(wireName: r'depositAmount')
  int get depositAmount;

  @BuiltValueField(wireName: r'chargesIncluded')
  bool? get chargesIncluded;

  @BuiltValueField(wireName: r'startDate')
  Date? get startDate;

  @BuiltValueField(wireName: r'durationUnits')
  int? get durationUnits;

  @BuiltValueField(wireName: r'tacitRenewal')
  bool? get tacitRenewal;

  @BuiltValueField(wireName: r'reservationRequestId')
  String? get reservationRequestId;

  CreateContractRequest._();

  factory CreateContractRequest([void updates(CreateContractRequestBuilder b)]) = _$CreateContractRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateContractRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateContractRequest> get serializer => _$CreateContractRequestSerializer();
}

class _$CreateContractRequestSerializer implements PrimitiveSerializer<CreateContractRequest> {
  @override
  final Iterable<Type> types = const [CreateContractRequest, _$CreateContractRequest];

  @override
  final String wireName = r'CreateContractRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateContractRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'annonceId';
    yield serializers.serialize(
      object.annonceId,
      specifiedType: const FullType(String),
    );
    if (object.tenantAccountId != null) {
      yield r'tenantAccountId';
      yield serializers.serialize(
        object.tenantAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.tenantPhone != null) {
      yield r'tenantPhone';
      yield serializers.serialize(
        object.tenantPhone,
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
        specifiedType: const FullType(CreateContractRequestRentalPeriodEnum),
      );
    }
    yield r'depositAmount';
    yield serializers.serialize(
      object.depositAmount,
      specifiedType: const FullType(int),
    );
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
    if (object.reservationRequestId != null) {
      yield r'reservationRequestId';
      yield serializers.serialize(
        object.reservationRequestId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateContractRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateContractRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'annonceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.annonceId = valueDes;
          break;
        case r'tenantAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.tenantAccountId = valueDes;
          break;
        case r'tenantPhone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.tenantPhone = valueDes;
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
            specifiedType: const FullType.nullable(CreateContractRequestRentalPeriodEnum),
          ) as CreateContractRequestRentalPeriodEnum?;
          if (valueDes == null) continue;
          result.rentalPeriod = valueDes;
          break;
        case r'depositAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
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
        case r'reservationRequestId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reservationRequestId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateContractRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateContractRequestBuilder();
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

class CreateContractRequestRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DAY')
  static const CreateContractRequestRentalPeriodEnum DAY = _$createContractRequestRentalPeriodEnum_DAY;
  @BuiltValueEnumConst(wireName: r'WEEK')
  static const CreateContractRequestRentalPeriodEnum WEEK = _$createContractRequestRentalPeriodEnum_WEEK;
  @BuiltValueEnumConst(wireName: r'MONTH')
  static const CreateContractRequestRentalPeriodEnum MONTH = _$createContractRequestRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const CreateContractRequestRentalPeriodEnum QUARTER = _$createContractRequestRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const CreateContractRequestRentalPeriodEnum YEAR = _$createContractRequestRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateContractRequestRentalPeriodEnum unknownDefaultOpenApi = _$createContractRequestRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<CreateContractRequestRentalPeriodEnum> get serializer => _$createContractRequestRentalPeriodEnumSerializer;

  const CreateContractRequestRentalPeriodEnum._(String name): super(name);

  static BuiltSet<CreateContractRequestRentalPeriodEnum> get values => _$createContractRequestRentalPeriodEnumValues;
  static CreateContractRequestRentalPeriodEnum valueOf(String name) => _$createContractRequestRentalPeriodEnumValueOf(name);
}

