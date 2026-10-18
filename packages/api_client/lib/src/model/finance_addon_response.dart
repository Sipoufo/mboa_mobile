//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_addon_response.g.dart';

/// FinanceAddonResponse
///
/// Properties:
/// * [active] 
/// * [periodEnd] 
/// * [everSubscribed] 
/// * [paid] 
/// * [monthlyPrice] 
@BuiltValue()
abstract class FinanceAddonResponse implements Built<FinanceAddonResponse, FinanceAddonResponseBuilder> {
  @BuiltValueField(wireName: r'active')
  bool? get active;

  @BuiltValueField(wireName: r'periodEnd')
  DateTime? get periodEnd;

  @BuiltValueField(wireName: r'everSubscribed')
  bool? get everSubscribed;

  @BuiltValueField(wireName: r'paid')
  bool? get paid;

  @BuiltValueField(wireName: r'monthlyPrice')
  int? get monthlyPrice;

  FinanceAddonResponse._();

  factory FinanceAddonResponse([void updates(FinanceAddonResponseBuilder b)]) = _$FinanceAddonResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceAddonResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceAddonResponse> get serializer => _$FinanceAddonResponseSerializer();
}

class _$FinanceAddonResponseSerializer implements PrimitiveSerializer<FinanceAddonResponse> {
  @override
  final Iterable<Type> types = const [FinanceAddonResponse, _$FinanceAddonResponse];

  @override
  final String wireName = r'FinanceAddonResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceAddonResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.active != null) {
      yield r'active';
      yield serializers.serialize(
        object.active,
        specifiedType: const FullType(bool),
      );
    }
    if (object.periodEnd != null) {
      yield r'periodEnd';
      yield serializers.serialize(
        object.periodEnd,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.everSubscribed != null) {
      yield r'everSubscribed';
      yield serializers.serialize(
        object.everSubscribed,
        specifiedType: const FullType(bool),
      );
    }
    if (object.paid != null) {
      yield r'paid';
      yield serializers.serialize(
        object.paid,
        specifiedType: const FullType(bool),
      );
    }
    if (object.monthlyPrice != null) {
      yield r'monthlyPrice';
      yield serializers.serialize(
        object.monthlyPrice,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceAddonResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinanceAddonResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.active = valueDes;
          break;
        case r'periodEnd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.periodEnd = valueDes;
          break;
        case r'everSubscribed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.everSubscribed = valueDes;
          break;
        case r'paid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.paid = valueDes;
          break;
        case r'monthlyPrice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.monthlyPrice = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinanceAddonResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceAddonResponseBuilder();
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

