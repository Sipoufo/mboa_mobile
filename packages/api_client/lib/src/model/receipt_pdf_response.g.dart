// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_pdf_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReceiptPdfResponse extends ReceiptPdfResponse {
  @override
  final String? downloadUrl;

  factory _$ReceiptPdfResponse([
    void Function(ReceiptPdfResponseBuilder)? updates,
  ]) => (ReceiptPdfResponseBuilder()..update(updates))._build();

  _$ReceiptPdfResponse._({this.downloadUrl}) : super._();
  @override
  ReceiptPdfResponse rebuild(
    void Function(ReceiptPdfResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReceiptPdfResponseBuilder toBuilder() =>
      ReceiptPdfResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReceiptPdfResponse && downloadUrl == other.downloadUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, downloadUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ReceiptPdfResponse',
    )..add('downloadUrl', downloadUrl)).toString();
  }
}

class ReceiptPdfResponseBuilder
    implements Builder<ReceiptPdfResponse, ReceiptPdfResponseBuilder> {
  _$ReceiptPdfResponse? _$v;

  String? _downloadUrl;
  String? get downloadUrl => _$this._downloadUrl;
  set downloadUrl(String? downloadUrl) => _$this._downloadUrl = downloadUrl;

  ReceiptPdfResponseBuilder() {
    ReceiptPdfResponse._defaults(this);
  }

  ReceiptPdfResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _downloadUrl = $v.downloadUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReceiptPdfResponse other) {
    _$v = other as _$ReceiptPdfResponse;
  }

  @override
  void update(void Function(ReceiptPdfResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReceiptPdfResponse build() => _build();

  _$ReceiptPdfResponse _build() {
    final _$result = _$v ?? _$ReceiptPdfResponse._(downloadUrl: downloadUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
