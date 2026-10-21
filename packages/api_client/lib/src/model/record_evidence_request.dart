//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/evidence_photo_request.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'record_evidence_request.g.dart';

/// RecordEvidenceRequest
///
/// Properties:
/// * [photos] 
@BuiltValue()
abstract class RecordEvidenceRequest implements Built<RecordEvidenceRequest, RecordEvidenceRequestBuilder> {
  @BuiltValueField(wireName: r'photos')
  BuiltList<EvidencePhotoRequest> get photos;

  RecordEvidenceRequest._();

  factory RecordEvidenceRequest([void updates(RecordEvidenceRequestBuilder b)]) = _$RecordEvidenceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RecordEvidenceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RecordEvidenceRequest> get serializer => _$RecordEvidenceRequestSerializer();
}

class _$RecordEvidenceRequestSerializer implements PrimitiveSerializer<RecordEvidenceRequest> {
  @override
  final Iterable<Type> types = const [RecordEvidenceRequest, _$RecordEvidenceRequest];

  @override
  final String wireName = r'RecordEvidenceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RecordEvidenceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'photos';
    yield serializers.serialize(
      object.photos,
      specifiedType: const FullType(BuiltList, [FullType(EvidencePhotoRequest)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RecordEvidenceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RecordEvidenceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'photos':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(EvidencePhotoRequest)]),
          ) as BuiltList<EvidencePhotoRequest>;
          result.photos.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RecordEvidenceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RecordEvidenceRequestBuilder();
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

