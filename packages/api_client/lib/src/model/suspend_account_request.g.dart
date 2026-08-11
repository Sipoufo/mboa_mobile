// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suspend_account_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SuspendAccountRequest extends SuspendAccountRequest {
  @override
  final String reason;

  factory _$SuspendAccountRequest([
    void Function(SuspendAccountRequestBuilder)? updates,
  ]) => (SuspendAccountRequestBuilder()..update(updates))._build();

  _$SuspendAccountRequest._({required this.reason}) : super._();
  @override
  SuspendAccountRequest rebuild(
    void Function(SuspendAccountRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SuspendAccountRequestBuilder toBuilder() =>
      SuspendAccountRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SuspendAccountRequest && reason == other.reason;
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
      r'SuspendAccountRequest',
    )..add('reason', reason)).toString();
  }
}

class SuspendAccountRequestBuilder
    implements Builder<SuspendAccountRequest, SuspendAccountRequestBuilder> {
  _$SuspendAccountRequest? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  SuspendAccountRequestBuilder() {
    SuspendAccountRequest._defaults(this);
  }

  SuspendAccountRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SuspendAccountRequest other) {
    _$v = other as _$SuspendAccountRequest;
  }

  @override
  void update(void Function(SuspendAccountRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SuspendAccountRequest build() => _build();

  _$SuspendAccountRequest _build() {
    final _$result =
        _$v ??
        _$SuspendAccountRequest._(
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'SuspendAccountRequest',
            'reason',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
