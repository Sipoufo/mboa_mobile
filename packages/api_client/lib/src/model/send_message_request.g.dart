// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendMessageRequest extends SendMessageRequest {
  @override
  final String? body;
  @override
  final BuiltList<String>? attachmentKeys;

  factory _$SendMessageRequest([
    void Function(SendMessageRequestBuilder)? updates,
  ]) => (SendMessageRequestBuilder()..update(updates))._build();

  _$SendMessageRequest._({this.body, this.attachmentKeys}) : super._();
  @override
  SendMessageRequest rebuild(
    void Function(SendMessageRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SendMessageRequestBuilder toBuilder() =>
      SendMessageRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendMessageRequest &&
        body == other.body &&
        attachmentKeys == other.attachmentKeys;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, attachmentKeys.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SendMessageRequest')
          ..add('body', body)
          ..add('attachmentKeys', attachmentKeys))
        .toString();
  }
}

class SendMessageRequestBuilder
    implements Builder<SendMessageRequest, SendMessageRequestBuilder> {
  _$SendMessageRequest? _$v;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  ListBuilder<String>? _attachmentKeys;
  ListBuilder<String> get attachmentKeys =>
      _$this._attachmentKeys ??= ListBuilder<String>();
  set attachmentKeys(ListBuilder<String>? attachmentKeys) =>
      _$this._attachmentKeys = attachmentKeys;

  SendMessageRequestBuilder() {
    SendMessageRequest._defaults(this);
  }

  SendMessageRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _body = $v.body;
      _attachmentKeys = $v.attachmentKeys?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendMessageRequest other) {
    _$v = other as _$SendMessageRequest;
  }

  @override
  void update(void Function(SendMessageRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendMessageRequest build() => _build();

  _$SendMessageRequest _build() {
    _$SendMessageRequest _$result;
    try {
      _$result =
          _$v ??
          _$SendMessageRequest._(
            body: body,
            attachmentKeys: _attachmentKeys?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attachmentKeys';
        _attachmentKeys?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SendMessageRequest',
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
