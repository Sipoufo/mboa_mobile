// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CountryResponse extends CountryResponse {
  @override
  final String? id;
  @override
  final String? code;
  @override
  final String? name;

  factory _$CountryResponse([void Function(CountryResponseBuilder)? updates]) =>
      (CountryResponseBuilder()..update(updates))._build();

  _$CountryResponse._({this.id, this.code, this.name}) : super._();
  @override
  CountryResponse rebuild(void Function(CountryResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CountryResponseBuilder toBuilder() => CountryResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CountryResponse &&
        id == other.id &&
        code == other.code &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CountryResponse')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name))
        .toString();
  }
}

class CountryResponseBuilder
    implements Builder<CountryResponse, CountryResponseBuilder> {
  _$CountryResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  CountryResponseBuilder() {
    CountryResponse._defaults(this);
  }

  CountryResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CountryResponse other) {
    _$v = other as _$CountryResponse;
  }

  @override
  void update(void Function(CountryResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CountryResponse build() => _build();

  _$CountryResponse _build() {
    final _$result = _$v ?? _$CountryResponse._(id: id, code: code, name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
