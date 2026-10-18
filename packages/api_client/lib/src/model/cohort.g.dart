// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cohort.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Cohort extends Cohort {
  @override
  final int? registered;
  @override
  final int? converted;
  @override
  final double? rate;

  factory _$Cohort([void Function(CohortBuilder)? updates]) =>
      (CohortBuilder()..update(updates))._build();

  _$Cohort._({this.registered, this.converted, this.rate}) : super._();
  @override
  Cohort rebuild(void Function(CohortBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CohortBuilder toBuilder() => CohortBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Cohort &&
        registered == other.registered &&
        converted == other.converted &&
        rate == other.rate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, registered.hashCode);
    _$hash = $jc(_$hash, converted.hashCode);
    _$hash = $jc(_$hash, rate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Cohort')
          ..add('registered', registered)
          ..add('converted', converted)
          ..add('rate', rate))
        .toString();
  }
}

class CohortBuilder implements Builder<Cohort, CohortBuilder> {
  _$Cohort? _$v;

  int? _registered;
  int? get registered => _$this._registered;
  set registered(int? registered) => _$this._registered = registered;

  int? _converted;
  int? get converted => _$this._converted;
  set converted(int? converted) => _$this._converted = converted;

  double? _rate;
  double? get rate => _$this._rate;
  set rate(double? rate) => _$this._rate = rate;

  CohortBuilder() {
    Cohort._defaults(this);
  }

  CohortBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _registered = $v.registered;
      _converted = $v.converted;
      _rate = $v.rate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Cohort other) {
    _$v = other as _$Cohort;
  }

  @override
  void update(void Function(CohortBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Cohort build() => _build();

  _$Cohort _build() {
    final _$result =
        _$v ??
        _$Cohort._(registered: registered, converted: converted, rate: rate);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
