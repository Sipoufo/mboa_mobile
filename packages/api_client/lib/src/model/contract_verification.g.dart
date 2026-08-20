// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_verification.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ContractVerification extends ContractVerification {
  @override
  final String? contractId;
  @override
  final bool? signed;
  @override
  final DateTime? signedAt;
  @override
  final String? city;
  @override
  final String? district;

  factory _$ContractVerification([
    void Function(ContractVerificationBuilder)? updates,
  ]) => (ContractVerificationBuilder()..update(updates))._build();

  _$ContractVerification._({
    this.contractId,
    this.signed,
    this.signedAt,
    this.city,
    this.district,
  }) : super._();
  @override
  ContractVerification rebuild(
    void Function(ContractVerificationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ContractVerificationBuilder toBuilder() =>
      ContractVerificationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContractVerification &&
        contractId == other.contractId &&
        signed == other.signed &&
        signedAt == other.signedAt &&
        city == other.city &&
        district == other.district;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, contractId.hashCode);
    _$hash = $jc(_$hash, signed.hashCode);
    _$hash = $jc(_$hash, signedAt.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, district.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ContractVerification')
          ..add('contractId', contractId)
          ..add('signed', signed)
          ..add('signedAt', signedAt)
          ..add('city', city)
          ..add('district', district))
        .toString();
  }
}

class ContractVerificationBuilder
    implements Builder<ContractVerification, ContractVerificationBuilder> {
  _$ContractVerification? _$v;

  String? _contractId;
  String? get contractId => _$this._contractId;
  set contractId(String? contractId) => _$this._contractId = contractId;

  bool? _signed;
  bool? get signed => _$this._signed;
  set signed(bool? signed) => _$this._signed = signed;

  DateTime? _signedAt;
  DateTime? get signedAt => _$this._signedAt;
  set signedAt(DateTime? signedAt) => _$this._signedAt = signedAt;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _district;
  String? get district => _$this._district;
  set district(String? district) => _$this._district = district;

  ContractVerificationBuilder() {
    ContractVerification._defaults(this);
  }

  ContractVerificationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _contractId = $v.contractId;
      _signed = $v.signed;
      _signedAt = $v.signedAt;
      _city = $v.city;
      _district = $v.district;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ContractVerification other) {
    _$v = other as _$ContractVerification;
  }

  @override
  void update(void Function(ContractVerificationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ContractVerification build() => _build();

  _$ContractVerification _build() {
    final _$result =
        _$v ??
        _$ContractVerification._(
          contractId: contractId,
          signed: signed,
          signedAt: signedAt,
          city: city,
          district: district,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
