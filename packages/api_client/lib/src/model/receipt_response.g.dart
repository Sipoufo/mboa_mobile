// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReceiptResponse extends ReceiptResponse {
  @override
  final String? downloadUrl;

  factory _$ReceiptResponse([void Function(ReceiptResponseBuilder)? updates]) =>
      (ReceiptResponseBuilder()..update(updates))._build();

  _$ReceiptResponse._({this.downloadUrl}) : super._();
  @override
  ReceiptResponse rebuild(void Function(ReceiptResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReceiptResponseBuilder toBuilder() => ReceiptResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReceiptResponse && downloadUrl == other.downloadUrl;
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
      r'ReceiptResponse',
    )..add('downloadUrl', downloadUrl)).toString();
  }
}

class ReceiptResponseBuilder
    implements Builder<ReceiptResponse, ReceiptResponseBuilder> {
  _$ReceiptResponse? _$v;

  String? _downloadUrl;
  String? get downloadUrl => _$this._downloadUrl;
  set downloadUrl(String? downloadUrl) => _$this._downloadUrl = downloadUrl;

  ReceiptResponseBuilder() {
    ReceiptResponse._defaults(this);
  }

  ReceiptResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _downloadUrl = $v.downloadUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReceiptResponse other) {
    _$v = other as _$ReceiptResponse;
  }

  @override
  void update(void Function(ReceiptResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReceiptResponse build() => _build();

  _$ReceiptResponse _build() {
    final _$result = _$v ?? _$ReceiptResponse._(downloadUrl: downloadUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
