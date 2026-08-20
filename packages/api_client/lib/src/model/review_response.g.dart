// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReviewResponse extends ReviewResponse {
  @override
  final String? id;
  @override
  final String? annonceId;
  @override
  final String? authorName;
  @override
  final int? rating;
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
  final DateTime? publishedAt;
  @override
  final BuiltList<Comment>? comments;

  factory _$ReviewResponse([void Function(ReviewResponseBuilder)? updates]) =>
      (ReviewResponseBuilder()..update(updates))._build();

  _$ReviewResponse._({
    this.id,
    this.annonceId,
    this.authorName,
    this.rating,
    this.perceivedCondition,
    this.comment,
    this.pros,
    this.cons,
    this.photoKeys,
    this.publishedAt,
    this.comments,
  }) : super._();
  @override
  ReviewResponse rebuild(void Function(ReviewResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewResponseBuilder toBuilder() => ReviewResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewResponse &&
        id == other.id &&
        annonceId == other.annonceId &&
        authorName == other.authorName &&
        rating == other.rating &&
        perceivedCondition == other.perceivedCondition &&
        comment == other.comment &&
        pros == other.pros &&
        cons == other.cons &&
        photoKeys == other.photoKeys &&
        publishedAt == other.publishedAt &&
        comments == other.comments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, authorName.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, perceivedCondition.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, pros.hashCode);
    _$hash = $jc(_$hash, cons.hashCode);
    _$hash = $jc(_$hash, photoKeys.hashCode);
    _$hash = $jc(_$hash, publishedAt.hashCode);
    _$hash = $jc(_$hash, comments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewResponse')
          ..add('id', id)
          ..add('annonceId', annonceId)
          ..add('authorName', authorName)
          ..add('rating', rating)
          ..add('perceivedCondition', perceivedCondition)
          ..add('comment', comment)
          ..add('pros', pros)
          ..add('cons', cons)
          ..add('photoKeys', photoKeys)
          ..add('publishedAt', publishedAt)
          ..add('comments', comments))
        .toString();
  }
}

class ReviewResponseBuilder
    implements Builder<ReviewResponse, ReviewResponseBuilder> {
  _$ReviewResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _authorName;
  String? get authorName => _$this._authorName;
  set authorName(String? authorName) => _$this._authorName = authorName;

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

  DateTime? _publishedAt;
  DateTime? get publishedAt => _$this._publishedAt;
  set publishedAt(DateTime? publishedAt) => _$this._publishedAt = publishedAt;

  ListBuilder<Comment>? _comments;
  ListBuilder<Comment> get comments =>
      _$this._comments ??= ListBuilder<Comment>();
  set comments(ListBuilder<Comment>? comments) => _$this._comments = comments;

  ReviewResponseBuilder() {
    ReviewResponse._defaults(this);
  }

  ReviewResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _annonceId = $v.annonceId;
      _authorName = $v.authorName;
      _rating = $v.rating;
      _perceivedCondition = $v.perceivedCondition;
      _comment = $v.comment;
      _pros = $v.pros?.toBuilder();
      _cons = $v.cons?.toBuilder();
      _photoKeys = $v.photoKeys?.toBuilder();
      _publishedAt = $v.publishedAt;
      _comments = $v.comments?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewResponse other) {
    _$v = other as _$ReviewResponse;
  }

  @override
  void update(void Function(ReviewResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewResponse build() => _build();

  _$ReviewResponse _build() {
    _$ReviewResponse _$result;
    try {
      _$result =
          _$v ??
          _$ReviewResponse._(
            id: id,
            annonceId: annonceId,
            authorName: authorName,
            rating: rating,
            perceivedCondition: perceivedCondition,
            comment: comment,
            pros: _pros?.build(),
            cons: _cons?.build(),
            photoKeys: _photoKeys?.build(),
            publishedAt: publishedAt,
            comments: _comments?.build(),
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

        _$failedField = 'comments';
        _comments?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ReviewResponse',
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
