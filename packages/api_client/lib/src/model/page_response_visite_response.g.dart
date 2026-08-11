// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response_visite_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PageResponseVisiteResponse extends PageResponseVisiteResponse {
  @override
  final BuiltList<VisiteResponse>? content;
  @override
  final int? page;
  @override
  final int? size;
  @override
  final int? totalElements;
  @override
  final int? totalPages;
  @override
  final bool? last;

  factory _$PageResponseVisiteResponse([
    void Function(PageResponseVisiteResponseBuilder)? updates,
  ]) => (PageResponseVisiteResponseBuilder()..update(updates))._build();

  _$PageResponseVisiteResponse._({
    this.content,
    this.page,
    this.size,
    this.totalElements,
    this.totalPages,
    this.last,
  }) : super._();
  @override
  PageResponseVisiteResponse rebuild(
    void Function(PageResponseVisiteResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PageResponseVisiteResponseBuilder toBuilder() =>
      PageResponseVisiteResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PageResponseVisiteResponse &&
        content == other.content &&
        page == other.page &&
        size == other.size &&
        totalElements == other.totalElements &&
        totalPages == other.totalPages &&
        last == other.last;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jc(_$hash, totalElements.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jc(_$hash, last.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PageResponseVisiteResponse')
          ..add('content', content)
          ..add('page', page)
          ..add('size', size)
          ..add('totalElements', totalElements)
          ..add('totalPages', totalPages)
          ..add('last', last))
        .toString();
  }
}

class PageResponseVisiteResponseBuilder
    implements
        Builder<PageResponseVisiteResponse, PageResponseVisiteResponseBuilder> {
  _$PageResponseVisiteResponse? _$v;

  ListBuilder<VisiteResponse>? _content;
  ListBuilder<VisiteResponse> get content =>
      _$this._content ??= ListBuilder<VisiteResponse>();
  set content(ListBuilder<VisiteResponse>? content) =>
      _$this._content = content;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _size;
  int? get size => _$this._size;
  set size(int? size) => _$this._size = size;

  int? _totalElements;
  int? get totalElements => _$this._totalElements;
  set totalElements(int? totalElements) =>
      _$this._totalElements = totalElements;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  bool? _last;
  bool? get last => _$this._last;
  set last(bool? last) => _$this._last = last;

  PageResponseVisiteResponseBuilder() {
    PageResponseVisiteResponse._defaults(this);
  }

  PageResponseVisiteResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content?.toBuilder();
      _page = $v.page;
      _size = $v.size;
      _totalElements = $v.totalElements;
      _totalPages = $v.totalPages;
      _last = $v.last;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PageResponseVisiteResponse other) {
    _$v = other as _$PageResponseVisiteResponse;
  }

  @override
  void update(void Function(PageResponseVisiteResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PageResponseVisiteResponse build() => _build();

  _$PageResponseVisiteResponse _build() {
    _$PageResponseVisiteResponse _$result;
    try {
      _$result =
          _$v ??
          _$PageResponseVisiteResponse._(
            content: _content?.build(),
            page: page,
            size: size,
            totalElements: totalElements,
            totalPages: totalPages,
            last: last,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'content';
        _content?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PageResponseVisiteResponse',
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
