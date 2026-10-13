//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'line.g.dart';

/// Line
///
/// Properties:
/// * [tier] 
/// * [paymentCount] 
/// * [revenue] 
/// * [refunded] 
/// * [net] 
/// * [activePaid] 
/// * [activeUnpaid] 
/// * [mrr] 
@BuiltValue()
abstract class Line implements Built<Line, LineBuilder> {
  @BuiltValueField(wireName: r'tier')
  LineTierEnum? get tier;
  // enum tierEnum {  FREE,  BASIC_PLUS,  PRO,  PRO_PLUS,  };

  @BuiltValueField(wireName: r'paymentCount')
  int? get paymentCount;

  @BuiltValueField(wireName: r'revenue')
  int? get revenue;

  @BuiltValueField(wireName: r'refunded')
  int? get refunded;

  @BuiltValueField(wireName: r'net')
  int? get net;

  @BuiltValueField(wireName: r'activePaid')
  int? get activePaid;

  @BuiltValueField(wireName: r'activeUnpaid')
  int? get activeUnpaid;

  @BuiltValueField(wireName: r'mrr')
  int? get mrr;

  Line._();

  factory Line([void updates(LineBuilder b)]) = _$Line;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LineBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Line> get serializer => _$LineSerializer();
}

class _$LineSerializer implements PrimitiveSerializer<Line> {
  @override
  final Iterable<Type> types = const [Line, _$Line];

  @override
  final String wireName = r'Line';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Line object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.tier != null) {
      yield r'tier';
      yield serializers.serialize(
        object.tier,
        specifiedType: const FullType(LineTierEnum),
      );
    }
    if (object.paymentCount != null) {
      yield r'paymentCount';
      yield serializers.serialize(
        object.paymentCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.revenue != null) {
      yield r'revenue';
      yield serializers.serialize(
        object.revenue,
        specifiedType: const FullType(int),
      );
    }
    if (object.refunded != null) {
      yield r'refunded';
      yield serializers.serialize(
        object.refunded,
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
    if (object.activePaid != null) {
      yield r'activePaid';
      yield serializers.serialize(
        object.activePaid,
        specifiedType: const FullType(int),
      );
    }
    if (object.activeUnpaid != null) {
      yield r'activeUnpaid';
      yield serializers.serialize(
        object.activeUnpaid,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    Line object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LineBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'tier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(LineTierEnum),
          ) as LineTierEnum?;
          if (valueDes == null) continue;
          result.tier = valueDes;
          break;
        case r'paymentCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.paymentCount = valueDes;
          break;
        case r'revenue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.revenue = valueDes;
          break;
        case r'refunded':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.refunded = valueDes;
          break;
        case r'net':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.net = valueDes;
          break;
        case r'activePaid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.activePaid = valueDes;
          break;
        case r'activeUnpaid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.activeUnpaid = valueDes;
          break;
        case r'mrr':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.mrr = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Line deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LineBuilder();
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

class LineTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FREE')
  static const LineTierEnum FREE = _$lineTierEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC_PLUS')
  static const LineTierEnum BASIC_PLUS = _$lineTierEnum_BASIC_PLUS;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const LineTierEnum PRO = _$lineTierEnum_PRO;
  @BuiltValueEnumConst(wireName: r'PRO_PLUS')
  static const LineTierEnum PRO_PLUS = _$lineTierEnum_PRO_PLUS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LineTierEnum unknownDefaultOpenApi = _$lineTierEnum_unknownDefaultOpenApi;

  static Serializer<LineTierEnum> get serializer => _$lineTierEnumSerializer;

  const LineTierEnum._(String name): super(name);

  static BuiltSet<LineTierEnum> get values => _$lineTierEnumValues;
  static LineTierEnum valueOf(String name) => _$lineTierEnumValueOf(name);
}

