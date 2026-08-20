// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_comment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReviewCommentRequest extends ReviewCommentRequest {
  @override
  final String body;

  factory _$ReviewCommentRequest([
    void Function(ReviewCommentRequestBuilder)? updates,
  ]) => (ReviewCommentRequestBuilder()..update(updates))._build();

  _$ReviewCommentRequest._({required this.body}) : super._();
  @override
  ReviewCommentRequest rebuild(
    void Function(ReviewCommentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReviewCommentRequestBuilder toBuilder() =>
      ReviewCommentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewCommentRequest && body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ReviewCommentRequest',
    )..add('body', body)).toString();
  }
}

class ReviewCommentRequestBuilder
    implements Builder<ReviewCommentRequest, ReviewCommentRequestBuilder> {
  _$ReviewCommentRequest? _$v;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  ReviewCommentRequestBuilder() {
    ReviewCommentRequest._defaults(this);
  }

  ReviewCommentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewCommentRequest other) {
    _$v = other as _$ReviewCommentRequest;
  }

  @override
  void update(void Function(ReviewCommentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewCommentRequest build() => _build();

  _$ReviewCommentRequest _build() {
    final _$result =
        _$v ??
        _$ReviewCommentRequest._(
          body: BuiltValueNullFieldError.checkNotNull(
            body,
            r'ReviewCommentRequest',
            'body',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
