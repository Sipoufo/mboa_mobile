//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'visitor_summary.g.dart';

/// VisitorSummary
///
/// Properties:
/// * [kind] 
/// * [agentId] 
/// * [displayName] 
/// * [photoKey] 
@BuiltValue()
abstract class VisitorSummary implements Built<VisitorSummary, VisitorSummaryBuilder> {
  @BuiltValueField(wireName: r'kind')
  VisitorSummaryKindEnum? get kind;
  // enum kindEnum {  AGENT,  OWNER,  };

  @BuiltValueField(wireName: r'agentId')
  String? get agentId;

  @BuiltValueField(wireName: r'displayName')
  String? get displayName;

  @BuiltValueField(wireName: r'photoKey')
  String? get photoKey;

  VisitorSummary._();

  factory VisitorSummary([void updates(VisitorSummaryBuilder b)]) = _$VisitorSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VisitorSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<VisitorSummary> get serializer => _$VisitorSummarySerializer();
}

class _$VisitorSummarySerializer implements PrimitiveSerializer<VisitorSummary> {
  @override
  final Iterable<Type> types = const [VisitorSummary, _$VisitorSummary];

  @override
  final String wireName = r'VisitorSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VisitorSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.kind != null) {
      yield r'kind';
      yield serializers.serialize(
        object.kind,
        specifiedType: const FullType(VisitorSummaryKindEnum),
      );
    }
    if (object.agentId != null) {
      yield r'agentId';
      yield serializers.serialize(
        object.agentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.displayName != null) {
      yield r'displayName';
      yield serializers.serialize(
        object.displayName,
        specifiedType: const FullType(String),
      );
    }
    if (object.photoKey != null) {
      yield r'photoKey';
      yield serializers.serialize(
        object.photoKey,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    VisitorSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VisitorSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(VisitorSummaryKindEnum),
          ) as VisitorSummaryKindEnum?;
          if (valueDes == null) continue;
          result.kind = valueDes;
          break;
        case r'agentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.agentId = valueDes;
          break;
        case r'displayName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.displayName = valueDes;
          break;
        case r'photoKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.photoKey = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  VisitorSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VisitorSummaryBuilder();
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

class VisitorSummaryKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'AGENT')
  static const VisitorSummaryKindEnum AGENT = _$visitorSummaryKindEnum_AGENT;
  @BuiltValueEnumConst(wireName: r'OWNER')
  static const VisitorSummaryKindEnum OWNER = _$visitorSummaryKindEnum_OWNER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const VisitorSummaryKindEnum unknownDefaultOpenApi = _$visitorSummaryKindEnum_unknownDefaultOpenApi;

  static Serializer<VisitorSummaryKindEnum> get serializer => _$visitorSummaryKindEnumSerializer;

  const VisitorSummaryKindEnum._(String name): super(name);

  static BuiltSet<VisitorSummaryKindEnum> get values => _$visitorSummaryKindEnumValues;
  static VisitorSummaryKindEnum valueOf(String name) => _$visitorSummaryKindEnumValueOf(name);
}

