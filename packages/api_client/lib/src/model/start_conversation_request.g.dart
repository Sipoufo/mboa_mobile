// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_conversation_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StartConversationRequest extends StartConversationRequest {
  @override
  final String annonceId;
  @override
  final String? body;
  @override
  final BuiltList<String>? attachmentKeys;

  factory _$StartConversationRequest([
    void Function(StartConversationRequestBuilder)? updates,
  ]) => (StartConversationRequestBuilder()..update(updates))._build();

  _$StartConversationRequest._({
    required this.annonceId,
    this.body,
    this.attachmentKeys,
  }) : super._();
  @override
  StartConversationRequest rebuild(
    void Function(StartConversationRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StartConversationRequestBuilder toBuilder() =>
      StartConversationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StartConversationRequest &&
        annonceId == other.annonceId &&
        body == other.body &&
        attachmentKeys == other.attachmentKeys;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, attachmentKeys.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StartConversationRequest')
          ..add('annonceId', annonceId)
          ..add('body', body)
          ..add('attachmentKeys', attachmentKeys))
        .toString();
  }
}

class StartConversationRequestBuilder
    implements
        Builder<StartConversationRequest, StartConversationRequestBuilder> {
  _$StartConversationRequest? _$v;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  ListBuilder<String>? _attachmentKeys;
  ListBuilder<String> get attachmentKeys =>
      _$this._attachmentKeys ??= ListBuilder<String>();
  set attachmentKeys(ListBuilder<String>? attachmentKeys) =>
      _$this._attachmentKeys = attachmentKeys;

  StartConversationRequestBuilder() {
    StartConversationRequest._defaults(this);
  }

  StartConversationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _annonceId = $v.annonceId;
      _body = $v.body;
      _attachmentKeys = $v.attachmentKeys?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StartConversationRequest other) {
    _$v = other as _$StartConversationRequest;
  }

  @override
  void update(void Function(StartConversationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StartConversationRequest build() => _build();

  _$StartConversationRequest _build() {
    _$StartConversationRequest _$result;
    try {
      _$result =
          _$v ??
          _$StartConversationRequest._(
            annonceId: BuiltValueNullFieldError.checkNotNull(
              annonceId,
              r'StartConversationRequest',
              'annonceId',
            ),
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
          r'StartConversationRequest',
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
