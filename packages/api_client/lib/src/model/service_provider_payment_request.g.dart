// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_provider_payment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ServiceProviderPaymentRequest extends ServiceProviderPaymentRequest {
  @override
  final int amount;
  @override
  final Date paidOn;
  @override
  final String? note;
  @override
  final String? annonceId;
  @override
  final String? residenceId;

  factory _$ServiceProviderPaymentRequest([
    void Function(ServiceProviderPaymentRequestBuilder)? updates,
  ]) => (ServiceProviderPaymentRequestBuilder()..update(updates))._build();

  _$ServiceProviderPaymentRequest._({
    required this.amount,
    required this.paidOn,
    this.note,
    this.annonceId,
    this.residenceId,
  }) : super._();
  @override
  ServiceProviderPaymentRequest rebuild(
    void Function(ServiceProviderPaymentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ServiceProviderPaymentRequestBuilder toBuilder() =>
      ServiceProviderPaymentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ServiceProviderPaymentRequest &&
        amount == other.amount &&
        paidOn == other.paidOn &&
        note == other.note &&
        annonceId == other.annonceId &&
        residenceId == other.residenceId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, paidOn.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, residenceId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ServiceProviderPaymentRequest')
          ..add('amount', amount)
          ..add('paidOn', paidOn)
          ..add('note', note)
          ..add('annonceId', annonceId)
          ..add('residenceId', residenceId))
        .toString();
  }
}

class ServiceProviderPaymentRequestBuilder
    implements
        Builder<
          ServiceProviderPaymentRequest,
          ServiceProviderPaymentRequestBuilder
        > {
  _$ServiceProviderPaymentRequest? _$v;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  Date? _paidOn;
  Date? get paidOn => _$this._paidOn;
  set paidOn(Date? paidOn) => _$this._paidOn = paidOn;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _residenceId;
  String? get residenceId => _$this._residenceId;
  set residenceId(String? residenceId) => _$this._residenceId = residenceId;

  ServiceProviderPaymentRequestBuilder() {
    ServiceProviderPaymentRequest._defaults(this);
  }

  ServiceProviderPaymentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _paidOn = $v.paidOn;
      _note = $v.note;
      _annonceId = $v.annonceId;
      _residenceId = $v.residenceId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ServiceProviderPaymentRequest other) {
    _$v = other as _$ServiceProviderPaymentRequest;
  }

  @override
  void update(void Function(ServiceProviderPaymentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ServiceProviderPaymentRequest build() => _build();

  _$ServiceProviderPaymentRequest _build() {
    final _$result =
        _$v ??
        _$ServiceProviderPaymentRequest._(
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'ServiceProviderPaymentRequest',
            'amount',
          ),
          paidOn: BuiltValueNullFieldError.checkNotNull(
            paidOn,
            r'ServiceProviderPaymentRequest',
            'paidOn',
          ),
          note: note,
          annonceId: annonceId,
          residenceId: residenceId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
