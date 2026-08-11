// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_availability_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateAvailabilityRequest extends UpdateAvailabilityRequest {
  @override
  final BuiltList<AvailabilityRuleRequest> rules;
  @override
  final int? visitDurationMinutes;

  factory _$UpdateAvailabilityRequest([
    void Function(UpdateAvailabilityRequestBuilder)? updates,
  ]) => (UpdateAvailabilityRequestBuilder()..update(updates))._build();

  _$UpdateAvailabilityRequest._({
    required this.rules,
    this.visitDurationMinutes,
  }) : super._();
  @override
  UpdateAvailabilityRequest rebuild(
    void Function(UpdateAvailabilityRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateAvailabilityRequestBuilder toBuilder() =>
      UpdateAvailabilityRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateAvailabilityRequest &&
        rules == other.rules &&
        visitDurationMinutes == other.visitDurationMinutes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rules.hashCode);
    _$hash = $jc(_$hash, visitDurationMinutes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateAvailabilityRequest')
          ..add('rules', rules)
          ..add('visitDurationMinutes', visitDurationMinutes))
        .toString();
  }
}

class UpdateAvailabilityRequestBuilder
    implements
        Builder<UpdateAvailabilityRequest, UpdateAvailabilityRequestBuilder> {
  _$UpdateAvailabilityRequest? _$v;

  ListBuilder<AvailabilityRuleRequest>? _rules;
  ListBuilder<AvailabilityRuleRequest> get rules =>
      _$this._rules ??= ListBuilder<AvailabilityRuleRequest>();
  set rules(ListBuilder<AvailabilityRuleRequest>? rules) =>
      _$this._rules = rules;

  int? _visitDurationMinutes;
  int? get visitDurationMinutes => _$this._visitDurationMinutes;
  set visitDurationMinutes(int? visitDurationMinutes) =>
      _$this._visitDurationMinutes = visitDurationMinutes;

  UpdateAvailabilityRequestBuilder() {
    UpdateAvailabilityRequest._defaults(this);
  }

  UpdateAvailabilityRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rules = $v.rules.toBuilder();
      _visitDurationMinutes = $v.visitDurationMinutes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateAvailabilityRequest other) {
    _$v = other as _$UpdateAvailabilityRequest;
  }

  @override
  void update(void Function(UpdateAvailabilityRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateAvailabilityRequest build() => _build();

  _$UpdateAvailabilityRequest _build() {
    _$UpdateAvailabilityRequest _$result;
    try {
      _$result =
          _$v ??
          _$UpdateAvailabilityRequest._(
            rules: rules.build(),
            visitDurationMinutes: visitDurationMinutes,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'rules';
        rules.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UpdateAvailabilityRequest',
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
