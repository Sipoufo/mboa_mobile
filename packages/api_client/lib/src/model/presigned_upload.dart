//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'presigned_upload.g.dart';

/// PresignedUpload
///
/// Properties:
/// * [uploadUrl] 
/// * [method] 
/// * [objectKey] 
/// * [expiresAt] 
@BuiltValue()
abstract class PresignedUpload implements Built<PresignedUpload, PresignedUploadBuilder> {
  @BuiltValueField(wireName: r'uploadUrl')
  String? get uploadUrl;

  @BuiltValueField(wireName: r'method')
  String? get method;

  @BuiltValueField(wireName: r'objectKey')
  String? get objectKey;

  @BuiltValueField(wireName: r'expiresAt')
  DateTime? get expiresAt;

  PresignedUpload._();

  factory PresignedUpload([void updates(PresignedUploadBuilder b)]) = _$PresignedUpload;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PresignedUploadBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PresignedUpload> get serializer => _$PresignedUploadSerializer();
}

class _$PresignedUploadSerializer implements PrimitiveSerializer<PresignedUpload> {
  @override
  final Iterable<Type> types = const [PresignedUpload, _$PresignedUpload];

  @override
  final String wireName = r'PresignedUpload';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PresignedUpload object, {
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
    PresignedUpload object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PresignedUploadBuilder result,
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
  PresignedUpload deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PresignedUploadBuilder();
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

