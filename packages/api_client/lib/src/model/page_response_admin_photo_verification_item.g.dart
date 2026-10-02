// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response_admin_photo_verification_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PageResponseAdminPhotoVerificationItem
    extends PageResponseAdminPhotoVerificationItem {
  @override
  final BuiltList<AdminPhotoVerificationItem>? content;
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

  factory _$PageResponseAdminPhotoVerificationItem([
    void Function(PageResponseAdminPhotoVerificationItemBuilder)? updates,
  ]) => (PageResponseAdminPhotoVerificationItemBuilder()..update(updates))
      ._build();

  _$PageResponseAdminPhotoVerificationItem._({
    this.content,
    this.page,
    this.size,
    this.totalElements,
    this.totalPages,
    this.last,
  }) : super._();
  @override
  PageResponseAdminPhotoVerificationItem rebuild(
    void Function(PageResponseAdminPhotoVerificationItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PageResponseAdminPhotoVerificationItemBuilder toBuilder() =>
      PageResponseAdminPhotoVerificationItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PageResponseAdminPhotoVerificationItem &&
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
    return (newBuiltValueToStringHelper(
            r'PageResponseAdminPhotoVerificationItem',
          )
          ..add('content', content)
          ..add('page', page)
          ..add('size', size)
          ..add('totalElements', totalElements)
          ..add('totalPages', totalPages)
          ..add('last', last))
        .toString();
  }
}

class PageResponseAdminPhotoVerificationItemBuilder
    implements
        Builder<
          PageResponseAdminPhotoVerificationItem,
          PageResponseAdminPhotoVerificationItemBuilder
        > {
  _$PageResponseAdminPhotoVerificationItem? _$v;

  ListBuilder<AdminPhotoVerificationItem>? _content;
  ListBuilder<AdminPhotoVerificationItem> get content =>
      _$this._content ??= ListBuilder<AdminPhotoVerificationItem>();
  set content(ListBuilder<AdminPhotoVerificationItem>? content) =>
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

  PageResponseAdminPhotoVerificationItemBuilder() {
    PageResponseAdminPhotoVerificationItem._defaults(this);
  }

  PageResponseAdminPhotoVerificationItemBuilder get _$this {
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
  void replace(PageResponseAdminPhotoVerificationItem other) {
    _$v = other as _$PageResponseAdminPhotoVerificationItem;
  }

  @override
  void update(
    void Function(PageResponseAdminPhotoVerificationItemBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  PageResponseAdminPhotoVerificationItem build() => _build();

  _$PageResponseAdminPhotoVerificationItem _build() {
    _$PageResponseAdminPhotoVerificationItem _$result;
    try {
      _$result =
          _$v ??
          _$PageResponseAdminPhotoVerificationItem._(
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
          r'PageResponseAdminPhotoVerificationItem',
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
