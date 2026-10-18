// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_moderation_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccountModerationEntryActionEnum
_$accountModerationEntryActionEnum_SUSPEND =
    const AccountModerationEntryActionEnum._('SUSPEND');
const AccountModerationEntryActionEnum
_$accountModerationEntryActionEnum_REACTIVATE =
    const AccountModerationEntryActionEnum._('REACTIVATE');
const AccountModerationEntryActionEnum
_$accountModerationEntryActionEnum_DELETE =
    const AccountModerationEntryActionEnum._('DELETE');
const AccountModerationEntryActionEnum
_$accountModerationEntryActionEnum_unknownDefaultOpenApi =
    const AccountModerationEntryActionEnum._('unknownDefaultOpenApi');

AccountModerationEntryActionEnum _$accountModerationEntryActionEnumValueOf(
  String name,
) {
  switch (name) {
    case 'SUSPEND':
      return _$accountModerationEntryActionEnum_SUSPEND;
    case 'REACTIVATE':
      return _$accountModerationEntryActionEnum_REACTIVATE;
    case 'DELETE':
      return _$accountModerationEntryActionEnum_DELETE;
    case 'unknownDefaultOpenApi':
      return _$accountModerationEntryActionEnum_unknownDefaultOpenApi;
    default:
      return _$accountModerationEntryActionEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AccountModerationEntryActionEnum>
_$accountModerationEntryActionEnumValues =
    BuiltSet<AccountModerationEntryActionEnum>(
      const <AccountModerationEntryActionEnum>[
        _$accountModerationEntryActionEnum_SUSPEND,
        _$accountModerationEntryActionEnum_REACTIVATE,
        _$accountModerationEntryActionEnum_DELETE,
        _$accountModerationEntryActionEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<AccountModerationEntryActionEnum>
_$accountModerationEntryActionEnumSerializer =
    _$AccountModerationEntryActionEnumSerializer();

class _$AccountModerationEntryActionEnumSerializer
    implements PrimitiveSerializer<AccountModerationEntryActionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'SUSPEND': 'SUSPEND',
    'REACTIVATE': 'REACTIVATE',
    'DELETE': 'DELETE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'SUSPEND': 'SUSPEND',
    'REACTIVATE': 'REACTIVATE',
    'DELETE': 'DELETE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AccountModerationEntryActionEnum];
  @override
  final String wireName = 'AccountModerationEntryActionEnum';

  @override
  Object serialize(
    Serializers serializers,
    AccountModerationEntryActionEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AccountModerationEntryActionEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AccountModerationEntryActionEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AccountModerationEntry extends AccountModerationEntry {
  @override
  final AccountModerationEntryActionEnum? action;
  @override
  final String? reason;
  @override
  final String? adminAccountId;
  @override
  final DateTime? suspendedUntil;
  @override
  final DateTime? liftedAt;
  @override
  final DateTime? createdAt;

  factory _$AccountModerationEntry([
    void Function(AccountModerationEntryBuilder)? updates,
  ]) => (AccountModerationEntryBuilder()..update(updates))._build();

  _$AccountModerationEntry._({
    this.action,
    this.reason,
    this.adminAccountId,
    this.suspendedUntil,
    this.liftedAt,
    this.createdAt,
  }) : super._();
  @override
  AccountModerationEntry rebuild(
    void Function(AccountModerationEntryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountModerationEntryBuilder toBuilder() =>
      AccountModerationEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountModerationEntry &&
        action == other.action &&
        reason == other.reason &&
        adminAccountId == other.adminAccountId &&
        suspendedUntil == other.suspendedUntil &&
        liftedAt == other.liftedAt &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, adminAccountId.hashCode);
    _$hash = $jc(_$hash, suspendedUntil.hashCode);
    _$hash = $jc(_$hash, liftedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountModerationEntry')
          ..add('action', action)
          ..add('reason', reason)
          ..add('adminAccountId', adminAccountId)
          ..add('suspendedUntil', suspendedUntil)
          ..add('liftedAt', liftedAt)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class AccountModerationEntryBuilder
    implements Builder<AccountModerationEntry, AccountModerationEntryBuilder> {
  _$AccountModerationEntry? _$v;

  AccountModerationEntryActionEnum? _action;
  AccountModerationEntryActionEnum? get action => _$this._action;
  set action(AccountModerationEntryActionEnum? action) =>
      _$this._action = action;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  String? _adminAccountId;
  String? get adminAccountId => _$this._adminAccountId;
  set adminAccountId(String? adminAccountId) =>
      _$this._adminAccountId = adminAccountId;

  DateTime? _suspendedUntil;
  DateTime? get suspendedUntil => _$this._suspendedUntil;
  set suspendedUntil(DateTime? suspendedUntil) =>
      _$this._suspendedUntil = suspendedUntil;

  DateTime? _liftedAt;
  DateTime? get liftedAt => _$this._liftedAt;
  set liftedAt(DateTime? liftedAt) => _$this._liftedAt = liftedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  AccountModerationEntryBuilder() {
    AccountModerationEntry._defaults(this);
  }

  AccountModerationEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _action = $v.action;
      _reason = $v.reason;
      _adminAccountId = $v.adminAccountId;
      _suspendedUntil = $v.suspendedUntil;
      _liftedAt = $v.liftedAt;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountModerationEntry other) {
    _$v = other as _$AccountModerationEntry;
  }

  @override
  void update(void Function(AccountModerationEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountModerationEntry build() => _build();

  _$AccountModerationEntry _build() {
    final _$result =
        _$v ??
        _$AccountModerationEntry._(
          action: action,
          reason: reason,
          adminAccountId: adminAccountId,
          suspendedUntil: suspendedUntil,
          liftedAt: liftedAt,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
