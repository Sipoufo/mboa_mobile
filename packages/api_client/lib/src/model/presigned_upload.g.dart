// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presigned_upload.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PresignedUpload extends PresignedUpload {
  @override
  final String? uploadUrl;
  @override
  final String? method;
  @override
  final String? objectKey;
  @override
  final DateTime? expiresAt;

  factory _$PresignedUpload([void Function(PresignedUploadBuilder)? updates]) =>
      (PresignedUploadBuilder()..update(updates))._build();

  _$PresignedUpload._({
    this.uploadUrl,
    this.method,
    this.objectKey,
    this.expiresAt,
  }) : super._();
  @override
  PresignedUpload rebuild(void Function(PresignedUploadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PresignedUploadBuilder toBuilder() => PresignedUploadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PresignedUpload &&
        uploadUrl == other.uploadUrl &&
        method == other.method &&
        objectKey == other.objectKey &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, uploadUrl.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, objectKey.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PresignedUpload')
          ..add('uploadUrl', uploadUrl)
          ..add('method', method)
          ..add('objectKey', objectKey)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class PresignedUploadBuilder
    implements Builder<PresignedUpload, PresignedUploadBuilder> {
  _$PresignedUpload? _$v;

  String? _uploadUrl;
  String? get uploadUrl => _$this._uploadUrl;
  set uploadUrl(String? uploadUrl) => _$this._uploadUrl = uploadUrl;

  String? _method;
  String? get method => _$this._method;
  set method(String? method) => _$this._method = method;

  String? _objectKey;
  String? get objectKey => _$this._objectKey;
  set objectKey(String? objectKey) => _$this._objectKey = objectKey;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  PresignedUploadBuilder() {
    PresignedUpload._defaults(this);
  }

  PresignedUploadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _uploadUrl = $v.uploadUrl;
      _method = $v.method;
      _objectKey = $v.objectKey;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PresignedUpload other) {
    _$v = other as _$PresignedUpload;
  }

  @override
  void update(void Function(PresignedUploadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PresignedUpload build() => _build();

  _$PresignedUpload _build() {
    final _$result =
        _$v ??
        _$PresignedUpload._(
          uploadUrl: uploadUrl,
          method: method,
          objectKey: objectKey,
          expiresAt: expiresAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
