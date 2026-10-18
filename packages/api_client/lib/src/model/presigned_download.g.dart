// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presigned_download.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PresignedDownload extends PresignedDownload {
  @override
  final String? downloadUrl;
  @override
  final DateTime? expiresAt;

  factory _$PresignedDownload([
    void Function(PresignedDownloadBuilder)? updates,
  ]) => (PresignedDownloadBuilder()..update(updates))._build();

  _$PresignedDownload._({this.downloadUrl, this.expiresAt}) : super._();
  @override
  PresignedDownload rebuild(void Function(PresignedDownloadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PresignedDownloadBuilder toBuilder() =>
      PresignedDownloadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PresignedDownload &&
        downloadUrl == other.downloadUrl &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, downloadUrl.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PresignedDownload')
          ..add('downloadUrl', downloadUrl)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class PresignedDownloadBuilder
    implements Builder<PresignedDownload, PresignedDownloadBuilder> {
  _$PresignedDownload? _$v;

  String? _downloadUrl;
  String? get downloadUrl => _$this._downloadUrl;
  set downloadUrl(String? downloadUrl) => _$this._downloadUrl = downloadUrl;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  PresignedDownloadBuilder() {
    PresignedDownload._defaults(this);
  }

  PresignedDownloadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _downloadUrl = $v.downloadUrl;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PresignedDownload other) {
    _$v = other as _$PresignedDownload;
  }

  @override
  void update(void Function(PresignedDownloadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PresignedDownload build() => _build();

  _$PresignedDownload _build() {
    final _$result =
        _$v ??
        _$PresignedDownload._(downloadUrl: downloadUrl, expiresAt: expiresAt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
