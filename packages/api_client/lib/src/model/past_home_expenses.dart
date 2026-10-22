//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/past_payment.dart';
import 'package:api_client/src/model/year_total.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'past_home_expenses.g.dart';

/// PastHomeExpenses
///
/// Properties:
/// * [confirmedTotal] 
/// * [byYear] 
/// * [confirmed] 
/// * [notConfirmed] 
@BuiltValue()
abstract class PastHomeExpenses implements Built<PastHomeExpenses, PastHomeExpensesBuilder> {
  @BuiltValueField(wireName: r'confirmedTotal')
  int? get confirmedTotal;

  @BuiltValueField(wireName: r'byYear')
  BuiltList<YearTotal>? get byYear;

  @BuiltValueField(wireName: r'confirmed')
  BuiltList<PastPayment>? get confirmed;

  @BuiltValueField(wireName: r'notConfirmed')
  BuiltList<PastPayment>? get notConfirmed;

  PastHomeExpenses._();

  factory PastHomeExpenses([void updates(PastHomeExpensesBuilder b)]) = _$PastHomeExpenses;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PastHomeExpensesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PastHomeExpenses> get serializer => _$PastHomeExpensesSerializer();
}

class _$PastHomeExpensesSerializer implements PrimitiveSerializer<PastHomeExpenses> {
  @override
  final Iterable<Type> types = const [PastHomeExpenses, _$PastHomeExpenses];

  @override
  final String wireName = r'PastHomeExpenses';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PastHomeExpenses object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.confirmedTotal != null) {
      yield r'confirmedTotal';
      yield serializers.serialize(
        object.confirmedTotal,
        specifiedType: const FullType(int),
      );
    }
    if (object.byYear != null) {
      yield r'byYear';
      yield serializers.serialize(
        object.byYear,
        specifiedType: const FullType(BuiltList, [FullType(YearTotal)]),
      );
    }
    if (object.confirmed != null) {
      yield r'confirmed';
      yield serializers.serialize(
        object.confirmed,
        specifiedType: const FullType(BuiltList, [FullType(PastPayment)]),
      );
    }
    if (object.notConfirmed != null) {
      yield r'notConfirmed';
      yield serializers.serialize(
        object.notConfirmed,
        specifiedType: const FullType(BuiltList, [FullType(PastPayment)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PastHomeExpenses object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PastHomeExpensesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'confirmedTotal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.confirmedTotal = valueDes;
          break;
        case r'byYear':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(YearTotal)]),
          ) as BuiltList<YearTotal>?;
          if (valueDes == null) continue;
          result.byYear.replace(valueDes);
          break;
        case r'confirmed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(PastPayment)]),
          ) as BuiltList<PastPayment>?;
          if (valueDes == null) continue;
          result.confirmed.replace(valueDes);
          break;
        case r'notConfirmed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(PastPayment)]),
          ) as BuiltList<PastPayment>?;
          if (valueDes == null) continue;
          result.notConfirmed.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PastHomeExpenses deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PastHomeExpensesBuilder();
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

