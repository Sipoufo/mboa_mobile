// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_day_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BlockDayRequest extends BlockDayRequest {
  @override
  final Date day;

  factory _$BlockDayRequest([void Function(BlockDayRequestBuilder)? updates]) =>
      (BlockDayRequestBuilder()..update(updates))._build();

  _$BlockDayRequest._({required this.day}) : super._();
  @override
  BlockDayRequest rebuild(void Function(BlockDayRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BlockDayRequestBuilder toBuilder() => BlockDayRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BlockDayRequest && day == other.day;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, day.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'BlockDayRequest',
    )..add('day', day)).toString();
  }
}

class BlockDayRequestBuilder
    implements Builder<BlockDayRequest, BlockDayRequestBuilder> {
  _$BlockDayRequest? _$v;

  Date? _day;
  Date? get day => _$this._day;
  set day(Date? day) => _$this._day = day;

  BlockDayRequestBuilder() {
    BlockDayRequest._defaults(this);
  }

  BlockDayRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _day = $v.day;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BlockDayRequest other) {
    _$v = other as _$BlockDayRequest;
  }

  @override
  void update(void Function(BlockDayRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BlockDayRequest build() => _build();

  _$BlockDayRequest _build() {
    final _$result =
        _$v ??
        _$BlockDayRequest._(
          day: BuiltValueNullFieldError.checkNotNull(
            day,
            r'BlockDayRequest',
            'day',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
