//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_item.g.dart';

/// NotificationItem
///
/// Properties:
/// * [id] 
/// * [type] 
/// * [title] 
/// * [body] 
/// * [entityId] 
/// * [deepLink] 
/// * [createdAt] 
/// * [readAt] 
@BuiltValue()
abstract class NotificationItem implements Built<NotificationItem, NotificationItemBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'type')
  NotificationItemTypeEnum? get type;
  // enum typeEnum {  PAYMENT_CONFIRMED,  MESSAGE,  ANNONCE,  VISIT,  KYC,  RESIDENCE,  CONTRACT,  BADGE,  SAVED_SEARCH,  FINANCE_ADDON,  INVOICE,  RESERVATION,  HOME,  HOME_REQUEST,  HOME_EVIDENCE,  };

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'body')
  String? get body;

  @BuiltValueField(wireName: r'entityId')
  String? get entityId;

  @BuiltValueField(wireName: r'deepLink')
  String? get deepLink;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'readAt')
  DateTime? get readAt;

  NotificationItem._();

  factory NotificationItem([void updates(NotificationItemBuilder b)]) = _$NotificationItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationItem> get serializer => _$NotificationItemSerializer();
}

class _$NotificationItemSerializer implements PrimitiveSerializer<NotificationItem> {
  @override
  final Iterable<Type> types = const [NotificationItem, _$NotificationItem];

  @override
  final String wireName = r'NotificationItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(NotificationItemTypeEnum),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.body != null) {
      yield r'body';
      yield serializers.serialize(
        object.body,
        specifiedType: const FullType(String),
      );
    }
    if (object.entityId != null) {
      yield r'entityId';
      yield serializers.serialize(
        object.entityId,
        specifiedType: const FullType(String),
      );
    }
    if (object.deepLink != null) {
      yield r'deepLink';
      yield serializers.serialize(
        object.deepLink,
        specifiedType: const FullType(String),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.readAt != null) {
      yield r'readAt';
      yield serializers.serialize(
        object.readAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.id = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(NotificationItemTypeEnum),
          ) as NotificationItemTypeEnum?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.body = valueDes;
          break;
        case r'entityId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.entityId = valueDes;
          break;
        case r'deepLink':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.deepLink = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'readAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.readAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationItemBuilder();
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

class NotificationItemTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PAYMENT_CONFIRMED')
  static const NotificationItemTypeEnum PAYMENT_CONFIRMED = _$notificationItemTypeEnum_PAYMENT_CONFIRMED;
  @BuiltValueEnumConst(wireName: r'MESSAGE')
  static const NotificationItemTypeEnum MESSAGE = _$notificationItemTypeEnum_MESSAGE;
  @BuiltValueEnumConst(wireName: r'ANNONCE')
  static const NotificationItemTypeEnum ANNONCE = _$notificationItemTypeEnum_ANNONCE;
  @BuiltValueEnumConst(wireName: r'VISIT')
  static const NotificationItemTypeEnum VISIT = _$notificationItemTypeEnum_VISIT;
  @BuiltValueEnumConst(wireName: r'KYC')
  static const NotificationItemTypeEnum KYC = _$notificationItemTypeEnum_KYC;
  @BuiltValueEnumConst(wireName: r'RESIDENCE')
  static const NotificationItemTypeEnum RESIDENCE = _$notificationItemTypeEnum_RESIDENCE;
  @BuiltValueEnumConst(wireName: r'CONTRACT')
  static const NotificationItemTypeEnum CONTRACT = _$notificationItemTypeEnum_CONTRACT;
  @BuiltValueEnumConst(wireName: r'BADGE')
  static const NotificationItemTypeEnum BADGE = _$notificationItemTypeEnum_BADGE;
  @BuiltValueEnumConst(wireName: r'SAVED_SEARCH')
  static const NotificationItemTypeEnum SAVED_SEARCH = _$notificationItemTypeEnum_SAVED_SEARCH;
  @BuiltValueEnumConst(wireName: r'FINANCE_ADDON')
  static const NotificationItemTypeEnum FINANCE_ADDON = _$notificationItemTypeEnum_FINANCE_ADDON;
  @BuiltValueEnumConst(wireName: r'INVOICE')
  static const NotificationItemTypeEnum INVOICE = _$notificationItemTypeEnum_INVOICE;
  @BuiltValueEnumConst(wireName: r'RESERVATION')
  static const NotificationItemTypeEnum RESERVATION = _$notificationItemTypeEnum_RESERVATION;
  @BuiltValueEnumConst(wireName: r'HOME')
  static const NotificationItemTypeEnum HOME = _$notificationItemTypeEnum_HOME;
  @BuiltValueEnumConst(wireName: r'HOME_REQUEST')
  static const NotificationItemTypeEnum HOME_REQUEST = _$notificationItemTypeEnum_HOME_REQUEST;
  @BuiltValueEnumConst(wireName: r'HOME_EVIDENCE')
  static const NotificationItemTypeEnum HOME_EVIDENCE = _$notificationItemTypeEnum_HOME_EVIDENCE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const NotificationItemTypeEnum unknownDefaultOpenApi = _$notificationItemTypeEnum_unknownDefaultOpenApi;

  static Serializer<NotificationItemTypeEnum> get serializer => _$notificationItemTypeEnumSerializer;

  const NotificationItemTypeEnum._(String name): super(name);

  static BuiltSet<NotificationItemTypeEnum> get values => _$notificationItemTypeEnumValues;
  static NotificationItemTypeEnum valueOf(String name) => _$notificationItemTypeEnumValueOf(name);
}

