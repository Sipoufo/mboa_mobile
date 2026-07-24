// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reject_kyc_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RejectKycRequest extends RejectKycRequest {
  @override
  final String reason;

  factory _$RejectKycRequest([
    void Function(RejectKycRequestBuilder)? updates,
  ]) => (RejectKycRequestBuilder()..update(updates))._build();

  _$RejectKycRequest._({required this.reason}) : super._();
  @override
  RejectKycRequest rebuild(void Function(RejectKycRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RejectKycRequestBuilder toBuilder() =>
      RejectKycRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RejectKycRequest && reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'RejectKycRequest',
    )..add('reason', reason)).toString();
  }
}

class RejectKycRequestBuilder
    implements Builder<RejectKycRequest, RejectKycRequestBuilder> {
  _$RejectKycRequest? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  RejectKycRequestBuilder() {
    RejectKycRequest._defaults(this);
  }

  RejectKycRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RejectKycRequest other) {
    _$v = other as _$RejectKycRequest;
  }

  @override
  void update(void Function(RejectKycRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RejectKycRequest build() => _build();

  _$RejectKycRequest _build() {
    final _$result =
        _$v ??
        _$RejectKycRequest._(
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'RejectKycRequest',
            'reason',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
