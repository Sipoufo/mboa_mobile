// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_kyc_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApproveKycRequest extends ApproveKycRequest {
  @override
  final KycCorrections? corrections;

  factory _$ApproveKycRequest([
    void Function(ApproveKycRequestBuilder)? updates,
  ]) => (ApproveKycRequestBuilder()..update(updates))._build();

  _$ApproveKycRequest._({this.corrections}) : super._();
  @override
  ApproveKycRequest rebuild(void Function(ApproveKycRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApproveKycRequestBuilder toBuilder() =>
      ApproveKycRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApproveKycRequest && corrections == other.corrections;
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
      r'ApproveKycRequest',
    )..add('corrections', corrections)).toString();
  }
}

class ApproveKycRequestBuilder
    implements Builder<ApproveKycRequest, ApproveKycRequestBuilder> {
  _$ApproveKycRequest? _$v;

  KycCorrectionsBuilder? _corrections;
  KycCorrectionsBuilder get corrections =>
      _$this._corrections ??= KycCorrectionsBuilder();
  set corrections(KycCorrectionsBuilder? corrections) =>
      _$this._corrections = corrections;

  ApproveKycRequestBuilder() {
    ApproveKycRequest._defaults(this);
  }

  ApproveKycRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _corrections = $v.corrections?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApproveKycRequest other) {
    _$v = other as _$ApproveKycRequest;
  }

  @override
  void update(void Function(ApproveKycRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApproveKycRequest build() => _build();

  _$ApproveKycRequest _build() {
    _$ApproveKycRequest _$result;
    try {
      _$result =
          _$v ?? _$ApproveKycRequest._(corrections: _corrections?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'corrections';
        _corrections?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ApproveKycRequest',
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
