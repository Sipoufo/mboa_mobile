//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'evidence_upload.g.dart';

/// EvidenceUpload
///
/// Properties:
/// * [uploadUrl] 
/// * [method] 
/// * [objectKey] 
/// * [headers] 
/// * [expiresAt] 
@BuiltValue()
abstract class EvidenceUpload implements Built<EvidenceUpload, EvidenceUploadBuilder> {
  @BuiltValueField(wireName: r'uploadUrl')
  String? get uploadUrl;

  @BuiltValueField(wireName: r'method')
  String? get method;

  @BuiltValueField(wireName: r'objectKey')
  String? get objectKey;

  @BuiltValueField(wireName: r'headers')
  BuiltMap<String, String>? get headers;

  @BuiltValueField(wireName: r'expiresAt')
  DateTime? get expiresAt;

  EvidenceUpload._();

  factory EvidenceUpload([void updates(EvidenceUploadBuilder b)]) = _$EvidenceUpload;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EvidenceUploadBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EvidenceUpload> get serializer => _$EvidenceUploadSerializer();
}

class _$EvidenceUploadSerializer implements PrimitiveSerializer<EvidenceUpload> {
  @override
  final Iterable<Type> types = const [EvidenceUpload, _$EvidenceUpload];

  @override
  final String wireName = r'EvidenceUpload';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EvidenceUpload object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.uploadUrl != null) {
      yield r'uploadUrl';
      yield serializers.serialize(
        object.uploadUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.method != null) {
      yield r'method';
      yield serializers.serialize(
        object.method,
        specifiedType: const FullType(String),
      );
    }
    if (object.objectKey != null) {
      yield r'objectKey';
      yield serializers.serialize(
        object.objectKey,
        specifiedType: const FullType(String),
      );
    }
    if (object.headers != null) {
      yield r'headers';
      yield serializers.serialize(
        object.headers,
        specifiedType: const FullType(BuiltMap, [FullType(String), FullType(String)]),
      );
    }
    if (object.expiresAt != null) {
      yield r'expiresAt';
      yield serializers.serialize(
        object.expiresAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    EvidenceUpload object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EvidenceUploadBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'uploadUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.uploadUrl = valueDes;
          break;
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.method = valueDes;
          break;
        case r'objectKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.objectKey = valueDes;
          break;
        case r'headers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(String)]),
          ) as BuiltMap<String, String>?;
          if (valueDes == null) continue;
          result.headers.replace(valueDes);
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.expiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EvidenceUpload deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EvidenceUploadBuilder();
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

