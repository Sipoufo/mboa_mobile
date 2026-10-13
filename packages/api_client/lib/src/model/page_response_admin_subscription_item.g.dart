// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response_admin_subscription_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PageResponseAdminSubscriptionItem
    extends PageResponseAdminSubscriptionItem {
  @override
  final BuiltList<AdminSubscriptionItem>? content;
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

  factory _$PageResponseAdminSubscriptionItem([
    void Function(PageResponseAdminSubscriptionItemBuilder)? updates,
  ]) => (PageResponseAdminSubscriptionItemBuilder()..update(updates))._build();

  _$PageResponseAdminSubscriptionItem._({
    this.content,
    this.page,
    this.size,
    this.totalElements,
    this.totalPages,
    this.last,
  }) : super._();
  @override
  PageResponseAdminSubscriptionItem rebuild(
    void Function(PageResponseAdminSubscriptionItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PageResponseAdminSubscriptionItemBuilder toBuilder() =>
      PageResponseAdminSubscriptionItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PageResponseAdminSubscriptionItem &&
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
    return (newBuiltValueToStringHelper(r'PageResponseAdminSubscriptionItem')
          ..add('content', content)
          ..add('page', page)
          ..add('size', size)
          ..add('totalElements', totalElements)
          ..add('totalPages', totalPages)
          ..add('last', last))
        .toString();
  }
}

class PageResponseAdminSubscriptionItemBuilder
    implements
        Builder<
          PageResponseAdminSubscriptionItem,
          PageResponseAdminSubscriptionItemBuilder
        > {
  _$PageResponseAdminSubscriptionItem? _$v;

  ListBuilder<AdminSubscriptionItem>? _content;
  ListBuilder<AdminSubscriptionItem> get content =>
      _$this._content ??= ListBuilder<AdminSubscriptionItem>();
  set content(ListBuilder<AdminSubscriptionItem>? content) =>
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

  PageResponseAdminSubscriptionItemBuilder() {
    PageResponseAdminSubscriptionItem._defaults(this);
  }

  PageResponseAdminSubscriptionItemBuilder get _$this {
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
  void replace(PageResponseAdminSubscriptionItem other) {
    _$v = other as _$PageResponseAdminSubscriptionItem;
  }

  @override
  void update(
    void Function(PageResponseAdminSubscriptionItemBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  PageResponseAdminSubscriptionItem build() => _build();

  _$PageResponseAdminSubscriptionItem _build() {
    _$PageResponseAdminSubscriptionItem _$result;
    try {
      _$result =
          _$v ??
          _$PageResponseAdminSubscriptionItem._(
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
          r'PageResponseAdminSubscriptionItem',
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
