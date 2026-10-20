//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'due.g.dart';

/// Due
///
/// Properties:
/// * [index] 
/// * [periodStart] 
/// * [periodEnd] 
/// * [dueDate] 
/// * [amount] 
/// * [confirmedTotal] 
/// * [status] 
/// * [late_] 
/// * [declarationIds] 
@BuiltValue()
abstract class Due implements Built<Due, DueBuilder> {
  @BuiltValueField(wireName: r'index')
  int? get index;

  @BuiltValueField(wireName: r'periodStart')
  Date? get periodStart;

  @BuiltValueField(wireName: r'periodEnd')
  Date? get periodEnd;

  @BuiltValueField(wireName: r'dueDate')
  Date? get dueDate;

  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'confirmedTotal')
  int? get confirmedTotal;

  @BuiltValueField(wireName: r'status')
  DueStatusEnum? get status;
  // enum statusEnum {  UPCOMING,  DUE,  LATE,  DECLARED,  UNCONFIRMED,  CONFIRMED,  CONTESTED,  UNTRACKED,  };

  @BuiltValueField(wireName: r'late')
  bool? get late_;

  @BuiltValueField(wireName: r'declarationIds')
  BuiltList<String>? get declarationIds;

  Due._();

  factory Due([void updates(DueBuilder b)]) = _$Due;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DueBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Due> get serializer => _$DueSerializer();
}

class _$DueSerializer implements PrimitiveSerializer<Due> {
  @override
  final Iterable<Type> types = const [Due, _$Due];

  @override
  final String wireName = r'Due';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Due object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.index != null) {
      yield r'index';
      yield serializers.serialize(
        object.index,
        specifiedType: const FullType(int),
      );
    }
    if (object.periodStart != null) {
      yield r'periodStart';
      yield serializers.serialize(
        object.periodStart,
        specifiedType: const FullType(Date),
      );
    }
    if (object.periodEnd != null) {
      yield r'periodEnd';
      yield serializers.serialize(
        object.periodEnd,
        specifiedType: const FullType(Date),
      );
    }
    if (object.dueDate != null) {
      yield r'dueDate';
      yield serializers.serialize(
        object.dueDate,
        specifiedType: const FullType(Date),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(int),
      );
    }
    if (object.confirmedTotal != null) {
      yield r'confirmedTotal';
      yield serializers.serialize(
        object.confirmedTotal,
        specifiedType: const FullType(int),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(DueStatusEnum),
      );
    }
    if (object.late_ != null) {
      yield r'late';
      yield serializers.serialize(
        object.late_,
        specifiedType: const FullType(bool),
      );
    }
    if (object.declarationIds != null) {
      yield r'declarationIds';
      yield serializers.serialize(
        object.declarationIds,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Due object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DueBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'index':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.index = valueDes;
          break;
        case r'periodStart':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.periodStart = valueDes;
          break;
        case r'periodEnd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.periodEnd = valueDes;
          break;
        case r'dueDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.dueDate = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'confirmedTotal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.confirmedTotal = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DueStatusEnum),
          ) as DueStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'late':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.late_ = valueDes;
          break;
        case r'declarationIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.declarationIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Due deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DueBuilder();
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

class DueStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'UPCOMING')
  static const DueStatusEnum UPCOMING = _$dueStatusEnum_UPCOMING;
  @BuiltValueEnumConst(wireName: r'DUE')
  static const DueStatusEnum DUE = _$dueStatusEnum_DUE;
  @BuiltValueEnumConst(wireName: r'LATE')
  static const DueStatusEnum LATE = _$dueStatusEnum_LATE;
  @BuiltValueEnumConst(wireName: r'DECLARED')
  static const DueStatusEnum DECLARED = _$dueStatusEnum_DECLARED;
  @BuiltValueEnumConst(wireName: r'UNCONFIRMED')
  static const DueStatusEnum UNCONFIRMED = _$dueStatusEnum_UNCONFIRMED;
  @BuiltValueEnumConst(wireName: r'CONFIRMED')
  static const DueStatusEnum CONFIRMED = _$dueStatusEnum_CONFIRMED;
  @BuiltValueEnumConst(wireName: r'CONTESTED')
  static const DueStatusEnum CONTESTED = _$dueStatusEnum_CONTESTED;
  @BuiltValueEnumConst(wireName: r'UNTRACKED')
  static const DueStatusEnum UNTRACKED = _$dueStatusEnum_UNTRACKED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DueStatusEnum unknownDefaultOpenApi = _$dueStatusEnum_unknownDefaultOpenApi;

  static Serializer<DueStatusEnum> get serializer => _$dueStatusEnumSerializer;

  const DueStatusEnum._(String name): super(name);

  static BuiltSet<DueStatusEnum> get values => _$dueStatusEnumValues;
  static DueStatusEnum valueOf(String name) => _$dueStatusEnumValueOf(name);
}

