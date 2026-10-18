//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/history_section_admin_visit_line.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_visit_history.g.dart';

/// AccountVisitHistory
///
/// Properties:
/// * [asClient] 
/// * [asVisitor] 
/// * [onOwnListings] 
@BuiltValue()
abstract class AccountVisitHistory implements Built<AccountVisitHistory, AccountVisitHistoryBuilder> {
  @BuiltValueField(wireName: r'asClient')
  HistorySectionAdminVisitLine? get asClient;

  @BuiltValueField(wireName: r'asVisitor')
  HistorySectionAdminVisitLine? get asVisitor;

  @BuiltValueField(wireName: r'onOwnListings')
  HistorySectionAdminVisitLine? get onOwnListings;

  AccountVisitHistory._();

  factory AccountVisitHistory([void updates(AccountVisitHistoryBuilder b)]) = _$AccountVisitHistory;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountVisitHistoryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountVisitHistory> get serializer => _$AccountVisitHistorySerializer();
}

class _$AccountVisitHistorySerializer implements PrimitiveSerializer<AccountVisitHistory> {
  @override
  final Iterable<Type> types = const [AccountVisitHistory, _$AccountVisitHistory];

  @override
  final String wireName = r'AccountVisitHistory';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountVisitHistory object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.asClient != null) {
      yield r'asClient';
      yield serializers.serialize(
        object.asClient,
        specifiedType: const FullType(HistorySectionAdminVisitLine),
      );
    }
    if (object.asVisitor != null) {
      yield r'asVisitor';
      yield serializers.serialize(
        object.asVisitor,
        specifiedType: const FullType(HistorySectionAdminVisitLine),
      );
    }
    if (object.onOwnListings != null) {
      yield r'onOwnListings';
      yield serializers.serialize(
        object.onOwnListings,
        specifiedType: const FullType(HistorySectionAdminVisitLine),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountVisitHistory object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountVisitHistoryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asClient':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HistorySectionAdminVisitLine),
          ) as HistorySectionAdminVisitLine?;
          if (valueDes == null) continue;
          result.asClient.replace(valueDes);
          break;
        case r'asVisitor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HistorySectionAdminVisitLine),
          ) as HistorySectionAdminVisitLine?;
          if (valueDes == null) continue;
          result.asVisitor.replace(valueDes);
          break;
        case r'onOwnListings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HistorySectionAdminVisitLine),
          ) as HistorySectionAdminVisitLine?;
          if (valueDes == null) continue;
          result.onOwnListings.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountVisitHistory deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountVisitHistoryBuilder();
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

