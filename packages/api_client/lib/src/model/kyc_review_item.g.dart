// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_review_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$KycReviewItem extends KycReviewItem {
  @override
  final String? id;
  @override
  final String? accountId;
  @override
  final String? status;
  @override
  final DateTime? submittedAt;
  @override
  final String? idDocumentFrontUrl;
  @override
  final String? idDocumentBackUrl;
  @override
  final String? selfieUrl;

  factory _$KycReviewItem([void Function(KycReviewItemBuilder)? updates]) =>
      (KycReviewItemBuilder()..update(updates))._build();

  _$KycReviewItem._({
    this.id,
    this.accountId,
    this.status,
    this.submittedAt,
    this.idDocumentFrontUrl,
    this.idDocumentBackUrl,
    this.selfieUrl,
  }) : super._();
  @override
  KycReviewItem rebuild(void Function(KycReviewItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KycReviewItemBuilder toBuilder() => KycReviewItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KycReviewItem &&
        id == other.id &&
        accountId == other.accountId &&
        status == other.status &&
        submittedAt == other.submittedAt &&
        idDocumentFrontUrl == other.idDocumentFrontUrl &&
        idDocumentBackUrl == other.idDocumentBackUrl &&
        selfieUrl == other.selfieUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, submittedAt.hashCode);
    _$hash = $jc(_$hash, idDocumentFrontUrl.hashCode);
    _$hash = $jc(_$hash, idDocumentBackUrl.hashCode);
    _$hash = $jc(_$hash, selfieUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KycReviewItem')
          ..add('id', id)
          ..add('accountId', accountId)
          ..add('status', status)
          ..add('submittedAt', submittedAt)
          ..add('idDocumentFrontUrl', idDocumentFrontUrl)
          ..add('idDocumentBackUrl', idDocumentBackUrl)
          ..add('selfieUrl', selfieUrl))
        .toString();
  }
}

class KycReviewItemBuilder
    implements Builder<KycReviewItem, KycReviewItemBuilder> {
  _$KycReviewItem? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  DateTime? _submittedAt;
  DateTime? get submittedAt => _$this._submittedAt;
  set submittedAt(DateTime? submittedAt) => _$this._submittedAt = submittedAt;

  String? _idDocumentFrontUrl;
  String? get idDocumentFrontUrl => _$this._idDocumentFrontUrl;
  set idDocumentFrontUrl(String? idDocumentFrontUrl) =>
      _$this._idDocumentFrontUrl = idDocumentFrontUrl;

  String? _idDocumentBackUrl;
  String? get idDocumentBackUrl => _$this._idDocumentBackUrl;
  set idDocumentBackUrl(String? idDocumentBackUrl) =>
      _$this._idDocumentBackUrl = idDocumentBackUrl;

  String? _selfieUrl;
  String? get selfieUrl => _$this._selfieUrl;
  set selfieUrl(String? selfieUrl) => _$this._selfieUrl = selfieUrl;

  KycReviewItemBuilder() {
    KycReviewItem._defaults(this);
  }

  KycReviewItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _accountId = $v.accountId;
      _status = $v.status;
      _submittedAt = $v.submittedAt;
      _idDocumentFrontUrl = $v.idDocumentFrontUrl;
      _idDocumentBackUrl = $v.idDocumentBackUrl;
      _selfieUrl = $v.selfieUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KycReviewItem other) {
    _$v = other as _$KycReviewItem;
  }

  @override
  void update(void Function(KycReviewItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KycReviewItem build() => _build();

  _$KycReviewItem _build() {
    final _$result =
        _$v ??
        _$KycReviewItem._(
          id: id,
          accountId: accountId,
          status: status,
          submittedAt: submittedAt,
          idDocumentFrontUrl: idDocumentFrontUrl,
          idDocumentBackUrl: idDocumentBackUrl,
          selfieUrl: selfieUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
