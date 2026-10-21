// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acknowledge_evidence_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AcknowledgeEvidenceRequest extends AcknowledgeEvidenceRequest {
  @override
  final String? comment;

  factory _$AcknowledgeEvidenceRequest([
    void Function(AcknowledgeEvidenceRequestBuilder)? updates,
  ]) => (AcknowledgeEvidenceRequestBuilder()..update(updates))._build();

  _$AcknowledgeEvidenceRequest._({this.comment}) : super._();
  @override
  AcknowledgeEvidenceRequest rebuild(
    void Function(AcknowledgeEvidenceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AcknowledgeEvidenceRequestBuilder toBuilder() =>
      AcknowledgeEvidenceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AcknowledgeEvidenceRequest && comment == other.comment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AcknowledgeEvidenceRequest',
    )..add('comment', comment)).toString();
  }
}

class AcknowledgeEvidenceRequestBuilder
    implements
        Builder<AcknowledgeEvidenceRequest, AcknowledgeEvidenceRequestBuilder> {
  _$AcknowledgeEvidenceRequest? _$v;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  AcknowledgeEvidenceRequestBuilder() {
    AcknowledgeEvidenceRequest._defaults(this);
  }

  AcknowledgeEvidenceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _comment = $v.comment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AcknowledgeEvidenceRequest other) {
    _$v = other as _$AcknowledgeEvidenceRequest;
  }

  @override
  void update(void Function(AcknowledgeEvidenceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AcknowledgeEvidenceRequest build() => _build();

  _$AcknowledgeEvidenceRequest _build() {
    final _$result = _$v ?? _$AcknowledgeEvidenceRequest._(comment: comment);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
