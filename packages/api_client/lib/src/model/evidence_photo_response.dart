//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'evidence_photo_response.g.dart';

/// EvidencePhotoResponse
///
/// Properties:
/// * [id] 
/// * [room] 
/// * [roomLabel] 
/// * [phase] 
/// * [comment] 
/// * [sha256] 
/// * [sizeBytes] 
/// * [recordedAt] 
/// * [downloadUrl] 
@BuiltValue()
abstract class EvidencePhotoResponse implements Built<EvidencePhotoResponse, EvidencePhotoResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'room')
  EvidencePhotoResponseRoomEnum? get room;
  // enum roomEnum {  LIVING_ROOM,  BEDROOM,  KITCHEN,  BATHROOM,  TOILET,  OUTDOOR,  OTHER,  };

  @BuiltValueField(wireName: r'roomLabel')
  String? get roomLabel;

  @BuiltValueField(wireName: r'phase')
  EvidencePhotoResponsePhaseEnum? get phase;
  // enum phaseEnum {  ENTRY,  STAY,  EXIT,  };

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'sha256')
  String? get sha256;

  @BuiltValueField(wireName: r'sizeBytes')
  int? get sizeBytes;

  @BuiltValueField(wireName: r'recordedAt')
  DateTime? get recordedAt;

  @BuiltValueField(wireName: r'downloadUrl')
  String? get downloadUrl;

  EvidencePhotoResponse._();

  factory EvidencePhotoResponse([void updates(EvidencePhotoResponseBuilder b)]) = _$EvidencePhotoResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EvidencePhotoResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EvidencePhotoResponse> get serializer => _$EvidencePhotoResponseSerializer();
}

class _$EvidencePhotoResponseSerializer implements PrimitiveSerializer<EvidencePhotoResponse> {
  @override
  final Iterable<Type> types = const [EvidencePhotoResponse, _$EvidencePhotoResponse];

  @override
  final String wireName = r'EvidencePhotoResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EvidencePhotoResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.room != null) {
      yield r'room';
      yield serializers.serialize(
        object.room,
        specifiedType: const FullType(EvidencePhotoResponseRoomEnum),
      );
    }
    if (object.roomLabel != null) {
      yield r'roomLabel';
      yield serializers.serialize(
        object.roomLabel,
        specifiedType: const FullType(String),
      );
    }
    if (object.phase != null) {
      yield r'phase';
      yield serializers.serialize(
        object.phase,
        specifiedType: const FullType(EvidencePhotoResponsePhaseEnum),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(String),
      );
    }
    if (object.sha256 != null) {
      yield r'sha256';
      yield serializers.serialize(
        object.sha256,
        specifiedType: const FullType(String),
      );
    }
    if (object.sizeBytes != null) {
      yield r'sizeBytes';
      yield serializers.serialize(
        object.sizeBytes,
        specifiedType: const FullType(int),
      );
    }
    if (object.recordedAt != null) {
      yield r'recordedAt';
      yield serializers.serialize(
        object.recordedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.downloadUrl != null) {
      yield r'downloadUrl';
      yield serializers.serialize(
        object.downloadUrl,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    EvidencePhotoResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EvidencePhotoResponseBuilder result,
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
        case r'room':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(EvidencePhotoResponseRoomEnum),
          ) as EvidencePhotoResponseRoomEnum?;
          if (valueDes == null) continue;
          result.room = valueDes;
          break;
        case r'roomLabel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.roomLabel = valueDes;
          break;
        case r'phase':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(EvidencePhotoResponsePhaseEnum),
          ) as EvidencePhotoResponsePhaseEnum?;
          if (valueDes == null) continue;
          result.phase = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        case r'sha256':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.sha256 = valueDes;
          break;
        case r'sizeBytes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.sizeBytes = valueDes;
          break;
        case r'recordedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.recordedAt = valueDes;
          break;
        case r'downloadUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.downloadUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EvidencePhotoResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EvidencePhotoResponseBuilder();
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

class EvidencePhotoResponseRoomEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LIVING_ROOM')
  static const EvidencePhotoResponseRoomEnum LIVING_ROOM = _$evidencePhotoResponseRoomEnum_LIVING_ROOM;
  @BuiltValueEnumConst(wireName: r'BEDROOM')
  static const EvidencePhotoResponseRoomEnum BEDROOM = _$evidencePhotoResponseRoomEnum_BEDROOM;
  @BuiltValueEnumConst(wireName: r'KITCHEN')
  static const EvidencePhotoResponseRoomEnum KITCHEN = _$evidencePhotoResponseRoomEnum_KITCHEN;
  @BuiltValueEnumConst(wireName: r'BATHROOM')
  static const EvidencePhotoResponseRoomEnum BATHROOM = _$evidencePhotoResponseRoomEnum_BATHROOM;
  @BuiltValueEnumConst(wireName: r'TOILET')
  static const EvidencePhotoResponseRoomEnum TOILET = _$evidencePhotoResponseRoomEnum_TOILET;
  @BuiltValueEnumConst(wireName: r'OUTDOOR')
  static const EvidencePhotoResponseRoomEnum OUTDOOR = _$evidencePhotoResponseRoomEnum_OUTDOOR;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const EvidencePhotoResponseRoomEnum OTHER = _$evidencePhotoResponseRoomEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EvidencePhotoResponseRoomEnum unknownDefaultOpenApi = _$evidencePhotoResponseRoomEnum_unknownDefaultOpenApi;

  static Serializer<EvidencePhotoResponseRoomEnum> get serializer => _$evidencePhotoResponseRoomEnumSerializer;

  const EvidencePhotoResponseRoomEnum._(String name): super(name);

  static BuiltSet<EvidencePhotoResponseRoomEnum> get values => _$evidencePhotoResponseRoomEnumValues;
  static EvidencePhotoResponseRoomEnum valueOf(String name) => _$evidencePhotoResponseRoomEnumValueOf(name);
}

class EvidencePhotoResponsePhaseEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ENTRY')
  static const EvidencePhotoResponsePhaseEnum ENTRY = _$evidencePhotoResponsePhaseEnum_ENTRY;
  @BuiltValueEnumConst(wireName: r'STAY')
  static const EvidencePhotoResponsePhaseEnum STAY = _$evidencePhotoResponsePhaseEnum_STAY;
  @BuiltValueEnumConst(wireName: r'EXIT')
  static const EvidencePhotoResponsePhaseEnum EXIT = _$evidencePhotoResponsePhaseEnum_EXIT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EvidencePhotoResponsePhaseEnum unknownDefaultOpenApi = _$evidencePhotoResponsePhaseEnum_unknownDefaultOpenApi;

  static Serializer<EvidencePhotoResponsePhaseEnum> get serializer => _$evidencePhotoResponsePhaseEnumSerializer;

  const EvidencePhotoResponsePhaseEnum._(String name): super(name);

  static BuiltSet<EvidencePhotoResponsePhaseEnum> get values => _$evidencePhotoResponsePhaseEnumValues;
  static EvidencePhotoResponsePhaseEnum valueOf(String name) => _$evidencePhotoResponsePhaseEnumValueOf(name);
}

