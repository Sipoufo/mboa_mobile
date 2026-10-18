//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/history_section_admin_contract_line.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_contract_history.g.dart';

/// AccountContractHistory
///
/// Properties:
/// * [asTenant] 
/// * [asOwner] 
@BuiltValue()
abstract class AccountContractHistory implements Built<AccountContractHistory, AccountContractHistoryBuilder> {
  @BuiltValueField(wireName: r'asTenant')
  HistorySectionAdminContractLine? get asTenant;

  @BuiltValueField(wireName: r'asOwner')
  HistorySectionAdminContractLine? get asOwner;

  AccountContractHistory._();

  factory AccountContractHistory([void updates(AccountContractHistoryBuilder b)]) = _$AccountContractHistory;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountContractHistoryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountContractHistory> get serializer => _$AccountContractHistorySerializer();
}

class _$AccountContractHistorySerializer implements PrimitiveSerializer<AccountContractHistory> {
  @override
  final Iterable<Type> types = const [AccountContractHistory, _$AccountContractHistory];

  @override
  final String wireName = r'AccountContractHistory';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountContractHistory object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.asTenant != null) {
      yield r'asTenant';
      yield serializers.serialize(
        object.asTenant,
        specifiedType: const FullType(HistorySectionAdminContractLine),
      );
    }
    if (object.asOwner != null) {
      yield r'asOwner';
      yield serializers.serialize(
        object.asOwner,
        specifiedType: const FullType(HistorySectionAdminContractLine),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountContractHistory object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountContractHistoryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asTenant':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HistorySectionAdminContractLine),
          ) as HistorySectionAdminContractLine?;
          if (valueDes == null) continue;
          result.asTenant.replace(valueDes);
          break;
        case r'asOwner':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HistorySectionAdminContractLine),
          ) as HistorySectionAdminContractLine?;
          if (valueDes == null) continue;
          result.asOwner.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountContractHistory deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountContractHistoryBuilder();
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

