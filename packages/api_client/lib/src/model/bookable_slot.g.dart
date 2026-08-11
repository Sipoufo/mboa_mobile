// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookable_slot.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BookableSlot extends BookableSlot {
  @override
  final DateTime? startsAt;
  @override
  final DateTime? endsAt;

  factory _$BookableSlot([void Function(BookableSlotBuilder)? updates]) =>
      (BookableSlotBuilder()..update(updates))._build();

  _$BookableSlot._({this.startsAt, this.endsAt}) : super._();
  @override
  BookableSlot rebuild(void Function(BookableSlotBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BookableSlotBuilder toBuilder() => BookableSlotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BookableSlot &&
        startsAt == other.startsAt &&
        endsAt == other.endsAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, startsAt.hashCode);
    _$hash = $jc(_$hash, endsAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BookableSlot')
          ..add('startsAt', startsAt)
          ..add('endsAt', endsAt))
        .toString();
  }
}

class BookableSlotBuilder
    implements Builder<BookableSlot, BookableSlotBuilder> {
  _$BookableSlot? _$v;

  DateTime? _startsAt;
  DateTime? get startsAt => _$this._startsAt;
  set startsAt(DateTime? startsAt) => _$this._startsAt = startsAt;

  DateTime? _endsAt;
  DateTime? get endsAt => _$this._endsAt;
  set endsAt(DateTime? endsAt) => _$this._endsAt = endsAt;

  BookableSlotBuilder() {
    BookableSlot._defaults(this);
  }

  BookableSlotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _startsAt = $v.startsAt;
      _endsAt = $v.endsAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BookableSlot other) {
    _$v = other as _$BookableSlot;
  }

  @override
  void update(void Function(BookableSlotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BookableSlot build() => _build();

  _$BookableSlot _build() {
    final _$result =
        _$v ?? _$BookableSlot._(startsAt: startsAt, endsAt: endsAt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
