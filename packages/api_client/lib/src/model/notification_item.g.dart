// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationItemTypeEnum _$notificationItemTypeEnum_PAYMENT_CONFIRMED =
    const NotificationItemTypeEnum._('PAYMENT_CONFIRMED');
const NotificationItemTypeEnum _$notificationItemTypeEnum_MESSAGE =
    const NotificationItemTypeEnum._('MESSAGE');
const NotificationItemTypeEnum _$notificationItemTypeEnum_ANNONCE =
    const NotificationItemTypeEnum._('ANNONCE');
const NotificationItemTypeEnum _$notificationItemTypeEnum_VISIT =
    const NotificationItemTypeEnum._('VISIT');
const NotificationItemTypeEnum _$notificationItemTypeEnum_KYC =
    const NotificationItemTypeEnum._('KYC');
const NotificationItemTypeEnum _$notificationItemTypeEnum_RESIDENCE =
    const NotificationItemTypeEnum._('RESIDENCE');
const NotificationItemTypeEnum _$notificationItemTypeEnum_CONTRACT =
    const NotificationItemTypeEnum._('CONTRACT');
const NotificationItemTypeEnum _$notificationItemTypeEnum_BADGE =
    const NotificationItemTypeEnum._('BADGE');
const NotificationItemTypeEnum _$notificationItemTypeEnum_SAVED_SEARCH =
    const NotificationItemTypeEnum._('SAVED_SEARCH');
const NotificationItemTypeEnum _$notificationItemTypeEnum_FINANCE_ADDON =
    const NotificationItemTypeEnum._('FINANCE_ADDON');
const NotificationItemTypeEnum _$notificationItemTypeEnum_INVOICE =
    const NotificationItemTypeEnum._('INVOICE');
const NotificationItemTypeEnum _$notificationItemTypeEnum_RESERVATION =
    const NotificationItemTypeEnum._('RESERVATION');
const NotificationItemTypeEnum _$notificationItemTypeEnum_HOME =
    const NotificationItemTypeEnum._('HOME');
const NotificationItemTypeEnum _$notificationItemTypeEnum_HOME_REQUEST =
    const NotificationItemTypeEnum._('HOME_REQUEST');
const NotificationItemTypeEnum _$notificationItemTypeEnum_HOME_EVIDENCE =
    const NotificationItemTypeEnum._('HOME_EVIDENCE');
const NotificationItemTypeEnum
_$notificationItemTypeEnum_unknownDefaultOpenApi =
    const NotificationItemTypeEnum._('unknownDefaultOpenApi');

