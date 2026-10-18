//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_moderation_entry.g.dart';

/// AccountModerationEntry
///
/// Properties:
/// * [action] 
/// * [reason] 
/// * [adminAccountId] 
/// * [suspendedUntil] 
/// * [liftedAt] 
/// * [createdAt] 
@BuiltValue()
abstract class AccountModerationEntry implements Built<AccountModerationEntry, AccountModerationEntryBuilder> {
  @BuiltValueField(wireName: r'action')
  AccountModerationEntryActionEnum? get action;
  // enum actionEnum {  SUSPEND,  REACTIVATE,  DELETE,  };

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  @BuiltValueField(wireName: r'adminAccountId')
  String? get adminAccountId;

  @BuiltValueField(wireName: r'suspendedUntil')
  DateTime? get suspendedUntil;

  @BuiltValueField(wireName: r'liftedAt')
  DateTime? get liftedAt;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  AccountModerationEntry._();

  factory AccountModerationEntry([void updates(AccountModerationEntryBuilder b)]) = _$AccountModerationEntry;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountModerationEntryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountModerationEntry> get serializer => _$AccountModerationEntrySerializer();
}

class _$AccountModerationEntrySerializer implements PrimitiveSerializer<AccountModerationEntry> {
  @override
  final Iterable<Type> types = const [AccountModerationEntry, _$AccountModerationEntry];

  @override
  final String wireName = r'AccountModerationEntry';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountModerationEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.action != null) {
      yield r'action';
      yield serializers.serialize(
        object.action,
        specifiedType: const FullType(AccountModerationEntryActionEnum),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
    if (object.adminAccountId != null) {
      yield r'adminAccountId';
      yield serializers.serialize(
        object.adminAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.suspendedUntil != null) {
      yield r'suspendedUntil';
      yield serializers.serialize(
        object.suspendedUntil,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.liftedAt != null) {
      yield r'liftedAt';
      yield serializers.serialize(
        object.liftedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountModerationEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountModerationEntryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AccountModerationEntryActionEnum),
          ) as AccountModerationEntryActionEnum?;
          if (valueDes == null) continue;
          result.action = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        case r'adminAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.adminAccountId = valueDes;
          break;
        case r'suspendedUntil':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.suspendedUntil = valueDes;
          break;
        case r'liftedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.liftedAt = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountModerationEntry deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountModerationEntryBuilder();
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

class AccountModerationEntryActionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'SUSPEND')
  static const AccountModerationEntryActionEnum SUSPEND = _$accountModerationEntryActionEnum_SUSPEND;
  @BuiltValueEnumConst(wireName: r'REACTIVATE')
  static const AccountModerationEntryActionEnum REACTIVATE = _$accountModerationEntryActionEnum_REACTIVATE;
  @BuiltValueEnumConst(wireName: r'DELETE')
  static const AccountModerationEntryActionEnum DELETE = _$accountModerationEntryActionEnum_DELETE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AccountModerationEntryActionEnum unknownDefaultOpenApi = _$accountModerationEntryActionEnum_unknownDefaultOpenApi;

  static Serializer<AccountModerationEntryActionEnum> get serializer => _$accountModerationEntryActionEnumSerializer;

  const AccountModerationEntryActionEnum._(String name): super(name);

  static BuiltSet<AccountModerationEntryActionEnum> get values => _$accountModerationEntryActionEnumValues;
  static AccountModerationEntryActionEnum valueOf(String name) => _$accountModerationEntryActionEnumValueOf(name);
}

