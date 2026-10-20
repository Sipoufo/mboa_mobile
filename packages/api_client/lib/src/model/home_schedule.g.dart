// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_schedule.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HomeSchedule extends HomeSchedule {
  @override
  final BuiltList<Due>? dues;
  @override
  final bool? moreBefore;
  @override
  final bool? moreAfter;

  factory _$HomeSchedule([void Function(HomeScheduleBuilder)? updates]) =>
      (HomeScheduleBuilder()..update(updates))._build();

  _$HomeSchedule._({this.dues, this.moreBefore, this.moreAfter}) : super._();
  @override
  HomeSchedule rebuild(void Function(HomeScheduleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeScheduleBuilder toBuilder() => HomeScheduleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeSchedule &&
        dues == other.dues &&
        moreBefore == other.moreBefore &&
        moreAfter == other.moreAfter;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, dues.hashCode);
    _$hash = $jc(_$hash, moreBefore.hashCode);
    _$hash = $jc(_$hash, moreAfter.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HomeSchedule')
          ..add('dues', dues)
          ..add('moreBefore', moreBefore)
          ..add('moreAfter', moreAfter))
        .toString();
  }
}

class HomeScheduleBuilder
    implements Builder<HomeSchedule, HomeScheduleBuilder> {
  _$HomeSchedule? _$v;

  ListBuilder<Due>? _dues;
  ListBuilder<Due> get dues => _$this._dues ??= ListBuilder<Due>();
  set dues(ListBuilder<Due>? dues) => _$this._dues = dues;

  bool? _moreBefore;
  bool? get moreBefore => _$this._moreBefore;
  set moreBefore(bool? moreBefore) => _$this._moreBefore = moreBefore;

  bool? _moreAfter;
  bool? get moreAfter => _$this._moreAfter;
  set moreAfter(bool? moreAfter) => _$this._moreAfter = moreAfter;

  HomeScheduleBuilder() {
    HomeSchedule._defaults(this);
  }

  HomeScheduleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _dues = $v.dues?.toBuilder();
      _moreBefore = $v.moreBefore;
      _moreAfter = $v.moreAfter;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeSchedule other) {
    _$v = other as _$HomeSchedule;
  }

  @override
  void update(void Function(HomeScheduleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HomeSchedule build() => _build();

  _$HomeSchedule _build() {
    _$HomeSchedule _$result;
    try {
      _$result =
          _$v ??
          _$HomeSchedule._(
            dues: _dues?.build(),
            moreBefore: moreBefore,
            moreAfter: moreAfter,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'dues';
        _dues?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HomeSchedule',
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
