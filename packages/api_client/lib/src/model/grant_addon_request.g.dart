// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grant_addon_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GrantAddonRequest extends GrantAddonRequest {
  @override
  final int? days;
  @override
  final String reason;

  factory _$GrantAddonRequest([
    void Function(GrantAddonRequestBuilder)? updates,
  ]) => (GrantAddonRequestBuilder()..update(updates))._build();

  _$GrantAddonRequest._({this.days, required this.reason}) : super._();
  @override
  GrantAddonRequest rebuild(void Function(GrantAddonRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GrantAddonRequestBuilder toBuilder() =>
      GrantAddonRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GrantAddonRequest &&
        days == other.days &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, days.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GrantAddonRequest')
          ..add('days', days)
          ..add('reason', reason))
        .toString();
  }
}

class GrantAddonRequestBuilder
    implements Builder<GrantAddonRequest, GrantAddonRequestBuilder> {
  _$GrantAddonRequest? _$v;

  int? _days;
  int? get days => _$this._days;
  set days(int? days) => _$this._days = days;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  GrantAddonRequestBuilder() {
    GrantAddonRequest._defaults(this);
  }

  GrantAddonRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _days = $v.days;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GrantAddonRequest other) {
    _$v = other as _$GrantAddonRequest;
  }

  @override
  void update(void Function(GrantAddonRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GrantAddonRequest build() => _build();

  _$GrantAddonRequest _build() {
    final _$result =
        _$v ??
        _$GrantAddonRequest._(
          days: days,
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'GrantAddonRequest',
            'reason',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
