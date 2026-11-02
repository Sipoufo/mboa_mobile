// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_kyc_document_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConfirmKycDocumentRequest extends ConfirmKycDocumentRequest {
  @override
  final KycCorrections? corrections;

  factory _$ConfirmKycDocumentRequest([
    void Function(ConfirmKycDocumentRequestBuilder)? updates,
  ]) => (ConfirmKycDocumentRequestBuilder()..update(updates))._build();

  _$ConfirmKycDocumentRequest._({this.corrections}) : super._();
  @override
  ConfirmKycDocumentRequest rebuild(
    void Function(ConfirmKycDocumentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ConfirmKycDocumentRequestBuilder toBuilder() =>
      ConfirmKycDocumentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfirmKycDocumentRequest &&
        corrections == other.corrections;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, corrections.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ConfirmKycDocumentRequest',
    )..add('corrections', corrections)).toString();
  }
}

class ConfirmKycDocumentRequestBuilder
    implements
        Builder<ConfirmKycDocumentRequest, ConfirmKycDocumentRequestBuilder> {
  _$ConfirmKycDocumentRequest? _$v;

  KycCorrectionsBuilder? _corrections;
  KycCorrectionsBuilder get corrections =>
      _$this._corrections ??= KycCorrectionsBuilder();
  set corrections(KycCorrectionsBuilder? corrections) =>
      _$this._corrections = corrections;

  ConfirmKycDocumentRequestBuilder() {
    ConfirmKycDocumentRequest._defaults(this);
  }

  ConfirmKycDocumentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _corrections = $v.corrections?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfirmKycDocumentRequest other) {
    _$v = other as _$ConfirmKycDocumentRequest;
  }

  @override
  void update(void Function(ConfirmKycDocumentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfirmKycDocumentRequest build() => _build();

  _$ConfirmKycDocumentRequest _build() {
    _$ConfirmKycDocumentRequest _$result;
    try {
      _$result =
          _$v ??
          _$ConfirmKycDocumentRequest._(corrections: _corrections?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'corrections';
        _corrections?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ConfirmKycDocumentRequest',
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
