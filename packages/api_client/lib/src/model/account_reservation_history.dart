//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_reservation_history.g.dart';

/// AccountReservationHistory
///
/// Properties:
/// * [asClient] 
/// * [onOwnListings] 
/// * [cancelledByOwner] 
@BuiltValue()
abstract class AccountReservationHistory implements Built<AccountReservationHistory, AccountReservationHistoryBuilder> {
  @BuiltValueField(wireName: r'asClient')
  BuiltMap<String, int>? get asClient;

  @BuiltValueField(wireName: r'onOwnListings')
  BuiltMap<String, int>? get onOwnListings;

  @BuiltValueField(wireName: r'cancelledByOwner')
  int? get cancelledByOwner;

  AccountReservationHistory._();

  factory AccountReservationHistory([void updates(AccountReservationHistoryBuilder b)]) = _$AccountReservationHistory;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountReservationHistoryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountReservationHistory> get serializer => _$AccountReservationHistorySerializer();
}

class _$AccountReservationHistorySerializer implements PrimitiveSerializer<AccountReservationHistory> {
  @override
  final Iterable<Type> types = const [AccountReservationHistory, _$AccountReservationHistory];

  @override
  final String wireName = r'AccountReservationHistory';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountReservationHistory object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.asClient != null) {
      yield r'asClient';
      yield serializers.serialize(
        object.asClient,
        specifiedType: const FullType(BuiltMap, [FullType(String), FullType(int)]),
      );
    }
    if (object.onOwnListings != null) {
      yield r'onOwnListings';
      yield serializers.serialize(
        object.onOwnListings,
        specifiedType: const FullType(BuiltMap, [FullType(String), FullType(int)]),
      );
    }
    if (object.cancelledByOwner != null) {
      yield r'cancelledByOwner';
      yield serializers.serialize(
        object.cancelledByOwner,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountReservationHistory object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountReservationHistoryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asClient':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(int)]),
          ) as BuiltMap<String, int>?;
          if (valueDes == null) continue;
          result.asClient.replace(valueDes);
          break;
        case r'onOwnListings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(int)]),
          ) as BuiltMap<String, int>?;
          if (valueDes == null) continue;
          result.onOwnListings.replace(valueDes);
          break;
        case r'cancelledByOwner':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.cancelledByOwner = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountReservationHistory deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountReservationHistoryBuilder();
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

