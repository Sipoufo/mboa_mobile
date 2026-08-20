// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_rating.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PropertyRating extends PropertyRating {
  @override
  final double? average;
  @override
  final int? reviewCount;
  @override
  final int? visitCount;
  @override
  final int? residentCount;

  factory _$PropertyRating([void Function(PropertyRatingBuilder)? updates]) =>
      (PropertyRatingBuilder()..update(updates))._build();

  _$PropertyRating._({
    this.average,
    this.reviewCount,
    this.visitCount,
    this.residentCount,
  }) : super._();
  @override
  PropertyRating rebuild(void Function(PropertyRatingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PropertyRatingBuilder toBuilder() => PropertyRatingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PropertyRating &&
        average == other.average &&
        reviewCount == other.reviewCount &&
        visitCount == other.visitCount &&
        residentCount == other.residentCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, average.hashCode);
    _$hash = $jc(_$hash, reviewCount.hashCode);
    _$hash = $jc(_$hash, visitCount.hashCode);
    _$hash = $jc(_$hash, residentCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PropertyRating')
          ..add('average', average)
          ..add('reviewCount', reviewCount)
          ..add('visitCount', visitCount)
          ..add('residentCount', residentCount))
        .toString();
  }
}

class PropertyRatingBuilder
    implements Builder<PropertyRating, PropertyRatingBuilder> {
  _$PropertyRating? _$v;

  double? _average;
  double? get average => _$this._average;
  set average(double? average) => _$this._average = average;

  int? _reviewCount;
  int? get reviewCount => _$this._reviewCount;
  set reviewCount(int? reviewCount) => _$this._reviewCount = reviewCount;

  int? _visitCount;
  int? get visitCount => _$this._visitCount;
  set visitCount(int? visitCount) => _$this._visitCount = visitCount;

  int? _residentCount;
  int? get residentCount => _$this._residentCount;
  set residentCount(int? residentCount) =>
      _$this._residentCount = residentCount;

  PropertyRatingBuilder() {
    PropertyRating._defaults(this);
  }

  PropertyRatingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _average = $v.average;
      _reviewCount = $v.reviewCount;
      _visitCount = $v.visitCount;
      _residentCount = $v.residentCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PropertyRating other) {
    _$v = other as _$PropertyRating;
  }

  @override
  void update(void Function(PropertyRatingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PropertyRating build() => _build();

  _$PropertyRating _build() {
    final _$result =
        _$v ??
        _$PropertyRating._(
          average: average,
          reviewCount: reviewCount,
          visitCount: visitCount,
          residentCount: residentCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
