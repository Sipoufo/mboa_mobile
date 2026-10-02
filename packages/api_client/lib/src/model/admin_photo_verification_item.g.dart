// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_photo_verification_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdminPhotoVerificationItemTargetEnum
_$adminPhotoVerificationItemTargetEnum_ANNONCE =
    const AdminPhotoVerificationItemTargetEnum._('ANNONCE');
const AdminPhotoVerificationItemTargetEnum
_$adminPhotoVerificationItemTargetEnum_RESIDENCE =
    const AdminPhotoVerificationItemTargetEnum._('RESIDENCE');
const AdminPhotoVerificationItemTargetEnum
_$adminPhotoVerificationItemTargetEnum_unknownDefaultOpenApi =
    const AdminPhotoVerificationItemTargetEnum._('unknownDefaultOpenApi');

AdminPhotoVerificationItemTargetEnum
_$adminPhotoVerificationItemTargetEnumValueOf(String name) {
  switch (name) {
    case 'ANNONCE':
      return _$adminPhotoVerificationItemTargetEnum_ANNONCE;
    case 'RESIDENCE':
      return _$adminPhotoVerificationItemTargetEnum_RESIDENCE;
    case 'unknownDefaultOpenApi':
      return _$adminPhotoVerificationItemTargetEnum_unknownDefaultOpenApi;
    default:
      return _$adminPhotoVerificationItemTargetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminPhotoVerificationItemTargetEnum>
_$adminPhotoVerificationItemTargetEnumValues =
    BuiltSet<AdminPhotoVerificationItemTargetEnum>(
      const <AdminPhotoVerificationItemTargetEnum>[
        _$adminPhotoVerificationItemTargetEnum_ANNONCE,
        _$adminPhotoVerificationItemTargetEnum_RESIDENCE,
        _$adminPhotoVerificationItemTargetEnum_unknownDefaultOpenApi,
      ],
    );

const AdminPhotoVerificationItemStatusEnum
_$adminPhotoVerificationItemStatusEnum_PENDING =
    const AdminPhotoVerificationItemStatusEnum._('PENDING');
const AdminPhotoVerificationItemStatusEnum
_$adminPhotoVerificationItemStatusEnum_APPROVED =
    const AdminPhotoVerificationItemStatusEnum._('APPROVED');
const AdminPhotoVerificationItemStatusEnum
_$adminPhotoVerificationItemStatusEnum_REJECTED =
    const AdminPhotoVerificationItemStatusEnum._('REJECTED');
const AdminPhotoVerificationItemStatusEnum
_$adminPhotoVerificationItemStatusEnum_REVOKED =
    const AdminPhotoVerificationItemStatusEnum._('REVOKED');
const AdminPhotoVerificationItemStatusEnum
_$adminPhotoVerificationItemStatusEnum_unknownDefaultOpenApi =
    const AdminPhotoVerificationItemStatusEnum._('unknownDefaultOpenApi');

AdminPhotoVerificationItemStatusEnum
_$adminPhotoVerificationItemStatusEnumValueOf(String name) {
  switch (name) {
    case 'PENDING':
      return _$adminPhotoVerificationItemStatusEnum_PENDING;
    case 'APPROVED':
      return _$adminPhotoVerificationItemStatusEnum_APPROVED;
    case 'REJECTED':
      return _$adminPhotoVerificationItemStatusEnum_REJECTED;
    case 'REVOKED':
      return _$adminPhotoVerificationItemStatusEnum_REVOKED;
    case 'unknownDefaultOpenApi':
      return _$adminPhotoVerificationItemStatusEnum_unknownDefaultOpenApi;
    default:
      return _$adminPhotoVerificationItemStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminPhotoVerificationItemStatusEnum>
_$adminPhotoVerificationItemStatusEnumValues =
    BuiltSet<AdminPhotoVerificationItemStatusEnum>(
      const <AdminPhotoVerificationItemStatusEnum>[
        _$adminPhotoVerificationItemStatusEnum_PENDING,
        _$adminPhotoVerificationItemStatusEnum_APPROVED,
        _$adminPhotoVerificationItemStatusEnum_REJECTED,
        _$adminPhotoVerificationItemStatusEnum_REVOKED,
        _$adminPhotoVerificationItemStatusEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<AdminPhotoVerificationItemTargetEnum>
_$adminPhotoVerificationItemTargetEnumSerializer =
    _$AdminPhotoVerificationItemTargetEnumSerializer();
Serializer<AdminPhotoVerificationItemStatusEnum>
_$adminPhotoVerificationItemStatusEnumSerializer =
    _$AdminPhotoVerificationItemStatusEnumSerializer();

class _$AdminPhotoVerificationItemTargetEnumSerializer
    implements PrimitiveSerializer<AdminPhotoVerificationItemTargetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ANNONCE': 'ANNONCE',
    'RESIDENCE': 'RESIDENCE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ANNONCE': 'ANNONCE',
    'RESIDENCE': 'RESIDENCE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AdminPhotoVerificationItemTargetEnum,
  ];
  @override
  final String wireName = 'AdminPhotoVerificationItemTargetEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminPhotoVerificationItemTargetEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminPhotoVerificationItemTargetEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminPhotoVerificationItemTargetEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminPhotoVerificationItemStatusEnumSerializer
    implements PrimitiveSerializer<AdminPhotoVerificationItemStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
    'APPROVED': 'APPROVED',
    'REJECTED': 'REJECTED',
    'REVOKED': 'REVOKED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
    'APPROVED': 'APPROVED',
    'REJECTED': 'REJECTED',
    'REVOKED': 'REVOKED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AdminPhotoVerificationItemStatusEnum,
  ];
  @override
  final String wireName = 'AdminPhotoVerificationItemStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminPhotoVerificationItemStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminPhotoVerificationItemStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminPhotoVerificationItemStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminPhotoVerificationItem extends AdminPhotoVerificationItem {
  @override
  final String? id;
  @override
  final String? accountId;
  @override
  final AdminPhotoVerificationItemTargetEnum? target;
  @override
  final String? targetId;
  @override
  final AdminPhotoVerificationItemStatusEnum? status;
  @override
  final DateTime? requestedAt;
  @override
  final DateTime? dueAt;
  @override
  final bool? overdue;
  @override
  final BuiltList<String>? photoUrls;
  @override
  final String? decidedBy;
  @override
  final DateTime? decidedAt;
  @override
  final String? reason;

  factory _$AdminPhotoVerificationItem([
    void Function(AdminPhotoVerificationItemBuilder)? updates,
  ]) => (AdminPhotoVerificationItemBuilder()..update(updates))._build();

  _$AdminPhotoVerificationItem._({
    this.id,
    this.accountId,
    this.target,
    this.targetId,
    this.status,
    this.requestedAt,
    this.dueAt,
    this.overdue,
    this.photoUrls,
    this.decidedBy,
    this.decidedAt,
    this.reason,
  }) : super._();
  @override
  AdminPhotoVerificationItem rebuild(
    void Function(AdminPhotoVerificationItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminPhotoVerificationItemBuilder toBuilder() =>
      AdminPhotoVerificationItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminPhotoVerificationItem &&
        id == other.id &&
        accountId == other.accountId &&
        target == other.target &&
        targetId == other.targetId &&
        status == other.status &&
        requestedAt == other.requestedAt &&
        dueAt == other.dueAt &&
        overdue == other.overdue &&
        photoUrls == other.photoUrls &&
        decidedBy == other.decidedBy &&
        decidedAt == other.decidedAt &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, target.hashCode);
    _$hash = $jc(_$hash, targetId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, requestedAt.hashCode);
    _$hash = $jc(_$hash, dueAt.hashCode);
    _$hash = $jc(_$hash, overdue.hashCode);
    _$hash = $jc(_$hash, photoUrls.hashCode);
    _$hash = $jc(_$hash, decidedBy.hashCode);
    _$hash = $jc(_$hash, decidedAt.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminPhotoVerificationItem')
          ..add('id', id)
          ..add('accountId', accountId)
          ..add('target', target)
          ..add('targetId', targetId)
          ..add('status', status)
          ..add('requestedAt', requestedAt)
          ..add('dueAt', dueAt)
          ..add('overdue', overdue)
          ..add('photoUrls', photoUrls)
          ..add('decidedBy', decidedBy)
          ..add('decidedAt', decidedAt)
          ..add('reason', reason))
        .toString();
  }
}

class AdminPhotoVerificationItemBuilder
    implements
        Builder<AdminPhotoVerificationItem, AdminPhotoVerificationItemBuilder> {
  _$AdminPhotoVerificationItem? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  AdminPhotoVerificationItemTargetEnum? _target;
  AdminPhotoVerificationItemTargetEnum? get target => _$this._target;
  set target(AdminPhotoVerificationItemTargetEnum? target) =>
      _$this._target = target;

  String? _targetId;
  String? get targetId => _$this._targetId;
  set targetId(String? targetId) => _$this._targetId = targetId;

  AdminPhotoVerificationItemStatusEnum? _status;
  AdminPhotoVerificationItemStatusEnum? get status => _$this._status;
  set status(AdminPhotoVerificationItemStatusEnum? status) =>
      _$this._status = status;

  DateTime? _requestedAt;
  DateTime? get requestedAt => _$this._requestedAt;
  set requestedAt(DateTime? requestedAt) => _$this._requestedAt = requestedAt;

  DateTime? _dueAt;
  DateTime? get dueAt => _$this._dueAt;
  set dueAt(DateTime? dueAt) => _$this._dueAt = dueAt;

  bool? _overdue;
  bool? get overdue => _$this._overdue;
  set overdue(bool? overdue) => _$this._overdue = overdue;

  ListBuilder<String>? _photoUrls;
  ListBuilder<String> get photoUrls =>
      _$this._photoUrls ??= ListBuilder<String>();
  set photoUrls(ListBuilder<String>? photoUrls) =>
      _$this._photoUrls = photoUrls;

  String? _decidedBy;
  String? get decidedBy => _$this._decidedBy;
  set decidedBy(String? decidedBy) => _$this._decidedBy = decidedBy;

  DateTime? _decidedAt;
  DateTime? get decidedAt => _$this._decidedAt;
  set decidedAt(DateTime? decidedAt) => _$this._decidedAt = decidedAt;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  AdminPhotoVerificationItemBuilder() {
    AdminPhotoVerificationItem._defaults(this);
  }

  AdminPhotoVerificationItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _accountId = $v.accountId;
      _target = $v.target;
      _targetId = $v.targetId;
      _status = $v.status;
      _requestedAt = $v.requestedAt;
      _dueAt = $v.dueAt;
      _overdue = $v.overdue;
      _photoUrls = $v.photoUrls?.toBuilder();
      _decidedBy = $v.decidedBy;
      _decidedAt = $v.decidedAt;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminPhotoVerificationItem other) {
    _$v = other as _$AdminPhotoVerificationItem;
  }

  @override
  void update(void Function(AdminPhotoVerificationItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminPhotoVerificationItem build() => _build();

  _$AdminPhotoVerificationItem _build() {
    _$AdminPhotoVerificationItem _$result;
    try {
      _$result =
          _$v ??
          _$AdminPhotoVerificationItem._(
            id: id,
            accountId: accountId,
            target: target,
            targetId: targetId,
            status: status,
            requestedAt: requestedAt,
            dueAt: dueAt,
            overdue: overdue,
            photoUrls: _photoUrls?.build(),
            decidedBy: decidedBy,
            decidedAt: decidedAt,
            reason: reason,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'photoUrls';
        _photoUrls?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminPhotoVerificationItem',
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
