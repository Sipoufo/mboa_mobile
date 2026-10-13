// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_subscription_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdminSubscriptionItemTierEnum _$adminSubscriptionItemTierEnum_FREE =
    const AdminSubscriptionItemTierEnum._('FREE');
const AdminSubscriptionItemTierEnum _$adminSubscriptionItemTierEnum_BASIC_PLUS =
    const AdminSubscriptionItemTierEnum._('BASIC_PLUS');
const AdminSubscriptionItemTierEnum _$adminSubscriptionItemTierEnum_PRO =
    const AdminSubscriptionItemTierEnum._('PRO');
const AdminSubscriptionItemTierEnum _$adminSubscriptionItemTierEnum_PRO_PLUS =
    const AdminSubscriptionItemTierEnum._('PRO_PLUS');
const AdminSubscriptionItemTierEnum
_$adminSubscriptionItemTierEnum_unknownDefaultOpenApi =
    const AdminSubscriptionItemTierEnum._('unknownDefaultOpenApi');

AdminSubscriptionItemTierEnum _$adminSubscriptionItemTierEnumValueOf(
  String name,
) {
  switch (name) {
    case 'FREE':
      return _$adminSubscriptionItemTierEnum_FREE;
    case 'BASIC_PLUS':
      return _$adminSubscriptionItemTierEnum_BASIC_PLUS;
    case 'PRO':
      return _$adminSubscriptionItemTierEnum_PRO;
    case 'PRO_PLUS':
      return _$adminSubscriptionItemTierEnum_PRO_PLUS;
    case 'unknownDefaultOpenApi':
      return _$adminSubscriptionItemTierEnum_unknownDefaultOpenApi;
    default:
      return _$adminSubscriptionItemTierEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminSubscriptionItemTierEnum>
_$adminSubscriptionItemTierEnumValues = BuiltSet<AdminSubscriptionItemTierEnum>(
  const <AdminSubscriptionItemTierEnum>[
    _$adminSubscriptionItemTierEnum_FREE,
    _$adminSubscriptionItemTierEnum_BASIC_PLUS,
    _$adminSubscriptionItemTierEnum_PRO,
    _$adminSubscriptionItemTierEnum_PRO_PLUS,
    _$adminSubscriptionItemTierEnum_unknownDefaultOpenApi,
  ],
);

const AdminSubscriptionItemEffectiveTierEnum
_$adminSubscriptionItemEffectiveTierEnum_FREE =
    const AdminSubscriptionItemEffectiveTierEnum._('FREE');
const AdminSubscriptionItemEffectiveTierEnum
_$adminSubscriptionItemEffectiveTierEnum_BASIC_PLUS =
    const AdminSubscriptionItemEffectiveTierEnum._('BASIC_PLUS');
const AdminSubscriptionItemEffectiveTierEnum
_$adminSubscriptionItemEffectiveTierEnum_PRO =
    const AdminSubscriptionItemEffectiveTierEnum._('PRO');
const AdminSubscriptionItemEffectiveTierEnum
_$adminSubscriptionItemEffectiveTierEnum_PRO_PLUS =
    const AdminSubscriptionItemEffectiveTierEnum._('PRO_PLUS');
const AdminSubscriptionItemEffectiveTierEnum
_$adminSubscriptionItemEffectiveTierEnum_unknownDefaultOpenApi =
    const AdminSubscriptionItemEffectiveTierEnum._('unknownDefaultOpenApi');

AdminSubscriptionItemEffectiveTierEnum
_$adminSubscriptionItemEffectiveTierEnumValueOf(String name) {
  switch (name) {
    case 'FREE':
      return _$adminSubscriptionItemEffectiveTierEnum_FREE;
    case 'BASIC_PLUS':
      return _$adminSubscriptionItemEffectiveTierEnum_BASIC_PLUS;
    case 'PRO':
      return _$adminSubscriptionItemEffectiveTierEnum_PRO;
    case 'PRO_PLUS':
      return _$adminSubscriptionItemEffectiveTierEnum_PRO_PLUS;
    case 'unknownDefaultOpenApi':
      return _$adminSubscriptionItemEffectiveTierEnum_unknownDefaultOpenApi;
    default:
      return _$adminSubscriptionItemEffectiveTierEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminSubscriptionItemEffectiveTierEnum>
_$adminSubscriptionItemEffectiveTierEnumValues =
    BuiltSet<AdminSubscriptionItemEffectiveTierEnum>(
      const <AdminSubscriptionItemEffectiveTierEnum>[
        _$adminSubscriptionItemEffectiveTierEnum_FREE,
        _$adminSubscriptionItemEffectiveTierEnum_BASIC_PLUS,
        _$adminSubscriptionItemEffectiveTierEnum_PRO,
        _$adminSubscriptionItemEffectiveTierEnum_PRO_PLUS,
        _$adminSubscriptionItemEffectiveTierEnum_unknownDefaultOpenApi,
      ],
    );

const AdminSubscriptionItemStatusEnum _$adminSubscriptionItemStatusEnum_ACTIVE =
    const AdminSubscriptionItemStatusEnum._('ACTIVE');
const AdminSubscriptionItemStatusEnum
_$adminSubscriptionItemStatusEnum_EXPIRED =
    const AdminSubscriptionItemStatusEnum._('EXPIRED');
const AdminSubscriptionItemStatusEnum
_$adminSubscriptionItemStatusEnum_unknownDefaultOpenApi =
    const AdminSubscriptionItemStatusEnum._('unknownDefaultOpenApi');

AdminSubscriptionItemStatusEnum _$adminSubscriptionItemStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'ACTIVE':
      return _$adminSubscriptionItemStatusEnum_ACTIVE;
    case 'EXPIRED':
      return _$adminSubscriptionItemStatusEnum_EXPIRED;
    case 'unknownDefaultOpenApi':
      return _$adminSubscriptionItemStatusEnum_unknownDefaultOpenApi;
    default:
      return _$adminSubscriptionItemStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminSubscriptionItemStatusEnum>
_$adminSubscriptionItemStatusEnumValues =
    BuiltSet<AdminSubscriptionItemStatusEnum>(
      const <AdminSubscriptionItemStatusEnum>[
        _$adminSubscriptionItemStatusEnum_ACTIVE,
        _$adminSubscriptionItemStatusEnum_EXPIRED,
        _$adminSubscriptionItemStatusEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<AdminSubscriptionItemTierEnum>
_$adminSubscriptionItemTierEnumSerializer =
    _$AdminSubscriptionItemTierEnumSerializer();
Serializer<AdminSubscriptionItemEffectiveTierEnum>
_$adminSubscriptionItemEffectiveTierEnumSerializer =
    _$AdminSubscriptionItemEffectiveTierEnumSerializer();
Serializer<AdminSubscriptionItemStatusEnum>
_$adminSubscriptionItemStatusEnumSerializer =
    _$AdminSubscriptionItemStatusEnumSerializer();

class _$AdminSubscriptionItemTierEnumSerializer
    implements PrimitiveSerializer<AdminSubscriptionItemTierEnum> {
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
  final Iterable<Type> types = const <Type>[AdminSubscriptionItemTierEnum];
  @override
  final String wireName = 'AdminSubscriptionItemTierEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminSubscriptionItemTierEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminSubscriptionItemTierEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminSubscriptionItemTierEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminSubscriptionItemEffectiveTierEnumSerializer
    implements PrimitiveSerializer<AdminSubscriptionItemEffectiveTierEnum> {
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
  final Iterable<Type> types = const <Type>[
    AdminSubscriptionItemEffectiveTierEnum,
  ];
  @override
  final String wireName = 'AdminSubscriptionItemEffectiveTierEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminSubscriptionItemEffectiveTierEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminSubscriptionItemEffectiveTierEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminSubscriptionItemEffectiveTierEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminSubscriptionItemStatusEnumSerializer
    implements PrimitiveSerializer<AdminSubscriptionItemStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ACTIVE': 'ACTIVE',
    'EXPIRED': 'EXPIRED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ACTIVE': 'ACTIVE',
    'EXPIRED': 'EXPIRED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AdminSubscriptionItemStatusEnum];
  @override
  final String wireName = 'AdminSubscriptionItemStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminSubscriptionItemStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminSubscriptionItemStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminSubscriptionItemStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminSubscriptionItem extends AdminSubscriptionItem {
  @override
  final String? accountId;
  @override
  final AdminSubscriptionItemTierEnum? tier;
  @override
  final AdminSubscriptionItemEffectiveTierEnum? effectiveTier;
  @override
  final AdminSubscriptionItemStatusEnum? status;
  @override
  final DateTime? currentPeriodStart;
  @override
  final DateTime? currentPeriodEnd;
  @override
  final bool? paid;
  @override
  final String? currentPaymentId;
  @override
  final DateTime? paidSince;

  factory _$AdminSubscriptionItem([
    void Function(AdminSubscriptionItemBuilder)? updates,
  ]) => (AdminSubscriptionItemBuilder()..update(updates))._build();

  _$AdminSubscriptionItem._({
    this.accountId,
    this.tier,
    this.effectiveTier,
    this.status,
    this.currentPeriodStart,
    this.currentPeriodEnd,
    this.paid,
    this.currentPaymentId,
    this.paidSince,
  }) : super._();
  @override
  AdminSubscriptionItem rebuild(
    void Function(AdminSubscriptionItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminSubscriptionItemBuilder toBuilder() =>
      AdminSubscriptionItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminSubscriptionItem &&
        accountId == other.accountId &&
        tier == other.tier &&
        effectiveTier == other.effectiveTier &&
        status == other.status &&
        currentPeriodStart == other.currentPeriodStart &&
        currentPeriodEnd == other.currentPeriodEnd &&
        paid == other.paid &&
        currentPaymentId == other.currentPaymentId &&
        paidSince == other.paidSince;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, effectiveTier.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, currentPeriodStart.hashCode);
    _$hash = $jc(_$hash, currentPeriodEnd.hashCode);
    _$hash = $jc(_$hash, paid.hashCode);
    _$hash = $jc(_$hash, currentPaymentId.hashCode);
    _$hash = $jc(_$hash, paidSince.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminSubscriptionItem')
          ..add('accountId', accountId)
          ..add('tier', tier)
          ..add('effectiveTier', effectiveTier)
          ..add('status', status)
          ..add('currentPeriodStart', currentPeriodStart)
          ..add('currentPeriodEnd', currentPeriodEnd)
          ..add('paid', paid)
          ..add('currentPaymentId', currentPaymentId)
          ..add('paidSince', paidSince))
        .toString();
  }
}

class AdminSubscriptionItemBuilder
    implements Builder<AdminSubscriptionItem, AdminSubscriptionItemBuilder> {
  _$AdminSubscriptionItem? _$v;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  AdminSubscriptionItemTierEnum? _tier;
  AdminSubscriptionItemTierEnum? get tier => _$this._tier;
  set tier(AdminSubscriptionItemTierEnum? tier) => _$this._tier = tier;

  AdminSubscriptionItemEffectiveTierEnum? _effectiveTier;
  AdminSubscriptionItemEffectiveTierEnum? get effectiveTier =>
      _$this._effectiveTier;
  set effectiveTier(AdminSubscriptionItemEffectiveTierEnum? effectiveTier) =>
      _$this._effectiveTier = effectiveTier;

  AdminSubscriptionItemStatusEnum? _status;
  AdminSubscriptionItemStatusEnum? get status => _$this._status;
  set status(AdminSubscriptionItemStatusEnum? status) =>
      _$this._status = status;

  DateTime? _currentPeriodStart;
  DateTime? get currentPeriodStart => _$this._currentPeriodStart;
  set currentPeriodStart(DateTime? currentPeriodStart) =>
      _$this._currentPeriodStart = currentPeriodStart;

  DateTime? _currentPeriodEnd;
  DateTime? get currentPeriodEnd => _$this._currentPeriodEnd;
  set currentPeriodEnd(DateTime? currentPeriodEnd) =>
      _$this._currentPeriodEnd = currentPeriodEnd;

  bool? _paid;
  bool? get paid => _$this._paid;
  set paid(bool? paid) => _$this._paid = paid;

  String? _currentPaymentId;
  String? get currentPaymentId => _$this._currentPaymentId;
  set currentPaymentId(String? currentPaymentId) =>
      _$this._currentPaymentId = currentPaymentId;

  DateTime? _paidSince;
  DateTime? get paidSince => _$this._paidSince;
  set paidSince(DateTime? paidSince) => _$this._paidSince = paidSince;

  AdminSubscriptionItemBuilder() {
    AdminSubscriptionItem._defaults(this);
  }

  AdminSubscriptionItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountId = $v.accountId;
      _tier = $v.tier;
      _effectiveTier = $v.effectiveTier;
      _status = $v.status;
      _currentPeriodStart = $v.currentPeriodStart;
      _currentPeriodEnd = $v.currentPeriodEnd;
      _paid = $v.paid;
      _currentPaymentId = $v.currentPaymentId;
      _paidSince = $v.paidSince;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminSubscriptionItem other) {
    _$v = other as _$AdminSubscriptionItem;
  }

  @override
  void update(void Function(AdminSubscriptionItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminSubscriptionItem build() => _build();

  _$AdminSubscriptionItem _build() {
    final _$result =
        _$v ??
        _$AdminSubscriptionItem._(
          accountId: accountId,
          tier: tier,
          effectiveTier: effectiveTier,
          status: status,
          currentPeriodStart: currentPeriodStart,
          currentPeriodEnd: currentPeriodEnd,
          paid: paid,
          currentPaymentId: currentPaymentId,
          paidSince: paidSince,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
