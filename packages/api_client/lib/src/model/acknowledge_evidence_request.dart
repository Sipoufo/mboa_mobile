//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'acknowledge_evidence_request.g.dart';

/// AcknowledgeEvidenceRequest
///
/// Properties:
/// * [comment] 
@BuiltValue()
abstract class AcknowledgeEvidenceRequest implements Built<AcknowledgeEvidenceRequest, AcknowledgeEvidenceRequestBuilder> {
  @BuiltValueField(wireName: r'comment')
  String? get comment;

  AcknowledgeEvidenceRequest._();

  factory AcknowledgeEvidenceRequest([void updates(AcknowledgeEvidenceRequestBuilder b)]) = _$AcknowledgeEvidenceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AcknowledgeEvidenceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AcknowledgeEvidenceRequest> get serializer => _$AcknowledgeEvidenceRequestSerializer();
}

class _$AcknowledgeEvidenceRequestSerializer implements PrimitiveSerializer<AcknowledgeEvidenceRequest> {
  @override
  final Iterable<Type> types = const [AcknowledgeEvidenceRequest, _$AcknowledgeEvidenceRequest];

  @override
  final String wireName = r'AcknowledgeEvidenceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AcknowledgeEvidenceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AcknowledgeEvidenceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AcknowledgeEvidenceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AcknowledgeEvidenceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AcknowledgeEvidenceRequestBuilder();
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

