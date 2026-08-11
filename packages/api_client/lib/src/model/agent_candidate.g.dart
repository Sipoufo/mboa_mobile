// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_candidate.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AgentCandidate extends AgentCandidate {
  @override
  final String? accountId;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? photoObjectKey;
  @override
  final int? completedVisitCount;

  factory _$AgentCandidate([void Function(AgentCandidateBuilder)? updates]) =>
      (AgentCandidateBuilder()..update(updates))._build();

  _$AgentCandidate._({
    this.accountId,
    this.firstName,
    this.lastName,
    this.photoObjectKey,
    this.completedVisitCount,
  }) : super._();
  @override
  AgentCandidate rebuild(void Function(AgentCandidateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AgentCandidateBuilder toBuilder() => AgentCandidateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AgentCandidate &&
        accountId == other.accountId &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        photoObjectKey == other.photoObjectKey &&
        completedVisitCount == other.completedVisitCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, photoObjectKey.hashCode);
    _$hash = $jc(_$hash, completedVisitCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AgentCandidate')
          ..add('accountId', accountId)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('photoObjectKey', photoObjectKey)
          ..add('completedVisitCount', completedVisitCount))
        .toString();
  }
}

class AgentCandidateBuilder
    implements Builder<AgentCandidate, AgentCandidateBuilder> {
  _$AgentCandidate? _$v;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _photoObjectKey;
  String? get photoObjectKey => _$this._photoObjectKey;
  set photoObjectKey(String? photoObjectKey) =>
      _$this._photoObjectKey = photoObjectKey;

  int? _completedVisitCount;
  int? get completedVisitCount => _$this._completedVisitCount;
  set completedVisitCount(int? completedVisitCount) =>
      _$this._completedVisitCount = completedVisitCount;

  AgentCandidateBuilder() {
    AgentCandidate._defaults(this);
  }

  AgentCandidateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountId = $v.accountId;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _photoObjectKey = $v.photoObjectKey;
      _completedVisitCount = $v.completedVisitCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AgentCandidate other) {
    _$v = other as _$AgentCandidate;
  }

  @override
  void update(void Function(AgentCandidateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AgentCandidate build() => _build();

  _$AgentCandidate _build() {
    final _$result =
        _$v ??
        _$AgentCandidate._(
          accountId: accountId,
          firstName: firstName,
          lastName: lastName,
          photoObjectKey: photoObjectKey,
          completedVisitCount: completedVisitCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
