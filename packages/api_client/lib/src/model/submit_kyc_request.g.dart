// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_kyc_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SubmitKycRequest extends SubmitKycRequest {
  @override
  final String idDocumentFrontKey;
  @override
  final String idDocumentBackKey;
  @override
  final String selfieKey;

  factory _$SubmitKycRequest([
    void Function(SubmitKycRequestBuilder)? updates,
  ]) => (SubmitKycRequestBuilder()..update(updates))._build();

  _$SubmitKycRequest._({
    required this.idDocumentFrontKey,
    required this.idDocumentBackKey,
    required this.selfieKey,
  }) : super._();
  @override
  SubmitKycRequest rebuild(void Function(SubmitKycRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubmitKycRequestBuilder toBuilder() =>
      SubmitKycRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubmitKycRequest &&
        idDocumentFrontKey == other.idDocumentFrontKey &&
        idDocumentBackKey == other.idDocumentBackKey &&
        selfieKey == other.selfieKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, idDocumentFrontKey.hashCode);
    _$hash = $jc(_$hash, idDocumentBackKey.hashCode);
    _$hash = $jc(_$hash, selfieKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubmitKycRequest')
          ..add('idDocumentFrontKey', idDocumentFrontKey)
          ..add('idDocumentBackKey', idDocumentBackKey)
          ..add('selfieKey', selfieKey))
        .toString();
  }
}

class SubmitKycRequestBuilder
    implements Builder<SubmitKycRequest, SubmitKycRequestBuilder> {
  _$SubmitKycRequest? _$v;

  String? _idDocumentFrontKey;
  String? get idDocumentFrontKey => _$this._idDocumentFrontKey;
  set idDocumentFrontKey(String? idDocumentFrontKey) =>
      _$this._idDocumentFrontKey = idDocumentFrontKey;

  String? _idDocumentBackKey;
  String? get idDocumentBackKey => _$this._idDocumentBackKey;
  set idDocumentBackKey(String? idDocumentBackKey) =>
      _$this._idDocumentBackKey = idDocumentBackKey;

  String? _selfieKey;
  String? get selfieKey => _$this._selfieKey;
  set selfieKey(String? selfieKey) => _$this._selfieKey = selfieKey;

  SubmitKycRequestBuilder() {
    SubmitKycRequest._defaults(this);
  }

  SubmitKycRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _idDocumentFrontKey = $v.idDocumentFrontKey;
      _idDocumentBackKey = $v.idDocumentBackKey;
      _selfieKey = $v.selfieKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubmitKycRequest other) {
    _$v = other as _$SubmitKycRequest;
  }

  @override
  void update(void Function(SubmitKycRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubmitKycRequest build() => _build();

  _$SubmitKycRequest _build() {
    final _$result =
        _$v ??
        _$SubmitKycRequest._(
          idDocumentFrontKey: BuiltValueNullFieldError.checkNotNull(
            idDocumentFrontKey,
            r'SubmitKycRequest',
            'idDocumentFrontKey',
          ),
          idDocumentBackKey: BuiltValueNullFieldError.checkNotNull(
            idDocumentBackKey,
            r'SubmitKycRequest',
            'idDocumentBackKey',
          ),
          selfieKey: BuiltValueNullFieldError.checkNotNull(
            selfieKey,
            r'SubmitKycRequest',
            'selfieKey',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
