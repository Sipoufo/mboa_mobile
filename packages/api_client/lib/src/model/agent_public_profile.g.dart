// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_public_profile.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AgentPublicProfile extends AgentPublicProfile {
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
  @override
  final double? averageRating;
  @override
  final int? ratingCount;
  @override
  final BuiltList<Zone>? zones;
  @override
  final DateTime? memberSince;

  factory _$AgentPublicProfile([
    void Function(AgentPublicProfileBuilder)? updates,
  ]) => (AgentPublicProfileBuilder()..update(updates))._build();

  _$AgentPublicProfile._({
    this.accountId,
    this.firstName,
    this.lastName,
    this.photoObjectKey,
    this.completedVisitCount,
    this.averageRating,
    this.ratingCount,
    this.zones,
    this.memberSince,
  }) : super._();
  @override
  AgentPublicProfile rebuild(
    void Function(AgentPublicProfileBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AgentPublicProfileBuilder toBuilder() =>
      AgentPublicProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AgentPublicProfile &&
        accountId == other.accountId &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        photoObjectKey == other.photoObjectKey &&
        completedVisitCount == other.completedVisitCount &&
        averageRating == other.averageRating &&
        ratingCount == other.ratingCount &&
        zones == other.zones &&
        memberSince == other.memberSince;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, photoObjectKey.hashCode);
    _$hash = $jc(_$hash, completedVisitCount.hashCode);
    _$hash = $jc(_$hash, averageRating.hashCode);
    _$hash = $jc(_$hash, ratingCount.hashCode);
    _$hash = $jc(_$hash, zones.hashCode);
    _$hash = $jc(_$hash, memberSince.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AgentPublicProfile')
          ..add('accountId', accountId)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('photoObjectKey', photoObjectKey)
          ..add('completedVisitCount', completedVisitCount)
          ..add('averageRating', averageRating)
          ..add('ratingCount', ratingCount)
          ..add('zones', zones)
          ..add('memberSince', memberSince))
        .toString();
  }
}

class AgentPublicProfileBuilder
    implements Builder<AgentPublicProfile, AgentPublicProfileBuilder> {
  _$AgentPublicProfile? _$v;

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

  double? _averageRating;
  double? get averageRating => _$this._averageRating;
  set averageRating(double? averageRating) =>
      _$this._averageRating = averageRating;

  int? _ratingCount;
  int? get ratingCount => _$this._ratingCount;
  set ratingCount(int? ratingCount) => _$this._ratingCount = ratingCount;

  ListBuilder<Zone>? _zones;
  ListBuilder<Zone> get zones => _$this._zones ??= ListBuilder<Zone>();
  set zones(ListBuilder<Zone>? zones) => _$this._zones = zones;

  DateTime? _memberSince;
  DateTime? get memberSince => _$this._memberSince;
  set memberSince(DateTime? memberSince) => _$this._memberSince = memberSince;

  AgentPublicProfileBuilder() {
    AgentPublicProfile._defaults(this);
  }

  AgentPublicProfileBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountId = $v.accountId;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _photoObjectKey = $v.photoObjectKey;
      _completedVisitCount = $v.completedVisitCount;
      _averageRating = $v.averageRating;
      _ratingCount = $v.ratingCount;
      _zones = $v.zones?.toBuilder();
      _memberSince = $v.memberSince;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AgentPublicProfile other) {
    _$v = other as _$AgentPublicProfile;
  }

  @override
  void update(void Function(AgentPublicProfileBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AgentPublicProfile build() => _build();

  _$AgentPublicProfile _build() {
    _$AgentPublicProfile _$result;
    try {
      _$result =
          _$v ??
          _$AgentPublicProfile._(
            accountId: accountId,
            firstName: firstName,
            lastName: lastName,
            photoObjectKey: photoObjectKey,
            completedVisitCount: completedVisitCount,
            averageRating: averageRating,
            ratingCount: ratingCount,
            zones: _zones?.build(),
            memberSince: memberSince,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'zones';
        _zones?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AgentPublicProfile',
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
