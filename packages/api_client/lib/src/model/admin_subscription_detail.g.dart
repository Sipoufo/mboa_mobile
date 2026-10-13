// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_subscription_detail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminSubscriptionDetail extends AdminSubscriptionDetail {
  @override
  final AdminSubscriptionItem? subscription;
  @override
  final BuiltList<AdminPaymentItem>? payments;
  @override
  final BuiltList<AdjustmentResponse>? adjustments;

  factory _$AdminSubscriptionDetail([
    void Function(AdminSubscriptionDetailBuilder)? updates,
  ]) => (AdminSubscriptionDetailBuilder()..update(updates))._build();

  _$AdminSubscriptionDetail._({
    this.subscription,
    this.payments,
    this.adjustments,
  }) : super._();
  @override
  AdminSubscriptionDetail rebuild(
    void Function(AdminSubscriptionDetailBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminSubscriptionDetailBuilder toBuilder() =>
      AdminSubscriptionDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminSubscriptionDetail &&
        subscription == other.subscription &&
        payments == other.payments &&
        adjustments == other.adjustments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, subscription.hashCode);
    _$hash = $jc(_$hash, payments.hashCode);
    _$hash = $jc(_$hash, adjustments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminSubscriptionDetail')
          ..add('subscription', subscription)
          ..add('payments', payments)
          ..add('adjustments', adjustments))
        .toString();
  }
}

class AdminSubscriptionDetailBuilder
    implements
        Builder<AdminSubscriptionDetail, AdminSubscriptionDetailBuilder> {
  _$AdminSubscriptionDetail? _$v;

  AdminSubscriptionItemBuilder? _subscription;
  AdminSubscriptionItemBuilder get subscription =>
      _$this._subscription ??= AdminSubscriptionItemBuilder();
  set subscription(AdminSubscriptionItemBuilder? subscription) =>
      _$this._subscription = subscription;

  ListBuilder<AdminPaymentItem>? _payments;
  ListBuilder<AdminPaymentItem> get payments =>
      _$this._payments ??= ListBuilder<AdminPaymentItem>();
  set payments(ListBuilder<AdminPaymentItem>? payments) =>
      _$this._payments = payments;

  ListBuilder<AdjustmentResponse>? _adjustments;
  ListBuilder<AdjustmentResponse> get adjustments =>
      _$this._adjustments ??= ListBuilder<AdjustmentResponse>();
  set adjustments(ListBuilder<AdjustmentResponse>? adjustments) =>
      _$this._adjustments = adjustments;

  AdminSubscriptionDetailBuilder() {
    AdminSubscriptionDetail._defaults(this);
  }

  AdminSubscriptionDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _subscription = $v.subscription?.toBuilder();
      _payments = $v.payments?.toBuilder();
      _adjustments = $v.adjustments?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminSubscriptionDetail other) {
    _$v = other as _$AdminSubscriptionDetail;
  }

  @override
  void update(void Function(AdminSubscriptionDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminSubscriptionDetail build() => _build();

  _$AdminSubscriptionDetail _build() {
    _$AdminSubscriptionDetail _$result;
    try {
      _$result =
          _$v ??
          _$AdminSubscriptionDetail._(
            subscription: _subscription?.build(),
            payments: _payments?.build(),
            adjustments: _adjustments?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'subscription';
        _subscription?.build();
        _$failedField = 'payments';
        _payments?.build();
        _$failedField = 'adjustments';
        _adjustments?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminSubscriptionDetail',
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
