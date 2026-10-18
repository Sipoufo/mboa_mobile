// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversion.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Conversion extends Conversion {
  @override
  final Cohort? last90Days;
  @override
  final Cohort? allTime;

  factory _$Conversion([void Function(ConversionBuilder)? updates]) =>
      (ConversionBuilder()..update(updates))._build();

  _$Conversion._({this.last90Days, this.allTime}) : super._();
  @override
  Conversion rebuild(void Function(ConversionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConversionBuilder toBuilder() => ConversionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Conversion &&
        last90Days == other.last90Days &&
        allTime == other.allTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, last90Days.hashCode);
    _$hash = $jc(_$hash, allTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Conversion')
          ..add('last90Days', last90Days)
          ..add('allTime', allTime))
        .toString();
  }
}

class ConversionBuilder implements Builder<Conversion, ConversionBuilder> {
  _$Conversion? _$v;

  CohortBuilder? _last90Days;
  CohortBuilder get last90Days => _$this._last90Days ??= CohortBuilder();
  set last90Days(CohortBuilder? last90Days) => _$this._last90Days = last90Days;

  CohortBuilder? _allTime;
  CohortBuilder get allTime => _$this._allTime ??= CohortBuilder();
  set allTime(CohortBuilder? allTime) => _$this._allTime = allTime;

  ConversionBuilder() {
    Conversion._defaults(this);
  }

  ConversionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _last90Days = $v.last90Days?.toBuilder();
      _allTime = $v.allTime?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Conversion other) {
    _$v = other as _$Conversion;
  }

  @override
  void update(void Function(ConversionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Conversion build() => _build();

  _$Conversion _build() {
    _$Conversion _$result;
    try {
      _$result =
          _$v ??
          _$Conversion._(
            last90Days: _last90Days?.build(),
            allTime: _allTime?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'last90Days';
        _last90Days?.build();
        _$failedField = 'allTime';
        _allTime?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'Conversion',
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
