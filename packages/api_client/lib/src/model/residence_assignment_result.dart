//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/skipped_unit.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'residence_assignment_result.g.dart';

/// ResidenceAssignmentResult
///
/// Properties:
/// * [residenceId] 
/// * [residenceName] 
/// * [agentAccountId] 
/// * [offered] 
/// * [skipped] 
@BuiltValue()
abstract class ResidenceAssignmentResult implements Built<ResidenceAssignmentResult, ResidenceAssignmentResultBuilder> {
  @BuiltValueField(wireName: r'residenceId')
  String? get residenceId;

  @BuiltValueField(wireName: r'residenceName')
  String? get residenceName;

  @BuiltValueField(wireName: r'agentAccountId')
  String? get agentAccountId;

  @BuiltValueField(wireName: r'offered')
  int? get offered;

  @BuiltValueField(wireName: r'skipped')
  BuiltList<SkippedUnit>? get skipped;

  ResidenceAssignmentResult._();

  factory ResidenceAssignmentResult([void updates(ResidenceAssignmentResultBuilder b)]) = _$ResidenceAssignmentResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResidenceAssignmentResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResidenceAssignmentResult> get serializer => _$ResidenceAssignmentResultSerializer();
}

class _$ResidenceAssignmentResultSerializer implements PrimitiveSerializer<ResidenceAssignmentResult> {
  @override
  final Iterable<Type> types = const [ResidenceAssignmentResult, _$ResidenceAssignmentResult];

  @override
  final String wireName = r'ResidenceAssignmentResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResidenceAssignmentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.residenceId != null) {
      yield r'residenceId';
      yield serializers.serialize(
        object.residenceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.residenceName != null) {
      yield r'residenceName';
      yield serializers.serialize(
        object.residenceName,
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
    if (object.offered != null) {
      yield r'offered';
      yield serializers.serialize(
        object.offered,
        specifiedType: const FullType(int),
      );
    }
    if (object.skipped != null) {
      yield r'skipped';
      yield serializers.serialize(
        object.skipped,
        specifiedType: const FullType(BuiltList, [FullType(SkippedUnit)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ResidenceAssignmentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResidenceAssignmentResultBuilder result,
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
        case r'residenceName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.residenceName = valueDes;
          break;
        case r'agentAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.agentAccountId = valueDes;
          break;
        case r'offered':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.offered = valueDes;
          break;
        case r'skipped':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SkippedUnit)]),
          ) as BuiltList<SkippedUnit>?;
          if (valueDes == null) continue;
          result.skipped.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResidenceAssignmentResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResidenceAssignmentResultBuilder();
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

