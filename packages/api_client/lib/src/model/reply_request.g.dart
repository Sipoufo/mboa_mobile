// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReplyRequest extends ReplyRequest {
  @override
  final String body;

  factory _$ReplyRequest([void Function(ReplyRequestBuilder)? updates]) =>
      (ReplyRequestBuilder()..update(updates))._build();

  _$ReplyRequest._({required this.body}) : super._();
  @override
  ReplyRequest rebuild(void Function(ReplyRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReplyRequestBuilder toBuilder() => ReplyRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReplyRequest && body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ReplyRequest',
    )..add('body', body)).toString();
  }
}

class ReplyRequestBuilder
    implements Builder<ReplyRequest, ReplyRequestBuilder> {
  _$ReplyRequest? _$v;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  ReplyRequestBuilder() {
    ReplyRequest._defaults(this);
  }

  ReplyRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReplyRequest other) {
    _$v = other as _$ReplyRequest;
  }

  @override
  void update(void Function(ReplyRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReplyRequest build() => _build();

  _$ReplyRequest _build() {
    final _$result =
        _$v ??
        _$ReplyRequest._(
          body: BuiltValueNullFieldError.checkNotNull(
            body,
            r'ReplyRequest',
            'body',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
