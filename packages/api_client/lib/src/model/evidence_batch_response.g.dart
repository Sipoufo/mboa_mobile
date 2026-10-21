// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evidence_batch_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EvidenceBatchResponse extends EvidenceBatchResponse {
  @override
  final String? id;
  @override
  final String? contractId;
  @override
  final DateTime? recordedAt;
  @override
  final BuiltList<EvidencePhotoResponse>? photos;
  @override
  final DateTime? acknowledgedAt;
  @override
  final String? ownerComment;
  @override
  final bool? canAcknowledge;

  factory _$EvidenceBatchResponse([
    void Function(EvidenceBatchResponseBuilder)? updates,
  ]) => (EvidenceBatchResponseBuilder()..update(updates))._build();

  _$EvidenceBatchResponse._({
    this.id,
    this.contractId,
    this.recordedAt,
    this.photos,
    this.acknowledgedAt,
    this.ownerComment,
    this.canAcknowledge,
  }) : super._();
  @override
  EvidenceBatchResponse rebuild(
    void Function(EvidenceBatchResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EvidenceBatchResponseBuilder toBuilder() =>
      EvidenceBatchResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EvidenceBatchResponse &&
        id == other.id &&
        contractId == other.contractId &&
        recordedAt == other.recordedAt &&
        photos == other.photos &&
        acknowledgedAt == other.acknowledgedAt &&
        ownerComment == other.ownerComment &&
        canAcknowledge == other.canAcknowledge;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, contractId.hashCode);
    _$hash = $jc(_$hash, recordedAt.hashCode);
    _$hash = $jc(_$hash, photos.hashCode);
    _$hash = $jc(_$hash, acknowledgedAt.hashCode);
    _$hash = $jc(_$hash, ownerComment.hashCode);
    _$hash = $jc(_$hash, canAcknowledge.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EvidenceBatchResponse')
          ..add('id', id)
          ..add('contractId', contractId)
          ..add('recordedAt', recordedAt)
          ..add('photos', photos)
          ..add('acknowledgedAt', acknowledgedAt)
          ..add('ownerComment', ownerComment)
          ..add('canAcknowledge', canAcknowledge))
        .toString();
  }
}

class EvidenceBatchResponseBuilder
    implements Builder<EvidenceBatchResponse, EvidenceBatchResponseBuilder> {
  _$EvidenceBatchResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _contractId;
  String? get contractId => _$this._contractId;
  set contractId(String? contractId) => _$this._contractId = contractId;

  DateTime? _recordedAt;
  DateTime? get recordedAt => _$this._recordedAt;
  set recordedAt(DateTime? recordedAt) => _$this._recordedAt = recordedAt;

  ListBuilder<EvidencePhotoResponse>? _photos;
  ListBuilder<EvidencePhotoResponse> get photos =>
      _$this._photos ??= ListBuilder<EvidencePhotoResponse>();
  set photos(ListBuilder<EvidencePhotoResponse>? photos) =>
      _$this._photos = photos;

  DateTime? _acknowledgedAt;
  DateTime? get acknowledgedAt => _$this._acknowledgedAt;
  set acknowledgedAt(DateTime? acknowledgedAt) =>
      _$this._acknowledgedAt = acknowledgedAt;

  String? _ownerComment;
  String? get ownerComment => _$this._ownerComment;
  set ownerComment(String? ownerComment) => _$this._ownerComment = ownerComment;

  bool? _canAcknowledge;
  bool? get canAcknowledge => _$this._canAcknowledge;
  set canAcknowledge(bool? canAcknowledge) =>
      _$this._canAcknowledge = canAcknowledge;

  EvidenceBatchResponseBuilder() {
    EvidenceBatchResponse._defaults(this);
  }

  EvidenceBatchResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _contractId = $v.contractId;
      _recordedAt = $v.recordedAt;
      _photos = $v.photos?.toBuilder();
      _acknowledgedAt = $v.acknowledgedAt;
      _ownerComment = $v.ownerComment;
      _canAcknowledge = $v.canAcknowledge;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EvidenceBatchResponse other) {
    _$v = other as _$EvidenceBatchResponse;
  }

  @override
  void update(void Function(EvidenceBatchResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EvidenceBatchResponse build() => _build();

  _$EvidenceBatchResponse _build() {
    _$EvidenceBatchResponse _$result;
    try {
      _$result =
          _$v ??
          _$EvidenceBatchResponse._(
            id: id,
            contractId: contractId,
            recordedAt: recordedAt,
            photos: _photos?.build(),
            acknowledgedAt: acknowledgedAt,
            ownerComment: ownerComment,
            canAcknowledge: canAcknowledge,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'photos';
        _photos?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EvidenceBatchResponse',
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
