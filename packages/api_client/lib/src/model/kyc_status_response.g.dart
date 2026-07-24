// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_status_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$KycStatusResponse extends KycStatusResponse {
  @override
  final String? status;
  @override
  final DateTime? submittedAt;
  @override
  final DateTime? reviewedAt;
  @override
  final String? rejectionReason;

  factory _$KycStatusResponse([
    void Function(KycStatusResponseBuilder)? updates,
  ]) => (KycStatusResponseBuilder()..update(updates))._build();

  _$KycStatusResponse._({
    this.status,
    this.submittedAt,
    this.reviewedAt,
    this.rejectionReason,
  }) : super._();
  @override
  KycStatusResponse rebuild(void Function(KycStatusResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KycStatusResponseBuilder toBuilder() =>
      KycStatusResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KycStatusResponse &&
        status == other.status &&
        submittedAt == other.submittedAt &&
        reviewedAt == other.reviewedAt &&
        rejectionReason == other.rejectionReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, submittedAt.hashCode);
    _$hash = $jc(_$hash, reviewedAt.hashCode);
    _$hash = $jc(_$hash, rejectionReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KycStatusResponse')
          ..add('status', status)
          ..add('submittedAt', submittedAt)
          ..add('reviewedAt', reviewedAt)
          ..add('rejectionReason', rejectionReason))
        .toString();
  }
}

class KycStatusResponseBuilder
    implements Builder<KycStatusResponse, KycStatusResponseBuilder> {
  _$KycStatusResponse? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  DateTime? _submittedAt;
  DateTime? get submittedAt => _$this._submittedAt;
  set submittedAt(DateTime? submittedAt) => _$this._submittedAt = submittedAt;

  DateTime? _reviewedAt;
  DateTime? get reviewedAt => _$this._reviewedAt;
  set reviewedAt(DateTime? reviewedAt) => _$this._reviewedAt = reviewedAt;

  String? _rejectionReason;
  String? get rejectionReason => _$this._rejectionReason;
  set rejectionReason(String? rejectionReason) =>
      _$this._rejectionReason = rejectionReason;

  KycStatusResponseBuilder() {
    KycStatusResponse._defaults(this);
  }

  KycStatusResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _submittedAt = $v.submittedAt;
      _reviewedAt = $v.reviewedAt;
      _rejectionReason = $v.rejectionReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KycStatusResponse other) {
    _$v = other as _$KycStatusResponse;
  }

  @override
  void update(void Function(KycStatusResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KycStatusResponse build() => _build();

  _$KycStatusResponse _build() {
    final _$result =
        _$v ??
        _$KycStatusResponse._(
          status: status,
          submittedAt: submittedAt,
          reviewedAt: reviewedAt,
          rejectionReason: rejectionReason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
