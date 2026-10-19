// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_reservation_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateReservationRequest extends CreateReservationRequest {
  @override
  final String annonceId;
  @override
  final Date desiredStartDate;
  @override
  final int durationUnits;
  @override
  final String? message;

  factory _$CreateReservationRequest([
    void Function(CreateReservationRequestBuilder)? updates,
  ]) => (CreateReservationRequestBuilder()..update(updates))._build();

  _$CreateReservationRequest._({
    required this.annonceId,
    required this.desiredStartDate,
    required this.durationUnits,
    this.message,
  }) : super._();
  @override
  CreateReservationRequest rebuild(
    void Function(CreateReservationRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateReservationRequestBuilder toBuilder() =>
      CreateReservationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateReservationRequest &&
        annonceId == other.annonceId &&
        desiredStartDate == other.desiredStartDate &&
        durationUnits == other.durationUnits &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, desiredStartDate.hashCode);
    _$hash = $jc(_$hash, durationUnits.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateReservationRequest')
          ..add('annonceId', annonceId)
          ..add('desiredStartDate', desiredStartDate)
          ..add('durationUnits', durationUnits)
          ..add('message', message))
        .toString();
  }
}

class CreateReservationRequestBuilder
    implements
        Builder<CreateReservationRequest, CreateReservationRequestBuilder> {
  _$CreateReservationRequest? _$v;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  Date? _desiredStartDate;
  Date? get desiredStartDate => _$this._desiredStartDate;
  set desiredStartDate(Date? desiredStartDate) =>
      _$this._desiredStartDate = desiredStartDate;

  int? _durationUnits;
  int? get durationUnits => _$this._durationUnits;
  set durationUnits(int? durationUnits) =>
      _$this._durationUnits = durationUnits;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  CreateReservationRequestBuilder() {
    CreateReservationRequest._defaults(this);
  }

  CreateReservationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _annonceId = $v.annonceId;
      _desiredStartDate = $v.desiredStartDate;
      _durationUnits = $v.durationUnits;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateReservationRequest other) {
    _$v = other as _$CreateReservationRequest;
  }

  @override
  void update(void Function(CreateReservationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateReservationRequest build() => _build();

  _$CreateReservationRequest _build() {
    final _$result =
        _$v ??
        _$CreateReservationRequest._(
          annonceId: BuiltValueNullFieldError.checkNotNull(
            annonceId,
            r'CreateReservationRequest',
            'annonceId',
          ),
          desiredStartDate: BuiltValueNullFieldError.checkNotNull(
            desiredStartDate,
            r'CreateReservationRequest',
            'desiredStartDate',
          ),
          durationUnits: BuiltValueNullFieldError.checkNotNull(
            durationUnits,
            r'CreateReservationRequest',
            'durationUnits',
          ),
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
