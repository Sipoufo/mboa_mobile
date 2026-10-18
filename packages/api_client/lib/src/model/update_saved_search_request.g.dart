// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_saved_search_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateSavedSearchRequest extends UpdateSavedSearchRequest {
  @override
  final String? name;
  @override
  final bool? alertsEnabled;

  factory _$UpdateSavedSearchRequest([
    void Function(UpdateSavedSearchRequestBuilder)? updates,
  ]) => (UpdateSavedSearchRequestBuilder()..update(updates))._build();

  _$UpdateSavedSearchRequest._({this.name, this.alertsEnabled}) : super._();
  @override
  UpdateSavedSearchRequest rebuild(
    void Function(UpdateSavedSearchRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateSavedSearchRequestBuilder toBuilder() =>
      UpdateSavedSearchRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateSavedSearchRequest &&
        name == other.name &&
        alertsEnabled == other.alertsEnabled;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, alertsEnabled.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateSavedSearchRequest')
          ..add('name', name)
          ..add('alertsEnabled', alertsEnabled))
        .toString();
  }
}

class UpdateSavedSearchRequestBuilder
    implements
        Builder<UpdateSavedSearchRequest, UpdateSavedSearchRequestBuilder> {
  _$UpdateSavedSearchRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  bool? _alertsEnabled;
  bool? get alertsEnabled => _$this._alertsEnabled;
  set alertsEnabled(bool? alertsEnabled) =>
      _$this._alertsEnabled = alertsEnabled;

  UpdateSavedSearchRequestBuilder() {
    UpdateSavedSearchRequest._defaults(this);
  }

  UpdateSavedSearchRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _alertsEnabled = $v.alertsEnabled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateSavedSearchRequest other) {
    _$v = other as _$UpdateSavedSearchRequest;
  }

  @override
  void update(void Function(UpdateSavedSearchRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateSavedSearchRequest build() => _build();

  _$UpdateSavedSearchRequest _build() {
    final _$result =
        _$v ??
        _$UpdateSavedSearchRequest._(name: name, alertsEnabled: alertsEnabled);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
