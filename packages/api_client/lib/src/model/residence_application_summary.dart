//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'residence_application_summary.g.dart';

/// ResidenceApplicationSummary
///
/// Properties:
/// * [residenceId] 
/// * [agentAccountId] 
/// * [agentName] 
/// * [photoObjectKey] 
/// * [completedVisitCount] 
/// * [unitCount] 
/// * [appliedAt] 
@BuiltValue()
abstract class ResidenceApplicationSummary implements Built<ResidenceApplicationSummary, ResidenceApplicationSummaryBuilder> {
  @BuiltValueField(wireName: r'residenceId')
  String? get residenceId;

  @BuiltValueField(wireName: r'agentAccountId')
  String? get agentAccountId;

  @BuiltValueField(wireName: r'agentName')
  String? get agentName;

  @BuiltValueField(wireName: r'photoObjectKey')
  String? get photoObjectKey;

  @BuiltValueField(wireName: r'completedVisitCount')
  int? get completedVisitCount;

  @BuiltValueField(wireName: r'unitCount')
  int? get unitCount;

  @BuiltValueField(wireName: r'appliedAt')
  DateTime? get appliedAt;

  ResidenceApplicationSummary._();

  factory ResidenceApplicationSummary([void updates(ResidenceApplicationSummaryBuilder b)]) = _$ResidenceApplicationSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResidenceApplicationSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResidenceApplicationSummary> get serializer => _$ResidenceApplicationSummarySerializer();
}

class _$ResidenceApplicationSummarySerializer implements PrimitiveSerializer<ResidenceApplicationSummary> {
  @override
  final Iterable<Type> types = const [ResidenceApplicationSummary, _$ResidenceApplicationSummary];

  @override
  final String wireName = r'ResidenceApplicationSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResidenceApplicationSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.residenceId != null) {
      yield r'residenceId';
      yield serializers.serialize(
        object.residenceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.agentAccountId != null) {
      yield r'agentAccountId';
      yield serializers.serialize(
        object.agentAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.agentName != null) {
      yield r'agentName';
      yield serializers.serialize(
        object.agentName,
        specifiedType: const FullType(String),
      );
    }
    if (object.photoObjectKey != null) {
      yield r'photoObjectKey';
      yield serializers.serialize(
        object.photoObjectKey,
        specifiedType: const FullType(String),
      );
    }
    if (object.completedVisitCount != null) {
      yield r'completedVisitCount';
      yield serializers.serialize(
        object.completedVisitCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.unitCount != null) {
      yield r'unitCount';
      yield serializers.serialize(
        object.unitCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.appliedAt != null) {
      yield r'appliedAt';
      yield serializers.serialize(
        object.appliedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ResidenceApplicationSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResidenceApplicationSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'residenceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.residenceId = valueDes;
          break;
        case r'agentAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.agentAccountId = valueDes;
          break;
        case r'agentName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.agentName = valueDes;
          break;
        case r'photoObjectKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.photoObjectKey = valueDes;
          break;
        case r'completedVisitCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.completedVisitCount = valueDes;
          break;
        case r'unitCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.unitCount = valueDes;
          break;
        case r'appliedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.appliedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResidenceApplicationSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResidenceApplicationSummaryBuilder();
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

