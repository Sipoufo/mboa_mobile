//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/history_section_admin_report_line.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_report_history.g.dart';

/// AccountReportHistory
///
/// Properties:
/// * [emitted] 
/// * [received] 
@BuiltValue()
abstract class AccountReportHistory implements Built<AccountReportHistory, AccountReportHistoryBuilder> {
  @BuiltValueField(wireName: r'emitted')
  HistorySectionAdminReportLine? get emitted;

  @BuiltValueField(wireName: r'received')
  HistorySectionAdminReportLine? get received;

  AccountReportHistory._();

  factory AccountReportHistory([void updates(AccountReportHistoryBuilder b)]) = _$AccountReportHistory;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountReportHistoryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountReportHistory> get serializer => _$AccountReportHistorySerializer();
}

class _$AccountReportHistorySerializer implements PrimitiveSerializer<AccountReportHistory> {
  @override
  final Iterable<Type> types = const [AccountReportHistory, _$AccountReportHistory];

  @override
  final String wireName = r'AccountReportHistory';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountReportHistory object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.emitted != null) {
      yield r'emitted';
      yield serializers.serialize(
        object.emitted,
        specifiedType: const FullType(HistorySectionAdminReportLine),
      );
    }
    if (object.received != null) {
      yield r'received';
      yield serializers.serialize(
        object.received,
        specifiedType: const FullType(HistorySectionAdminReportLine),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountReportHistory object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountReportHistoryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'emitted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HistorySectionAdminReportLine),
          ) as HistorySectionAdminReportLine?;
          if (valueDes == null) continue;
          result.emitted.replace(valueDes);
          break;
        case r'received':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HistorySectionAdminReportLine),
          ) as HistorySectionAdminReportLine?;
          if (valueDes == null) continue;
          result.received.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountReportHistory deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountReportHistoryBuilder();
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

