//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/evidence_file_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'evidence_uploads_request.g.dart';

/// EvidenceUploadsRequest
///
/// Properties:
/// * [files] 
@BuiltValue()
abstract class EvidenceUploadsRequest implements Built<EvidenceUploadsRequest, EvidenceUploadsRequestBuilder> {
  @BuiltValueField(wireName: r'files')
  BuiltList<EvidenceFileRequest> get files;

  EvidenceUploadsRequest._();

  factory EvidenceUploadsRequest([void updates(EvidenceUploadsRequestBuilder b)]) = _$EvidenceUploadsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EvidenceUploadsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EvidenceUploadsRequest> get serializer => _$EvidenceUploadsRequestSerializer();
}

class _$EvidenceUploadsRequestSerializer implements PrimitiveSerializer<EvidenceUploadsRequest> {
  @override
  final Iterable<Type> types = const [EvidenceUploadsRequest, _$EvidenceUploadsRequest];

  @override
  final String wireName = r'EvidenceUploadsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EvidenceUploadsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'files';
    yield serializers.serialize(
      object.files,
      specifiedType: const FullType(BuiltList, [FullType(EvidenceFileRequest)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EvidenceUploadsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EvidenceUploadsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'files':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(EvidenceFileRequest)]),
          ) as BuiltList<EvidenceFileRequest>;
          result.files.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EvidenceUploadsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EvidenceUploadsRequestBuilder();
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

