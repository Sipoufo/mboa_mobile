//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'score_signal.g.dart';

/// ScoreSignal
///
/// Properties:
/// * [code] 
/// * [points] 
/// * [maxPoints] 
/// * [count] 
/// * [available] 
@BuiltValue()
abstract class ScoreSignal implements Built<ScoreSignal, ScoreSignalBuilder> {
  @BuiltValueField(wireName: r'code')
  ScoreSignalCodeEnum? get code;
  // enum codeEnum {  PROFILE_COMPLETE,  IDENTITY_VERIFIED,  ACCOUNT_SENIORITY,  SIGNED_CONTRACTS,  PROVIDER_RATING,  VALIDATED_REPORTS,  ADMIN_ADJUSTMENT,  };

  @BuiltValueField(wireName: r'points')
  int? get points;

  @BuiltValueField(wireName: r'maxPoints')
  int? get maxPoints;

  @BuiltValueField(wireName: r'count')
  int? get count;

  @BuiltValueField(wireName: r'available')
  bool? get available;

  ScoreSignal._();

  factory ScoreSignal([void updates(ScoreSignalBuilder b)]) = _$ScoreSignal;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScoreSignalBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScoreSignal> get serializer => _$ScoreSignalSerializer();
}

class _$ScoreSignalSerializer implements PrimitiveSerializer<ScoreSignal> {
  @override
  final Iterable<Type> types = const [ScoreSignal, _$ScoreSignal];

  @override
  final String wireName = r'ScoreSignal';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScoreSignal object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(ScoreSignalCodeEnum),
      );
    }
    if (object.points != null) {
      yield r'points';
      yield serializers.serialize(
        object.points,
        specifiedType: const FullType(int),
      );
    }
    if (object.maxPoints != null) {
      yield r'maxPoints';
      yield serializers.serialize(
        object.maxPoints,
        specifiedType: const FullType(int),
      );
    }
    if (object.count != null) {
      yield r'count';
      yield serializers.serialize(
        object.count,
        specifiedType: const FullType(int),
      );
    }
    if (object.available != null) {
      yield r'available';
      yield serializers.serialize(
        object.available,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ScoreSignal object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ScoreSignalBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ScoreSignalCodeEnum),
          ) as ScoreSignalCodeEnum?;
          if (valueDes == null) continue;
          result.code = valueDes;
          break;
        case r'points':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.points = valueDes;
          break;
        case r'maxPoints':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.maxPoints = valueDes;
          break;
        case r'count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.count = valueDes;
          break;
        case r'available':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.available = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ScoreSignal deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScoreSignalBuilder();
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

class ScoreSignalCodeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PROFILE_COMPLETE')
  static const ScoreSignalCodeEnum PROFILE_COMPLETE = _$scoreSignalCodeEnum_PROFILE_COMPLETE;
  @BuiltValueEnumConst(wireName: r'IDENTITY_VERIFIED')
  static const ScoreSignalCodeEnum IDENTITY_VERIFIED = _$scoreSignalCodeEnum_IDENTITY_VERIFIED;
  @BuiltValueEnumConst(wireName: r'ACCOUNT_SENIORITY')
  static const ScoreSignalCodeEnum ACCOUNT_SENIORITY = _$scoreSignalCodeEnum_ACCOUNT_SENIORITY;
  @BuiltValueEnumConst(wireName: r'SIGNED_CONTRACTS')
  static const ScoreSignalCodeEnum SIGNED_CONTRACTS = _$scoreSignalCodeEnum_SIGNED_CONTRACTS;
  @BuiltValueEnumConst(wireName: r'PROVIDER_RATING')
  static const ScoreSignalCodeEnum PROVIDER_RATING = _$scoreSignalCodeEnum_PROVIDER_RATING;
  @BuiltValueEnumConst(wireName: r'VALIDATED_REPORTS')
  static const ScoreSignalCodeEnum VALIDATED_REPORTS = _$scoreSignalCodeEnum_VALIDATED_REPORTS;
  @BuiltValueEnumConst(wireName: r'ADMIN_ADJUSTMENT')
  static const ScoreSignalCodeEnum ADMIN_ADJUSTMENT = _$scoreSignalCodeEnum_ADMIN_ADJUSTMENT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ScoreSignalCodeEnum unknownDefaultOpenApi = _$scoreSignalCodeEnum_unknownDefaultOpenApi;

  static Serializer<ScoreSignalCodeEnum> get serializer => _$scoreSignalCodeEnumSerializer;

  const ScoreSignalCodeEnum._(String name): super(name);

  static BuiltSet<ScoreSignalCodeEnum> get values => _$scoreSignalCodeEnumValues;
  static ScoreSignalCodeEnum valueOf(String name) => _$scoreSignalCodeEnumValueOf(name);
}

