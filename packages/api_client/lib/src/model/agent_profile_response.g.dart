// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_profile_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AgentProfileResponseStatusEnum _$agentProfileResponseStatusEnum_PENDING =
    const AgentProfileResponseStatusEnum._('PENDING');
const AgentProfileResponseStatusEnum _$agentProfileResponseStatusEnum_ACTIVE =
    const AgentProfileResponseStatusEnum._('ACTIVE');
const AgentProfileResponseStatusEnum
_$agentProfileResponseStatusEnum_SUSPENDED =
    const AgentProfileResponseStatusEnum._('SUSPENDED');
const AgentProfileResponseStatusEnum _$agentProfileResponseStatusEnum_DELETED =
    const AgentProfileResponseStatusEnum._('DELETED');
const AgentProfileResponseStatusEnum
_$agentProfileResponseStatusEnum_unknownDefaultOpenApi =
    const AgentProfileResponseStatusEnum._('unknownDefaultOpenApi');

AgentProfileResponseStatusEnum _$agentProfileResponseStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PENDING':
      return _$agentProfileResponseStatusEnum_PENDING;
    case 'ACTIVE':
      return _$agentProfileResponseStatusEnum_ACTIVE;
    case 'SUSPENDED':
      return _$agentProfileResponseStatusEnum_SUSPENDED;
    case 'DELETED':
      return _$agentProfileResponseStatusEnum_DELETED;
    case 'unknownDefaultOpenApi':
      return _$agentProfileResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$agentProfileResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AgentProfileResponseStatusEnum>
_$agentProfileResponseStatusEnumValues =
    BuiltSet<AgentProfileResponseStatusEnum>(
      const <AgentProfileResponseStatusEnum>[
        _$agentProfileResponseStatusEnum_PENDING,
        _$agentProfileResponseStatusEnum_ACTIVE,
        _$agentProfileResponseStatusEnum_SUSPENDED,
        _$agentProfileResponseStatusEnum_DELETED,
        _$agentProfileResponseStatusEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<AgentProfileResponseStatusEnum>
_$agentProfileResponseStatusEnumSerializer =
    _$AgentProfileResponseStatusEnumSerializer();

class _$AgentProfileResponseStatusEnumSerializer
    implements PrimitiveSerializer<AgentProfileResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
    'ACTIVE': 'ACTIVE',
    'SUSPENDED': 'SUSPENDED',
    'DELETED': 'DELETED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
    'ACTIVE': 'ACTIVE',
    'SUSPENDED': 'SUSPENDED',
    'DELETED': 'DELETED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AgentProfileResponseStatusEnum];
  @override
  final String wireName = 'AgentProfileResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    AgentProfileResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AgentProfileResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AgentProfileResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AgentProfileResponse extends AgentProfileResponse {
  @override
  final String? accountId;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? photoObjectKey;
  @override
  final BuiltList<ZoneResponse>? zones;
  @override
  final bool? acceptingAssignments;
  @override
  final int? completedVisitCount;
  @override
  final double? averageRating;
  @override
  final int? ratingCount;
  @override
  final AgentProfileResponseStatusEnum? status;
  @override
  final bool? profileComplete;
  @override
  final DateTime? createdAt;

  factory _$AgentProfileResponse([
    void Function(AgentProfileResponseBuilder)? updates,
  ]) => (AgentProfileResponseBuilder()..update(updates))._build();

  _$AgentProfileResponse._({
    this.accountId,
    this.firstName,
    this.lastName,
    this.photoObjectKey,
    this.zones,
    this.acceptingAssignments,
    this.completedVisitCount,
    this.averageRating,
    this.ratingCount,
    this.status,
    this.profileComplete,
    this.createdAt,
  }) : super._();
  @override
  AgentProfileResponse rebuild(
    void Function(AgentProfileResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AgentProfileResponseBuilder toBuilder() =>
      AgentProfileResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AgentProfileResponse &&
        accountId == other.accountId &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        photoObjectKey == other.photoObjectKey &&
        zones == other.zones &&
        acceptingAssignments == other.acceptingAssignments &&
        completedVisitCount == other.completedVisitCount &&
        averageRating == other.averageRating &&
        ratingCount == other.ratingCount &&
        status == other.status &&
        profileComplete == other.profileComplete &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, photoObjectKey.hashCode);
    _$hash = $jc(_$hash, zones.hashCode);
    _$hash = $jc(_$hash, acceptingAssignments.hashCode);
    _$hash = $jc(_$hash, completedVisitCount.hashCode);
    _$hash = $jc(_$hash, averageRating.hashCode);
    _$hash = $jc(_$hash, ratingCount.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, profileComplete.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AgentProfileResponse')
          ..add('accountId', accountId)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('photoObjectKey', photoObjectKey)
          ..add('zones', zones)
          ..add('acceptingAssignments', acceptingAssignments)
          ..add('completedVisitCount', completedVisitCount)
          ..add('averageRating', averageRating)
          ..add('ratingCount', ratingCount)
          ..add('status', status)
          ..add('profileComplete', profileComplete)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class AgentProfileResponseBuilder
    implements Builder<AgentProfileResponse, AgentProfileResponseBuilder> {
  _$AgentProfileResponse? _$v;

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

  ListBuilder<ZoneResponse>? _zones;
  ListBuilder<ZoneResponse> get zones =>
      _$this._zones ??= ListBuilder<ZoneResponse>();
  set zones(ListBuilder<ZoneResponse>? zones) => _$this._zones = zones;

  bool? _acceptingAssignments;
  bool? get acceptingAssignments => _$this._acceptingAssignments;
  set acceptingAssignments(bool? acceptingAssignments) =>
      _$this._acceptingAssignments = acceptingAssignments;

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

  AgentProfileResponseStatusEnum? _status;
  AgentProfileResponseStatusEnum? get status => _$this._status;
  set status(AgentProfileResponseStatusEnum? status) => _$this._status = status;

  bool? _profileComplete;
  bool? get profileComplete => _$this._profileComplete;
  set profileComplete(bool? profileComplete) =>
      _$this._profileComplete = profileComplete;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  AgentProfileResponseBuilder() {
    AgentProfileResponse._defaults(this);
  }

  AgentProfileResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountId = $v.accountId;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _photoObjectKey = $v.photoObjectKey;
      _zones = $v.zones?.toBuilder();
      _acceptingAssignments = $v.acceptingAssignments;
      _completedVisitCount = $v.completedVisitCount;
      _averageRating = $v.averageRating;
      _ratingCount = $v.ratingCount;
      _status = $v.status;
      _profileComplete = $v.profileComplete;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AgentProfileResponse other) {
    _$v = other as _$AgentProfileResponse;
  }

  @override
  void update(void Function(AgentProfileResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AgentProfileResponse build() => _build();

  _$AgentProfileResponse _build() {
    _$AgentProfileResponse _$result;
    try {
      _$result =
          _$v ??
          _$AgentProfileResponse._(
            accountId: accountId,
            firstName: firstName,
            lastName: lastName,
            photoObjectKey: photoObjectKey,
            zones: _zones?.build(),
            acceptingAssignments: acceptingAssignments,
            completedVisitCount: completedVisitCount,
            averageRating: averageRating,
            ratingCount: ratingCount,
            status: status,
            profileComplete: profileComplete,
            createdAt: createdAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'zones';
        _zones?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AgentProfileResponse',
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
