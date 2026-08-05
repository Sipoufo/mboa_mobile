// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConversationResponse extends ConversationResponse {
  @override
  final String? id;
  @override
  final String? annonceId;
  @override
  final String? annonceTitle;
  @override
  final String? peerAccountId;
  @override
  final String? peerName;
  @override
  final String? peerPhotoKey;
  @override
  final DateTime? lastMessageAt;
  @override
  final String? lastMessage;
  @override
  final int? unreadCount;
  @override
  final bool? readOnly;

  factory _$ConversationResponse([
    void Function(ConversationResponseBuilder)? updates,
  ]) => (ConversationResponseBuilder()..update(updates))._build();

  _$ConversationResponse._({
    this.id,
    this.annonceId,
    this.annonceTitle,
    this.peerAccountId,
    this.peerName,
    this.peerPhotoKey,
    this.lastMessageAt,
    this.lastMessage,
    this.unreadCount,
    this.readOnly,
  }) : super._();
  @override
  ConversationResponse rebuild(
    void Function(ConversationResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ConversationResponseBuilder toBuilder() =>
      ConversationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConversationResponse &&
        id == other.id &&
        annonceId == other.annonceId &&
        annonceTitle == other.annonceTitle &&
        peerAccountId == other.peerAccountId &&
        peerName == other.peerName &&
        peerPhotoKey == other.peerPhotoKey &&
        lastMessageAt == other.lastMessageAt &&
        lastMessage == other.lastMessage &&
        unreadCount == other.unreadCount &&
        readOnly == other.readOnly;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, annonceTitle.hashCode);
    _$hash = $jc(_$hash, peerAccountId.hashCode);
    _$hash = $jc(_$hash, peerName.hashCode);
    _$hash = $jc(_$hash, peerPhotoKey.hashCode);
    _$hash = $jc(_$hash, lastMessageAt.hashCode);
    _$hash = $jc(_$hash, lastMessage.hashCode);
    _$hash = $jc(_$hash, unreadCount.hashCode);
    _$hash = $jc(_$hash, readOnly.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConversationResponse')
          ..add('id', id)
          ..add('annonceId', annonceId)
          ..add('annonceTitle', annonceTitle)
          ..add('peerAccountId', peerAccountId)
          ..add('peerName', peerName)
          ..add('peerPhotoKey', peerPhotoKey)
          ..add('lastMessageAt', lastMessageAt)
          ..add('lastMessage', lastMessage)
          ..add('unreadCount', unreadCount)
          ..add('readOnly', readOnly))
        .toString();
  }
}

class ConversationResponseBuilder
    implements Builder<ConversationResponse, ConversationResponseBuilder> {
  _$ConversationResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _annonceTitle;
  String? get annonceTitle => _$this._annonceTitle;
  set annonceTitle(String? annonceTitle) => _$this._annonceTitle = annonceTitle;

  String? _peerAccountId;
  String? get peerAccountId => _$this._peerAccountId;
  set peerAccountId(String? peerAccountId) =>
      _$this._peerAccountId = peerAccountId;

  String? _peerName;
  String? get peerName => _$this._peerName;
  set peerName(String? peerName) => _$this._peerName = peerName;

  String? _peerPhotoKey;
  String? get peerPhotoKey => _$this._peerPhotoKey;
  set peerPhotoKey(String? peerPhotoKey) => _$this._peerPhotoKey = peerPhotoKey;

  DateTime? _lastMessageAt;
  DateTime? get lastMessageAt => _$this._lastMessageAt;
  set lastMessageAt(DateTime? lastMessageAt) =>
      _$this._lastMessageAt = lastMessageAt;

  String? _lastMessage;
  String? get lastMessage => _$this._lastMessage;
  set lastMessage(String? lastMessage) => _$this._lastMessage = lastMessage;

  int? _unreadCount;
  int? get unreadCount => _$this._unreadCount;
  set unreadCount(int? unreadCount) => _$this._unreadCount = unreadCount;

  bool? _readOnly;
  bool? get readOnly => _$this._readOnly;
  set readOnly(bool? readOnly) => _$this._readOnly = readOnly;

  ConversationResponseBuilder() {
    ConversationResponse._defaults(this);
  }

  ConversationResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _annonceId = $v.annonceId;
      _annonceTitle = $v.annonceTitle;
      _peerAccountId = $v.peerAccountId;
      _peerName = $v.peerName;
      _peerPhotoKey = $v.peerPhotoKey;
      _lastMessageAt = $v.lastMessageAt;
      _lastMessage = $v.lastMessage;
      _unreadCount = $v.unreadCount;
      _readOnly = $v.readOnly;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConversationResponse other) {
    _$v = other as _$ConversationResponse;
  }

  @override
  void update(void Function(ConversationResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConversationResponse build() => _build();

  _$ConversationResponse _build() {
    final _$result =
        _$v ??
        _$ConversationResponse._(
          id: id,
          annonceId: annonceId,
          annonceTitle: annonceTitle,
          peerAccountId: peerAccountId,
          peerName: peerName,
          peerPhotoKey: peerPhotoKey,
          lastMessageAt: lastMessageAt,
          lastMessage: lastMessage,
          unreadCount: unreadCount,
          readOnly: readOnly,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
