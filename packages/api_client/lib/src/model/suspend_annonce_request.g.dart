// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suspend_annonce_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SuspendAnnonceRequest extends SuspendAnnonceRequest {
  @override
  final String reason;

  factory _$SuspendAnnonceRequest([
    void Function(SuspendAnnonceRequestBuilder)? updates,
  ]) => (SuspendAnnonceRequestBuilder()..update(updates))._build();

  _$SuspendAnnonceRequest._({required this.reason}) : super._();
  @override
  SuspendAnnonceRequest rebuild(
    void Function(SuspendAnnonceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SuspendAnnonceRequestBuilder toBuilder() =>
      SuspendAnnonceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SuspendAnnonceRequest && reason == other.reason;
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
      r'SuspendAnnonceRequest',
    )..add('reason', reason)).toString();
  }
}

class SuspendAnnonceRequestBuilder
    implements Builder<SuspendAnnonceRequest, SuspendAnnonceRequestBuilder> {
  _$SuspendAnnonceRequest? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  SuspendAnnonceRequestBuilder() {
    SuspendAnnonceRequest._defaults(this);
  }

  SuspendAnnonceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SuspendAnnonceRequest other) {
    _$v = other as _$SuspendAnnonceRequest;
  }

  @override
  void update(void Function(SuspendAnnonceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SuspendAnnonceRequest build() => _build();

  _$SuspendAnnonceRequest _build() {
    final _$result =
        _$v ??
        _$SuspendAnnonceRequest._(
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'SuspendAnnonceRequest',
            'reason',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
