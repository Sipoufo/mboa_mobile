// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_detail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HomeDetail extends HomeDetail {
  @override
  final HomeSummary? home;
  @override
  final HomeSchedule? schedule;

  factory _$HomeDetail([void Function(HomeDetailBuilder)? updates]) =>
      (HomeDetailBuilder()..update(updates))._build();

  _$HomeDetail._({this.home, this.schedule}) : super._();
  @override
  HomeDetail rebuild(void Function(HomeDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeDetailBuilder toBuilder() => HomeDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeDetail &&
        home == other.home &&
        schedule == other.schedule;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, home.hashCode);
    _$hash = $jc(_$hash, schedule.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HomeDetail')
          ..add('home', home)
          ..add('schedule', schedule))
        .toString();
  }
}

class HomeDetailBuilder implements Builder<HomeDetail, HomeDetailBuilder> {
  _$HomeDetail? _$v;

  HomeSummaryBuilder? _home;
  HomeSummaryBuilder get home => _$this._home ??= HomeSummaryBuilder();
  set home(HomeSummaryBuilder? home) => _$this._home = home;

  HomeScheduleBuilder? _schedule;
  HomeScheduleBuilder get schedule =>
      _$this._schedule ??= HomeScheduleBuilder();
  set schedule(HomeScheduleBuilder? schedule) => _$this._schedule = schedule;

  HomeDetailBuilder() {
    HomeDetail._defaults(this);
  }

  HomeDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _home = $v.home?.toBuilder();
      _schedule = $v.schedule?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeDetail other) {
    _$v = other as _$HomeDetail;
  }

  @override
  void update(void Function(HomeDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HomeDetail build() => _build();

  _$HomeDetail _build() {
    _$HomeDetail _$result;
    try {
      _$result =
          _$v ??
          _$HomeDetail._(home: _home?.build(), schedule: _schedule?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'home';
        _home?.build();
        _$failedField = 'schedule';
        _schedule?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HomeDetail',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