NotificationItemTypeEnum _$notificationItemTypeEnumValueOf(String name) {
  switch (name) {
    case 'PAYMENT_CONFIRMED':
      return _$notificationItemTypeEnum_PAYMENT_CONFIRMED;
    case 'MESSAGE':
      return _$notificationItemTypeEnum_MESSAGE;
    case 'ANNONCE':
      return _$notificationItemTypeEnum_ANNONCE;
    case 'VISIT':
      return _$notificationItemTypeEnum_VISIT;
    case 'KYC':
      return _$notificationItemTypeEnum_KYC;
    case 'RESIDENCE':
      return _$notificationItemTypeEnum_RESIDENCE;
    case 'CONTRACT':
      return _$notificationItemTypeEnum_CONTRACT;
    case 'BADGE':
      return _$notificationItemTypeEnum_BADGE;
    case 'SAVED_SEARCH':
      return _$notificationItemTypeEnum_SAVED_SEARCH;
    case 'FINANCE_ADDON':
      return _$notificationItemTypeEnum_FINANCE_ADDON;
    case 'INVOICE':
      return _$notificationItemTypeEnum_INVOICE;
    case 'RESERVATION':
      return _$notificationItemTypeEnum_RESERVATION;
    case 'HOME':
      return _$notificationItemTypeEnum_HOME;
    case 'HOME_REQUEST':
      return _$notificationItemTypeEnum_HOME_REQUEST;
    case 'HOME_EVIDENCE':
      return _$notificationItemTypeEnum_HOME_EVIDENCE;
    case 'unknownDefaultOpenApi':
      return _$notificationItemTypeEnum_unknownDefaultOpenApi;
    default:
      return _$notificationItemTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<NotificationItemTypeEnum> _$notificationItemTypeEnumValues =
    BuiltSet<NotificationItemTypeEnum>(const <NotificationItemTypeEnum>[
      _$notificationItemTypeEnum_PAYMENT_CONFIRMED,
      _$notificationItemTypeEnum_MESSAGE,
      _$notificationItemTypeEnum_ANNONCE,
      _$notificationItemTypeEnum_VISIT,
      _$notificationItemTypeEnum_KYC,
      _$notificationItemTypeEnum_RESIDENCE,
      _$notificationItemTypeEnum_CONTRACT,
      _$notificationItemTypeEnum_BADGE,
      _$notificationItemTypeEnum_SAVED_SEARCH,
      _$notificationItemTypeEnum_FINANCE_ADDON,
      _$notificationItemTypeEnum_INVOICE,
      _$notificationItemTypeEnum_RESERVATION,
      _$notificationItemTypeEnum_HOME,
      _$notificationItemTypeEnum_HOME_REQUEST,
      _$notificationItemTypeEnum_HOME_EVIDENCE,
      _$notificationItemTypeEnum_unknownDefaultOpenApi,
    ]);

Serializer<NotificationItemTypeEnum> _$notificationItemTypeEnumSerializer =
    _$NotificationItemTypeEnumSerializer();

class _$NotificationItemTypeEnumSerializer
    implements PrimitiveSerializer<NotificationItemTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PAYMENT_CONFIRMED': 'PAYMENT_CONFIRMED',
    'MESSAGE': 'MESSAGE',
    'ANNONCE': 'ANNONCE',
    'VISIT': 'VISIT',
    'KYC': 'KYC',
    'RESIDENCE': 'RESIDENCE',
    'CONTRACT': 'CONTRACT',
    'BADGE': 'BADGE',
    'SAVED_SEARCH': 'SAVED_SEARCH',
    'FINANCE_ADDON': 'FINANCE_ADDON',
    'INVOICE': 'INVOICE',
    'RESERVATION': 'RESERVATION',
    'HOME': 'HOME',
    'HOME_REQUEST': 'HOME_REQUEST',
    'HOME_EVIDENCE': 'HOME_EVIDENCE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PAYMENT_CONFIRMED': 'PAYMENT_CONFIRMED',
    'MESSAGE': 'MESSAGE',
    'ANNONCE': 'ANNONCE',
    'VISIT': 'VISIT',
    'KYC': 'KYC',
    'RESIDENCE': 'RESIDENCE',
    'CONTRACT': 'CONTRACT',
    'BADGE': 'BADGE',
    'SAVED_SEARCH': 'SAVED_SEARCH',
    'FINANCE_ADDON': 'FINANCE_ADDON',
    'INVOICE': 'INVOICE',
    'RESERVATION': 'RESERVATION',
    'HOME': 'HOME',
    'HOME_REQUEST': 'HOME_REQUEST',
    'HOME_EVIDENCE': 'HOME_EVIDENCE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[NotificationItemTypeEnum];
  @override
  final String wireName = 'NotificationItemTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    NotificationItemTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  NotificationItemTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => NotificationItemTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$NotificationItem extends NotificationItem {
  @override
  final String? id;
  @override
  final NotificationItemTypeEnum? type;
  @override
  final String? title;
  @override
  final String? body;
  @override
  final String? entityId;
  @override
  final String? deepLink;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? readAt;

  factory _$NotificationItem([
    void Function(NotificationItemBuilder)? updates,
  ]) => (NotificationItemBuilder()..update(updates))._build();

  _$NotificationItem._({
    this.id,
    this.type,
    this.title,
    this.body,
    this.entityId,
    this.deepLink,
    this.createdAt,
    this.readAt,
  }) : super._();
  @override
  NotificationItem rebuild(void Function(NotificationItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationItemBuilder toBuilder() =>
      NotificationItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationItem &&
        id == other.id &&
        type == other.type &&
        title == other.title &&
        body == other.body &&
        entityId == other.entityId &&
        deepLink == other.deepLink &&
        createdAt == other.createdAt &&
        readAt == other.readAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, entityId.hashCode);
    _$hash = $jc(_$hash, deepLink.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, readAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationItem')
          ..add('id', id)
          ..add('type', type)
          ..add('title', title)
          ..add('body', body)
          ..add('entityId', entityId)
          ..add('deepLink', deepLink)
          ..add('createdAt', createdAt)
          ..add('readAt', readAt))
        .toString();
  }
}

class NotificationItemBuilder
    implements Builder<NotificationItem, NotificationItemBuilder> {
  _$NotificationItem? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  NotificationItemTypeEnum? _type;
  NotificationItemTypeEnum? get type => _$this._type;
  set type(NotificationItemTypeEnum? type) => _$this._type = type;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  String? _entityId;
  String? get entityId => _$this._entityId;
  set entityId(String? entityId) => _$this._entityId = entityId;

  String? _deepLink;
  String? get deepLink => _$this._deepLink;
  set deepLink(String? deepLink) => _$this._deepLink = deepLink;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _readAt;
  DateTime? get readAt => _$this._readAt;
  set readAt(DateTime? readAt) => _$this._readAt = readAt;

  NotificationItemBuilder() {
    NotificationItem._defaults(this);
  }

  NotificationItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _type = $v.type;
      _title = $v.title;
      _body = $v.body;
      _entityId = $v.entityId;
      _deepLink = $v.deepLink;
      _createdAt = $v.createdAt;
      _readAt = $v.readAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationItem other) {
    _$v = other as _$NotificationItem;
  }

  @override
  void update(void Function(NotificationItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationItem build() => _build();

  _$NotificationItem _build() {
    final _$result =
        _$v ??
        _$NotificationItem._(
          id: id,
          type: type,
          title: title,
          body: body,
          entityId: entityId,
          deepLink: deepLink,
          createdAt: createdAt,
          readAt: readAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
