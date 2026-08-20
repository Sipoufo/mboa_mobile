// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_slots.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const VisitorSlotsVisitorKindEnum _$visitorSlotsVisitorKindEnum_AGENT =
    const VisitorSlotsVisitorKindEnum._('AGENT');
const VisitorSlotsVisitorKindEnum _$visitorSlotsVisitorKindEnum_OWNER =
    const VisitorSlotsVisitorKindEnum._('OWNER');
const VisitorSlotsVisitorKindEnum
_$visitorSlotsVisitorKindEnum_unknownDefaultOpenApi =
    const VisitorSlotsVisitorKindEnum._('unknownDefaultOpenApi');

VisitorSlotsVisitorKindEnum _$visitorSlotsVisitorKindEnumValueOf(String name) {
  switch (name) {
    case 'AGENT':
      return _$visitorSlotsVisitorKindEnum_AGENT;
    case 'OWNER':
      return _$visitorSlotsVisitorKindEnum_OWNER;
    case 'unknownDefaultOpenApi':
      return _$visitorSlotsVisitorKindEnum_unknownDefaultOpenApi;
    default:
      return _$visitorSlotsVisitorKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<VisitorSlotsVisitorKindEnum>
_$visitorSlotsVisitorKindEnumValues =
    BuiltSet<VisitorSlotsVisitorKindEnum>(const <VisitorSlotsVisitorKindEnum>[
      _$visitorSlotsVisitorKindEnum_AGENT,
      _$visitorSlotsVisitorKindEnum_OWNER,
      _$visitorSlotsVisitorKindEnum_unknownDefaultOpenApi,
    ]);

const VisitorSlotsModeEnum _$visitorSlotsModeEnum_SLOTS =
    const VisitorSlotsModeEnum._('SLOTS');
const VisitorSlotsModeEnum _$visitorSlotsModeEnum_ON_REQUEST =
    const VisitorSlotsModeEnum._('ON_REQUEST');
const VisitorSlotsModeEnum _$visitorSlotsModeEnum_unknownDefaultOpenApi =
    const VisitorSlotsModeEnum._('unknownDefaultOpenApi');

VisitorSlotsModeEnum _$visitorSlotsModeEnumValueOf(String name) {
  switch (name) {
    case 'SLOTS':
      return _$visitorSlotsModeEnum_SLOTS;
    case 'ON_REQUEST':
      return _$visitorSlotsModeEnum_ON_REQUEST;
    case 'unknownDefaultOpenApi':
      return _$visitorSlotsModeEnum_unknownDefaultOpenApi;
    default:
      return _$visitorSlotsModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<VisitorSlotsModeEnum> _$visitorSlotsModeEnumValues =
    BuiltSet<VisitorSlotsModeEnum>(const <VisitorSlotsModeEnum>[
      _$visitorSlotsModeEnum_SLOTS,
      _$visitorSlotsModeEnum_ON_REQUEST,
      _$visitorSlotsModeEnum_unknownDefaultOpenApi,
    ]);

const VisitorSlotsReasonEnum _$visitorSlotsReasonEnum_AGENT_NO_AVAILABILITY =
    const VisitorSlotsReasonEnum._('AGENT_NO_AVAILABILITY');
const VisitorSlotsReasonEnum _$visitorSlotsReasonEnum_ALL_DAYS_BLOCKED =
    const VisitorSlotsReasonEnum._('ALL_DAYS_BLOCKED');
const VisitorSlotsReasonEnum _$visitorSlotsReasonEnum_FULLY_BOOKED =
    const VisitorSlotsReasonEnum._('FULLY_BOOKED');
const VisitorSlotsReasonEnum _$visitorSlotsReasonEnum_unknownDefaultOpenApi =
    const VisitorSlotsReasonEnum._('unknownDefaultOpenApi');

VisitorSlotsReasonEnum _$visitorSlotsReasonEnumValueOf(String name) {
  switch (name) {
    case 'AGENT_NO_AVAILABILITY':
      return _$visitorSlotsReasonEnum_AGENT_NO_AVAILABILITY;
    case 'ALL_DAYS_BLOCKED':
      return _$visitorSlotsReasonEnum_ALL_DAYS_BLOCKED;
    case 'FULLY_BOOKED':
      return _$visitorSlotsReasonEnum_FULLY_BOOKED;
    case 'unknownDefaultOpenApi':
      return _$visitorSlotsReasonEnum_unknownDefaultOpenApi;
    default:
      return _$visitorSlotsReasonEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<VisitorSlotsReasonEnum> _$visitorSlotsReasonEnumValues =
    BuiltSet<VisitorSlotsReasonEnum>(const <VisitorSlotsReasonEnum>[
      _$visitorSlotsReasonEnum_AGENT_NO_AVAILABILITY,
      _$visitorSlotsReasonEnum_ALL_DAYS_BLOCKED,
      _$visitorSlotsReasonEnum_FULLY_BOOKED,
      _$visitorSlotsReasonEnum_unknownDefaultOpenApi,
    ]);

Serializer<VisitorSlotsVisitorKindEnum>
_$visitorSlotsVisitorKindEnumSerializer =
    _$VisitorSlotsVisitorKindEnumSerializer();
Serializer<VisitorSlotsModeEnum> _$visitorSlotsModeEnumSerializer =
    _$VisitorSlotsModeEnumSerializer();
Serializer<VisitorSlotsReasonEnum> _$visitorSlotsReasonEnumSerializer =
    _$VisitorSlotsReasonEnumSerializer();

class _$VisitorSlotsVisitorKindEnumSerializer
    implements PrimitiveSerializer<VisitorSlotsVisitorKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'AGENT': 'AGENT',
    'OWNER': 'OWNER',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'AGENT': 'AGENT',
    'OWNER': 'OWNER',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[VisitorSlotsVisitorKindEnum];
  @override
  final String wireName = 'VisitorSlotsVisitorKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    VisitorSlotsVisitorKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  VisitorSlotsVisitorKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => VisitorSlotsVisitorKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$VisitorSlotsModeEnumSerializer
    implements PrimitiveSerializer<VisitorSlotsModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'SLOTS': 'SLOTS',
    'ON_REQUEST': 'ON_REQUEST',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'SLOTS': 'SLOTS',
    'ON_REQUEST': 'ON_REQUEST',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[VisitorSlotsModeEnum];
  @override
  final String wireName = 'VisitorSlotsModeEnum';

  @override
  Object serialize(
    Serializers serializers,
    VisitorSlotsModeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  VisitorSlotsModeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => VisitorSlotsModeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$VisitorSlotsReasonEnumSerializer
    implements PrimitiveSerializer<VisitorSlotsReasonEnum> {
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
  final Iterable<Type> types = const <Type>[VisitorSlotsReasonEnum];
  @override
  final String wireName = 'VisitorSlotsReasonEnum';

  @override
  Object serialize(
    Serializers serializers,
    VisitorSlotsReasonEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  VisitorSlotsReasonEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => VisitorSlotsReasonEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$VisitorSlots extends VisitorSlots {
  @override
  final String? visitorAccountId;
  @override
  final VisitorSlotsVisitorKindEnum? visitorKind;
  @override
  final String? displayName;
  @override
  final String? photoObjectKey;
  @override
  final int? completedVisitCount;
  @override
  final double? averageRating;
  @override
  final int? ratingCount;
  @override
  final VisitorSlotsModeEnum? mode;
  @override
  final BuiltList<BookableSlot>? slots;
  @override
  final VisitorSlotsReasonEnum? reason;

  factory _$VisitorSlots([void Function(VisitorSlotsBuilder)? updates]) =>
      (VisitorSlotsBuilder()..update(updates))._build();

  _$VisitorSlots._({
    this.visitorAccountId,
    this.visitorKind,
    this.displayName,
    this.photoObjectKey,
    this.completedVisitCount,
    this.averageRating,
    this.ratingCount,
    this.mode,
    this.slots,
    this.reason,
  }) : super._();
  @override
  VisitorSlots rebuild(void Function(VisitorSlotsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VisitorSlotsBuilder toBuilder() => VisitorSlotsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VisitorSlots &&
        visitorAccountId == other.visitorAccountId &&
        visitorKind == other.visitorKind &&
        displayName == other.displayName &&
        photoObjectKey == other.photoObjectKey &&
        completedVisitCount == other.completedVisitCount &&
        averageRating == other.averageRating &&
        ratingCount == other.ratingCount &&
        mode == other.mode &&
        slots == other.slots &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, visitorAccountId.hashCode);
    _$hash = $jc(_$hash, visitorKind.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, photoObjectKey.hashCode);
    _$hash = $jc(_$hash, completedVisitCount.hashCode);
    _$hash = $jc(_$hash, averageRating.hashCode);
    _$hash = $jc(_$hash, ratingCount.hashCode);
    _$hash = $jc(_$hash, mode.hashCode);
    _$hash = $jc(_$hash, slots.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VisitorSlots')
          ..add('visitorAccountId', visitorAccountId)
          ..add('visitorKind', visitorKind)
          ..add('displayName', displayName)
          ..add('photoObjectKey', photoObjectKey)
          ..add('completedVisitCount', completedVisitCount)
          ..add('averageRating', averageRating)
          ..add('ratingCount', ratingCount)
          ..add('mode', mode)
          ..add('slots', slots)
          ..add('reason', reason))
        .toString();
  }
}

class VisitorSlotsBuilder
    implements Builder<VisitorSlots, VisitorSlotsBuilder> {
  _$VisitorSlots? _$v;

  String? _visitorAccountId;
  String? get visitorAccountId => _$this._visitorAccountId;
  set visitorAccountId(String? visitorAccountId) =>
      _$this._visitorAccountId = visitorAccountId;

  VisitorSlotsVisitorKindEnum? _visitorKind;
  VisitorSlotsVisitorKindEnum? get visitorKind => _$this._visitorKind;
  set visitorKind(VisitorSlotsVisitorKindEnum? visitorKind) =>
      _$this._visitorKind = visitorKind;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _photoObjectKey;
  String? get photoObjectKey => _$this._photoObjectKey;
  set photoObjectKey(String? photoObjectKey) =>
      _$this._photoObjectKey = photoObjectKey;

  int? _completedVisitCount;
  int? get completedVisitCount => _$this._completedVisitCount;
  set completedVisitCount(int? completedVisitCount) =>
      _$this._completedVisitCount = completedVisitCount;

  double? _averageRating;
  double? get averageRating => _$this._averageRating;
  set averageRating(double? averageRating) =>
      _$this._averageRating = averageRating;

  int? _ratingCount;
  int? get ratingCount => _$this._ratingCount;
  set ratingCount(int? ratingCount) => _$this._ratingCount = ratingCount;

  VisitorSlotsModeEnum? _mode;
  VisitorSlotsModeEnum? get mode => _$this._mode;
  set mode(VisitorSlotsModeEnum? mode) => _$this._mode = mode;

  ListBuilder<BookableSlot>? _slots;
  ListBuilder<BookableSlot> get slots =>
      _$this._slots ??= ListBuilder<BookableSlot>();
  set slots(ListBuilder<BookableSlot>? slots) => _$this._slots = slots;

  VisitorSlotsReasonEnum? _reason;
  VisitorSlotsReasonEnum? get reason => _$this._reason;
  set reason(VisitorSlotsReasonEnum? reason) => _$this._reason = reason;

  VisitorSlotsBuilder() {
    VisitorSlots._defaults(this);
  }

  VisitorSlotsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _visitorAccountId = $v.visitorAccountId;
      _visitorKind = $v.visitorKind;
      _displayName = $v.displayName;
      _photoObjectKey = $v.photoObjectKey;
      _completedVisitCount = $v.completedVisitCount;
      _averageRating = $v.averageRating;
      _ratingCount = $v.ratingCount;
      _mode = $v.mode;
      _slots = $v.slots?.toBuilder();
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VisitorSlots other) {
    _$v = other as _$VisitorSlots;
  }

  @override
  void update(void Function(VisitorSlotsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VisitorSlots build() => _build();

  _$VisitorSlots _build() {
    _$VisitorSlots _$result;
    try {
      _$result =
          _$v ??
          _$VisitorSlots._(
            visitorAccountId: visitorAccountId,
            visitorKind: visitorKind,
            displayName: displayName,
            photoObjectKey: photoObjectKey,
            completedVisitCount: completedVisitCount,
            averageRating: averageRating,
            ratingCount: ratingCount,
            mode: mode,
            slots: _slots?.build(),
            reason: reason,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'slots';
        _slots?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'VisitorSlots',
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
