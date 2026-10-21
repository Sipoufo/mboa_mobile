// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evidence_file_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EvidenceFileRequest extends EvidenceFileRequest {
  @override
  final String contentType;
  @override
  final int size;
  @override
  final String sha256;

  factory _$EvidenceFileRequest([
    void Function(EvidenceFileRequestBuilder)? updates,
  ]) => (EvidenceFileRequestBuilder()..update(updates))._build();

  _$EvidenceFileRequest._({
    required this.contentType,
    required this.size,
    required this.sha256,
  }) : super._();
  @override
  EvidenceFileRequest rebuild(
    void Function(EvidenceFileRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EvidenceFileRequestBuilder toBuilder() =>
      EvidenceFileRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EvidenceFileRequest &&
        contentType == other.contentType &&
        size == other.size &&
        sha256 == other.sha256;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, contentType.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jc(_$hash, sha256.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EvidenceFileRequest')
          ..add('contentType', contentType)
          ..add('size', size)
          ..add('sha256', sha256))
        .toString();
  }
}

class EvidenceFileRequestBuilder
    implements Builder<EvidenceFileRequest, EvidenceFileRequestBuilder> {
  _$EvidenceFileRequest? _$v;

  String? _contentType;
  String? get contentType => _$this._contentType;
  set contentType(String? contentType) => _$this._contentType = contentType;

  int? _size;
  int? get size => _$this._size;
  set size(int? size) => _$this._size = size;

  String? _sha256;
  String? get sha256 => _$this._sha256;
  set sha256(String? sha256) => _$this._sha256 = sha256;

  EvidenceFileRequestBuilder() {
    EvidenceFileRequest._defaults(this);
  }

  EvidenceFileRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _contentType = $v.contentType;
      _size = $v.size;
      _sha256 = $v.sha256;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EvidenceFileRequest other) {
    _$v = other as _$EvidenceFileRequest;
  }

  @override
  void update(void Function(EvidenceFileRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EvidenceFileRequest build() => _build();

  _$EvidenceFileRequest _build() {
    final _$result =
        _$v ??
        _$EvidenceFileRequest._(
          contentType: BuiltValueNullFieldError.checkNotNull(
            contentType,
            r'EvidenceFileRequest',
            'contentType',
          ),
          size: BuiltValueNullFieldError.checkNotNull(
            size,
            r'EvidenceFileRequest',
            'size',
          ),
          sha256: BuiltValueNullFieldError.checkNotNull(
            sha256,
            r'EvidenceFileRequest',
            'sha256',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
