// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'window.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Window extends Window {
  @override
  final int? last7Days;
  @override
  final int? last30Days;

  factory _$Window([void Function(WindowBuilder)? updates]) =>
      (WindowBuilder()..update(updates))._build();

  _$Window._({this.last7Days, this.last30Days}) : super._();
  @override
  Window rebuild(void Function(WindowBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WindowBuilder toBuilder() => WindowBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Window &&
        last7Days == other.last7Days &&
        last30Days == other.last30Days;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, last7Days.hashCode);
    _$hash = $jc(_$hash, last30Days.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Window')
          ..add('last7Days', last7Days)
          ..add('last30Days', last30Days))
        .toString();
  }
}

class WindowBuilder implements Builder<Window, WindowBuilder> {
  _$Window? _$v;

  int? _last7Days;
  int? get last7Days => _$this._last7Days;
  set last7Days(int? last7Days) => _$this._last7Days = last7Days;

  int? _last30Days;
  int? get last30Days => _$this._last30Days;
  set last30Days(int? last30Days) => _$this._last30Days = last30Days;

  WindowBuilder() {
    Window._defaults(this);
  }

  WindowBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _last7Days = $v.last7Days;
      _last30Days = $v.last30Days;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Window other) {
    _$v = other as _$Window;
  }

  @override
  void update(void Function(WindowBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Window build() => _build();

  _$Window _build() {
    final _$result =
        _$v ?? _$Window._(last7Days: last7Days, last30Days: last30Days);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
