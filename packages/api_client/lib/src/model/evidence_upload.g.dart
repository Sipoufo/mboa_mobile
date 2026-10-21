// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evidence_upload.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EvidenceUpload extends EvidenceUpload {
  @override
  final String? uploadUrl;
  @override
  final String? method;
  @override
  final String? objectKey;
  @override
  final BuiltMap<String, String>? headers;
  @override
  final DateTime? expiresAt;

  factory _$EvidenceUpload([void Function(EvidenceUploadBuilder)? updates]) =>
      (EvidenceUploadBuilder()..update(updates))._build();

  _$EvidenceUpload._({
    this.uploadUrl,
    this.method,
    this.objectKey,
    this.headers,
    this.expiresAt,
  }) : super._();
  @override
  EvidenceUpload rebuild(void Function(EvidenceUploadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EvidenceUploadBuilder toBuilder() => EvidenceUploadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EvidenceUpload &&
        uploadUrl == other.uploadUrl &&
        method == other.method &&
        objectKey == other.objectKey &&
        headers == other.headers &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, uploadUrl.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, objectKey.hashCode);
    _$hash = $jc(_$hash, headers.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EvidenceUpload')
          ..add('uploadUrl', uploadUrl)
          ..add('method', method)
          ..add('objectKey', objectKey)
          ..add('headers', headers)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class EvidenceUploadBuilder
    implements Builder<EvidenceUpload, EvidenceUploadBuilder> {
  _$EvidenceUpload? _$v;

  String? _uploadUrl;
  String? get uploadUrl => _$this._uploadUrl;
  set uploadUrl(String? uploadUrl) => _$this._uploadUrl = uploadUrl;

  String? _method;
  String? get method => _$this._method;
  set method(String? method) => _$this._method = method;

  String? _objectKey;
  String? get objectKey => _$this._objectKey;
  set objectKey(String? objectKey) => _$this._objectKey = objectKey;

  MapBuilder<String, String>? _headers;
  MapBuilder<String, String> get headers =>
      _$this._headers ??= MapBuilder<String, String>();
  set headers(MapBuilder<String, String>? headers) => _$this._headers = headers;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  EvidenceUploadBuilder() {
    EvidenceUpload._defaults(this);
  }

  EvidenceUploadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _uploadUrl = $v.uploadUrl;
      _method = $v.method;
      _objectKey = $v.objectKey;
      _headers = $v.headers?.toBuilder();
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EvidenceUpload other) {
    _$v = other as _$EvidenceUpload;
  }

  @override
  void update(void Function(EvidenceUploadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EvidenceUpload build() => _build();

  _$EvidenceUpload _build() {
    _$EvidenceUpload _$result;
    try {
      _$result =
          _$v ??
          _$EvidenceUpload._(
            uploadUrl: uploadUrl,
            method: method,
            objectKey: objectKey,
            headers: _headers?.build(),
            expiresAt: expiresAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'headers';
        _headers?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EvidenceUpload',
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
