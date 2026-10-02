// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_review_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const KycReviewItemRoleEnum _$kycReviewItemRoleEnum_USER =
    const KycReviewItemRoleEnum._('USER');
const KycReviewItemRoleEnum _$kycReviewItemRoleEnum_PRESTATAIRE =
    const KycReviewItemRoleEnum._('PRESTATAIRE');
const KycReviewItemRoleEnum _$kycReviewItemRoleEnum_AGENT =
    const KycReviewItemRoleEnum._('AGENT');
const KycReviewItemRoleEnum _$kycReviewItemRoleEnum_ADMIN =
    const KycReviewItemRoleEnum._('ADMIN');
const KycReviewItemRoleEnum _$kycReviewItemRoleEnum_unknownDefaultOpenApi =
    const KycReviewItemRoleEnum._('unknownDefaultOpenApi');

KycReviewItemRoleEnum _$kycReviewItemRoleEnumValueOf(String name) {
  switch (name) {
    case 'USER':
      return _$kycReviewItemRoleEnum_USER;
    case 'PRESTATAIRE':
      return _$kycReviewItemRoleEnum_PRESTATAIRE;
    case 'AGENT':
      return _$kycReviewItemRoleEnum_AGENT;
    case 'ADMIN':
      return _$kycReviewItemRoleEnum_ADMIN;
    case 'unknownDefaultOpenApi':
      return _$kycReviewItemRoleEnum_unknownDefaultOpenApi;
    default:
      return _$kycReviewItemRoleEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<KycReviewItemRoleEnum> _$kycReviewItemRoleEnumValues =
    BuiltSet<KycReviewItemRoleEnum>(const <KycReviewItemRoleEnum>[
      _$kycReviewItemRoleEnum_USER,
      _$kycReviewItemRoleEnum_PRESTATAIRE,
      _$kycReviewItemRoleEnum_AGENT,
      _$kycReviewItemRoleEnum_ADMIN,
      _$kycReviewItemRoleEnum_unknownDefaultOpenApi,
    ]);

Serializer<KycReviewItemRoleEnum> _$kycReviewItemRoleEnumSerializer =
    _$KycReviewItemRoleEnumSerializer();

class _$KycReviewItemRoleEnumSerializer
    implements PrimitiveSerializer<KycReviewItemRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USER': 'USER',
    'PRESTATAIRE': 'PRESTATAIRE',
    'AGENT': 'AGENT',
    'ADMIN': 'ADMIN',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USER': 'USER',
    'PRESTATAIRE': 'PRESTATAIRE',
    'AGENT': 'AGENT',
    'ADMIN': 'ADMIN',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[KycReviewItemRoleEnum];
  @override
  final String wireName = 'KycReviewItemRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    KycReviewItemRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  KycReviewItemRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => KycReviewItemRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

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
  @override
  final KycReviewItemRoleEnum? role;
  @override
  final String? displayName;
  @override
  final DateTime? dueAt;
  @override
  final bool? overdue;

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
    this.role,
    this.displayName,
    this.dueAt,
    this.overdue,
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
        selfieUrl == other.selfieUrl &&
        role == other.role &&
        displayName == other.displayName &&
        dueAt == other.dueAt &&
        overdue == other.overdue;
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
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, dueAt.hashCode);
    _$hash = $jc(_$hash, overdue.hashCode);
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
          ..add('selfieUrl', selfieUrl)
          ..add('role', role)
          ..add('displayName', displayName)
          ..add('dueAt', dueAt)
          ..add('overdue', overdue))
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

  KycReviewItemRoleEnum? _role;
  KycReviewItemRoleEnum? get role => _$this._role;
  set role(KycReviewItemRoleEnum? role) => _$this._role = role;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  DateTime? _dueAt;
  DateTime? get dueAt => _$this._dueAt;
  set dueAt(DateTime? dueAt) => _$this._dueAt = dueAt;

  bool? _overdue;
  bool? get overdue => _$this._overdue;
  set overdue(bool? overdue) => _$this._overdue = overdue;

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
      _role = $v.role;
      _displayName = $v.displayName;
      _dueAt = $v.dueAt;
      _overdue = $v.overdue;
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
          role: role,
          displayName: displayName,
          dueAt: dueAt,
          overdue: overdue,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
