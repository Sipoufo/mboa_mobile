// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_visit_history.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountVisitHistory extends AccountVisitHistory {
  @override
  final HistorySectionAdminVisitLine? asClient;
  @override
  final HistorySectionAdminVisitLine? asVisitor;
  @override
  final HistorySectionAdminVisitLine? onOwnListings;

  factory _$AccountVisitHistory([
    void Function(AccountVisitHistoryBuilder)? updates,
  ]) => (AccountVisitHistoryBuilder()..update(updates))._build();

  _$AccountVisitHistory._({this.asClient, this.asVisitor, this.onOwnListings})
    : super._();
  @override
  AccountVisitHistory rebuild(
    void Function(AccountVisitHistoryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountVisitHistoryBuilder toBuilder() =>
      AccountVisitHistoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountVisitHistory &&
        asClient == other.asClient &&
        asVisitor == other.asVisitor &&
        onOwnListings == other.onOwnListings;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, asClient.hashCode);
    _$hash = $jc(_$hash, asVisitor.hashCode);
    _$hash = $jc(_$hash, onOwnListings.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountVisitHistory')
          ..add('asClient', asClient)
          ..add('asVisitor', asVisitor)
          ..add('onOwnListings', onOwnListings))
        .toString();
  }
}

class AccountVisitHistoryBuilder
    implements Builder<AccountVisitHistory, AccountVisitHistoryBuilder> {
  _$AccountVisitHistory? _$v;

  HistorySectionAdminVisitLineBuilder? _asClient;
  HistorySectionAdminVisitLineBuilder get asClient =>
      _$this._asClient ??= HistorySectionAdminVisitLineBuilder();
  set asClient(HistorySectionAdminVisitLineBuilder? asClient) =>
      _$this._asClient = asClient;

  HistorySectionAdminVisitLineBuilder? _asVisitor;
  HistorySectionAdminVisitLineBuilder get asVisitor =>
      _$this._asVisitor ??= HistorySectionAdminVisitLineBuilder();
  set asVisitor(HistorySectionAdminVisitLineBuilder? asVisitor) =>
      _$this._asVisitor = asVisitor;

  HistorySectionAdminVisitLineBuilder? _onOwnListings;
  HistorySectionAdminVisitLineBuilder get onOwnListings =>
      _$this._onOwnListings ??= HistorySectionAdminVisitLineBuilder();
  set onOwnListings(HistorySectionAdminVisitLineBuilder? onOwnListings) =>
      _$this._onOwnListings = onOwnListings;

  AccountVisitHistoryBuilder() {
    AccountVisitHistory._defaults(this);
  }

  AccountVisitHistoryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _asClient = $v.asClient?.toBuilder();
      _asVisitor = $v.asVisitor?.toBuilder();
      _onOwnListings = $v.onOwnListings?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountVisitHistory other) {
    _$v = other as _$AccountVisitHistory;
  }

  @override
  void update(void Function(AccountVisitHistoryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountVisitHistory build() => _build();

  _$AccountVisitHistory _build() {
    _$AccountVisitHistory _$result;
    try {
      _$result =
          _$v ??
          _$AccountVisitHistory._(
            asClient: _asClient?.build(),
            asVisitor: _asVisitor?.build(),
            onOwnListings: _onOwnListings?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asClient';
        _asClient?.build();
        _$failedField = 'asVisitor';
        _asVisitor?.build();
        _$failedField = 'onOwnListings';
        _onOwnListings?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountVisitHistory',
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
