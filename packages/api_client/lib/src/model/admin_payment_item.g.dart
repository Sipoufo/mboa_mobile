// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_payment_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdminPaymentItemTierEnum _$adminPaymentItemTierEnum_FREE =
    const AdminPaymentItemTierEnum._('FREE');
const AdminPaymentItemTierEnum _$adminPaymentItemTierEnum_BASIC_PLUS =
    const AdminPaymentItemTierEnum._('BASIC_PLUS');
const AdminPaymentItemTierEnum _$adminPaymentItemTierEnum_PRO =
    const AdminPaymentItemTierEnum._('PRO');
const AdminPaymentItemTierEnum _$adminPaymentItemTierEnum_PRO_PLUS =
    const AdminPaymentItemTierEnum._('PRO_PLUS');
const AdminPaymentItemTierEnum
_$adminPaymentItemTierEnum_unknownDefaultOpenApi =
    const AdminPaymentItemTierEnum._('unknownDefaultOpenApi');

AdminPaymentItemTierEnum _$adminPaymentItemTierEnumValueOf(String name) {
  switch (name) {
    case 'FREE':
      return _$adminPaymentItemTierEnum_FREE;
    case 'BASIC_PLUS':
      return _$adminPaymentItemTierEnum_BASIC_PLUS;
    case 'PRO':
      return _$adminPaymentItemTierEnum_PRO;
    case 'PRO_PLUS':
      return _$adminPaymentItemTierEnum_PRO_PLUS;
    case 'unknownDefaultOpenApi':
      return _$adminPaymentItemTierEnum_unknownDefaultOpenApi;
    default:
      return _$adminPaymentItemTierEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminPaymentItemTierEnum> _$adminPaymentItemTierEnumValues =
    BuiltSet<AdminPaymentItemTierEnum>(const <AdminPaymentItemTierEnum>[
      _$adminPaymentItemTierEnum_FREE,
      _$adminPaymentItemTierEnum_BASIC_PLUS,
      _$adminPaymentItemTierEnum_PRO,
      _$adminPaymentItemTierEnum_PRO_PLUS,
      _$adminPaymentItemTierEnum_unknownDefaultOpenApi,
    ]);

const AdminPaymentItemMethodEnum _$adminPaymentItemMethodEnum_MTN_MOMO =
    const AdminPaymentItemMethodEnum._('MTN_MOMO');
const AdminPaymentItemMethodEnum _$adminPaymentItemMethodEnum_ORANGE_MONEY =
    const AdminPaymentItemMethodEnum._('ORANGE_MONEY');
const AdminPaymentItemMethodEnum
_$adminPaymentItemMethodEnum_unknownDefaultOpenApi =
    const AdminPaymentItemMethodEnum._('unknownDefaultOpenApi');

AdminPaymentItemMethodEnum _$adminPaymentItemMethodEnumValueOf(String name) {
  switch (name) {
    case 'MTN_MOMO':
      return _$adminPaymentItemMethodEnum_MTN_MOMO;
    case 'ORANGE_MONEY':
      return _$adminPaymentItemMethodEnum_ORANGE_MONEY;
    case 'unknownDefaultOpenApi':
      return _$adminPaymentItemMethodEnum_unknownDefaultOpenApi;
    default:
      return _$adminPaymentItemMethodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminPaymentItemMethodEnum> _$adminPaymentItemMethodEnumValues =
    BuiltSet<AdminPaymentItemMethodEnum>(const <AdminPaymentItemMethodEnum>[
      _$adminPaymentItemMethodEnum_MTN_MOMO,
      _$adminPaymentItemMethodEnum_ORANGE_MONEY,
      _$adminPaymentItemMethodEnum_unknownDefaultOpenApi,
    ]);

const AdminPaymentItemStatusEnum _$adminPaymentItemStatusEnum_PENDING =
    const AdminPaymentItemStatusEnum._('PENDING');
const AdminPaymentItemStatusEnum _$adminPaymentItemStatusEnum_CONFIRMED =
    const AdminPaymentItemStatusEnum._('CONFIRMED');
const AdminPaymentItemStatusEnum _$adminPaymentItemStatusEnum_FAILED =
    const AdminPaymentItemStatusEnum._('FAILED');
const AdminPaymentItemStatusEnum _$adminPaymentItemStatusEnum_CANCELLED =
    const AdminPaymentItemStatusEnum._('CANCELLED');
const AdminPaymentItemStatusEnum _$adminPaymentItemStatusEnum_REFUNDED =
    const AdminPaymentItemStatusEnum._('REFUNDED');
const AdminPaymentItemStatusEnum
_$adminPaymentItemStatusEnum_unknownDefaultOpenApi =
    const AdminPaymentItemStatusEnum._('unknownDefaultOpenApi');

AdminPaymentItemStatusEnum _$adminPaymentItemStatusEnumValueOf(String name) {
  switch (name) {
    case 'PENDING':
      return _$adminPaymentItemStatusEnum_PENDING;
    case 'CONFIRMED':
      return _$adminPaymentItemStatusEnum_CONFIRMED;
    case 'FAILED':
      return _$adminPaymentItemStatusEnum_FAILED;
    case 'CANCELLED':
      return _$adminPaymentItemStatusEnum_CANCELLED;
    case 'REFUNDED':
      return _$adminPaymentItemStatusEnum_REFUNDED;
    case 'unknownDefaultOpenApi':
      return _$adminPaymentItemStatusEnum_unknownDefaultOpenApi;
    default:
      return _$adminPaymentItemStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminPaymentItemStatusEnum> _$adminPaymentItemStatusEnumValues =
    BuiltSet<AdminPaymentItemStatusEnum>(const <AdminPaymentItemStatusEnum>[
      _$adminPaymentItemStatusEnum_PENDING,
      _$adminPaymentItemStatusEnum_CONFIRMED,
      _$adminPaymentItemStatusEnum_FAILED,
      _$adminPaymentItemStatusEnum_CANCELLED,
      _$adminPaymentItemStatusEnum_REFUNDED,
      _$adminPaymentItemStatusEnum_unknownDefaultOpenApi,
    ]);

Serializer<AdminPaymentItemTierEnum> _$adminPaymentItemTierEnumSerializer =
    _$AdminPaymentItemTierEnumSerializer();
Serializer<AdminPaymentItemMethodEnum> _$adminPaymentItemMethodEnumSerializer =
    _$AdminPaymentItemMethodEnumSerializer();
Serializer<AdminPaymentItemStatusEnum> _$adminPaymentItemStatusEnumSerializer =
    _$AdminPaymentItemStatusEnumSerializer();

class _$AdminPaymentItemTierEnumSerializer
    implements PrimitiveSerializer<AdminPaymentItemTierEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'FREE': 'FREE',
    'BASIC_PLUS': 'BASIC_PLUS',
    'PRO': 'PRO',
    'PRO_PLUS': 'PRO_PLUS',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'FREE': 'FREE',
    'BASIC_PLUS': 'BASIC_PLUS',
    'PRO': 'PRO',
    'PRO_PLUS': 'PRO_PLUS',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AdminPaymentItemTierEnum];
  @override
  final String wireName = 'AdminPaymentItemTierEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminPaymentItemTierEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminPaymentItemTierEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminPaymentItemTierEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminPaymentItemMethodEnumSerializer
    implements PrimitiveSerializer<AdminPaymentItemMethodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MTN_MOMO': 'MTN_MOMO',
    'ORANGE_MONEY': 'ORANGE_MONEY',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MTN_MOMO': 'MTN_MOMO',
    'ORANGE_MONEY': 'ORANGE_MONEY',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AdminPaymentItemMethodEnum];
  @override
  final String wireName = 'AdminPaymentItemMethodEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminPaymentItemMethodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminPaymentItemMethodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminPaymentItemMethodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminPaymentItemStatusEnumSerializer
    implements PrimitiveSerializer<AdminPaymentItemStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
    'CONFIRMED': 'CONFIRMED',
    'FAILED': 'FAILED',
    'CANCELLED': 'CANCELLED',
    'REFUNDED': 'REFUNDED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
    'CONFIRMED': 'CONFIRMED',
    'FAILED': 'FAILED',
    'CANCELLED': 'CANCELLED',
    'REFUNDED': 'REFUNDED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AdminPaymentItemStatusEnum];
  @override
  final String wireName = 'AdminPaymentItemStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminPaymentItemStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminPaymentItemStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminPaymentItemStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminPaymentItem extends AdminPaymentItem {
  @override
  final String? id;
  @override
  final String? accountId;
  @override
  final AdminPaymentItemTierEnum? tier;
  @override
  final int? amount;
  @override
  final AdminPaymentItemMethodEnum? method;
  @override
  final String? provider;
  @override
  final AdminPaymentItemStatusEnum? status;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? confirmedAt;
  @override
  final DateTime? refundedAt;
  @override
  final String? refundedBy;
  @override
  final String? refundReason;

  factory _$AdminPaymentItem([
    void Function(AdminPaymentItemBuilder)? updates,
  ]) => (AdminPaymentItemBuilder()..update(updates))._build();

  _$AdminPaymentItem._({
    this.id,
    this.accountId,
    this.tier,
    this.amount,
    this.method,
    this.provider,
    this.status,
    this.createdAt,
    this.confirmedAt,
    this.refundedAt,
    this.refundedBy,
    this.refundReason,
  }) : super._();
  @override
  AdminPaymentItem rebuild(void Function(AdminPaymentItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdminPaymentItemBuilder toBuilder() =>
      AdminPaymentItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminPaymentItem &&
        id == other.id &&
        accountId == other.accountId &&
        tier == other.tier &&
        amount == other.amount &&
        method == other.method &&
        provider == other.provider &&
        status == other.status &&
        createdAt == other.createdAt &&
        confirmedAt == other.confirmedAt &&
        refundedAt == other.refundedAt &&
        refundedBy == other.refundedBy &&
        refundReason == other.refundReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, provider.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, confirmedAt.hashCode);
    _$hash = $jc(_$hash, refundedAt.hashCode);
    _$hash = $jc(_$hash, refundedBy.hashCode);
    _$hash = $jc(_$hash, refundReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminPaymentItem')
          ..add('id', id)
          ..add('accountId', accountId)
          ..add('tier', tier)
          ..add('amount', amount)
          ..add('method', method)
          ..add('provider', provider)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('confirmedAt', confirmedAt)
          ..add('refundedAt', refundedAt)
          ..add('refundedBy', refundedBy)
          ..add('refundReason', refundReason))
        .toString();
  }
}

class AdminPaymentItemBuilder
    implements Builder<AdminPaymentItem, AdminPaymentItemBuilder> {
  _$AdminPaymentItem? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  AdminPaymentItemTierEnum? _tier;
  AdminPaymentItemTierEnum? get tier => _$this._tier;
  set tier(AdminPaymentItemTierEnum? tier) => _$this._tier = tier;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  AdminPaymentItemMethodEnum? _method;
  AdminPaymentItemMethodEnum? get method => _$this._method;
  set method(AdminPaymentItemMethodEnum? method) => _$this._method = method;

  String? _provider;
  String? get provider => _$this._provider;
  set provider(String? provider) => _$this._provider = provider;

  AdminPaymentItemStatusEnum? _status;
  AdminPaymentItemStatusEnum? get status => _$this._status;
  set status(AdminPaymentItemStatusEnum? status) => _$this._status = status;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _confirmedAt;
  DateTime? get confirmedAt => _$this._confirmedAt;
  set confirmedAt(DateTime? confirmedAt) => _$this._confirmedAt = confirmedAt;

  DateTime? _refundedAt;
  DateTime? get refundedAt => _$this._refundedAt;
  set refundedAt(DateTime? refundedAt) => _$this._refundedAt = refundedAt;

  String? _refundedBy;
  String? get refundedBy => _$this._refundedBy;
  set refundedBy(String? refundedBy) => _$this._refundedBy = refundedBy;

  String? _refundReason;
  String? get refundReason => _$this._refundReason;
  set refundReason(String? refundReason) => _$this._refundReason = refundReason;

  AdminPaymentItemBuilder() {
    AdminPaymentItem._defaults(this);
  }

  AdminPaymentItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _accountId = $v.accountId;
      _tier = $v.tier;
      _amount = $v.amount;
      _method = $v.method;
      _provider = $v.provider;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _confirmedAt = $v.confirmedAt;
      _refundedAt = $v.refundedAt;
      _refundedBy = $v.refundedBy;
      _refundReason = $v.refundReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminPaymentItem other) {
    _$v = other as _$AdminPaymentItem;
  }

  @override
  void update(void Function(AdminPaymentItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminPaymentItem build() => _build();

  _$AdminPaymentItem _build() {
    final _$result =
        _$v ??
        _$AdminPaymentItem._(
          id: id,
          accountId: accountId,
          tier: tier,
          amount: amount,
          method: method,
          provider: provider,
          status: status,
          createdAt: createdAt,
          confirmedAt: confirmedAt,
          refundedAt: refundedAt,
          refundedBy: refundedBy,
          refundReason: refundReason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
