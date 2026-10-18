//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/category_total.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ledger_summary_response.g.dart';

/// LedgerSummaryResponse
///
/// Properties:
/// * [income] 
/// * [expense] 
/// * [net] 
/// * [entryCount] 
/// * [byCategory] 
@BuiltValue()
abstract class LedgerSummaryResponse implements Built<LedgerSummaryResponse, LedgerSummaryResponseBuilder> {
  @BuiltValueField(wireName: r'income')
  int? get income;

  @BuiltValueField(wireName: r'expense')
  int? get expense;

  @BuiltValueField(wireName: r'net')
  int? get net;

  @BuiltValueField(wireName: r'entryCount')
  int? get entryCount;

  @BuiltValueField(wireName: r'byCategory')
  BuiltList<CategoryTotal>? get byCategory;

  LedgerSummaryResponse._();

  factory LedgerSummaryResponse([void updates(LedgerSummaryResponseBuilder b)]) = _$LedgerSummaryResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LedgerSummaryResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LedgerSummaryResponse> get serializer => _$LedgerSummaryResponseSerializer();
}

class _$LedgerSummaryResponseSerializer implements PrimitiveSerializer<LedgerSummaryResponse> {
  @override
  final Iterable<Type> types = const [LedgerSummaryResponse, _$LedgerSummaryResponse];

  @override
  final String wireName = r'LedgerSummaryResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LedgerSummaryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.income != null) {
      yield r'income';
      yield serializers.serialize(
        object.income,
        specifiedType: const FullType(int),
      );
    }
    if (object.expense != null) {
      yield r'expense';
      yield serializers.serialize(
        object.expense,
        specifiedType: const FullType(int),
      );
    }
    if (object.net != null) {
      yield r'net';
      yield serializers.serialize(
        object.net,
        specifiedType: const FullType(int),
      );
    }
    if (object.entryCount != null) {
      yield r'entryCount';
      yield serializers.serialize(
        object.entryCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.byCategory != null) {
      yield r'byCategory';
      yield serializers.serialize(
        object.byCategory,
        specifiedType: const FullType(BuiltList, [FullType(CategoryTotal)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LedgerSummaryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LedgerSummaryResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'income':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.income = valueDes;
          break;
        case r'expense':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.expense = valueDes;
          break;
        case r'net':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.net = valueDes;
          break;
        case r'entryCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.entryCount = valueDes;
          break;
        case r'byCategory':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(CategoryTotal)]),
          ) as BuiltList<CategoryTotal>?;
          if (valueDes == null) continue;
          result.byCategory.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LedgerSummaryResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LedgerSummaryResponseBuilder();
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

