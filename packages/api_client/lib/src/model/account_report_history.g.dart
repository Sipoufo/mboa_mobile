// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_report_history.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountReportHistory extends AccountReportHistory {
  @override
  final HistorySectionAdminReportLine? emitted;
  @override
  final HistorySectionAdminReportLine? received;

  factory _$AccountReportHistory([
    void Function(AccountReportHistoryBuilder)? updates,
  ]) => (AccountReportHistoryBuilder()..update(updates))._build();

  _$AccountReportHistory._({this.emitted, this.received}) : super._();
  @override
  AccountReportHistory rebuild(
    void Function(AccountReportHistoryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountReportHistoryBuilder toBuilder() =>
      AccountReportHistoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountReportHistory &&
        emitted == other.emitted &&
        received == other.received;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, emitted.hashCode);
    _$hash = $jc(_$hash, received.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountReportHistory')
          ..add('emitted', emitted)
          ..add('received', received))
        .toString();
  }
}

class AccountReportHistoryBuilder
    implements Builder<AccountReportHistory, AccountReportHistoryBuilder> {
  _$AccountReportHistory? _$v;

  HistorySectionAdminReportLineBuilder? _emitted;
  HistorySectionAdminReportLineBuilder get emitted =>
      _$this._emitted ??= HistorySectionAdminReportLineBuilder();
  set emitted(HistorySectionAdminReportLineBuilder? emitted) =>
      _$this._emitted = emitted;

  HistorySectionAdminReportLineBuilder? _received;
  HistorySectionAdminReportLineBuilder get received =>
      _$this._received ??= HistorySectionAdminReportLineBuilder();
  set received(HistorySectionAdminReportLineBuilder? received) =>
      _$this._received = received;

  AccountReportHistoryBuilder() {
    AccountReportHistory._defaults(this);
  }

  AccountReportHistoryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _emitted = $v.emitted?.toBuilder();
      _received = $v.received?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountReportHistory other) {
    _$v = other as _$AccountReportHistory;
  }

  @override
  void update(void Function(AccountReportHistoryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountReportHistory build() => _build();

  _$AccountReportHistory _build() {
    _$AccountReportHistory _$result;
    try {
      _$result =
          _$v ??
          _$AccountReportHistory._(
            emitted: _emitted?.build(),
            received: _received?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'emitted';
        _emitted?.build();
        _$failedField = 'received';
        _received?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountReportHistory',
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
