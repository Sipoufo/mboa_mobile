// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extend_subscription_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExtendSubscriptionRequest extends ExtendSubscriptionRequest {
  @override
  final int days;
  @override
  final String reason;

  factory _$ExtendSubscriptionRequest([
    void Function(ExtendSubscriptionRequestBuilder)? updates,
  ]) => (ExtendSubscriptionRequestBuilder()..update(updates))._build();

  _$ExtendSubscriptionRequest._({required this.days, required this.reason})
    : super._();
  @override
  ExtendSubscriptionRequest rebuild(
    void Function(ExtendSubscriptionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExtendSubscriptionRequestBuilder toBuilder() =>
      ExtendSubscriptionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExtendSubscriptionRequest &&
        days == other.days &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, days.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExtendSubscriptionRequest')
          ..add('days', days)
          ..add('reason', reason))
        .toString();
  }
}

class ExtendSubscriptionRequestBuilder
    implements
        Builder<ExtendSubscriptionRequest, ExtendSubscriptionRequestBuilder> {
  _$ExtendSubscriptionRequest? _$v;

  int? _days;
  int? get days => _$this._days;
  set days(int? days) => _$this._days = days;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  ExtendSubscriptionRequestBuilder() {
    ExtendSubscriptionRequest._defaults(this);
  }

  ExtendSubscriptionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _days = $v.days;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExtendSubscriptionRequest other) {
    _$v = other as _$ExtendSubscriptionRequest;
  }

  @override
  void update(void Function(ExtendSubscriptionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExtendSubscriptionRequest build() => _build();

  _$ExtendSubscriptionRequest _build() {
    final _$result =
        _$v ??
        _$ExtendSubscriptionRequest._(
          days: BuiltValueNullFieldError.checkNotNull(
            days,
            r'ExtendSubscriptionRequest',
            'days',
          ),
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'ExtendSubscriptionRequest',
            'reason',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
