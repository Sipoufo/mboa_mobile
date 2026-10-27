// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_nui_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddNuiRequest extends AddNuiRequest {
  @override
  final String nui;

  factory _$AddNuiRequest([void Function(AddNuiRequestBuilder)? updates]) =>
      (AddNuiRequestBuilder()..update(updates))._build();

  _$AddNuiRequest._({required this.nui}) : super._();
  @override
  AddNuiRequest rebuild(void Function(AddNuiRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddNuiRequestBuilder toBuilder() => AddNuiRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddNuiRequest && nui == other.nui;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, nui.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AddNuiRequest',
    )..add('nui', nui)).toString();
  }
}

class AddNuiRequestBuilder
    implements Builder<AddNuiRequest, AddNuiRequestBuilder> {
  _$AddNuiRequest? _$v;

  String? _nui;
  String? get nui => _$this._nui;
  set nui(String? nui) => _$this._nui = nui;

  AddNuiRequestBuilder() {
    AddNuiRequest._defaults(this);
  }

  AddNuiRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _nui = $v.nui;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddNuiRequest other) {
    _$v = other as _$AddNuiRequest;
  }

  @override
  void update(void Function(AddNuiRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddNuiRequest build() => _build();

  _$AddNuiRequest _build() {
    final _$result =
        _$v ??
        _$AddNuiRequest._(
          nui: BuiltValueNullFieldError.checkNotNull(
            nui,
            r'AddNuiRequest',
            'nui',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
