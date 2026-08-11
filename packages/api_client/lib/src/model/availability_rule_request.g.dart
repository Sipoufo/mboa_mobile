// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_rule_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AvailabilityRuleRequest extends AvailabilityRuleRequest {
  @override
  final int dayOfWeek;
  @override
  final String startTime;
  @override
  final String endTime;

  factory _$AvailabilityRuleRequest([
    void Function(AvailabilityRuleRequestBuilder)? updates,
  ]) => (AvailabilityRuleRequestBuilder()..update(updates))._build();

  _$AvailabilityRuleRequest._({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  }) : super._();
  @override
  AvailabilityRuleRequest rebuild(
    void Function(AvailabilityRuleRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AvailabilityRuleRequestBuilder toBuilder() =>
      AvailabilityRuleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AvailabilityRuleRequest &&
        dayOfWeek == other.dayOfWeek &&
        startTime == other.startTime &&
        endTime == other.endTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, dayOfWeek.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AvailabilityRuleRequest')
          ..add('dayOfWeek', dayOfWeek)
          ..add('startTime', startTime)
          ..add('endTime', endTime))
        .toString();
  }
}

class AvailabilityRuleRequestBuilder
    implements
        Builder<AvailabilityRuleRequest, AvailabilityRuleRequestBuilder> {
  _$AvailabilityRuleRequest? _$v;

  int? _dayOfWeek;
  int? get dayOfWeek => _$this._dayOfWeek;
  set dayOfWeek(int? dayOfWeek) => _$this._dayOfWeek = dayOfWeek;

  String? _startTime;
  String? get startTime => _$this._startTime;
  set startTime(String? startTime) => _$this._startTime = startTime;

  String? _endTime;
  String? get endTime => _$this._endTime;
  set endTime(String? endTime) => _$this._endTime = endTime;

  AvailabilityRuleRequestBuilder() {
    AvailabilityRuleRequest._defaults(this);
  }

  AvailabilityRuleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _dayOfWeek = $v.dayOfWeek;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AvailabilityRuleRequest other) {
    _$v = other as _$AvailabilityRuleRequest;
  }

  @override
  void update(void Function(AvailabilityRuleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AvailabilityRuleRequest build() => _build();

  _$AvailabilityRuleRequest _build() {
    final _$result =
        _$v ??
        _$AvailabilityRuleRequest._(
          dayOfWeek: BuiltValueNullFieldError.checkNotNull(
            dayOfWeek,
            r'AvailabilityRuleRequest',
            'dayOfWeek',
          ),
          startTime: BuiltValueNullFieldError.checkNotNull(
            startTime,
            r'AvailabilityRuleRequest',
            'startTime',
          ),
          endTime: BuiltValueNullFieldError.checkNotNull(
            endTime,
            r'AvailabilityRuleRequest',
            'endTime',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
