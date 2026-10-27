// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_tenant_rating_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminTenantRatingResponse extends AdminTenantRatingResponse {
  @override
  final String? contractId;
  @override
  final String? tenantAccountId;
  @override
  final String? prestataireAccountId;
  @override
  final int? stars;
  @override
  final String? comment;
  @override
  final DateTime? ratedAt;

  factory _$AdminTenantRatingResponse([
    void Function(AdminTenantRatingResponseBuilder)? updates,
  ]) => (AdminTenantRatingResponseBuilder()..update(updates))._build();

  _$AdminTenantRatingResponse._({
    this.contractId,
    this.tenantAccountId,
    this.prestataireAccountId,
    this.stars,
    this.comment,
    this.ratedAt,
  }) : super._();
  @override
  AdminTenantRatingResponse rebuild(
    void Function(AdminTenantRatingResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminTenantRatingResponseBuilder toBuilder() =>
      AdminTenantRatingResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminTenantRatingResponse &&
        contractId == other.contractId &&
        tenantAccountId == other.tenantAccountId &&
        prestataireAccountId == other.prestataireAccountId &&
        stars == other.stars &&
        comment == other.comment &&
        ratedAt == other.ratedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, contractId.hashCode);
    _$hash = $jc(_$hash, tenantAccountId.hashCode);
    _$hash = $jc(_$hash, prestataireAccountId.hashCode);
    _$hash = $jc(_$hash, stars.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, ratedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminTenantRatingResponse')
          ..add('contractId', contractId)
          ..add('tenantAccountId', tenantAccountId)
          ..add('prestataireAccountId', prestataireAccountId)
          ..add('stars', stars)
          ..add('comment', comment)
          ..add('ratedAt', ratedAt))
        .toString();
  }
}

class AdminTenantRatingResponseBuilder
    implements
        Builder<AdminTenantRatingResponse, AdminTenantRatingResponseBuilder> {
  _$AdminTenantRatingResponse? _$v;

  String? _contractId;
  String? get contractId => _$this._contractId;
  set contractId(String? contractId) => _$this._contractId = contractId;

  String? _tenantAccountId;
  String? get tenantAccountId => _$this._tenantAccountId;
  set tenantAccountId(String? tenantAccountId) =>
      _$this._tenantAccountId = tenantAccountId;

  String? _prestataireAccountId;
  String? get prestataireAccountId => _$this._prestataireAccountId;
  set prestataireAccountId(String? prestataireAccountId) =>
      _$this._prestataireAccountId = prestataireAccountId;

  int? _stars;
  int? get stars => _$this._stars;
  set stars(int? stars) => _$this._stars = stars;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  DateTime? _ratedAt;
  DateTime? get ratedAt => _$this._ratedAt;
  set ratedAt(DateTime? ratedAt) => _$this._ratedAt = ratedAt;

  AdminTenantRatingResponseBuilder() {
    AdminTenantRatingResponse._defaults(this);
  }

  AdminTenantRatingResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _contractId = $v.contractId;
      _tenantAccountId = $v.tenantAccountId;
      _prestataireAccountId = $v.prestataireAccountId;
      _stars = $v.stars;
      _comment = $v.comment;
      _ratedAt = $v.ratedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminTenantRatingResponse other) {
    _$v = other as _$AdminTenantRatingResponse;
  }

  @override
  void update(void Function(AdminTenantRatingResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminTenantRatingResponse build() => _build();

  _$AdminTenantRatingResponse _build() {
    final _$result =
        _$v ??
        _$AdminTenantRatingResponse._(
          contractId: contractId,
          tenantAccountId: tenantAccountId,
          prestataireAccountId: prestataireAccountId,
          stars: stars,
          comment: comment,
          ratedAt: ratedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
