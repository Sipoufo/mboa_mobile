// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_rating_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TenantRatingResponse extends TenantRatingResponse {
  @override
  final String? contractId;
  @override
  final int? stars;
  @override
  final DateTime? ratedAt;

  factory _$TenantRatingResponse([
    void Function(TenantRatingResponseBuilder)? updates,
  ]) => (TenantRatingResponseBuilder()..update(updates))._build();

  _$TenantRatingResponse._({this.contractId, this.stars, this.ratedAt})
    : super._();
  @override
  TenantRatingResponse rebuild(
    void Function(TenantRatingResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TenantRatingResponseBuilder toBuilder() =>
      TenantRatingResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TenantRatingResponse &&
        contractId == other.contractId &&
        stars == other.stars &&
        ratedAt == other.ratedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, contractId.hashCode);
    _$hash = $jc(_$hash, stars.hashCode);
    _$hash = $jc(_$hash, ratedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TenantRatingResponse')
          ..add('contractId', contractId)
          ..add('stars', stars)
          ..add('ratedAt', ratedAt))
        .toString();
  }
}

class TenantRatingResponseBuilder
    implements Builder<TenantRatingResponse, TenantRatingResponseBuilder> {
  _$TenantRatingResponse? _$v;

  String? _contractId;
  String? get contractId => _$this._contractId;
  set contractId(String? contractId) => _$this._contractId = contractId;

  int? _stars;
  int? get stars => _$this._stars;
  set stars(int? stars) => _$this._stars = stars;

  DateTime? _ratedAt;
  DateTime? get ratedAt => _$this._ratedAt;
  set ratedAt(DateTime? ratedAt) => _$this._ratedAt = ratedAt;

  TenantRatingResponseBuilder() {
    TenantRatingResponse._defaults(this);
  }

  TenantRatingResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _contractId = $v.contractId;
      _stars = $v.stars;
      _ratedAt = $v.ratedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TenantRatingResponse other) {
    _$v = other as _$TenantRatingResponse;
  }

  @override
  void update(void Function(TenantRatingResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TenantRatingResponse build() => _build();

  _$TenantRatingResponse _build() {
    final _$result =
        _$v ??
        _$TenantRatingResponse._(
          contractId: contractId,
          stars: stars,
          ratedAt: ratedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
