// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AvailabilityResponse extends AvailabilityResponse {
  @override
  final BuiltList<AvailabilityRuleRequest>? rules;
  @override
  final int? visitDurationMinutes;
  @override
  final BuiltList<Date>? daysOff;

  factory _$AvailabilityResponse([
    void Function(AvailabilityResponseBuilder)? updates,
  ]) => (AvailabilityResponseBuilder()..update(updates))._build();

  _$AvailabilityResponse._({
    this.rules,
    this.visitDurationMinutes,
    this.daysOff,
  }) : super._();
  @override
  AvailabilityResponse rebuild(
    void Function(AvailabilityResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AvailabilityResponseBuilder toBuilder() =>
      AvailabilityResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AvailabilityResponse &&
        rules == other.rules &&
        visitDurationMinutes == other.visitDurationMinutes &&
        daysOff == other.daysOff;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rules.hashCode);
    _$hash = $jc(_$hash, visitDurationMinutes.hashCode);
    _$hash = $jc(_$hash, daysOff.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AvailabilityResponse')
          ..add('rules', rules)
          ..add('visitDurationMinutes', visitDurationMinutes)
          ..add('daysOff', daysOff))
        .toString();
  }
}

class AvailabilityResponseBuilder
    implements Builder<AvailabilityResponse, AvailabilityResponseBuilder> {
  _$AvailabilityResponse? _$v;

  ListBuilder<AvailabilityRuleRequest>? _rules;
  ListBuilder<AvailabilityRuleRequest> get rules =>
      _$this._rules ??= ListBuilder<AvailabilityRuleRequest>();
  set rules(ListBuilder<AvailabilityRuleRequest>? rules) =>
      _$this._rules = rules;

  int? _visitDurationMinutes;
  int? get visitDurationMinutes => _$this._visitDurationMinutes;
  set visitDurationMinutes(int? visitDurationMinutes) =>
      _$this._visitDurationMinutes = visitDurationMinutes;

  ListBuilder<Date>? _daysOff;
  ListBuilder<Date> get daysOff => _$this._daysOff ??= ListBuilder<Date>();
  set daysOff(ListBuilder<Date>? daysOff) => _$this._daysOff = daysOff;

  AvailabilityResponseBuilder() {
    AvailabilityResponse._defaults(this);
  }

  AvailabilityResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rules = $v.rules?.toBuilder();
      _visitDurationMinutes = $v.visitDurationMinutes;
      _daysOff = $v.daysOff?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AvailabilityResponse other) {
    _$v = other as _$AvailabilityResponse;
  }

  @override
  void update(void Function(AvailabilityResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AvailabilityResponse build() => _build();

  _$AvailabilityResponse _build() {
    _$AvailabilityResponse _$result;
    try {
      _$result =
          _$v ??
          _$AvailabilityResponse._(
            rules: _rules?.build(),
            visitDurationMinutes: visitDurationMinutes,
            daysOff: _daysOff?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'rules';
        _rules?.build();

        _$failedField = 'daysOff';
        _daysOff?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AvailabilityResponse',
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
