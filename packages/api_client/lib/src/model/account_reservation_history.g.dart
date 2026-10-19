// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_reservation_history.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountReservationHistory extends AccountReservationHistory {
  @override
  final BuiltMap<String, int>? asClient;
  @override
  final BuiltMap<String, int>? onOwnListings;
  @override
  final int? cancelledByOwner;

  factory _$AccountReservationHistory([
    void Function(AccountReservationHistoryBuilder)? updates,
  ]) => (AccountReservationHistoryBuilder()..update(updates))._build();

  _$AccountReservationHistory._({
    this.asClient,
    this.onOwnListings,
    this.cancelledByOwner,
  }) : super._();
  @override
  AccountReservationHistory rebuild(
    void Function(AccountReservationHistoryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountReservationHistoryBuilder toBuilder() =>
      AccountReservationHistoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountReservationHistory &&
        asClient == other.asClient &&
        onOwnListings == other.onOwnListings &&
        cancelledByOwner == other.cancelledByOwner;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, asClient.hashCode);
    _$hash = $jc(_$hash, onOwnListings.hashCode);
    _$hash = $jc(_$hash, cancelledByOwner.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountReservationHistory')
          ..add('asClient', asClient)
          ..add('onOwnListings', onOwnListings)
          ..add('cancelledByOwner', cancelledByOwner))
        .toString();
  }
}

class AccountReservationHistoryBuilder
    implements
        Builder<AccountReservationHistory, AccountReservationHistoryBuilder> {
  _$AccountReservationHistory? _$v;

  MapBuilder<String, int>? _asClient;
  MapBuilder<String, int> get asClient =>
      _$this._asClient ??= MapBuilder<String, int>();
  set asClient(MapBuilder<String, int>? asClient) =>
      _$this._asClient = asClient;

  MapBuilder<String, int>? _onOwnListings;
  MapBuilder<String, int> get onOwnListings =>
      _$this._onOwnListings ??= MapBuilder<String, int>();
  set onOwnListings(MapBuilder<String, int>? onOwnListings) =>
      _$this._onOwnListings = onOwnListings;

  int? _cancelledByOwner;
  int? get cancelledByOwner => _$this._cancelledByOwner;
  set cancelledByOwner(int? cancelledByOwner) =>
      _$this._cancelledByOwner = cancelledByOwner;

  AccountReservationHistoryBuilder() {
    AccountReservationHistory._defaults(this);
  }

  AccountReservationHistoryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _asClient = $v.asClient?.toBuilder();
      _onOwnListings = $v.onOwnListings?.toBuilder();
      _cancelledByOwner = $v.cancelledByOwner;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountReservationHistory other) {
    _$v = other as _$AccountReservationHistory;
  }

  @override
  void update(void Function(AccountReservationHistoryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountReservationHistory build() => _build();

  _$AccountReservationHistory _build() {
    _$AccountReservationHistory _$result;
    try {
      _$result =
          _$v ??
          _$AccountReservationHistory._(
            asClient: _asClient?.build(),
            onOwnListings: _onOwnListings?.build(),
            cancelledByOwner: cancelledByOwner,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asClient';
        _asClient?.build();
        _$failedField = 'onOwnListings';
        _onOwnListings?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountReservationHistory',
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
