//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/evidence_photo_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'evidence_batch_response.g.dart';

/// EvidenceBatchResponse
///
/// Properties:
/// * [id] 
/// * [contractId] 
/// * [recordedAt] 
/// * [photos] 
/// * [acknowledgedAt] 
/// * [ownerComment] 
/// * [canAcknowledge] 
@BuiltValue()
abstract class EvidenceBatchResponse implements Built<EvidenceBatchResponse, EvidenceBatchResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'contractId')
  String? get contractId;

  @BuiltValueField(wireName: r'recordedAt')
  DateTime? get recordedAt;

  @BuiltValueField(wireName: r'photos')
  BuiltList<EvidencePhotoResponse>? get photos;

  @BuiltValueField(wireName: r'acknowledgedAt')
  DateTime? get acknowledgedAt;

  @BuiltValueField(wireName: r'ownerComment')
  String? get ownerComment;

  @BuiltValueField(wireName: r'canAcknowledge')
  bool? get canAcknowledge;

  EvidenceBatchResponse._();

  factory EvidenceBatchResponse([void updates(EvidenceBatchResponseBuilder b)]) = _$EvidenceBatchResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EvidenceBatchResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EvidenceBatchResponse> get serializer => _$EvidenceBatchResponseSerializer();
}

class _$EvidenceBatchResponseSerializer implements PrimitiveSerializer<EvidenceBatchResponse> {
  @override
  final Iterable<Type> types = const [EvidenceBatchResponse, _$EvidenceBatchResponse];

  @override
  final String wireName = r'EvidenceBatchResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EvidenceBatchResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.contractId != null) {
      yield r'contractId';
      yield serializers.serialize(
        object.contractId,
        specifiedType: const FullType(String),
      );
    }
    if (object.recordedAt != null) {
      yield r'recordedAt';
      yield serializers.serialize(
        object.recordedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.photos != null) {
      yield r'photos';
      yield serializers.serialize(
        object.photos,
        specifiedType: const FullType(BuiltList, [FullType(EvidencePhotoResponse)]),
      );
    }
    if (object.acknowledgedAt != null) {
      yield r'acknowledgedAt';
      yield serializers.serialize(
        object.acknowledgedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.ownerComment != null) {
      yield r'ownerComment';
      yield serializers.serialize(
        object.ownerComment,
        specifiedType: const FullType(String),
      );
    }
    if (object.canAcknowledge != null) {
      yield r'canAcknowledge';
      yield serializers.serialize(
        object.canAcknowledge,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    EvidenceBatchResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EvidenceBatchResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.id = valueDes;
          break;
        case r'contractId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contractId = valueDes;
          break;
        case r'recordedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.recordedAt = valueDes;
          break;
        case r'photos':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(EvidencePhotoResponse)]),
          ) as BuiltList<EvidencePhotoResponse>?;
          if (valueDes == null) continue;
          result.photos.replace(valueDes);
          break;
        case r'acknowledgedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.acknowledgedAt = valueDes;
          break;
        case r'ownerComment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.ownerComment = valueDes;
          break;
        case r'canAcknowledge':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canAcknowledge = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EvidenceBatchResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EvidenceBatchResponseBuilder();
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

