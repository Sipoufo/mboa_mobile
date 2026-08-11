//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/residence_assignment_summary.dart';
import 'package:api_client/src/model/assignment_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'assignment_item.g.dart';

/// AssignmentItem
///
/// Properties:
/// * [type] 
/// * [assignment] 
/// * [residence] 
@BuiltValue()
abstract class AssignmentItem implements Built<AssignmentItem, AssignmentItemBuilder> {
  @BuiltValueField(wireName: r'type')
  AssignmentItemTypeEnum? get type;
  // enum typeEnum {  LISTING,  RESIDENCE,  };

  @BuiltValueField(wireName: r'assignment')
  AssignmentResponse? get assignment;

  @BuiltValueField(wireName: r'residence')
  ResidenceAssignmentSummary? get residence;

  AssignmentItem._();

  factory AssignmentItem([void updates(AssignmentItemBuilder b)]) = _$AssignmentItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AssignmentItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AssignmentItem> get serializer => _$AssignmentItemSerializer();
}

class _$AssignmentItemSerializer implements PrimitiveSerializer<AssignmentItem> {
  @override
  final Iterable<Type> types = const [AssignmentItem, _$AssignmentItem];

  @override
  final String wireName = r'AssignmentItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AssignmentItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(AssignmentItemTypeEnum),
      );
    }
    if (object.assignment != null) {
      yield r'assignment';
      yield serializers.serialize(
        object.assignment,
        specifiedType: const FullType(AssignmentResponse),
      );
    }
    if (object.residence != null) {
      yield r'residence';
      yield serializers.serialize(
        object.residence,
        specifiedType: const FullType(ResidenceAssignmentSummary),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AssignmentItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AssignmentItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AssignmentItemTypeEnum),
          ) as AssignmentItemTypeEnum?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
        case r'assignment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AssignmentResponse),
          ) as AssignmentResponse?;
          if (valueDes == null) continue;
          result.assignment.replace(valueDes);
          break;
        case r'residence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ResidenceAssignmentSummary),
          ) as ResidenceAssignmentSummary?;
          if (valueDes == null) continue;
          result.residence.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AssignmentItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AssignmentItemBuilder();
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

class AssignmentItemTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LISTING')
  static const AssignmentItemTypeEnum LISTING = _$assignmentItemTypeEnum_LISTING;
  @BuiltValueEnumConst(wireName: r'RESIDENCE')
  static const AssignmentItemTypeEnum RESIDENCE = _$assignmentItemTypeEnum_RESIDENCE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AssignmentItemTypeEnum unknownDefaultOpenApi = _$assignmentItemTypeEnum_unknownDefaultOpenApi;

  static Serializer<AssignmentItemTypeEnum> get serializer => _$assignmentItemTypeEnumSerializer;

  const AssignmentItemTypeEnum._(String name): super(name);

  static BuiltSet<AssignmentItemTypeEnum> get values => _$assignmentItemTypeEnumValues;
  static AssignmentItemTypeEnum valueOf(String name) => _$assignmentItemTypeEnumValueOf(name);
}

