//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_contract_line.g.dart';

/// AdminContractLine
///
/// Properties:
/// * [contractId] 
/// * [annonceId] 
/// * [annonceTitle] 
/// * [status] 
/// * [startDate] 
/// * [durationUnits] 
/// * [rentalPeriod] 
/// * [signedAt] 
/// * [createdAt] 
@BuiltValue()
abstract class AdminContractLine implements Built<AdminContractLine, AdminContractLineBuilder> {
  @BuiltValueField(wireName: r'contractId')
  String? get contractId;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'annonceTitle')
  String? get annonceTitle;

  @BuiltValueField(wireName: r'status')
  AdminContractLineStatusEnum? get status;
  // enum statusEnum {  DRAFT,  SENT,  CHANGES_REQUESTED,  ACCEPTED,  SIGNED,  CANCELLED,  };

  @BuiltValueField(wireName: r'startDate')
  Date? get startDate;

  @BuiltValueField(wireName: r'durationUnits')
  int? get durationUnits;

  @BuiltValueField(wireName: r'rentalPeriod')
  AdminContractLineRentalPeriodEnum? get rentalPeriod;
  // enum rentalPeriodEnum {  DAY,  WEEK,  MONTH,  QUARTER,  YEAR,  };

  @BuiltValueField(wireName: r'signedAt')
  DateTime? get signedAt;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  AdminContractLine._();

  factory AdminContractLine([void updates(AdminContractLineBuilder b)]) = _$AdminContractLine;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminContractLineBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminContractLine> get serializer => _$AdminContractLineSerializer();
}

class _$AdminContractLineSerializer implements PrimitiveSerializer<AdminContractLine> {
  @override
  final Iterable<Type> types = const [AdminContractLine, _$AdminContractLine];

  @override
  final String wireName = r'AdminContractLine';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminContractLine object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.contractId != null) {
      yield r'contractId';
      yield serializers.serialize(
        object.contractId,
        specifiedType: const FullType(String),
      );
    }
    if (object.annonceId != null) {
      yield r'annonceId';
      yield serializers.serialize(
        object.annonceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.annonceTitle != null) {
      yield r'annonceTitle';
      yield serializers.serialize(
        object.annonceTitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(AdminContractLineStatusEnum),
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
    if (object.rentalPeriod != null) {
      yield r'rentalPeriod';
      yield serializers.serialize(
        object.rentalPeriod,
        specifiedType: const FullType(AdminContractLineRentalPeriodEnum),
      );
    }
    if (object.signedAt != null) {
      yield r'signedAt';
      yield serializers.serialize(
        object.signedAt,
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
    AdminContractLine object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminContractLineBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'contractId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contractId = valueDes;
          break;
        case r'annonceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.annonceId = valueDes;
          break;
        case r'annonceTitle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.annonceTitle = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminContractLineStatusEnum),
          ) as AdminContractLineStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
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
        case r'rentalPeriod':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminContractLineRentalPeriodEnum),
          ) as AdminContractLineRentalPeriodEnum?;
          if (valueDes == null) continue;
          result.rentalPeriod = valueDes;
          break;
        case r'signedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.signedAt = valueDes;
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
  AdminContractLine deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminContractLineBuilder();
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

class AdminContractLineStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DRAFT')
  static const AdminContractLineStatusEnum DRAFT = _$adminContractLineStatusEnum_DRAFT;
  @BuiltValueEnumConst(wireName: r'SENT')
  static const AdminContractLineStatusEnum SENT = _$adminContractLineStatusEnum_SENT;
  @BuiltValueEnumConst(wireName: r'CHANGES_REQUESTED')
  static const AdminContractLineStatusEnum CHANGES_REQUESTED = _$adminContractLineStatusEnum_CHANGES_REQUESTED;
  @BuiltValueEnumConst(wireName: r'ACCEPTED')
  static const AdminContractLineStatusEnum ACCEPTED = _$adminContractLineStatusEnum_ACCEPTED;
  @BuiltValueEnumConst(wireName: r'SIGNED')
  static const AdminContractLineStatusEnum SIGNED = _$adminContractLineStatusEnum_SIGNED;
  @BuiltValueEnumConst(wireName: r'CANCELLED')
  static const AdminContractLineStatusEnum CANCELLED = _$adminContractLineStatusEnum_CANCELLED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminContractLineStatusEnum unknownDefaultOpenApi = _$adminContractLineStatusEnum_unknownDefaultOpenApi;

  static Serializer<AdminContractLineStatusEnum> get serializer => _$adminContractLineStatusEnumSerializer;

  const AdminContractLineStatusEnum._(String name): super(name);

  static BuiltSet<AdminContractLineStatusEnum> get values => _$adminContractLineStatusEnumValues;
  static AdminContractLineStatusEnum valueOf(String name) => _$adminContractLineStatusEnumValueOf(name);
}

class AdminContractLineRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DAY')
  static const AdminContractLineRentalPeriodEnum DAY = _$adminContractLineRentalPeriodEnum_DAY;
  @BuiltValueEnumConst(wireName: r'WEEK')
  static const AdminContractLineRentalPeriodEnum WEEK = _$adminContractLineRentalPeriodEnum_WEEK;
  @BuiltValueEnumConst(wireName: r'MONTH')
  static const AdminContractLineRentalPeriodEnum MONTH = _$adminContractLineRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const AdminContractLineRentalPeriodEnum QUARTER = _$adminContractLineRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const AdminContractLineRentalPeriodEnum YEAR = _$adminContractLineRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminContractLineRentalPeriodEnum unknownDefaultOpenApi = _$adminContractLineRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<AdminContractLineRentalPeriodEnum> get serializer => _$adminContractLineRentalPeriodEnumSerializer;

  const AdminContractLineRentalPeriodEnum._(String name): super(name);

  static BuiltSet<AdminContractLineRentalPeriodEnum> get values => _$adminContractLineRentalPeriodEnumValues;
  static AdminContractLineRentalPeriodEnum valueOf(String name) => _$adminContractLineRentalPeriodEnumValueOf(name);
}

