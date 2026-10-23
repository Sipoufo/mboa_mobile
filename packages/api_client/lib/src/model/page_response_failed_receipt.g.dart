// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response_failed_receipt.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PageResponseFailedReceipt extends PageResponseFailedReceipt {
  @override
  final BuiltList<FailedReceipt>? content;
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

  factory _$PageResponseFailedReceipt([
    void Function(PageResponseFailedReceiptBuilder)? updates,
  ]) => (PageResponseFailedReceiptBuilder()..update(updates))._build();

  _$PageResponseFailedReceipt._({
    this.content,
    this.page,
    this.size,
    this.totalElements,
    this.totalPages,
    this.last,
  }) : super._();
  @override
  PageResponseFailedReceipt rebuild(
    void Function(PageResponseFailedReceiptBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PageResponseFailedReceiptBuilder toBuilder() =>
      PageResponseFailedReceiptBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PageResponseFailedReceipt &&
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
    return (newBuiltValueToStringHelper(r'PageResponseFailedReceipt')
          ..add('content', content)
          ..add('page', page)
          ..add('size', size)
          ..add('totalElements', totalElements)
          ..add('totalPages', totalPages)
          ..add('last', last))
        .toString();
  }
}

class PageResponseFailedReceiptBuilder
    implements
        Builder<PageResponseFailedReceipt, PageResponseFailedReceiptBuilder> {
  _$PageResponseFailedReceipt? _$v;

  ListBuilder<FailedReceipt>? _content;
  ListBuilder<FailedReceipt> get content =>
      _$this._content ??= ListBuilder<FailedReceipt>();
  set content(ListBuilder<FailedReceipt>? content) => _$this._content = content;

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

  PageResponseFailedReceiptBuilder() {
    PageResponseFailedReceipt._defaults(this);
  }

  PageResponseFailedReceiptBuilder get _$this {
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
  void replace(PageResponseFailedReceipt other) {
    _$v = other as _$PageResponseFailedReceipt;
  }

  @override
  void update(void Function(PageResponseFailedReceiptBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PageResponseFailedReceipt build() => _build();

  _$PageResponseFailedReceipt _build() {
    _$PageResponseFailedReceipt _$result;
    try {
      _$result =
          _$v ??
          _$PageResponseFailedReceipt._(
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
          r'PageResponseFailedReceipt',
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
