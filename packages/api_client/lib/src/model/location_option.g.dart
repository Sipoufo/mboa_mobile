// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_option.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LocationOption extends LocationOption {
  @override
  final String? id;
  @override
  final String? name;

  factory _$LocationOption([void Function(LocationOptionBuilder)? updates]) =>
      (LocationOptionBuilder()..update(updates))._build();

  _$LocationOption._({this.id, this.name}) : super._();
  @override
  LocationOption rebuild(void Function(LocationOptionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LocationOptionBuilder toBuilder() => LocationOptionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LocationOption && id == other.id && name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LocationOption')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class LocationOptionBuilder
    implements Builder<LocationOption, LocationOptionBuilder> {
  _$LocationOption? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  LocationOptionBuilder() {
    LocationOption._defaults(this);
  }

  LocationOptionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LocationOption other) {
    _$v = other as _$LocationOption;
  }

  @override
  void update(void Function(LocationOptionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LocationOption build() => _build();

  _$LocationOption _build() {
    final _$result = _$v ?? _$LocationOption._(id: id, name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
