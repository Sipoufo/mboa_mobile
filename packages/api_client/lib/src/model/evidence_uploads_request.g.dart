// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evidence_uploads_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EvidenceUploadsRequest extends EvidenceUploadsRequest {
  @override
  final BuiltList<EvidenceFileRequest> files;

  factory _$EvidenceUploadsRequest([
    void Function(EvidenceUploadsRequestBuilder)? updates,
  ]) => (EvidenceUploadsRequestBuilder()..update(updates))._build();

  _$EvidenceUploadsRequest._({required this.files}) : super._();
  @override
  EvidenceUploadsRequest rebuild(
    void Function(EvidenceUploadsRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EvidenceUploadsRequestBuilder toBuilder() =>
      EvidenceUploadsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EvidenceUploadsRequest && files == other.files;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, files.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'EvidenceUploadsRequest',
    )..add('files', files)).toString();
  }
}

class EvidenceUploadsRequestBuilder
    implements Builder<EvidenceUploadsRequest, EvidenceUploadsRequestBuilder> {
  _$EvidenceUploadsRequest? _$v;

  ListBuilder<EvidenceFileRequest>? _files;
  ListBuilder<EvidenceFileRequest> get files =>
      _$this._files ??= ListBuilder<EvidenceFileRequest>();
  set files(ListBuilder<EvidenceFileRequest>? files) => _$this._files = files;

  EvidenceUploadsRequestBuilder() {
    EvidenceUploadsRequest._defaults(this);
  }

  EvidenceUploadsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _files = $v.files.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EvidenceUploadsRequest other) {
    _$v = other as _$EvidenceUploadsRequest;
  }

  @override
  void update(void Function(EvidenceUploadsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EvidenceUploadsRequest build() => _build();

  _$EvidenceUploadsRequest _build() {
    _$EvidenceUploadsRequest _$result;
    try {
      _$result = _$v ?? _$EvidenceUploadsRequest._(files: files.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'files';
        files.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EvidenceUploadsRequest',
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
