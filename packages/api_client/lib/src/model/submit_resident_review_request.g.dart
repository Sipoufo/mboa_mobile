// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_resident_review_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SubmitResidentReviewRequest extends SubmitResidentReviewRequest {
  @override
  final int rating;
  @override
  final String? comment;
  @override
  final BuiltList<String>? pros;
  @override
  final BuiltList<String>? cons;

  factory _$SubmitResidentReviewRequest([
    void Function(SubmitResidentReviewRequestBuilder)? updates,
  ]) => (SubmitResidentReviewRequestBuilder()..update(updates))._build();

  _$SubmitResidentReviewRequest._({
    required this.rating,
    this.comment,
    this.pros,
    this.cons,
  }) : super._();
  @override
  SubmitResidentReviewRequest rebuild(
    void Function(SubmitResidentReviewRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SubmitResidentReviewRequestBuilder toBuilder() =>
      SubmitResidentReviewRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubmitResidentReviewRequest &&
        rating == other.rating &&
        comment == other.comment &&
        pros == other.pros &&
        cons == other.cons;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, pros.hashCode);
    _$hash = $jc(_$hash, cons.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubmitResidentReviewRequest')
          ..add('rating', rating)
          ..add('comment', comment)
          ..add('pros', pros)
          ..add('cons', cons))
        .toString();
  }
}

class SubmitResidentReviewRequestBuilder
    implements
        Builder<
          SubmitResidentReviewRequest,
          SubmitResidentReviewRequestBuilder
        > {
  _$SubmitResidentReviewRequest? _$v;

  int? _rating;
  int? get rating => _$this._rating;
  set rating(int? rating) => _$this._rating = rating;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  ListBuilder<String>? _pros;
  ListBuilder<String> get pros => _$this._pros ??= ListBuilder<String>();
  set pros(ListBuilder<String>? pros) => _$this._pros = pros;

  ListBuilder<String>? _cons;
  ListBuilder<String> get cons => _$this._cons ??= ListBuilder<String>();
  set cons(ListBuilder<String>? cons) => _$this._cons = cons;

  SubmitResidentReviewRequestBuilder() {
    SubmitResidentReviewRequest._defaults(this);
  }

  SubmitResidentReviewRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rating = $v.rating;
      _comment = $v.comment;
      _pros = $v.pros?.toBuilder();
      _cons = $v.cons?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubmitResidentReviewRequest other) {
    _$v = other as _$SubmitResidentReviewRequest;
  }

  @override
  void update(void Function(SubmitResidentReviewRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubmitResidentReviewRequest build() => _build();

  _$SubmitResidentReviewRequest _build() {
    _$SubmitResidentReviewRequest _$result;
    try {
      _$result =
          _$v ??
          _$SubmitResidentReviewRequest._(
            rating: BuiltValueNullFieldError.checkNotNull(
              rating,
              r'SubmitResidentReviewRequest',
              'rating',
            ),
            comment: comment,
            pros: _pros?.build(),
            cons: _cons?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'pros';
        _pros?.build();
        _$failedField = 'cons';
        _cons?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SubmitResidentReviewRequest',
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
