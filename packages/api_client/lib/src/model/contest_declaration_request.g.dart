// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contest_declaration_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ContestDeclarationRequest extends ContestDeclarationRequest {
  @override
  final String? reason;

  factory _$ContestDeclarationRequest([
    void Function(ContestDeclarationRequestBuilder)? updates,
  ]) => (ContestDeclarationRequestBuilder()..update(updates))._build();

  _$ContestDeclarationRequest._({this.reason}) : super._();
  @override
  ContestDeclarationRequest rebuild(
    void Function(ContestDeclarationRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ContestDeclarationRequestBuilder toBuilder() =>
      ContestDeclarationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContestDeclarationRequest && reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ContestDeclarationRequest',
    )..add('reason', reason)).toString();
  }
}

class ContestDeclarationRequestBuilder
    implements
        Builder<ContestDeclarationRequest, ContestDeclarationRequestBuilder> {
  _$ContestDeclarationRequest? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  ContestDeclarationRequestBuilder() {
    ContestDeclarationRequest._defaults(this);
  }

  ContestDeclarationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ContestDeclarationRequest other) {
    _$v = other as _$ContestDeclarationRequest;
  }

  @override
  void update(void Function(ContestDeclarationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ContestDeclarationRequest build() => _build();

  _$ContestDeclarationRequest _build() {
    final _$result = _$v ?? _$ContestDeclarationRequest._(reason: reason);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
