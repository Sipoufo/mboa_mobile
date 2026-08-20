//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'participant_summary.g.dart';

/// ParticipantSummary
///
/// Properties:
/// * [accountId] 
/// * [displayName] 
/// * [photoObjectKey] 
@BuiltValue()
abstract class ParticipantSummary implements Built<ParticipantSummary, ParticipantSummaryBuilder> {
  @BuiltValueField(wireName: r'accountId')
  String? get accountId;

  @BuiltValueField(wireName: r'displayName')
  String? get displayName;

  @BuiltValueField(wireName: r'photoObjectKey')
  String? get photoObjectKey;

  ParticipantSummary._();

  factory ParticipantSummary([void updates(ParticipantSummaryBuilder b)]) = _$ParticipantSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParticipantSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParticipantSummary> get serializer => _$ParticipantSummarySerializer();
}

class _$ParticipantSummarySerializer implements PrimitiveSerializer<ParticipantSummary> {
  @override
  final Iterable<Type> types = const [ParticipantSummary, _$ParticipantSummary];

  @override
  final String wireName = r'ParticipantSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParticipantSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.accountId != null) {
      yield r'accountId';
      yield serializers.serialize(
        object.accountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.displayName != null) {
      yield r'displayName';
      yield serializers.serialize(
        object.displayName,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ParticipantSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParticipantSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'accountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.accountId = valueDes;
          break;
        case r'displayName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.displayName = valueDes;
          break;
        case r'photoObjectKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.photoObjectKey = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParticipantSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParticipantSummaryBuilder();
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

