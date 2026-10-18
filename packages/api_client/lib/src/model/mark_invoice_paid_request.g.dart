// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_invoice_paid_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MarkInvoicePaidRequest extends MarkInvoicePaidRequest {
  @override
  final Date? paidOn;

  factory _$MarkInvoicePaidRequest([
    void Function(MarkInvoicePaidRequestBuilder)? updates,
  ]) => (MarkInvoicePaidRequestBuilder()..update(updates))._build();

  _$MarkInvoicePaidRequest._({this.paidOn}) : super._();
  @override
  MarkInvoicePaidRequest rebuild(
    void Function(MarkInvoicePaidRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MarkInvoicePaidRequestBuilder toBuilder() =>
      MarkInvoicePaidRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MarkInvoicePaidRequest && paidOn == other.paidOn;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, paidOn.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'MarkInvoicePaidRequest',
    )..add('paidOn', paidOn)).toString();
  }
}

class MarkInvoicePaidRequestBuilder
    implements Builder<MarkInvoicePaidRequest, MarkInvoicePaidRequestBuilder> {
  _$MarkInvoicePaidRequest? _$v;

  Date? _paidOn;
  Date? get paidOn => _$this._paidOn;
  set paidOn(Date? paidOn) => _$this._paidOn = paidOn;

  MarkInvoicePaidRequestBuilder() {
    MarkInvoicePaidRequest._defaults(this);
  }

  MarkInvoicePaidRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _paidOn = $v.paidOn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MarkInvoicePaidRequest other) {
    _$v = other as _$MarkInvoicePaidRequest;
  }

  @override
  void update(void Function(MarkInvoicePaidRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MarkInvoicePaidRequest build() => _build();

  _$MarkInvoicePaidRequest _build() {
    final _$result = _$v ?? _$MarkInvoicePaidRequest._(paidOn: paidOn);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
