// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_request_snapshot.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ReservationRequestSnapshotRentalPeriodEnum
_$reservationRequestSnapshotRentalPeriodEnum_DAY =
    const ReservationRequestSnapshotRentalPeriodEnum._('DAY');
const ReservationRequestSnapshotRentalPeriodEnum
_$reservationRequestSnapshotRentalPeriodEnum_WEEK =
    const ReservationRequestSnapshotRentalPeriodEnum._('WEEK');
const ReservationRequestSnapshotRentalPeriodEnum
_$reservationRequestSnapshotRentalPeriodEnum_MONTH =
    const ReservationRequestSnapshotRentalPeriodEnum._('MONTH');
const ReservationRequestSnapshotRentalPeriodEnum
_$reservationRequestSnapshotRentalPeriodEnum_QUARTER =
    const ReservationRequestSnapshotRentalPeriodEnum._('QUARTER');
const ReservationRequestSnapshotRentalPeriodEnum
_$reservationRequestSnapshotRentalPeriodEnum_YEAR =
    const ReservationRequestSnapshotRentalPeriodEnum._('YEAR');
const ReservationRequestSnapshotRentalPeriodEnum
_$reservationRequestSnapshotRentalPeriodEnum_unknownDefaultOpenApi =
    const ReservationRequestSnapshotRentalPeriodEnum._('unknownDefaultOpenApi');

