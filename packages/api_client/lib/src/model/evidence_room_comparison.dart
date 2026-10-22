//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/evidence_photo_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'evidence_room_comparison.g.dart';

/// EvidenceRoomComparison
///
/// Properties:
/// * [room] 
/// * [roomLabel] 
/// * [entry] 
/// * [exit] 
@BuiltValue()
abstract class EvidenceRoomComparison implements Built<EvidenceRoomComparison, EvidenceRoomComparisonBuilder> {
  @BuiltValueField(wireName: r'room')
  EvidenceRoomComparisonRoomEnum? get room;
  // enum roomEnum {  LIVING_ROOM,  BEDROOM,  KITCHEN,  BATHROOM,  TOILET,  OUTDOOR,  OTHER,  };

  @BuiltValueField(wireName: r'roomLabel')
  String? get roomLabel;

  @BuiltValueField(wireName: r'entry')
  BuiltList<EvidencePhotoResponse>? get entry;

  @BuiltValueField(wireName: r'exit')
  BuiltList<EvidencePhotoResponse>? get exit;

  EvidenceRoomComparison._();

  factory EvidenceRoomComparison([void updates(EvidenceRoomComparisonBuilder b)]) = _$EvidenceRoomComparison;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EvidenceRoomComparisonBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EvidenceRoomComparison> get serializer => _$EvidenceRoomComparisonSerializer();
}

class _$EvidenceRoomComparisonSerializer implements PrimitiveSerializer<EvidenceRoomComparison> {
  @override
  final Iterable<Type> types = const [EvidenceRoomComparison, _$EvidenceRoomComparison];

  @override
  final String wireName = r'EvidenceRoomComparison';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EvidenceRoomComparison object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.room != null) {
      yield r'room';
      yield serializers.serialize(
        object.room,
        specifiedType: const FullType(EvidenceRoomComparisonRoomEnum),
      );
    }
    if (object.roomLabel != null) {
      yield r'roomLabel';
      yield serializers.serialize(
        object.roomLabel,
        specifiedType: const FullType(String),
      );
    }
    if (object.entry != null) {
      yield r'entry';
      yield serializers.serialize(
        object.entry,
        specifiedType: const FullType(BuiltList, [FullType(EvidencePhotoResponse)]),
      );
    }
    if (object.exit != null) {
      yield r'exit';
      yield serializers.serialize(
        object.exit,
        specifiedType: const FullType(BuiltList, [FullType(EvidencePhotoResponse)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    EvidenceRoomComparison object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EvidenceRoomComparisonBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'room':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(EvidenceRoomComparisonRoomEnum),
          ) as EvidenceRoomComparisonRoomEnum?;
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
        case r'entry':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(EvidencePhotoResponse)]),
          ) as BuiltList<EvidencePhotoResponse>?;
          if (valueDes == null) continue;
          result.entry.replace(valueDes);
          break;
        case r'exit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(EvidencePhotoResponse)]),
          ) as BuiltList<EvidencePhotoResponse>?;
          if (valueDes == null) continue;
          result.exit.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EvidenceRoomComparison deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EvidenceRoomComparisonBuilder();
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

class EvidenceRoomComparisonRoomEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LIVING_ROOM')
  static const EvidenceRoomComparisonRoomEnum LIVING_ROOM = _$evidenceRoomComparisonRoomEnum_LIVING_ROOM;
  @BuiltValueEnumConst(wireName: r'BEDROOM')
  static const EvidenceRoomComparisonRoomEnum BEDROOM = _$evidenceRoomComparisonRoomEnum_BEDROOM;
  @BuiltValueEnumConst(wireName: r'KITCHEN')
  static const EvidenceRoomComparisonRoomEnum KITCHEN = _$evidenceRoomComparisonRoomEnum_KITCHEN;
  @BuiltValueEnumConst(wireName: r'BATHROOM')
  static const EvidenceRoomComparisonRoomEnum BATHROOM = _$evidenceRoomComparisonRoomEnum_BATHROOM;
  @BuiltValueEnumConst(wireName: r'TOILET')
  static const EvidenceRoomComparisonRoomEnum TOILET = _$evidenceRoomComparisonRoomEnum_TOILET;
  @BuiltValueEnumConst(wireName: r'OUTDOOR')
  static const EvidenceRoomComparisonRoomEnum OUTDOOR = _$evidenceRoomComparisonRoomEnum_OUTDOOR;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const EvidenceRoomComparisonRoomEnum OTHER = _$evidenceRoomComparisonRoomEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EvidenceRoomComparisonRoomEnum unknownDefaultOpenApi = _$evidenceRoomComparisonRoomEnum_unknownDefaultOpenApi;

  static Serializer<EvidenceRoomComparisonRoomEnum> get serializer => _$evidenceRoomComparisonRoomEnumSerializer;

  const EvidenceRoomComparisonRoomEnum._(String name): super(name);

  static BuiltSet<EvidenceRoomComparisonRoomEnum> get values => _$evidenceRoomComparisonRoomEnumValues;
  static EvidenceRoomComparisonRoomEnum valueOf(String name) => _$evidenceRoomComparisonRoomEnumValueOf(name);
}

