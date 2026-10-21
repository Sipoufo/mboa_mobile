//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'evidence_photo_request.g.dart';

/// EvidencePhotoRequest
///
/// Properties:
/// * [objectKey] 
/// * [sha256] 
/// * [room] 
/// * [roomLabel] 
/// * [phase] 
/// * [comment] 
@BuiltValue()
abstract class EvidencePhotoRequest implements Built<EvidencePhotoRequest, EvidencePhotoRequestBuilder> {
  @BuiltValueField(wireName: r'objectKey')
  String get objectKey;

  @BuiltValueField(wireName: r'sha256')
  String get sha256;

  @BuiltValueField(wireName: r'room')
  EvidencePhotoRequestRoomEnum get room;
  // enum roomEnum {  LIVING_ROOM,  BEDROOM,  KITCHEN,  BATHROOM,  TOILET,  OUTDOOR,  OTHER,  };

  @BuiltValueField(wireName: r'roomLabel')
  String? get roomLabel;

  @BuiltValueField(wireName: r'phase')
  EvidencePhotoRequestPhaseEnum get phase;
  // enum phaseEnum {  ENTRY,  STAY,  EXIT,  };

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  EvidencePhotoRequest._();

  factory EvidencePhotoRequest([void updates(EvidencePhotoRequestBuilder b)]) = _$EvidencePhotoRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EvidencePhotoRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EvidencePhotoRequest> get serializer => _$EvidencePhotoRequestSerializer();
}

class _$EvidencePhotoRequestSerializer implements PrimitiveSerializer<EvidencePhotoRequest> {
  @override
  final Iterable<Type> types = const [EvidencePhotoRequest, _$EvidencePhotoRequest];

  @override
  final String wireName = r'EvidencePhotoRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EvidencePhotoRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'objectKey';
    yield serializers.serialize(
      object.objectKey,
      specifiedType: const FullType(String),
    );
    yield r'sha256';
    yield serializers.serialize(
      object.sha256,
      specifiedType: const FullType(String),
    );
    yield r'room';
    yield serializers.serialize(
      object.room,
      specifiedType: const FullType(EvidencePhotoRequestRoomEnum),
    );
    if (object.roomLabel != null) {
      yield r'roomLabel';
      yield serializers.serialize(
        object.roomLabel,
        specifiedType: const FullType(String),
      );
    }
    yield r'phase';
    yield serializers.serialize(
      object.phase,
      specifiedType: const FullType(EvidencePhotoRequestPhaseEnum),
    );
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
    EvidencePhotoRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EvidencePhotoRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'objectKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.objectKey = valueDes;
          break;
        case r'sha256':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sha256 = valueDes;
          break;
        case r'room':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EvidencePhotoRequestRoomEnum),
          ) as EvidencePhotoRequestRoomEnum;
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
            specifiedType: const FullType(EvidencePhotoRequestPhaseEnum),
          ) as EvidencePhotoRequestPhaseEnum;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EvidencePhotoRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EvidencePhotoRequestBuilder();
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

class EvidencePhotoRequestRoomEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LIVING_ROOM')
  static const EvidencePhotoRequestRoomEnum LIVING_ROOM = _$evidencePhotoRequestRoomEnum_LIVING_ROOM;
  @BuiltValueEnumConst(wireName: r'BEDROOM')
  static const EvidencePhotoRequestRoomEnum BEDROOM = _$evidencePhotoRequestRoomEnum_BEDROOM;
  @BuiltValueEnumConst(wireName: r'KITCHEN')
  static const EvidencePhotoRequestRoomEnum KITCHEN = _$evidencePhotoRequestRoomEnum_KITCHEN;
  @BuiltValueEnumConst(wireName: r'BATHROOM')
  static const EvidencePhotoRequestRoomEnum BATHROOM = _$evidencePhotoRequestRoomEnum_BATHROOM;
  @BuiltValueEnumConst(wireName: r'TOILET')
  static const EvidencePhotoRequestRoomEnum TOILET = _$evidencePhotoRequestRoomEnum_TOILET;
  @BuiltValueEnumConst(wireName: r'OUTDOOR')
  static const EvidencePhotoRequestRoomEnum OUTDOOR = _$evidencePhotoRequestRoomEnum_OUTDOOR;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const EvidencePhotoRequestRoomEnum OTHER = _$evidencePhotoRequestRoomEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EvidencePhotoRequestRoomEnum unknownDefaultOpenApi = _$evidencePhotoRequestRoomEnum_unknownDefaultOpenApi;

  static Serializer<EvidencePhotoRequestRoomEnum> get serializer => _$evidencePhotoRequestRoomEnumSerializer;

  const EvidencePhotoRequestRoomEnum._(String name): super(name);

  static BuiltSet<EvidencePhotoRequestRoomEnum> get values => _$evidencePhotoRequestRoomEnumValues;
  static EvidencePhotoRequestRoomEnum valueOf(String name) => _$evidencePhotoRequestRoomEnumValueOf(name);
}

class EvidencePhotoRequestPhaseEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ENTRY')
  static const EvidencePhotoRequestPhaseEnum ENTRY = _$evidencePhotoRequestPhaseEnum_ENTRY;
  @BuiltValueEnumConst(wireName: r'STAY')
  static const EvidencePhotoRequestPhaseEnum STAY = _$evidencePhotoRequestPhaseEnum_STAY;
  @BuiltValueEnumConst(wireName: r'EXIT')
  static const EvidencePhotoRequestPhaseEnum EXIT = _$evidencePhotoRequestPhaseEnum_EXIT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EvidencePhotoRequestPhaseEnum unknownDefaultOpenApi = _$evidencePhotoRequestPhaseEnum_unknownDefaultOpenApi;

  static Serializer<EvidencePhotoRequestPhaseEnum> get serializer => _$evidencePhotoRequestPhaseEnumSerializer;

  const EvidencePhotoRequestPhaseEnum._(String name): super(name);

  static BuiltSet<EvidencePhotoRequestPhaseEnum> get values => _$evidencePhotoRequestPhaseEnumValues;
  static EvidencePhotoRequestPhaseEnum valueOf(String name) => _$evidencePhotoRequestPhaseEnumValueOf(name);
}

