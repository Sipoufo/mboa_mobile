// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

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
        readAt == other.readAt;
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
          ..add('readAt', readAt))
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
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attachmentKeys';
        _attachmentKeys?.build();
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
