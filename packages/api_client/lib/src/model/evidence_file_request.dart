//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'evidence_file_request.g.dart';

/// EvidenceFileRequest
///
/// Properties:
/// * [contentType] 
/// * [size] 
/// * [sha256] 
@BuiltValue()
abstract class EvidenceFileRequest implements Built<EvidenceFileRequest, EvidenceFileRequestBuilder> {
  @BuiltValueField(wireName: r'contentType')
  String get contentType;

  @BuiltValueField(wireName: r'size')
  int get size;

  @BuiltValueField(wireName: r'sha256')
  String get sha256;

  EvidenceFileRequest._();

  factory EvidenceFileRequest([void updates(EvidenceFileRequestBuilder b)]) = _$EvidenceFileRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EvidenceFileRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EvidenceFileRequest> get serializer => _$EvidenceFileRequestSerializer();
}

class _$EvidenceFileRequestSerializer implements PrimitiveSerializer<EvidenceFileRequest> {
  @override
  final Iterable<Type> types = const [EvidenceFileRequest, _$EvidenceFileRequest];

  @override
  final String wireName = r'EvidenceFileRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EvidenceFileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'contentType';
    yield serializers.serialize(
      object.contentType,
      specifiedType: const FullType(String),
    );
    yield r'size';
    yield serializers.serialize(
      object.size,
      specifiedType: const FullType(int),
    );
    yield r'sha256';
    yield serializers.serialize(
      object.sha256,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EvidenceFileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EvidenceFileRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'contentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.contentType = valueDes;
          break;
        case r'size':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.size = valueDes;
          break;
        case r'sha256':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sha256 = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EvidenceFileRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EvidenceFileRequestBuilder();
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

