// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookable_slots_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BookableSlotsResponseReasonEnum
_$bookableSlotsResponseReasonEnum_AGENT_NO_AVAILABILITY =
    const BookableSlotsResponseReasonEnum._('AGENT_NO_AVAILABILITY');
const BookableSlotsResponseReasonEnum
_$bookableSlotsResponseReasonEnum_ALL_DAYS_BLOCKED =
    const BookableSlotsResponseReasonEnum._('ALL_DAYS_BLOCKED');
const BookableSlotsResponseReasonEnum
_$bookableSlotsResponseReasonEnum_FULLY_BOOKED =
    const BookableSlotsResponseReasonEnum._('FULLY_BOOKED');
const BookableSlotsResponseReasonEnum
_$bookableSlotsResponseReasonEnum_unknownDefaultOpenApi =
    const BookableSlotsResponseReasonEnum._('unknownDefaultOpenApi');

BookableSlotsResponseReasonEnum _$bookableSlotsResponseReasonEnumValueOf(
  String name,
) {
  switch (name) {
    case 'AGENT_NO_AVAILABILITY':
      return _$bookableSlotsResponseReasonEnum_AGENT_NO_AVAILABILITY;
    case 'ALL_DAYS_BLOCKED':
      return _$bookableSlotsResponseReasonEnum_ALL_DAYS_BLOCKED;
    case 'FULLY_BOOKED':
      return _$bookableSlotsResponseReasonEnum_FULLY_BOOKED;
    case 'unknownDefaultOpenApi':
      return _$bookableSlotsResponseReasonEnum_unknownDefaultOpenApi;
    default:
      return _$bookableSlotsResponseReasonEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BookableSlotsResponseReasonEnum>
_$bookableSlotsResponseReasonEnumValues =
    BuiltSet<BookableSlotsResponseReasonEnum>(
      const <BookableSlotsResponseReasonEnum>[
        _$bookableSlotsResponseReasonEnum_AGENT_NO_AVAILABILITY,
        _$bookableSlotsResponseReasonEnum_ALL_DAYS_BLOCKED,
        _$bookableSlotsResponseReasonEnum_FULLY_BOOKED,
        _$bookableSlotsResponseReasonEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<BookableSlotsResponseReasonEnum>
_$bookableSlotsResponseReasonEnumSerializer =
    _$BookableSlotsResponseReasonEnumSerializer();

class _$BookableSlotsResponseReasonEnumSerializer
    implements PrimitiveSerializer<BookableSlotsResponseReasonEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'AGENT_NO_AVAILABILITY': 'AGENT_NO_AVAILABILITY',
    'ALL_DAYS_BLOCKED': 'ALL_DAYS_BLOCKED',
    'FULLY_BOOKED': 'FULLY_BOOKED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'AGENT_NO_AVAILABILITY': 'AGENT_NO_AVAILABILITY',
    'ALL_DAYS_BLOCKED': 'ALL_DAYS_BLOCKED',
    'FULLY_BOOKED': 'FULLY_BOOKED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BookableSlotsResponseReasonEnum];
  @override
  final String wireName = 'BookableSlotsResponseReasonEnum';

  @override
  Object serialize(
    Serializers serializers,
    BookableSlotsResponseReasonEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  BookableSlotsResponseReasonEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => BookableSlotsResponseReasonEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$BookableSlotsResponse extends BookableSlotsResponse {
  @override
  final BuiltList<BookableSlot>? slots;
  @override
  final BookableSlotsResponseReasonEnum? reason;

  factory _$BookableSlotsResponse([
    void Function(BookableSlotsResponseBuilder)? updates,
  ]) => (BookableSlotsResponseBuilder()..update(updates))._build();

  _$BookableSlotsResponse._({this.slots, this.reason}) : super._();
  @override
  BookableSlotsResponse rebuild(
    void Function(BookableSlotsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BookableSlotsResponseBuilder toBuilder() =>
      BookableSlotsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BookableSlotsResponse &&
        slots == other.slots &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, slots.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BookableSlotsResponse')
          ..add('slots', slots)
          ..add('reason', reason))
        .toString();
  }
}

class BookableSlotsResponseBuilder
    implements Builder<BookableSlotsResponse, BookableSlotsResponseBuilder> {
  _$BookableSlotsResponse? _$v;

  ListBuilder<BookableSlot>? _slots;
  ListBuilder<BookableSlot> get slots =>
      _$this._slots ??= ListBuilder<BookableSlot>();
  set slots(ListBuilder<BookableSlot>? slots) => _$this._slots = slots;

  BookableSlotsResponseReasonEnum? _reason;
  BookableSlotsResponseReasonEnum? get reason => _$this._reason;
  set reason(BookableSlotsResponseReasonEnum? reason) =>
      _$this._reason = reason;

  BookableSlotsResponseBuilder() {
    BookableSlotsResponse._defaults(this);
  }

  BookableSlotsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _slots = $v.slots?.toBuilder();
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BookableSlotsResponse other) {
    _$v = other as _$BookableSlotsResponse;
  }

  @override
  void update(void Function(BookableSlotsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BookableSlotsResponse build() => _build();

  _$BookableSlotsResponse _build() {
    _$BookableSlotsResponse _$result;
    try {
      _$result =
          _$v ??
          _$BookableSlotsResponse._(slots: _slots?.build(), reason: reason);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'slots';
        _slots?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'BookableSlotsResponse',
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
