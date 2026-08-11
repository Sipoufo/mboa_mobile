// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BatchResult extends BatchResult {
  @override
  final int? count;

  factory _$BatchResult([void Function(BatchResultBuilder)? updates]) =>
      (BatchResultBuilder()..update(updates))._build();

  _$BatchResult._({this.count}) : super._();
  @override
  BatchResult rebuild(void Function(BatchResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BatchResultBuilder toBuilder() => BatchResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BatchResult && count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'BatchResult',
    )..add('count', count)).toString();
  }
}

class BatchResultBuilder implements Builder<BatchResult, BatchResultBuilder> {
  _$BatchResult? _$v;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  BatchResultBuilder() {
    BatchResult._defaults(this);
  }

  BatchResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BatchResult other) {
    _$v = other as _$BatchResult;
  }

  @override
  void update(void Function(BatchResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BatchResult build() => _build();

  _$BatchResult _build() {
    final _$result = _$v ?? _$BatchResult._(count: count);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
