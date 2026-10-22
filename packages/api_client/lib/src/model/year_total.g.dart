// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_total.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$YearTotal extends YearTotal {
  @override
  final int? year;
  @override
  final int? total;

  factory _$YearTotal([void Function(YearTotalBuilder)? updates]) =>
      (YearTotalBuilder()..update(updates))._build();

  _$YearTotal._({this.year, this.total}) : super._();
  @override
  YearTotal rebuild(void Function(YearTotalBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  YearTotalBuilder toBuilder() => YearTotalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is YearTotal && year == other.year && total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'YearTotal')
          ..add('year', year)
          ..add('total', total))
        .toString();
  }
}

class YearTotalBuilder implements Builder<YearTotal, YearTotalBuilder> {
  _$YearTotal? _$v;

  int? _year;
  int? get year => _$this._year;
  set year(int? year) => _$this._year = year;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  YearTotalBuilder() {
    YearTotal._defaults(this);
  }

  YearTotalBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _year = $v.year;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(YearTotal other) {
    _$v = other as _$YearTotal;
  }

  @override
  void update(void Function(YearTotalBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  YearTotal build() => _build();

  _$YearTotal _build() {
    final _$result = _$v ?? _$YearTotal._(year: year, total: total);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
