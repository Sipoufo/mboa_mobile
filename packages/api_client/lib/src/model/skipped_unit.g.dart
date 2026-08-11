// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skipped_unit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SkippedUnit extends SkippedUnit {
  @override
  final String? annonceId;
  @override
  final String? title;
  @override
  final String? reason;

  factory _$SkippedUnit([void Function(SkippedUnitBuilder)? updates]) =>
      (SkippedUnitBuilder()..update(updates))._build();

  _$SkippedUnit._({this.annonceId, this.title, this.reason}) : super._();
  @override
  SkippedUnit rebuild(void Function(SkippedUnitBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SkippedUnitBuilder toBuilder() => SkippedUnitBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SkippedUnit &&
        annonceId == other.annonceId &&
        title == other.title &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SkippedUnit')
          ..add('annonceId', annonceId)
          ..add('title', title)
          ..add('reason', reason))
        .toString();
  }
}

class SkippedUnitBuilder implements Builder<SkippedUnit, SkippedUnitBuilder> {
  _$SkippedUnit? _$v;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  SkippedUnitBuilder() {
    SkippedUnit._defaults(this);
  }

  SkippedUnitBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _annonceId = $v.annonceId;
      _title = $v.title;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SkippedUnit other) {
    _$v = other as _$SkippedUnit;
  }

  @override
  void update(void Function(SkippedUnitBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SkippedUnit build() => _build();

  _$SkippedUnit _build() {
    final _$result =
        _$v ??
        _$SkippedUnit._(annonceId: annonceId, title: title, reason: reason);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