ReservationRequestSnapshotRentalPeriodEnum
_$reservationRequestSnapshotRentalPeriodEnumValueOf(String name) {
  switch (name) {
    case 'DAY':
      return _$reservationRequestSnapshotRentalPeriodEnum_DAY;
    case 'WEEK':
      return _$reservationRequestSnapshotRentalPeriodEnum_WEEK;
    case 'MONTH':
      return _$reservationRequestSnapshotRentalPeriodEnum_MONTH;
    case 'QUARTER':
      return _$reservationRequestSnapshotRentalPeriodEnum_QUARTER;
    case 'YEAR':
      return _$reservationRequestSnapshotRentalPeriodEnum_YEAR;
    case 'unknownDefaultOpenApi':
      return _$reservationRequestSnapshotRentalPeriodEnum_unknownDefaultOpenApi;
    default:
      return _$reservationRequestSnapshotRentalPeriodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ReservationRequestSnapshotRentalPeriodEnum>
_$reservationRequestSnapshotRentalPeriodEnumValues =
    BuiltSet<ReservationRequestSnapshotRentalPeriodEnum>(
      const <ReservationRequestSnapshotRentalPeriodEnum>[
        _$reservationRequestSnapshotRentalPeriodEnum_DAY,
        _$reservationRequestSnapshotRentalPeriodEnum_WEEK,
        _$reservationRequestSnapshotRentalPeriodEnum_MONTH,
        _$reservationRequestSnapshotRentalPeriodEnum_QUARTER,
        _$reservationRequestSnapshotRentalPeriodEnum_YEAR,
        _$reservationRequestSnapshotRentalPeriodEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<ReservationRequestSnapshotRentalPeriodEnum>
_$reservationRequestSnapshotRentalPeriodEnumSerializer =
    _$ReservationRequestSnapshotRentalPeriodEnumSerializer();

class _$ReservationRequestSnapshotRentalPeriodEnumSerializer
    implements PrimitiveSerializer<ReservationRequestSnapshotRentalPeriodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'DAY': 'DAY',
    'WEEK': 'WEEK',
    'MONTH': 'MONTH',
    'QUARTER': 'QUARTER',
    'YEAR': 'YEAR',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'DAY': 'DAY',
    'WEEK': 'WEEK',
    'MONTH': 'MONTH',
    'QUARTER': 'QUARTER',
    'YEAR': 'YEAR',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ReservationRequestSnapshotRentalPeriodEnum,
  ];
  @override
  final String wireName = 'ReservationRequestSnapshotRentalPeriodEnum';

  @override
  Object serialize(
    Serializers serializers,
    ReservationRequestSnapshotRentalPeriodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ReservationRequestSnapshotRentalPeriodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ReservationRequestSnapshotRentalPeriodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ReservationRequestSnapshot extends ReservationRequestSnapshot {
  @override
  final String? reservationRequestId;
  @override
  final Date? desiredStartDate;
  @override
  final int? durationUnits;
  @override
  final ReservationRequestSnapshotRentalPeriodEnum? rentalPeriod;

  factory _$ReservationRequestSnapshot([
    void Function(ReservationRequestSnapshotBuilder)? updates,
  ]) => (ReservationRequestSnapshotBuilder()..update(updates))._build();

  _$ReservationRequestSnapshot._({
    this.reservationRequestId,
    this.desiredStartDate,
    this.durationUnits,
    this.rentalPeriod,
  }) : super._();
  @override
  ReservationRequestSnapshot rebuild(
    void Function(ReservationRequestSnapshotBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReservationRequestSnapshotBuilder toBuilder() =>
      ReservationRequestSnapshotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReservationRequestSnapshot &&
        reservationRequestId == other.reservationRequestId &&
        desiredStartDate == other.desiredStartDate &&
        durationUnits == other.durationUnits &&
        rentalPeriod == other.rentalPeriod;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reservationRequestId.hashCode);
    _$hash = $jc(_$hash, desiredStartDate.hashCode);
    _$hash = $jc(_$hash, durationUnits.hashCode);
    _$hash = $jc(_$hash, rentalPeriod.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReservationRequestSnapshot')
          ..add('reservationRequestId', reservationRequestId)
          ..add('desiredStartDate', desiredStartDate)
          ..add('durationUnits', durationUnits)
          ..add('rentalPeriod', rentalPeriod))
        .toString();
  }
}

class ReservationRequestSnapshotBuilder
    implements
        Builder<ReservationRequestSnapshot, ReservationRequestSnapshotBuilder> {
  _$ReservationRequestSnapshot? _$v;

  String? _reservationRequestId;
  String? get reservationRequestId => _$this._reservationRequestId;
  set reservationRequestId(String? reservationRequestId) =>
      _$this._reservationRequestId = reservationRequestId;

  Date? _desiredStartDate;
  Date? get desiredStartDate => _$this._desiredStartDate;
  set desiredStartDate(Date? desiredStartDate) =>
      _$this._desiredStartDate = desiredStartDate;

  int? _durationUnits;
  int? get durationUnits => _$this._durationUnits;
  set durationUnits(int? durationUnits) =>
      _$this._durationUnits = durationUnits;

  ReservationRequestSnapshotRentalPeriodEnum? _rentalPeriod;
  ReservationRequestSnapshotRentalPeriodEnum? get rentalPeriod =>
      _$this._rentalPeriod;
  set rentalPeriod(ReservationRequestSnapshotRentalPeriodEnum? rentalPeriod) =>
      _$this._rentalPeriod = rentalPeriod;

  ReservationRequestSnapshotBuilder() {
    ReservationRequestSnapshot._defaults(this);
  }

  ReservationRequestSnapshotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reservationRequestId = $v.reservationRequestId;
      _desiredStartDate = $v.desiredStartDate;
      _durationUnits = $v.durationUnits;
      _rentalPeriod = $v.rentalPeriod;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReservationRequestSnapshot other) {
    _$v = other as _$ReservationRequestSnapshot;
  }

  @override
  void update(void Function(ReservationRequestSnapshotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReservationRequestSnapshot build() => _build();

  _$ReservationRequestSnapshot _build() {
    final _$result =
        _$v ??
        _$ReservationRequestSnapshot._(
          reservationRequestId: reservationRequestId,
          desiredStartDate: desiredStartDate,
          durationUnits: durationUnits,
          rentalPeriod: rentalPeriod,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
