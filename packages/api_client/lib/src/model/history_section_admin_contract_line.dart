//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/admin_contract_line.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'history_section_admin_contract_line.g.dart';

/// HistorySectionAdminContractLine
///
/// Properties:
/// * [total] 
/// * [byStatus] 
/// * [recent] 
@BuiltValue()
abstract class HistorySectionAdminContractLine implements Built<HistorySectionAdminContractLine, HistorySectionAdminContractLineBuilder> {
  @BuiltValueField(wireName: r'total')
  int? get total;

  @BuiltValueField(wireName: r'byStatus')
  BuiltMap<String, int>? get byStatus;

  @BuiltValueField(wireName: r'recent')
  BuiltList<AdminContractLine>? get recent;

  HistorySectionAdminContractLine._();

  factory HistorySectionAdminContractLine([void updates(HistorySectionAdminContractLineBuilder b)]) = _$HistorySectionAdminContractLine;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HistorySectionAdminContractLineBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HistorySectionAdminContractLine> get serializer => _$HistorySectionAdminContractLineSerializer();
}

class _$HistorySectionAdminContractLineSerializer implements PrimitiveSerializer<HistorySectionAdminContractLine> {
  @override
  final Iterable<Type> types = const [HistorySectionAdminContractLine, _$HistorySectionAdminContractLine];

  @override
  final String wireName = r'HistorySectionAdminContractLine';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HistorySectionAdminContractLine object, {
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
        specifiedType: const FullType(BuiltList, [FullType(AdminContractLine)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HistorySectionAdminContractLine object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HistorySectionAdminContractLineBuilder result,
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
            specifiedType: const FullType.nullable(BuiltList, [FullType(AdminContractLine)]),
          ) as BuiltList<AdminContractLine>?;
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
  HistorySectionAdminContractLine deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HistorySectionAdminContractLineBuilder();
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

