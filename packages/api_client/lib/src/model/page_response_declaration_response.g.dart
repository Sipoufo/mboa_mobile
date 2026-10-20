// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response_declaration_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PageResponseDeclarationResponse
    extends PageResponseDeclarationResponse {
  @override
  final BuiltList<DeclarationResponse>? content;
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

  factory _$PageResponseDeclarationResponse([
    void Function(PageResponseDeclarationResponseBuilder)? updates,
  ]) => (PageResponseDeclarationResponseBuilder()..update(updates))._build();

  _$PageResponseDeclarationResponse._({
    this.content,
    this.page,
    this.size,
    this.totalElements,
    this.totalPages,
    this.last,
  }) : super._();
  @override
  PageResponseDeclarationResponse rebuild(
    void Function(PageResponseDeclarationResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PageResponseDeclarationResponseBuilder toBuilder() =>
      PageResponseDeclarationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PageResponseDeclarationResponse &&
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
    return (newBuiltValueToStringHelper(r'PageResponseDeclarationResponse')
          ..add('content', content)
          ..add('page', page)
          ..add('size', size)
          ..add('totalElements', totalElements)
          ..add('totalPages', totalPages)
          ..add('last', last))
        .toString();
  }
}

class PageResponseDeclarationResponseBuilder
    implements
        Builder<
          PageResponseDeclarationResponse,
          PageResponseDeclarationResponseBuilder
        > {
  _$PageResponseDeclarationResponse? _$v;

  ListBuilder<DeclarationResponse>? _content;
  ListBuilder<DeclarationResponse> get content =>
      _$this._content ??= ListBuilder<DeclarationResponse>();
  set content(ListBuilder<DeclarationResponse>? content) =>
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

  PageResponseDeclarationResponseBuilder() {
    PageResponseDeclarationResponse._defaults(this);
  }

  PageResponseDeclarationResponseBuilder get _$this {
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
  void replace(PageResponseDeclarationResponse other) {
    _$v = other as _$PageResponseDeclarationResponse;
  }

  @override
  void update(void Function(PageResponseDeclarationResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PageResponseDeclarationResponse build() => _build();

  _$PageResponseDeclarationResponse _build() {
    _$PageResponseDeclarationResponse _$result;
    try {
      _$result =
          _$v ??
          _$PageResponseDeclarationResponse._(
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
          r'PageResponseDeclarationResponse',
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
