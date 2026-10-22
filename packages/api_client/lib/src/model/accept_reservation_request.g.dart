// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_reservation_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AcceptReservationRequest extends AcceptReservationRequest {
  @override
  final String? unitId;

  factory _$AcceptReservationRequest([
    void Function(AcceptReservationRequestBuilder)? updates,
  ]) => (AcceptReservationRequestBuilder()..update(updates))._build();

  _$AcceptReservationRequest._({this.unitId}) : super._();
  @override
  AcceptReservationRequest rebuild(
    void Function(AcceptReservationRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AcceptReservationRequestBuilder toBuilder() =>
      AcceptReservationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AcceptReservationRequest && unitId == other.unitId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, unitId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AcceptReservationRequest',
    )..add('unitId', unitId)).toString();
  }
}

class AcceptReservationRequestBuilder
    implements
        Builder<AcceptReservationRequest, AcceptReservationRequestBuilder> {
  _$AcceptReservationRequest? _$v;

  String? _unitId;
  String? get unitId => _$this._unitId;
  set unitId(String? unitId) => _$this._unitId = unitId;

  AcceptReservationRequestBuilder() {
    AcceptReservationRequest._defaults(this);
  }

  AcceptReservationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _unitId = $v.unitId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AcceptReservationRequest other) {
    _$v = other as _$AcceptReservationRequest;
  }

  @override
  void update(void Function(AcceptReservationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AcceptReservationRequest build() => _build();

  _$AcceptReservationRequest _build() {
    final _$result = _$v ?? _$AcceptReservationRequest._(unitId: unitId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
