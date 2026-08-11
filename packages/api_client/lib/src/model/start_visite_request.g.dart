// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_visite_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StartVisiteRequest extends StartVisiteRequest {
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String? overrideReason;

  factory _$StartVisiteRequest([
    void Function(StartVisiteRequestBuilder)? updates,
  ]) => (StartVisiteRequestBuilder()..update(updates))._build();

  _$StartVisiteRequest._({
    required this.latitude,
    required this.longitude,
    this.overrideReason,
  }) : super._();
  @override
  StartVisiteRequest rebuild(
    void Function(StartVisiteRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StartVisiteRequestBuilder toBuilder() =>
      StartVisiteRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StartVisiteRequest &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        overrideReason == other.overrideReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, overrideReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StartVisiteRequest')
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('overrideReason', overrideReason))
        .toString();
  }
}

class StartVisiteRequestBuilder
    implements Builder<StartVisiteRequest, StartVisiteRequestBuilder> {
  _$StartVisiteRequest? _$v;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  String? _overrideReason;
  String? get overrideReason => _$this._overrideReason;
  set overrideReason(String? overrideReason) =>
      _$this._overrideReason = overrideReason;

  StartVisiteRequestBuilder() {
    StartVisiteRequest._defaults(this);
  }

  StartVisiteRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _overrideReason = $v.overrideReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StartVisiteRequest other) {
    _$v = other as _$StartVisiteRequest;
  }

  @override
  void update(void Function(StartVisiteRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StartVisiteRequest build() => _build();

  _$StartVisiteRequest _build() {
    final _$result =
        _$v ??
        _$StartVisiteRequest._(
          latitude: BuiltValueNullFieldError.checkNotNull(
            latitude,
            r'StartVisiteRequest',
            'latitude',
          ),
          longitude: BuiltValueNullFieldError.checkNotNull(
            longitude,
            r'StartVisiteRequest',
            'longitude',
          ),
          overrideReason: overrideReason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
