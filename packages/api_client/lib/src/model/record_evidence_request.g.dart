// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_evidence_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RecordEvidenceRequest extends RecordEvidenceRequest {
  @override
  final BuiltList<EvidencePhotoRequest> photos;

  factory _$RecordEvidenceRequest([
    void Function(RecordEvidenceRequestBuilder)? updates,
  ]) => (RecordEvidenceRequestBuilder()..update(updates))._build();

  _$RecordEvidenceRequest._({required this.photos}) : super._();
  @override
  RecordEvidenceRequest rebuild(
    void Function(RecordEvidenceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  RecordEvidenceRequestBuilder toBuilder() =>
      RecordEvidenceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecordEvidenceRequest && photos == other.photos;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, photos.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'RecordEvidenceRequest',
    )..add('photos', photos)).toString();
  }
}

class RecordEvidenceRequestBuilder
    implements Builder<RecordEvidenceRequest, RecordEvidenceRequestBuilder> {
  _$RecordEvidenceRequest? _$v;

  ListBuilder<EvidencePhotoRequest>? _photos;
  ListBuilder<EvidencePhotoRequest> get photos =>
      _$this._photos ??= ListBuilder<EvidencePhotoRequest>();
  set photos(ListBuilder<EvidencePhotoRequest>? photos) =>
      _$this._photos = photos;

  RecordEvidenceRequestBuilder() {
    RecordEvidenceRequest._defaults(this);
  }

  RecordEvidenceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _photos = $v.photos.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecordEvidenceRequest other) {
    _$v = other as _$RecordEvidenceRequest;
  }

  @override
  void update(void Function(RecordEvidenceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecordEvidenceRequest build() => _build();

  _$RecordEvidenceRequest _build() {
    _$RecordEvidenceRequest _$result;
    try {
      _$result = _$v ?? _$RecordEvidenceRequest._(photos: photos.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'photos';
        photos.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'RecordEvidenceRequest',
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
