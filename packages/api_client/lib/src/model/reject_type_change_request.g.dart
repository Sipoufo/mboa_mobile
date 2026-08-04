// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reject_type_change_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RejectTypeChangeRequest extends RejectTypeChangeRequest {
  @override
  final String reason;

  factory _$RejectTypeChangeRequest([
    void Function(RejectTypeChangeRequestBuilder)? updates,
  ]) => (RejectTypeChangeRequestBuilder()..update(updates))._build();

  _$RejectTypeChangeRequest._({required this.reason}) : super._();
  @override
  RejectTypeChangeRequest rebuild(
    void Function(RejectTypeChangeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  RejectTypeChangeRequestBuilder toBuilder() =>
      RejectTypeChangeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RejectTypeChangeRequest && reason == other.reason;
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
      r'RejectTypeChangeRequest',
    )..add('reason', reason)).toString();
  }
}

class RejectTypeChangeRequestBuilder
    implements
        Builder<RejectTypeChangeRequest, RejectTypeChangeRequestBuilder> {
  _$RejectTypeChangeRequest? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  RejectTypeChangeRequestBuilder() {
    RejectTypeChangeRequest._defaults(this);
  }

  RejectTypeChangeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RejectTypeChangeRequest other) {
    _$v = other as _$RejectTypeChangeRequest;
  }

  @override
  void update(void Function(RejectTypeChangeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RejectTypeChangeRequest build() => _build();

  _$RejectTypeChangeRequest _build() {
    final _$result =
        _$v ??
        _$RejectTypeChangeRequest._(
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'RejectTypeChangeRequest',
            'reason',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
