//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/admin_report_line.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'history_section_admin_report_line.g.dart';

/// HistorySectionAdminReportLine
///
/// Properties:
/// * [total] 
/// * [byStatus] 
/// * [recent] 
@BuiltValue()
abstract class HistorySectionAdminReportLine implements Built<HistorySectionAdminReportLine, HistorySectionAdminReportLineBuilder> {
  @BuiltValueField(wireName: r'total')
  int? get total;

  @BuiltValueField(wireName: r'byStatus')
  BuiltMap<String, int>? get byStatus;

  @BuiltValueField(wireName: r'recent')
  BuiltList<AdminReportLine>? get recent;

  HistorySectionAdminReportLine._();

  factory HistorySectionAdminReportLine([void updates(HistorySectionAdminReportLineBuilder b)]) = _$HistorySectionAdminReportLine;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HistorySectionAdminReportLineBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HistorySectionAdminReportLine> get serializer => _$HistorySectionAdminReportLineSerializer();
}

class _$HistorySectionAdminReportLineSerializer implements PrimitiveSerializer<HistorySectionAdminReportLine> {
  @override
  final Iterable<Type> types = const [HistorySectionAdminReportLine, _$HistorySectionAdminReportLine];

  @override
  final String wireName = r'HistorySectionAdminReportLine';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HistorySectionAdminReportLine object, {
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
        specifiedType: const FullType(BuiltList, [FullType(AdminReportLine)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HistorySectionAdminReportLine object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HistorySectionAdminReportLineBuilder result,
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
            specifiedType: const FullType.nullable(BuiltList, [FullType(AdminReportLine)]),
          ) as BuiltList<AdminReportLine>?;
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
  HistorySectionAdminReportLine deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HistorySectionAdminReportLineBuilder();
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

