// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_contract_history.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountContractHistory extends AccountContractHistory {
  @override
  final HistorySectionAdminContractLine? asTenant;
  @override
  final HistorySectionAdminContractLine? asOwner;

  factory _$AccountContractHistory([
    void Function(AccountContractHistoryBuilder)? updates,
  ]) => (AccountContractHistoryBuilder()..update(updates))._build();

  _$AccountContractHistory._({this.asTenant, this.asOwner}) : super._();
  @override
  AccountContractHistory rebuild(
    void Function(AccountContractHistoryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountContractHistoryBuilder toBuilder() =>
      AccountContractHistoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountContractHistory &&
        asTenant == other.asTenant &&
        asOwner == other.asOwner;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, asTenant.hashCode);
    _$hash = $jc(_$hash, asOwner.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountContractHistory')
          ..add('asTenant', asTenant)
          ..add('asOwner', asOwner))
        .toString();
  }
}

class AccountContractHistoryBuilder
    implements Builder<AccountContractHistory, AccountContractHistoryBuilder> {
  _$AccountContractHistory? _$v;

  HistorySectionAdminContractLineBuilder? _asTenant;
  HistorySectionAdminContractLineBuilder get asTenant =>
      _$this._asTenant ??= HistorySectionAdminContractLineBuilder();
  set asTenant(HistorySectionAdminContractLineBuilder? asTenant) =>
      _$this._asTenant = asTenant;

  HistorySectionAdminContractLineBuilder? _asOwner;
  HistorySectionAdminContractLineBuilder get asOwner =>
      _$this._asOwner ??= HistorySectionAdminContractLineBuilder();
  set asOwner(HistorySectionAdminContractLineBuilder? asOwner) =>
      _$this._asOwner = asOwner;

  AccountContractHistoryBuilder() {
    AccountContractHistory._defaults(this);
  }

  AccountContractHistoryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _asTenant = $v.asTenant?.toBuilder();
      _asOwner = $v.asOwner?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountContractHistory other) {
    _$v = other as _$AccountContractHistory;
  }

  @override
  void update(void Function(AccountContractHistoryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountContractHistory build() => _build();

  _$AccountContractHistory _build() {
    _$AccountContractHistory _$result;
    try {
      _$result =
          _$v ??
          _$AccountContractHistory._(
            asTenant: _asTenant?.build(),
            asOwner: _asOwner?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asTenant';
        _asTenant?.build();
        _$failedField = 'asOwner';
        _asOwner?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountContractHistory',
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
