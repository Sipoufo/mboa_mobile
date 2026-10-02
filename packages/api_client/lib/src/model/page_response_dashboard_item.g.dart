// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response_dashboard_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PageResponseDashboardItem extends PageResponseDashboardItem {
  @override
  final BuiltList<DashboardItem>? content;
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

  factory _$PageResponseDashboardItem([
    void Function(PageResponseDashboardItemBuilder)? updates,
  ]) => (PageResponseDashboardItemBuilder()..update(updates))._build();

  _$PageResponseDashboardItem._({
    this.content,
    this.page,
    this.size,
    this.totalElements,
    this.totalPages,
    this.last,
  }) : super._();
  @override
  PageResponseDashboardItem rebuild(
    void Function(PageResponseDashboardItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PageResponseDashboardItemBuilder toBuilder() =>
      PageResponseDashboardItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PageResponseDashboardItem &&
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
    return (newBuiltValueToStringHelper(r'PageResponseDashboardItem')
          ..add('content', content)
          ..add('page', page)
          ..add('size', size)
          ..add('totalElements', totalElements)
          ..add('totalPages', totalPages)
          ..add('last', last))
        .toString();
  }
}

class PageResponseDashboardItemBuilder
    implements
        Builder<PageResponseDashboardItem, PageResponseDashboardItemBuilder> {
  _$PageResponseDashboardItem? _$v;

  ListBuilder<DashboardItem>? _content;
  ListBuilder<DashboardItem> get content =>
      _$this._content ??= ListBuilder<DashboardItem>();
  set content(ListBuilder<DashboardItem>? content) => _$this._content = content;

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

  PageResponseDashboardItemBuilder() {
    PageResponseDashboardItem._defaults(this);
  }

  PageResponseDashboardItemBuilder get _$this {
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
  void replace(PageResponseDashboardItem other) {
    _$v = other as _$PageResponseDashboardItem;
  }

  @override
  void update(void Function(PageResponseDashboardItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PageResponseDashboardItem build() => _build();

  _$PageResponseDashboardItem _build() {
    _$PageResponseDashboardItem _$result;
    try {
      _$result =
          _$v ??
          _$PageResponseDashboardItem._(
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
          r'PageResponseDashboardItem',
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
