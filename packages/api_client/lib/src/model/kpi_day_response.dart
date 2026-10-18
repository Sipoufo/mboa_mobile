//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'kpi_day_response.g.dart';

/// KpiDayResponse
///
/// Properties:
/// * [day] 
/// * [provisional] 
/// * [newPrestataires] 
/// * [converted] 
/// * [agentVisitsCompleted] 
/// * [contractsSigned] 
/// * [paidLost] 
/// * [activeListings] 
/// * [prestatairesFree] 
/// * [basicPlusPaid] 
/// * [basicPlusUnpaid] 
/// * [proPaid] 
/// * [proUnpaid] 
/// * [proPlusPaid] 
/// * [proPlusUnpaid] 
/// * [mrr] 
/// * [snapshotTakenAt] 
@BuiltValue()
abstract class KpiDayResponse implements Built<KpiDayResponse, KpiDayResponseBuilder> {
  @BuiltValueField(wireName: r'day')
  Date? get day;

  @BuiltValueField(wireName: r'provisional')
  bool? get provisional;

  @BuiltValueField(wireName: r'newPrestataires')
  int? get newPrestataires;

  @BuiltValueField(wireName: r'converted')
  int? get converted;

  @BuiltValueField(wireName: r'agentVisitsCompleted')
  int? get agentVisitsCompleted;

  @BuiltValueField(wireName: r'contractsSigned')
  int? get contractsSigned;

  @BuiltValueField(wireName: r'paidLost')
  int? get paidLost;

  @BuiltValueField(wireName: r'activeListings')
  int? get activeListings;

  @BuiltValueField(wireName: r'prestatairesFree')
  int? get prestatairesFree;

  @BuiltValueField(wireName: r'basicPlusPaid')
  int? get basicPlusPaid;

  @BuiltValueField(wireName: r'basicPlusUnpaid')
  int? get basicPlusUnpaid;

  @BuiltValueField(wireName: r'proPaid')
  int? get proPaid;

  @BuiltValueField(wireName: r'proUnpaid')
  int? get proUnpaid;

  @BuiltValueField(wireName: r'proPlusPaid')
  int? get proPlusPaid;

  @BuiltValueField(wireName: r'proPlusUnpaid')
  int? get proPlusUnpaid;

  @BuiltValueField(wireName: r'mrr')
  int? get mrr;

  @BuiltValueField(wireName: r'snapshotTakenAt')
  DateTime? get snapshotTakenAt;

  KpiDayResponse._();

  factory KpiDayResponse([void updates(KpiDayResponseBuilder b)]) = _$KpiDayResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KpiDayResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KpiDayResponse> get serializer => _$KpiDayResponseSerializer();
}

class _$KpiDayResponseSerializer implements PrimitiveSerializer<KpiDayResponse> {
  @override
  final Iterable<Type> types = const [KpiDayResponse, _$KpiDayResponse];

  @override
  final String wireName = r'KpiDayResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KpiDayResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.day != null) {
      yield r'day';
      yield serializers.serialize(
        object.day,
        specifiedType: const FullType(Date),
      );
    }
    if (object.provisional != null) {
      yield r'provisional';
      yield serializers.serialize(
        object.provisional,
        specifiedType: const FullType(bool),
      );
    }
    if (object.newPrestataires != null) {
      yield r'newPrestataires';
      yield serializers.serialize(
        object.newPrestataires,
        specifiedType: const FullType(int),
      );
    }
    if (object.converted != null) {
      yield r'converted';
      yield serializers.serialize(
        object.converted,
        specifiedType: const FullType(int),
      );
    }
    if (object.agentVisitsCompleted != null) {
      yield r'agentVisitsCompleted';
      yield serializers.serialize(
        object.agentVisitsCompleted,
        specifiedType: const FullType(int),
      );
    }
    if (object.contractsSigned != null) {
      yield r'contractsSigned';
      yield serializers.serialize(
        object.contractsSigned,
        specifiedType: const FullType(int),
      );
    }
    if (object.paidLost != null) {
      yield r'paidLost';
      yield serializers.serialize(
        object.paidLost,
        specifiedType: const FullType(int),
      );
    }
    if (object.activeListings != null) {
      yield r'activeListings';
      yield serializers.serialize(
        object.activeListings,
        specifiedType: const FullType(int),
      );
    }
    if (object.prestatairesFree != null) {
      yield r'prestatairesFree';
      yield serializers.serialize(
        object.prestatairesFree,
        specifiedType: const FullType(int),
      );
    }
    if (object.basicPlusPaid != null) {
      yield r'basicPlusPaid';
      yield serializers.serialize(
        object.basicPlusPaid,
        specifiedType: const FullType(int),
      );
    }
    if (object.basicPlusUnpaid != null) {
      yield r'basicPlusUnpaid';
      yield serializers.serialize(
        object.basicPlusUnpaid,
        specifiedType: const FullType(int),
      );
    }
    if (object.proPaid != null) {
      yield r'proPaid';
      yield serializers.serialize(
        object.proPaid,
        specifiedType: const FullType(int),
      );
    }
    if (object.proUnpaid != null) {
      yield r'proUnpaid';
      yield serializers.serialize(
        object.proUnpaid,
        specifiedType: const FullType(int),
      );
    }
    if (object.proPlusPaid != null) {
      yield r'proPlusPaid';
      yield serializers.serialize(
        object.proPlusPaid,
        specifiedType: const FullType(int),
      );
    }
    if (object.proPlusUnpaid != null) {
      yield r'proPlusUnpaid';
      yield serializers.serialize(
        object.proPlusUnpaid,
        specifiedType: const FullType(int),
      );
    }
    if (object.mrr != null) {
      yield r'mrr';
      yield serializers.serialize(
        object.mrr,
        specifiedType: const FullType(int),
      );
    }
    if (object.snapshotTakenAt != null) {
      yield r'snapshotTakenAt';
      yield serializers.serialize(
        object.snapshotTakenAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    KpiDayResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KpiDayResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'day':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.day = valueDes;
          break;
        case r'provisional':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.provisional = valueDes;
          break;
        case r'newPrestataires':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.newPrestataires = valueDes;
          break;
        case r'converted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.converted = valueDes;
          break;
        case r'agentVisitsCompleted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.agentVisitsCompleted = valueDes;
          break;
        case r'contractsSigned':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.contractsSigned = valueDes;
          break;
        case r'paidLost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.paidLost = valueDes;
          break;
        case r'activeListings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.activeListings = valueDes;
          break;
        case r'prestatairesFree':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.prestatairesFree = valueDes;
          break;
        case r'basicPlusPaid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.basicPlusPaid = valueDes;
          break;
        case r'basicPlusUnpaid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.basicPlusUnpaid = valueDes;
          break;
        case r'proPaid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.proPaid = valueDes;
          break;
        case r'proUnpaid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.proUnpaid = valueDes;
          break;
        case r'proPlusPaid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.proPlusPaid = valueDes;
          break;
        case r'proPlusUnpaid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.proPlusUnpaid = valueDes;
          break;
        case r'mrr':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.mrr = valueDes;
          break;
        case r'snapshotTakenAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.snapshotTakenAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  KpiDayResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KpiDayResponseBuilder();
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

