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

const KycReviewItemIdDocumentTypeEnum _$kycReviewItemIdDocumentTypeEnum_CNI =
    const KycReviewItemIdDocumentTypeEnum._('CNI');
const KycReviewItemIdDocumentTypeEnum
_$kycReviewItemIdDocumentTypeEnum_PASSPORT =
    const KycReviewItemIdDocumentTypeEnum._('PASSPORT');
const KycReviewItemIdDocumentTypeEnum
_$kycReviewItemIdDocumentTypeEnum_DRIVING_LICENCE =
    const KycReviewItemIdDocumentTypeEnum._('DRIVING_LICENCE');
const KycReviewItemIdDocumentTypeEnum
_$kycReviewItemIdDocumentTypeEnum_unknownDefaultOpenApi =
    const KycReviewItemIdDocumentTypeEnum._('unknownDefaultOpenApi');

KycReviewItemIdDocumentTypeEnum _$kycReviewItemIdDocumentTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'CNI':
      return _$kycReviewItemIdDocumentTypeEnum_CNI;
    case 'PASSPORT':
      return _$kycReviewItemIdDocumentTypeEnum_PASSPORT;
    case 'DRIVING_LICENCE':
      return _$kycReviewItemIdDocumentTypeEnum_DRIVING_LICENCE;
    case 'unknownDefaultOpenApi':
      return _$kycReviewItemIdDocumentTypeEnum_unknownDefaultOpenApi;
    default:
      return _$kycReviewItemIdDocumentTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<KycReviewItemIdDocumentTypeEnum>
_$kycReviewItemIdDocumentTypeEnumValues =
    BuiltSet<KycReviewItemIdDocumentTypeEnum>(
      const <KycReviewItemIdDocumentTypeEnum>[
        _$kycReviewItemIdDocumentTypeEnum_CNI,
        _$kycReviewItemIdDocumentTypeEnum_PASSPORT,
        _$kycReviewItemIdDocumentTypeEnum_DRIVING_LICENCE,
        _$kycReviewItemIdDocumentTypeEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<KycReviewItemRoleEnum> _$kycReviewItemRoleEnumSerializer =
    _$KycReviewItemRoleEnumSerializer();
Serializer<KycReviewItemIdDocumentTypeEnum>
_$kycReviewItemIdDocumentTypeEnumSerializer =
    _$KycReviewItemIdDocumentTypeEnumSerializer();

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

class _$KycReviewItemIdDocumentTypeEnumSerializer
    implements PrimitiveSerializer<KycReviewItemIdDocumentTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CNI': 'CNI',
    'PASSPORT': 'PASSPORT',
    'DRIVING_LICENCE': 'DRIVING_LICENCE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CNI': 'CNI',
    'PASSPORT': 'PASSPORT',
    'DRIVING_LICENCE': 'DRIVING_LICENCE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[KycReviewItemIdDocumentTypeEnum];
  @override
  final String wireName = 'KycReviewItemIdDocumentTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    KycReviewItemIdDocumentTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  KycReviewItemIdDocumentTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => KycReviewItemIdDocumentTypeEnum.valueOf(
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
  @override
  final String? nui;
  @override
  final KycAddress? address;
  @override
  final KycReviewItemIdDocumentTypeEnum? idDocumentType;
  @override
  final String? idNumber;
  @override
  final Date? issuedOn;
  @override
  final Date? expiresOn;
  @override
  final String? issuedAt;

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
    this.nui,
    this.address,
    this.idDocumentType,
    this.idNumber,
    this.issuedOn,
    this.expiresOn,
    this.issuedAt,
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
        overdue == other.overdue &&
        nui == other.nui &&
        address == other.address &&
        idDocumentType == other.idDocumentType &&
        idNumber == other.idNumber &&
        issuedOn == other.issuedOn &&
        expiresOn == other.expiresOn &&
        issuedAt == other.issuedAt;
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
    _$hash = $jc(_$hash, nui.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, idDocumentType.hashCode);
    _$hash = $jc(_$hash, idNumber.hashCode);
    _$hash = $jc(_$hash, issuedOn.hashCode);
    _$hash = $jc(_$hash, expiresOn.hashCode);
    _$hash = $jc(_$hash, issuedAt.hashCode);
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
          ..add('overdue', overdue)
          ..add('nui', nui)
          ..add('address', address)
          ..add('idDocumentType', idDocumentType)
          ..add('idNumber', idNumber)
          ..add('issuedOn', issuedOn)
          ..add('expiresOn', expiresOn)
          ..add('issuedAt', issuedAt))
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

  String? _nui;
  String? get nui => _$this._nui;
  set nui(String? nui) => _$this._nui = nui;

  KycAddressBuilder? _address;
  KycAddressBuilder get address => _$this._address ??= KycAddressBuilder();
  set address(KycAddressBuilder? address) => _$this._address = address;

  KycReviewItemIdDocumentTypeEnum? _idDocumentType;
  KycReviewItemIdDocumentTypeEnum? get idDocumentType => _$this._idDocumentType;
  set idDocumentType(KycReviewItemIdDocumentTypeEnum? idDocumentType) =>
      _$this._idDocumentType = idDocumentType;

  String? _idNumber;
  String? get idNumber => _$this._idNumber;
  set idNumber(String? idNumber) => _$this._idNumber = idNumber;

  Date? _issuedOn;
  Date? get issuedOn => _$this._issuedOn;
  set issuedOn(Date? issuedOn) => _$this._issuedOn = issuedOn;

  Date? _expiresOn;
  Date? get expiresOn => _$this._expiresOn;
  set expiresOn(Date? expiresOn) => _$this._expiresOn = expiresOn;

  String? _issuedAt;
  String? get issuedAt => _$this._issuedAt;
  set issuedAt(String? issuedAt) => _$this._issuedAt = issuedAt;

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
      _nui = $v.nui;
      _address = $v.address?.toBuilder();
      _idDocumentType = $v.idDocumentType;
      _idNumber = $v.idNumber;
      _issuedOn = $v.issuedOn;
      _expiresOn = $v.expiresOn;
      _issuedAt = $v.issuedAt;
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
    _$KycReviewItem _$result;
    try {
      _$result =
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
            nui: nui,
            address: _address?.build(),
            idDocumentType: idDocumentType,
            idNumber: idNumber,
            issuedOn: issuedOn,
            expiresOn: expiresOn,
            issuedAt: issuedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'address';
        _address?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'KycReviewItem',
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
