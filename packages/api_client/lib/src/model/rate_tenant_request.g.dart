// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_tenant_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RateTenantRequest extends RateTenantRequest {
  @override
  final int stars;
  @override
  final String? comment;

  factory _$RateTenantRequest([
    void Function(RateTenantRequestBuilder)? updates,
  ]) => (RateTenantRequestBuilder()..update(updates))._build();

  _$RateTenantRequest._({required this.stars, this.comment}) : super._();
  @override
  RateTenantRequest rebuild(void Function(RateTenantRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RateTenantRequestBuilder toBuilder() =>
      RateTenantRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RateTenantRequest &&
        stars == other.stars &&
        comment == other.comment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, stars.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RateTenantRequest')
          ..add('stars', stars)
          ..add('comment', comment))
        .toString();
  }
}

class RateTenantRequestBuilder
    implements Builder<RateTenantRequest, RateTenantRequestBuilder> {
  _$RateTenantRequest? _$v;

  int? _stars;
  int? get stars => _$this._stars;
  set stars(int? stars) => _$this._stars = stars;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  RateTenantRequestBuilder() {
    RateTenantRequest._defaults(this);
  }

  RateTenantRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _stars = $v.stars;
      _comment = $v.comment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RateTenantRequest other) {
    _$v = other as _$RateTenantRequest;
  }

  @override
  void update(void Function(RateTenantRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RateTenantRequest build() => _build();

  _$RateTenantRequest _build() {
    final _$result =
        _$v ??
        _$RateTenantRequest._(
          stars: BuiltValueNullFieldError.checkNotNull(
            stars,
            r'RateTenantRequest',
            'stars',
          ),
          comment: comment,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
