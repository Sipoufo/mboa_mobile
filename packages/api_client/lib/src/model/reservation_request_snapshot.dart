//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reservation_request_snapshot.g.dart';

/// ReservationRequestSnapshot
///
/// Properties:
/// * [reservationRequestId] 
/// * [desiredStartDate] 
/// * [durationUnits] 
/// * [rentalPeriod] 
@BuiltValue()
abstract class ReservationRequestSnapshot implements Built<ReservationRequestSnapshot, ReservationRequestSnapshotBuilder> {
  @BuiltValueField(wireName: r'reservationRequestId')
  String? get reservationRequestId;

  @BuiltValueField(wireName: r'desiredStartDate')
  Date? get desiredStartDate;

  @BuiltValueField(wireName: r'durationUnits')
  int? get durationUnits;

  @BuiltValueField(wireName: r'rentalPeriod')
  ReservationRequestSnapshotRentalPeriodEnum? get rentalPeriod;
  // enum rentalPeriodEnum {  DAY,  WEEK,  MONTH,  QUARTER,  YEAR,  };

  ReservationRequestSnapshot._();

  factory ReservationRequestSnapshot([void updates(ReservationRequestSnapshotBuilder b)]) = _$ReservationRequestSnapshot;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReservationRequestSnapshotBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReservationRequestSnapshot> get serializer => _$ReservationRequestSnapshotSerializer();
}

class _$ReservationRequestSnapshotSerializer implements PrimitiveSerializer<ReservationRequestSnapshot> {
  @override
  final Iterable<Type> types = const [ReservationRequestSnapshot, _$ReservationRequestSnapshot];

  @override
  final String wireName = r'ReservationRequestSnapshot';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReservationRequestSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.reservationRequestId != null) {
      yield r'reservationRequestId';
      yield serializers.serialize(
        object.reservationRequestId,
        specifiedType: const FullType(String),
      );
    }
    if (object.desiredStartDate != null) {
      yield r'desiredStartDate';
      yield serializers.serialize(
        object.desiredStartDate,
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
        specifiedType: const FullType(ReservationRequestSnapshotRentalPeriodEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReservationRequestSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReservationRequestSnapshotBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reservationRequestId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reservationRequestId = valueDes;
          break;
        case r'desiredStartDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.desiredStartDate = valueDes;
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
            specifiedType: const FullType.nullable(ReservationRequestSnapshotRentalPeriodEnum),
          ) as ReservationRequestSnapshotRentalPeriodEnum?;
          if (valueDes == null) continue;
          result.rentalPeriod = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReservationRequestSnapshot deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReservationRequestSnapshotBuilder();
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

class ReservationRequestSnapshotRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DAY')
  static const ReservationRequestSnapshotRentalPeriodEnum DAY = _$reservationRequestSnapshotRentalPeriodEnum_DAY;
  @BuiltValueEnumConst(wireName: r'WEEK')
  static const ReservationRequestSnapshotRentalPeriodEnum WEEK = _$reservationRequestSnapshotRentalPeriodEnum_WEEK;
  @BuiltValueEnumConst(wireName: r'MONTH')
  static const ReservationRequestSnapshotRentalPeriodEnum MONTH = _$reservationRequestSnapshotRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const ReservationRequestSnapshotRentalPeriodEnum QUARTER = _$reservationRequestSnapshotRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const ReservationRequestSnapshotRentalPeriodEnum YEAR = _$reservationRequestSnapshotRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ReservationRequestSnapshotRentalPeriodEnum unknownDefaultOpenApi = _$reservationRequestSnapshotRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<ReservationRequestSnapshotRentalPeriodEnum> get serializer => _$reservationRequestSnapshotRentalPeriodEnumSerializer;

  const ReservationRequestSnapshotRentalPeriodEnum._(String name): super(name);

  static BuiltSet<ReservationRequestSnapshotRentalPeriodEnum> get values => _$reservationRequestSnapshotRentalPeriodEnumValues;
  static ReservationRequestSnapshotRentalPeriodEnum valueOf(String name) => _$reservationRequestSnapshotRentalPeriodEnumValueOf(name);
}

