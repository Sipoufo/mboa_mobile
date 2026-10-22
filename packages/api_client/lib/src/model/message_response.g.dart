// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MessageResponseKindEnum _$messageResponseKindEnum_USER =
    const MessageResponseKindEnum._('USER');
const MessageResponseKindEnum _$messageResponseKindEnum_SYSTEM =
    const MessageResponseKindEnum._('SYSTEM');
const MessageResponseKindEnum _$messageResponseKindEnum_unknownDefaultOpenApi =
    const MessageResponseKindEnum._('unknownDefaultOpenApi');

MessageResponseKindEnum _$messageResponseKindEnumValueOf(String name) {
  switch (name) {
    case 'USER':
      return _$messageResponseKindEnum_USER;
    case 'SYSTEM':
      return _$messageResponseKindEnum_SYSTEM;
    case 'unknownDefaultOpenApi':
      return _$messageResponseKindEnum_unknownDefaultOpenApi;
    default:
      return _$messageResponseKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MessageResponseKindEnum> _$messageResponseKindEnumValues =
    BuiltSet<MessageResponseKindEnum>(const <MessageResponseKindEnum>[
      _$messageResponseKindEnum_USER,
      _$messageResponseKindEnum_SYSTEM,
      _$messageResponseKindEnum_unknownDefaultOpenApi,
    ]);

const MessageResponseSystemEventEnum
_$messageResponseSystemEventEnum_RESERVATION_REQUESTED =
    const MessageResponseSystemEventEnum._('RESERVATION_REQUESTED');
const MessageResponseSystemEventEnum
_$messageResponseSystemEventEnum_RESERVATION_UNIT_ASSIGNED =
    const MessageResponseSystemEventEnum._('RESERVATION_UNIT_ASSIGNED');
const MessageResponseSystemEventEnum
_$messageResponseSystemEventEnum_HOME_REQUEST_OPENED =
    const MessageResponseSystemEventEnum._('HOME_REQUEST_OPENED');
const MessageResponseSystemEventEnum
_$messageResponseSystemEventEnum_HOME_REQUEST_UPDATED =
    const MessageResponseSystemEventEnum._('HOME_REQUEST_UPDATED');
const MessageResponseSystemEventEnum
_$messageResponseSystemEventEnum_unknownDefaultOpenApi =
    const MessageResponseSystemEventEnum._('unknownDefaultOpenApi');

MessageResponseSystemEventEnum _$messageResponseSystemEventEnumValueOf(
  String name,
) {
  switch (name) {
    case 'RESERVATION_REQUESTED':
      return _$messageResponseSystemEventEnum_RESERVATION_REQUESTED;
    case 'RESERVATION_UNIT_ASSIGNED':
      return _$messageResponseSystemEventEnum_RESERVATION_UNIT_ASSIGNED;
    case 'HOME_REQUEST_OPENED':
      return _$messageResponseSystemEventEnum_HOME_REQUEST_OPENED;
    case 'HOME_REQUEST_UPDATED':
      return _$messageResponseSystemEventEnum_HOME_REQUEST_UPDATED;
    case 'unknownDefaultOpenApi':
      return _$messageResponseSystemEventEnum_unknownDefaultOpenApi;
    default:
      return _$messageResponseSystemEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MessageResponseSystemEventEnum>
_$messageResponseSystemEventEnumValues =
    BuiltSet<MessageResponseSystemEventEnum>(
      const <MessageResponseSystemEventEnum>[
        _$messageResponseSystemEventEnum_RESERVATION_REQUESTED,
        _$messageResponseSystemEventEnum_RESERVATION_UNIT_ASSIGNED,
        _$messageResponseSystemEventEnum_HOME_REQUEST_OPENED,
        _$messageResponseSystemEventEnum_HOME_REQUEST_UPDATED,
        _$messageResponseSystemEventEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<MessageResponseKindEnum> _$messageResponseKindEnumSerializer =
    _$MessageResponseKindEnumSerializer();
Serializer<MessageResponseSystemEventEnum>
_$messageResponseSystemEventEnumSerializer =
    _$MessageResponseSystemEventEnumSerializer();

class _$MessageResponseKindEnumSerializer
    implements PrimitiveSerializer<MessageResponseKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USER': 'USER',
    'SYSTEM': 'SYSTEM',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USER': 'USER',
    'SYSTEM': 'SYSTEM',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[MessageResponseKindEnum];
  @override
  final String wireName = 'MessageResponseKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    MessageResponseKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  MessageResponseKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => MessageResponseKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$MessageResponseSystemEventEnumSerializer
    implements PrimitiveSerializer<MessageResponseSystemEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'RESERVATION_REQUESTED': 'RESERVATION_REQUESTED',
    'RESERVATION_UNIT_ASSIGNED': 'RESERVATION_UNIT_ASSIGNED',
    'HOME_REQUEST_OPENED': 'HOME_REQUEST_OPENED',
    'HOME_REQUEST_UPDATED': 'HOME_REQUEST_UPDATED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'RESERVATION_REQUESTED': 'RESERVATION_REQUESTED',
    'RESERVATION_UNIT_ASSIGNED': 'RESERVATION_UNIT_ASSIGNED',
    'HOME_REQUEST_OPENED': 'HOME_REQUEST_OPENED',
    'HOME_REQUEST_UPDATED': 'HOME_REQUEST_UPDATED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[MessageResponseSystemEventEnum];
  @override
  final String wireName = 'MessageResponseSystemEventEnum';

  @override
  Object serialize(
    Serializers serializers,
    MessageResponseSystemEventEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  MessageResponseSystemEventEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => MessageResponseSystemEventEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$MessageResponse extends MessageResponse {
  @override
  final String? id;
  @override
  final String? senderAccountId;
  @override
  final bool? mine;
  @override
  final String? body;
  @override
  final BuiltList<String>? attachmentKeys;
  @override
  final DateTime? sentAt;
  @override
  final DateTime? readAt;
  @override
  final MessageResponseKindEnum? kind;
  @override
  final MessageResponseSystemEventEnum? systemEvent;
  @override
  final ReservationRequestSnapshot? reservation;
  @override
  final String? homeRequestId;

  factory _$MessageResponse([void Function(MessageResponseBuilder)? updates]) =>
      (MessageResponseBuilder()..update(updates))._build();

  _$MessageResponse._({
    this.id,
    this.senderAccountId,
    this.mine,
    this.body,
    this.attachmentKeys,
    this.sentAt,
    this.readAt,
    this.kind,
    this.systemEvent,
    this.reservation,
    this.homeRequestId,
  }) : super._();
  @override
  MessageResponse rebuild(void Function(MessageResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MessageResponseBuilder toBuilder() => MessageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MessageResponse &&
        id == other.id &&
        senderAccountId == other.senderAccountId &&
        mine == other.mine &&
        body == other.body &&
        attachmentKeys == other.attachmentKeys &&
        sentAt == other.sentAt &&
        readAt == other.readAt &&
        kind == other.kind &&
        systemEvent == other.systemEvent &&
        reservation == other.reservation &&
        homeRequestId == other.homeRequestId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, senderAccountId.hashCode);
    _$hash = $jc(_$hash, mine.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, attachmentKeys.hashCode);
    _$hash = $jc(_$hash, sentAt.hashCode);
    _$hash = $jc(_$hash, readAt.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, systemEvent.hashCode);
    _$hash = $jc(_$hash, reservation.hashCode);
    _$hash = $jc(_$hash, homeRequestId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MessageResponse')
          ..add('id', id)
          ..add('senderAccountId', senderAccountId)
          ..add('mine', mine)
          ..add('body', body)
          ..add('attachmentKeys', attachmentKeys)
          ..add('sentAt', sentAt)
          ..add('readAt', readAt)
          ..add('kind', kind)
          ..add('systemEvent', systemEvent)
          ..add('reservation', reservation)
          ..add('homeRequestId', homeRequestId))
        .toString();
  }
}

class MessageResponseBuilder
    implements Builder<MessageResponse, MessageResponseBuilder> {
  _$MessageResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _senderAccountId;
  String? get senderAccountId => _$this._senderAccountId;
  set senderAccountId(String? senderAccountId) =>
      _$this._senderAccountId = senderAccountId;

  bool? _mine;
  bool? get mine => _$this._mine;
  set mine(bool? mine) => _$this._mine = mine;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  ListBuilder<String>? _attachmentKeys;
  ListBuilder<String> get attachmentKeys =>
      _$this._attachmentKeys ??= ListBuilder<String>();
  set attachmentKeys(ListBuilder<String>? attachmentKeys) =>
      _$this._attachmentKeys = attachmentKeys;

  DateTime? _sentAt;
  DateTime? get sentAt => _$this._sentAt;
  set sentAt(DateTime? sentAt) => _$this._sentAt = sentAt;

  DateTime? _readAt;
  DateTime? get readAt => _$this._readAt;
  set readAt(DateTime? readAt) => _$this._readAt = readAt;

  MessageResponseKindEnum? _kind;
  MessageResponseKindEnum? get kind => _$this._kind;
  set kind(MessageResponseKindEnum? kind) => _$this._kind = kind;

  MessageResponseSystemEventEnum? _systemEvent;
  MessageResponseSystemEventEnum? get systemEvent => _$this._systemEvent;
  set systemEvent(MessageResponseSystemEventEnum? systemEvent) =>
      _$this._systemEvent = systemEvent;

  ReservationRequestSnapshotBuilder? _reservation;
  ReservationRequestSnapshotBuilder get reservation =>
      _$this._reservation ??= ReservationRequestSnapshotBuilder();
  set reservation(ReservationRequestSnapshotBuilder? reservation) =>
      _$this._reservation = reservation;

  String? _homeRequestId;
  String? get homeRequestId => _$this._homeRequestId;
  set homeRequestId(String? homeRequestId) =>
      _$this._homeRequestId = homeRequestId;

  MessageResponseBuilder() {
    MessageResponse._defaults(this);
  }

  MessageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _senderAccountId = $v.senderAccountId;
      _mine = $v.mine;
      _body = $v.body;
      _attachmentKeys = $v.attachmentKeys?.toBuilder();
      _sentAt = $v.sentAt;
      _readAt = $v.readAt;
      _kind = $v.kind;
      _systemEvent = $v.systemEvent;
      _reservation = $v.reservation?.toBuilder();
      _homeRequestId = $v.homeRequestId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MessageResponse other) {
    _$v = other as _$MessageResponse;
  }

  @override
  void update(void Function(MessageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MessageResponse build() => _build();

  _$MessageResponse _build() {
    _$MessageResponse _$result;
    try {
      _$result =
          _$v ??
          _$MessageResponse._(
            id: id,
            senderAccountId: senderAccountId,
            mine: mine,
            body: body,
            attachmentKeys: _attachmentKeys?.build(),
            sentAt: sentAt,
            readAt: readAt,
            kind: kind,
            systemEvent: systemEvent,
            reservation: _reservation?.build(),
            homeRequestId: homeRequestId,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attachmentKeys';
        _attachmentKeys?.build();

        _$failedField = 'reservation';
        _reservation?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'MessageResponse',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
