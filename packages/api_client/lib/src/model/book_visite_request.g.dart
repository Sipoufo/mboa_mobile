// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_visite_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BookVisiteRequest extends BookVisiteRequest {
  @override
  final String annonceId;
  @override
  final String visitorAccountId;
  @override
  final DateTime startsAt;

  factory _$BookVisiteRequest([
    void Function(BookVisiteRequestBuilder)? updates,
  ]) => (BookVisiteRequestBuilder()..update(updates))._build();

  _$BookVisiteRequest._({
    required this.annonceId,
    required this.visitorAccountId,
    required this.startsAt,
  }) : super._();
  @override
  BookVisiteRequest rebuild(void Function(BookVisiteRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BookVisiteRequestBuilder toBuilder() =>
      BookVisiteRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BookVisiteRequest &&
        annonceId == other.annonceId &&
        visitorAccountId == other.visitorAccountId &&
        startsAt == other.startsAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, visitorAccountId.hashCode);
    _$hash = $jc(_$hash, startsAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BookVisiteRequest')
          ..add('annonceId', annonceId)
          ..add('visitorAccountId', visitorAccountId)
          ..add('startsAt', startsAt))
        .toString();
  }
}

class BookVisiteRequestBuilder
    implements Builder<BookVisiteRequest, BookVisiteRequestBuilder> {
  _$BookVisiteRequest? _$v;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _visitorAccountId;
  String? get visitorAccountId => _$this._visitorAccountId;
  set visitorAccountId(String? visitorAccountId) =>
      _$this._visitorAccountId = visitorAccountId;

  DateTime? _startsAt;
  DateTime? get startsAt => _$this._startsAt;
  set startsAt(DateTime? startsAt) => _$this._startsAt = startsAt;

  BookVisiteRequestBuilder() {
    BookVisiteRequest._defaults(this);
  }

  BookVisiteRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _annonceId = $v.annonceId;
      _visitorAccountId = $v.visitorAccountId;
      _startsAt = $v.startsAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BookVisiteRequest other) {
    _$v = other as _$BookVisiteRequest;
  }

  @override
  void update(void Function(BookVisiteRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BookVisiteRequest build() => _build();

  _$BookVisiteRequest _build() {
    final _$result =
        _$v ??
        _$BookVisiteRequest._(
          annonceId: BuiltValueNullFieldError.checkNotNull(
            annonceId,
            r'BookVisiteRequest',
            'annonceId',
          ),
          visitorAccountId: BuiltValueNullFieldError.checkNotNull(
            visitorAccountId,
            r'BookVisiteRequest',
            'visitorAccountId',
          ),
          startsAt: BuiltValueNullFieldError.checkNotNull(
            startsAt,
            r'BookVisiteRequest',
            'startsAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
