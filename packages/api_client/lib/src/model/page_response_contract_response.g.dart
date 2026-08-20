// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response_contract_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PageResponseContractResponse extends PageResponseContractResponse {
  @override
  final BuiltList<ContractResponse>? content;
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

  factory _$PageResponseContractResponse([
    void Function(PageResponseContractResponseBuilder)? updates,
  ]) => (PageResponseContractResponseBuilder()..update(updates))._build();

  _$PageResponseContractResponse._({
    this.content,
    this.page,
    this.size,
    this.totalElements,
    this.totalPages,
    this.last,
  }) : super._();
  @override
  PageResponseContractResponse rebuild(
    void Function(PageResponseContractResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PageResponseContractResponseBuilder toBuilder() =>
      PageResponseContractResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PageResponseContractResponse &&
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
    return (newBuiltValueToStringHelper(r'PageResponseContractResponse')
          ..add('content', content)
          ..add('page', page)
          ..add('size', size)
          ..add('totalElements', totalElements)
          ..add('totalPages', totalPages)
          ..add('last', last))
        .toString();
  }
}

class PageResponseContractResponseBuilder
    implements
        Builder<
          PageResponseContractResponse,
          PageResponseContractResponseBuilder
        > {
  _$PageResponseContractResponse? _$v;

  ListBuilder<ContractResponse>? _content;
  ListBuilder<ContractResponse> get content =>
      _$this._content ??= ListBuilder<ContractResponse>();
  set content(ListBuilder<ContractResponse>? content) =>
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

  PageResponseContractResponseBuilder() {
    PageResponseContractResponse._defaults(this);
  }

  PageResponseContractResponseBuilder get _$this {
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
  void replace(PageResponseContractResponse other) {
    _$v = other as _$PageResponseContractResponse;
  }

  @override
  void update(void Function(PageResponseContractResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PageResponseContractResponse build() => _build();

  _$PageResponseContractResponse _build() {
    _$PageResponseContractResponse _$result;
    try {
      _$result =
          _$v ??
          _$PageResponseContractResponse._(
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
          r'PageResponseContractResponse',
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
