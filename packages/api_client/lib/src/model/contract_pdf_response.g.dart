// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_pdf_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ContractPdfResponse extends ContractPdfResponse {
  @override
  final String? downloadUrl;

  factory _$ContractPdfResponse([
    void Function(ContractPdfResponseBuilder)? updates,
  ]) => (ContractPdfResponseBuilder()..update(updates))._build();

  _$ContractPdfResponse._({this.downloadUrl}) : super._();
  @override
  ContractPdfResponse rebuild(
    void Function(ContractPdfResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ContractPdfResponseBuilder toBuilder() =>
      ContractPdfResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContractPdfResponse && downloadUrl == other.downloadUrl;
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
      r'ContractPdfResponse',
    )..add('downloadUrl', downloadUrl)).toString();
  }
}

class ContractPdfResponseBuilder
    implements Builder<ContractPdfResponse, ContractPdfResponseBuilder> {
  _$ContractPdfResponse? _$v;

  String? _downloadUrl;
  String? get downloadUrl => _$this._downloadUrl;
  set downloadUrl(String? downloadUrl) => _$this._downloadUrl = downloadUrl;

  ContractPdfResponseBuilder() {
    ContractPdfResponse._defaults(this);
  }

  ContractPdfResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _downloadUrl = $v.downloadUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ContractPdfResponse other) {
    _$v = other as _$ContractPdfResponse;
  }

  @override
  void update(void Function(ContractPdfResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ContractPdfResponse build() => _build();

  _$ContractPdfResponse _build() {
    final _$result = _$v ?? _$ContractPdfResponse._(downloadUrl: downloadUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
