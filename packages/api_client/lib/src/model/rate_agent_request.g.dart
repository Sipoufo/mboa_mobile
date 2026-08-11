// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_agent_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RateAgentRequest extends RateAgentRequest {
  @override
  final int rating;

  factory _$RateAgentRequest([
    void Function(RateAgentRequestBuilder)? updates,
  ]) => (RateAgentRequestBuilder()..update(updates))._build();

  _$RateAgentRequest._({required this.rating}) : super._();
  @override
  RateAgentRequest rebuild(void Function(RateAgentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RateAgentRequestBuilder toBuilder() =>
      RateAgentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RateAgentRequest && rating == other.rating;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'RateAgentRequest',
    )..add('rating', rating)).toString();
  }
}

class RateAgentRequestBuilder
    implements Builder<RateAgentRequest, RateAgentRequestBuilder> {
  _$RateAgentRequest? _$v;

  int? _rating;
  int? get rating => _$this._rating;
  set rating(int? rating) => _$this._rating = rating;

  RateAgentRequestBuilder() {
    RateAgentRequest._defaults(this);
  }

  RateAgentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rating = $v.rating;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RateAgentRequest other) {
    _$v = other as _$RateAgentRequest;
  }

  @override
  void update(void Function(RateAgentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RateAgentRequest build() => _build();

  _$RateAgentRequest _build() {
    final _$result =
        _$v ??
        _$RateAgentRequest._(
          rating: BuiltValueNullFieldError.checkNotNull(
            rating,
            r'RateAgentRequest',
            'rating',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
