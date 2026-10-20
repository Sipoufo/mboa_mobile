//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'home_deposit.g.dart';

/// HomeDeposit
///
/// Properties:
/// * [amount] 
/// * [confirmedTotal] 
/// * [status] 
@BuiltValue()
abstract class HomeDeposit implements Built<HomeDeposit, HomeDepositBuilder> {
  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'confirmedTotal')
  int? get confirmedTotal;

  @BuiltValueField(wireName: r'status')
  HomeDepositStatusEnum? get status;
  // enum statusEnum {  NONE,  DECLARED,  UNCONFIRMED,  CONFIRMED,  CONTESTED,  };

  HomeDeposit._();

  factory HomeDeposit([void updates(HomeDepositBuilder b)]) = _$HomeDeposit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HomeDepositBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HomeDeposit> get serializer => _$HomeDepositSerializer();
}

class _$HomeDepositSerializer implements PrimitiveSerializer<HomeDeposit> {
  @override
  final Iterable<Type> types = const [HomeDeposit, _$HomeDeposit];

  @override
  final String wireName = r'HomeDeposit';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HomeDeposit object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
        specifiedType: const FullType(HomeDepositStatusEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HomeDeposit object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HomeDepositBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType.nullable(HomeDepositStatusEnum),
          ) as HomeDepositStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HomeDeposit deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HomeDepositBuilder();
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

class HomeDepositStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'NONE')
  static const HomeDepositStatusEnum NONE = _$homeDepositStatusEnum_NONE;
  @BuiltValueEnumConst(wireName: r'DECLARED')
  static const HomeDepositStatusEnum DECLARED = _$homeDepositStatusEnum_DECLARED;
  @BuiltValueEnumConst(wireName: r'UNCONFIRMED')
  static const HomeDepositStatusEnum UNCONFIRMED = _$homeDepositStatusEnum_UNCONFIRMED;
  @BuiltValueEnumConst(wireName: r'CONFIRMED')
  static const HomeDepositStatusEnum CONFIRMED = _$homeDepositStatusEnum_CONFIRMED;
  @BuiltValueEnumConst(wireName: r'CONTESTED')
  static const HomeDepositStatusEnum CONTESTED = _$homeDepositStatusEnum_CONTESTED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const HomeDepositStatusEnum unknownDefaultOpenApi = _$homeDepositStatusEnum_unknownDefaultOpenApi;

  static Serializer<HomeDepositStatusEnum> get serializer => _$homeDepositStatusEnumSerializer;

  const HomeDepositStatusEnum._(String name): super(name);

  static BuiltSet<HomeDepositStatusEnum> get values => _$homeDepositStatusEnumValues;
  static HomeDepositStatusEnum valueOf(String name) => _$homeDepositStatusEnumValueOf(name);
}

