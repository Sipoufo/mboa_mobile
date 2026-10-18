//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/admin_visit_line.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'history_section_admin_visit_line.g.dart';

/// HistorySectionAdminVisitLine
///
/// Properties:
/// * [total] 
/// * [byStatus] 
/// * [recent] 
@BuiltValue()
abstract class HistorySectionAdminVisitLine implements Built<HistorySectionAdminVisitLine, HistorySectionAdminVisitLineBuilder> {
  @BuiltValueField(wireName: r'total')
  int? get total;

  @BuiltValueField(wireName: r'byStatus')
  BuiltMap<String, int>? get byStatus;

  @BuiltValueField(wireName: r'recent')
  BuiltList<AdminVisitLine>? get recent;

  HistorySectionAdminVisitLine._();

  factory HistorySectionAdminVisitLine([void updates(HistorySectionAdminVisitLineBuilder b)]) = _$HistorySectionAdminVisitLine;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HistorySectionAdminVisitLineBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HistorySectionAdminVisitLine> get serializer => _$HistorySectionAdminVisitLineSerializer();
}

class _$HistorySectionAdminVisitLineSerializer implements PrimitiveSerializer<HistorySectionAdminVisitLine> {
  @override
  final Iterable<Type> types = const [HistorySectionAdminVisitLine, _$HistorySectionAdminVisitLine];

  @override
  final String wireName = r'HistorySectionAdminVisitLine';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HistorySectionAdminVisitLine object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.total != null) {
      yield r'total';
      yield serializers.serialize(
        object.total,
        specifiedType: const FullType(int),
      );
    }
    if (object.byStatus != null) {
      yield r'byStatus';
      yield serializers.serialize(
        object.byStatus,
        specifiedType: const FullType(BuiltMap, [FullType(String), FullType(int)]),
      );
    }
    if (object.recent != null) {
      yield r'recent';
      yield serializers.serialize(
        object.recent,
        specifiedType: const FullType(BuiltList, [FullType(AdminVisitLine)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HistorySectionAdminVisitLine object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HistorySectionAdminVisitLineBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.total = valueDes;
          break;
        case r'byStatus':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(int)]),
          ) as BuiltMap<String, int>?;
          if (valueDes == null) continue;
          result.byStatus.replace(valueDes);
          break;
        case r'recent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(AdminVisitLine)]),
          ) as BuiltList<AdminVisitLine>?;
          if (valueDes == null) continue;
          result.recent.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HistorySectionAdminVisitLine deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HistorySectionAdminVisitLineBuilder();
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

