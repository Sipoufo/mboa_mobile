// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_provider_payment_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ServiceProviderPaymentResponse extends ServiceProviderPaymentResponse {
  @override
  final String? id;
  @override
  final String? providerId;
  @override
  final int? amount;
  @override
  final Date? paidOn;
  @override
  final String? note;
  @override
  final String? annonceId;
  @override
  final String? residenceId;
  @override
  final String? propertyLabel;
  @override
  final bool? inLedger;
  @override
  final DateTime? createdAt;

  factory _$ServiceProviderPaymentResponse([
    void Function(ServiceProviderPaymentResponseBuilder)? updates,
  ]) => (ServiceProviderPaymentResponseBuilder()..update(updates))._build();

  _$ServiceProviderPaymentResponse._({
    this.id,
    this.providerId,
    this.amount,
    this.paidOn,
    this.note,
    this.annonceId,
    this.residenceId,
    this.propertyLabel,
    this.inLedger,
    this.createdAt,
  }) : super._();
  @override
  ServiceProviderPaymentResponse rebuild(
    void Function(ServiceProviderPaymentResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ServiceProviderPaymentResponseBuilder toBuilder() =>
      ServiceProviderPaymentResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ServiceProviderPaymentResponse &&
        id == other.id &&
        providerId == other.providerId &&
        amount == other.amount &&
        paidOn == other.paidOn &&
        note == other.note &&
        annonceId == other.annonceId &&
        residenceId == other.residenceId &&
        propertyLabel == other.propertyLabel &&
        inLedger == other.inLedger &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, providerId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, paidOn.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, residenceId.hashCode);
    _$hash = $jc(_$hash, propertyLabel.hashCode);
    _$hash = $jc(_$hash, inLedger.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ServiceProviderPaymentResponse')
          ..add('id', id)
          ..add('providerId', providerId)
          ..add('amount', amount)
          ..add('paidOn', paidOn)
          ..add('note', note)
          ..add('annonceId', annonceId)
          ..add('residenceId', residenceId)
          ..add('propertyLabel', propertyLabel)
          ..add('inLedger', inLedger)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ServiceProviderPaymentResponseBuilder
    implements
        Builder<
          ServiceProviderPaymentResponse,
          ServiceProviderPaymentResponseBuilder
        > {
  _$ServiceProviderPaymentResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _providerId;
  String? get providerId => _$this._providerId;
  set providerId(String? providerId) => _$this._providerId = providerId;

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

  String? _propertyLabel;
  String? get propertyLabel => _$this._propertyLabel;
  set propertyLabel(String? propertyLabel) =>
      _$this._propertyLabel = propertyLabel;

  bool? _inLedger;
  bool? get inLedger => _$this._inLedger;
  set inLedger(bool? inLedger) => _$this._inLedger = inLedger;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ServiceProviderPaymentResponseBuilder() {
    ServiceProviderPaymentResponse._defaults(this);
  }

  ServiceProviderPaymentResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _providerId = $v.providerId;
      _amount = $v.amount;
      _paidOn = $v.paidOn;
      _note = $v.note;
      _annonceId = $v.annonceId;
      _residenceId = $v.residenceId;
      _propertyLabel = $v.propertyLabel;
      _inLedger = $v.inLedger;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ServiceProviderPaymentResponse other) {
    _$v = other as _$ServiceProviderPaymentResponse;
  }

  @override
  void update(void Function(ServiceProviderPaymentResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ServiceProviderPaymentResponse build() => _build();

  _$ServiceProviderPaymentResponse _build() {
    final _$result =
        _$v ??
        _$ServiceProviderPaymentResponse._(
          id: id,
          providerId: providerId,
          amount: amount,
          paidOn: paidOn,
          note: note,
          annonceId: annonceId,
          residenceId: residenceId,
          propertyLabel: propertyLabel,
          inLedger: inLedger,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
