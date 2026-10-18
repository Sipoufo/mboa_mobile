// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_invoice_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateInvoiceRequest extends UpdateInvoiceRequest {
  @override
  final String? label;
  @override
  final int? amount;
  @override
  final Date? dueDate;

  factory _$UpdateInvoiceRequest([
    void Function(UpdateInvoiceRequestBuilder)? updates,
  ]) => (UpdateInvoiceRequestBuilder()..update(updates))._build();

  _$UpdateInvoiceRequest._({this.label, this.amount, this.dueDate}) : super._();
  @override
  UpdateInvoiceRequest rebuild(
    void Function(UpdateInvoiceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateInvoiceRequestBuilder toBuilder() =>
      UpdateInvoiceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateInvoiceRequest &&
        label == other.label &&
        amount == other.amount &&
        dueDate == other.dueDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, dueDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateInvoiceRequest')
          ..add('label', label)
          ..add('amount', amount)
          ..add('dueDate', dueDate))
        .toString();
  }
}

class UpdateInvoiceRequestBuilder
    implements Builder<UpdateInvoiceRequest, UpdateInvoiceRequestBuilder> {
  _$UpdateInvoiceRequest? _$v;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  Date? _dueDate;
  Date? get dueDate => _$this._dueDate;
  set dueDate(Date? dueDate) => _$this._dueDate = dueDate;

  UpdateInvoiceRequestBuilder() {
    UpdateInvoiceRequest._defaults(this);
  }

  UpdateInvoiceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _label = $v.label;
      _amount = $v.amount;
      _dueDate = $v.dueDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateInvoiceRequest other) {
    _$v = other as _$UpdateInvoiceRequest;
  }

  @override
  void update(void Function(UpdateInvoiceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateInvoiceRequest build() => _build();

  _$UpdateInvoiceRequest _build() {
    final _$result =
        _$v ??
        _$UpdateInvoiceRequest._(
          label: label,
          amount: amount,
          dueDate: dueDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
