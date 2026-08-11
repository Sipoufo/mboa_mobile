// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_agent_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AssignAgentRequest extends AssignAgentRequest {
  @override
  final String agentAccountId;

  factory _$AssignAgentRequest([
    void Function(AssignAgentRequestBuilder)? updates,
  ]) => (AssignAgentRequestBuilder()..update(updates))._build();

  _$AssignAgentRequest._({required this.agentAccountId}) : super._();
  @override
  AssignAgentRequest rebuild(
    void Function(AssignAgentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AssignAgentRequestBuilder toBuilder() =>
      AssignAgentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssignAgentRequest &&
        agentAccountId == other.agentAccountId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, agentAccountId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AssignAgentRequest',
    )..add('agentAccountId', agentAccountId)).toString();
  }
}

class AssignAgentRequestBuilder
    implements Builder<AssignAgentRequest, AssignAgentRequestBuilder> {
  _$AssignAgentRequest? _$v;

  String? _agentAccountId;
  String? get agentAccountId => _$this._agentAccountId;
  set agentAccountId(String? agentAccountId) =>
      _$this._agentAccountId = agentAccountId;

  AssignAgentRequestBuilder() {
    AssignAgentRequest._defaults(this);
  }

  AssignAgentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _agentAccountId = $v.agentAccountId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssignAgentRequest other) {
    _$v = other as _$AssignAgentRequest;
  }

  @override
  void update(void Function(AssignAgentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssignAgentRequest build() => _build();

  _$AssignAgentRequest _build() {
    final _$result =
        _$v ??
        _$AssignAgentRequest._(
          agentAccountId: BuiltValueNullFieldError.checkNotNull(
            agentAccountId,
            r'AssignAgentRequest',
            'agentAccountId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
