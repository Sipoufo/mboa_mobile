// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Reply extends Reply {
  @override
  final String? authorName;
  @override
  final String? body;
  @override
  final DateTime? createdAt;

  factory _$Reply([void Function(ReplyBuilder)? updates]) =>
      (ReplyBuilder()..update(updates))._build();

  _$Reply._({this.authorName, this.body, this.createdAt}) : super._();
  @override
  Reply rebuild(void Function(ReplyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReplyBuilder toBuilder() => ReplyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Reply &&
        authorName == other.authorName &&
        body == other.body &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, authorName.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Reply')
          ..add('authorName', authorName)
          ..add('body', body)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ReplyBuilder implements Builder<Reply, ReplyBuilder> {
  _$Reply? _$v;

  String? _authorName;
  String? get authorName => _$this._authorName;
  set authorName(String? authorName) => _$this._authorName = authorName;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ReplyBuilder() {
    Reply._defaults(this);
  }

  ReplyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _authorName = $v.authorName;
      _body = $v.body;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Reply other) {
    _$v = other as _$Reply;
  }

  @override
  void update(void Function(ReplyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Reply build() => _build();

  _$Reply _build() {
    final _$result =
        _$v ??
        _$Reply._(authorName: authorName, body: body, createdAt: createdAt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
