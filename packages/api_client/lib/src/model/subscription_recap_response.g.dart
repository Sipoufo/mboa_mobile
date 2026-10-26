// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_recap_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SubscriptionRecapResponse extends SubscriptionRecapResponse {
  @override
  final String? month;
  @override
  final bool? live;
  @override
  final DateTime? snapshotTakenAt;
  @override
  final BuiltList<Line>? tiers;
  @override
  final Line? total;

  factory _$SubscriptionRecapResponse([
    void Function(SubscriptionRecapResponseBuilder)? updates,
  ]) => (SubscriptionRecapResponseBuilder()..update(updates))._build();

  _$SubscriptionRecapResponse._({
    this.month,
    this.live,
    this.snapshotTakenAt,
    this.tiers,
    this.total,
  }) : super._();
  @override
  SubscriptionRecapResponse rebuild(
    void Function(SubscriptionRecapResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SubscriptionRecapResponseBuilder toBuilder() =>
      SubscriptionRecapResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubscriptionRecapResponse &&
        month == other.month &&
        live == other.live &&
        snapshotTakenAt == other.snapshotTakenAt &&
        tiers == other.tiers &&
        total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, live.hashCode);
    _$hash = $jc(_$hash, snapshotTakenAt.hashCode);
    _$hash = $jc(_$hash, tiers.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubscriptionRecapResponse')
          ..add('month', month)
          ..add('live', live)
          ..add('snapshotTakenAt', snapshotTakenAt)
          ..add('tiers', tiers)
          ..add('total', total))
        .toString();
  }
}

class SubscriptionRecapResponseBuilder
    implements
        Builder<SubscriptionRecapResponse, SubscriptionRecapResponseBuilder> {
  _$SubscriptionRecapResponse? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  bool? _live;
  bool? get live => _$this._live;
  set live(bool? live) => _$this._live = live;

  DateTime? _snapshotTakenAt;
  DateTime? get snapshotTakenAt => _$this._snapshotTakenAt;
  set snapshotTakenAt(DateTime? snapshotTakenAt) =>
      _$this._snapshotTakenAt = snapshotTakenAt;

  ListBuilder<Line>? _tiers;
  ListBuilder<Line> get tiers => _$this._tiers ??= ListBuilder<Line>();
  set tiers(ListBuilder<Line>? tiers) => _$this._tiers = tiers;

  LineBuilder? _total;
  LineBuilder get total => _$this._total ??= LineBuilder();
  set total(LineBuilder? total) => _$this._total = total;

  SubscriptionRecapResponseBuilder() {
    SubscriptionRecapResponse._defaults(this);
  }

  SubscriptionRecapResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _live = $v.live;
      _snapshotTakenAt = $v.snapshotTakenAt;
      _tiers = $v.tiers?.toBuilder();
      _total = $v.total?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubscriptionRecapResponse other) {
    _$v = other as _$SubscriptionRecapResponse;
  }

  @override
  void update(void Function(SubscriptionRecapResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubscriptionRecapResponse build() => _build();

  _$SubscriptionRecapResponse _build() {
    _$SubscriptionRecapResponse _$result;
    try {
      _$result =
          _$v ??
          _$SubscriptionRecapResponse._(
            month: month,
            live: live,
            snapshotTakenAt: snapshotTakenAt,
            tiers: _tiers?.build(),
            total: _total?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tiers';
        _tiers?.build();
        _$failedField = 'total';
        _total?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SubscriptionRecapResponse',
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
