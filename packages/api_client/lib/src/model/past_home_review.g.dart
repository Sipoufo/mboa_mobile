// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_home_review.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PastHomeReview extends PastHomeReview {
  @override
  final String? reviewId;
  @override
  final int? rating;
  @override
  final bool? canWrite;
  @override
  final bool? canEdit;
  @override
  final DateTime? editableUntil;

  factory _$PastHomeReview([void Function(PastHomeReviewBuilder)? updates]) =>
      (PastHomeReviewBuilder()..update(updates))._build();

  _$PastHomeReview._({
    this.reviewId,
    this.rating,
    this.canWrite,
    this.canEdit,
    this.editableUntil,
  }) : super._();
  @override
  PastHomeReview rebuild(void Function(PastHomeReviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PastHomeReviewBuilder toBuilder() => PastHomeReviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PastHomeReview &&
        reviewId == other.reviewId &&
        rating == other.rating &&
        canWrite == other.canWrite &&
        canEdit == other.canEdit &&
        editableUntil == other.editableUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reviewId.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, canWrite.hashCode);
    _$hash = $jc(_$hash, canEdit.hashCode);
    _$hash = $jc(_$hash, editableUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PastHomeReview')
          ..add('reviewId', reviewId)
          ..add('rating', rating)
          ..add('canWrite', canWrite)
          ..add('canEdit', canEdit)
          ..add('editableUntil', editableUntil))
        .toString();
  }
}

class PastHomeReviewBuilder
    implements Builder<PastHomeReview, PastHomeReviewBuilder> {
  _$PastHomeReview? _$v;

  String? _reviewId;
  String? get reviewId => _$this._reviewId;
  set reviewId(String? reviewId) => _$this._reviewId = reviewId;

  int? _rating;
  int? get rating => _$this._rating;
  set rating(int? rating) => _$this._rating = rating;

  bool? _canWrite;
  bool? get canWrite => _$this._canWrite;
  set canWrite(bool? canWrite) => _$this._canWrite = canWrite;

  bool? _canEdit;
  bool? get canEdit => _$this._canEdit;
  set canEdit(bool? canEdit) => _$this._canEdit = canEdit;

  DateTime? _editableUntil;
  DateTime? get editableUntil => _$this._editableUntil;
  set editableUntil(DateTime? editableUntil) =>
      _$this._editableUntil = editableUntil;

  PastHomeReviewBuilder() {
    PastHomeReview._defaults(this);
  }

  PastHomeReviewBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reviewId = $v.reviewId;
      _rating = $v.rating;
      _canWrite = $v.canWrite;
      _canEdit = $v.canEdit;
      _editableUntil = $v.editableUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PastHomeReview other) {
    _$v = other as _$PastHomeReview;
  }

  @override
  void update(void Function(PastHomeReviewBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PastHomeReview build() => _build();

  _$PastHomeReview _build() {
    final _$result =
        _$v ??
        _$PastHomeReview._(
          reviewId: reviewId,
          rating: rating,
          canWrite: canWrite,
          canEdit: canEdit,
          editableUntil: editableUntil,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
