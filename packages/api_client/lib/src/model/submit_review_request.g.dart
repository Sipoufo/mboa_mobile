// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_review_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SubmitReviewRequest extends SubmitReviewRequest {
  @override
  final int rating;
  @override
  final int? perceivedCondition;
  @override
  final String? comment;
  @override
  final BuiltList<String>? pros;
  @override
  final BuiltList<String>? cons;
  @override
  final BuiltList<String>? photoKeys;
  @override
  final int? agentRating;

  factory _$SubmitReviewRequest([
    void Function(SubmitReviewRequestBuilder)? updates,
  ]) => (SubmitReviewRequestBuilder()..update(updates))._build();

  _$SubmitReviewRequest._({
    required this.rating,
    this.perceivedCondition,
    this.comment,
    this.pros,
    this.cons,
    this.photoKeys,
    this.agentRating,
  }) : super._();
  @override
  SubmitReviewRequest rebuild(
    void Function(SubmitReviewRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SubmitReviewRequestBuilder toBuilder() =>
      SubmitReviewRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubmitReviewRequest &&
        rating == other.rating &&
        perceivedCondition == other.perceivedCondition &&
        comment == other.comment &&
        pros == other.pros &&
        cons == other.cons &&
        photoKeys == other.photoKeys &&
        agentRating == other.agentRating;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, perceivedCondition.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, pros.hashCode);
    _$hash = $jc(_$hash, cons.hashCode);
    _$hash = $jc(_$hash, photoKeys.hashCode);
    _$hash = $jc(_$hash, agentRating.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubmitReviewRequest')
          ..add('rating', rating)
          ..add('perceivedCondition', perceivedCondition)
          ..add('comment', comment)
          ..add('pros', pros)
          ..add('cons', cons)
          ..add('photoKeys', photoKeys)
          ..add('agentRating', agentRating))
        .toString();
  }
}

class SubmitReviewRequestBuilder
    implements Builder<SubmitReviewRequest, SubmitReviewRequestBuilder> {
  _$SubmitReviewRequest? _$v;

  int? _rating;
  int? get rating => _$this._rating;
  set rating(int? rating) => _$this._rating = rating;

  int? _perceivedCondition;
  int? get perceivedCondition => _$this._perceivedCondition;
  set perceivedCondition(int? perceivedCondition) =>
      _$this._perceivedCondition = perceivedCondition;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  ListBuilder<String>? _pros;
  ListBuilder<String> get pros => _$this._pros ??= ListBuilder<String>();
  set pros(ListBuilder<String>? pros) => _$this._pros = pros;

  ListBuilder<String>? _cons;
  ListBuilder<String> get cons => _$this._cons ??= ListBuilder<String>();
  set cons(ListBuilder<String>? cons) => _$this._cons = cons;

  ListBuilder<String>? _photoKeys;
  ListBuilder<String> get photoKeys =>
      _$this._photoKeys ??= ListBuilder<String>();
  set photoKeys(ListBuilder<String>? photoKeys) =>
      _$this._photoKeys = photoKeys;

  int? _agentRating;
  int? get agentRating => _$this._agentRating;
  set agentRating(int? agentRating) => _$this._agentRating = agentRating;

  SubmitReviewRequestBuilder() {
    SubmitReviewRequest._defaults(this);
  }

  SubmitReviewRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rating = $v.rating;
      _perceivedCondition = $v.perceivedCondition;
      _comment = $v.comment;
      _pros = $v.pros?.toBuilder();
      _cons = $v.cons?.toBuilder();
      _photoKeys = $v.photoKeys?.toBuilder();
      _agentRating = $v.agentRating;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubmitReviewRequest other) {
    _$v = other as _$SubmitReviewRequest;
  }

  @override
  void update(void Function(SubmitReviewRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubmitReviewRequest build() => _build();

  _$SubmitReviewRequest _build() {
    _$SubmitReviewRequest _$result;
    try {
      _$result =
          _$v ??
          _$SubmitReviewRequest._(
            rating: BuiltValueNullFieldError.checkNotNull(
              rating,
              r'SubmitReviewRequest',
              'rating',
            ),
            perceivedCondition: perceivedCondition,
            comment: comment,
            pros: _pros?.build(),
            cons: _cons?.build(),
            photoKeys: _photoKeys?.build(),
            agentRating: agentRating,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'pros';
        _pros?.build();
        _$failedField = 'cons';
        _cons?.build();
        _$failedField = 'photoKeys';
        _photoKeys?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SubmitReviewRequest',
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
