// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_signalement_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReviewSignalementRequest extends ReviewSignalementRequest {
  @override
  final String? note;

  factory _$ReviewSignalementRequest([
    void Function(ReviewSignalementRequestBuilder)? updates,
  ]) => (ReviewSignalementRequestBuilder()..update(updates))._build();

  _$ReviewSignalementRequest._({this.note}) : super._();
  @override
  ReviewSignalementRequest rebuild(
    void Function(ReviewSignalementRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReviewSignalementRequestBuilder toBuilder() =>
      ReviewSignalementRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewSignalementRequest && note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ReviewSignalementRequest',
    )..add('note', note)).toString();
  }
}

class ReviewSignalementRequestBuilder
    implements
        Builder<ReviewSignalementRequest, ReviewSignalementRequestBuilder> {
  _$ReviewSignalementRequest? _$v;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  ReviewSignalementRequestBuilder() {
    ReviewSignalementRequest._defaults(this);
  }

  ReviewSignalementRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewSignalementRequest other) {
    _$v = other as _$ReviewSignalementRequest;
  }

  @override
  void update(void Function(ReviewSignalementRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewSignalementRequest build() => _build();

  _$ReviewSignalementRequest _build() {
    final _$result = _$v ?? _$ReviewSignalementRequest._(note: note);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
