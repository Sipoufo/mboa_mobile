// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'residence_assignment_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ResidenceAssignmentSummaryStatusEnum
_$residenceAssignmentSummaryStatusEnum_APPLIED =
    const ResidenceAssignmentSummaryStatusEnum._('APPLIED');
const ResidenceAssignmentSummaryStatusEnum
_$residenceAssignmentSummaryStatusEnum_PENDING =
    const ResidenceAssignmentSummaryStatusEnum._('PENDING');
const ResidenceAssignmentSummaryStatusEnum
_$residenceAssignmentSummaryStatusEnum_ACCEPTED =
    const ResidenceAssignmentSummaryStatusEnum._('ACCEPTED');
const ResidenceAssignmentSummaryStatusEnum
_$residenceAssignmentSummaryStatusEnum_DECLINED =
    const ResidenceAssignmentSummaryStatusEnum._('DECLINED');
const ResidenceAssignmentSummaryStatusEnum
_$residenceAssignmentSummaryStatusEnum_WITHDRAWN =
    const ResidenceAssignmentSummaryStatusEnum._('WITHDRAWN');
const ResidenceAssignmentSummaryStatusEnum
_$residenceAssignmentSummaryStatusEnum_REVOKED =
    const ResidenceAssignmentSummaryStatusEnum._('REVOKED');
const ResidenceAssignmentSummaryStatusEnum
_$residenceAssignmentSummaryStatusEnum_RESIGNED =
    const ResidenceAssignmentSummaryStatusEnum._('RESIGNED');
const ResidenceAssignmentSummaryStatusEnum
_$residenceAssignmentSummaryStatusEnum_unknownDefaultOpenApi =
    const ResidenceAssignmentSummaryStatusEnum._('unknownDefaultOpenApi');

ResidenceAssignmentSummaryStatusEnum
_$residenceAssignmentSummaryStatusEnumValueOf(String name) {
  switch (name) {
    case 'APPLIED':
      return _$residenceAssignmentSummaryStatusEnum_APPLIED;
    case 'PENDING':
      return _$residenceAssignmentSummaryStatusEnum_PENDING;
    case 'ACCEPTED':
      return _$residenceAssignmentSummaryStatusEnum_ACCEPTED;
    case 'DECLINED':
      return _$residenceAssignmentSummaryStatusEnum_DECLINED;
    case 'WITHDRAWN':
      return _$residenceAssignmentSummaryStatusEnum_WITHDRAWN;
    case 'REVOKED':
      return _$residenceAssignmentSummaryStatusEnum_REVOKED;
    case 'RESIGNED':
      return _$residenceAssignmentSummaryStatusEnum_RESIGNED;
    case 'unknownDefaultOpenApi':
      return _$residenceAssignmentSummaryStatusEnum_unknownDefaultOpenApi;
    default:
      return _$residenceAssignmentSummaryStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ResidenceAssignmentSummaryStatusEnum>
_$residenceAssignmentSummaryStatusEnumValues =
    BuiltSet<ResidenceAssignmentSummaryStatusEnum>(
      const <ResidenceAssignmentSummaryStatusEnum>[
        _$residenceAssignmentSummaryStatusEnum_APPLIED,
        _$residenceAssignmentSummaryStatusEnum_PENDING,
        _$residenceAssignmentSummaryStatusEnum_ACCEPTED,
        _$residenceAssignmentSummaryStatusEnum_DECLINED,
        _$residenceAssignmentSummaryStatusEnum_WITHDRAWN,
        _$residenceAssignmentSummaryStatusEnum_REVOKED,
        _$residenceAssignmentSummaryStatusEnum_RESIGNED,
        _$residenceAssignmentSummaryStatusEnum_unknownDefaultOpenApi,
      ],
    );

const ResidenceAssignmentSummaryInitiatedByEnum
_$residenceAssignmentSummaryInitiatedByEnum_PRESTATAIRE =
    const ResidenceAssignmentSummaryInitiatedByEnum._('PRESTATAIRE');
const ResidenceAssignmentSummaryInitiatedByEnum
_$residenceAssignmentSummaryInitiatedByEnum_AGENT =
    const ResidenceAssignmentSummaryInitiatedByEnum._('AGENT');
const ResidenceAssignmentSummaryInitiatedByEnum
_$residenceAssignmentSummaryInitiatedByEnum_unknownDefaultOpenApi =
    const ResidenceAssignmentSummaryInitiatedByEnum._('unknownDefaultOpenApi');

ResidenceAssignmentSummaryInitiatedByEnum
_$residenceAssignmentSummaryInitiatedByEnumValueOf(String name) {
  switch (name) {
    case 'PRESTATAIRE':
      return _$residenceAssignmentSummaryInitiatedByEnum_PRESTATAIRE;
    case 'AGENT':
      return _$residenceAssignmentSummaryInitiatedByEnum_AGENT;
    case 'unknownDefaultOpenApi':
      return _$residenceAssignmentSummaryInitiatedByEnum_unknownDefaultOpenApi;
    default:
      return _$residenceAssignmentSummaryInitiatedByEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ResidenceAssignmentSummaryInitiatedByEnum>
_$residenceAssignmentSummaryInitiatedByEnumValues =
    BuiltSet<ResidenceAssignmentSummaryInitiatedByEnum>(
      const <ResidenceAssignmentSummaryInitiatedByEnum>[
        _$residenceAssignmentSummaryInitiatedByEnum_PRESTATAIRE,
        _$residenceAssignmentSummaryInitiatedByEnum_AGENT,
        _$residenceAssignmentSummaryInitiatedByEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<ResidenceAssignmentSummaryStatusEnum>
_$residenceAssignmentSummaryStatusEnumSerializer =
    _$ResidenceAssignmentSummaryStatusEnumSerializer();
Serializer<ResidenceAssignmentSummaryInitiatedByEnum>
_$residenceAssignmentSummaryInitiatedByEnumSerializer =
    _$ResidenceAssignmentSummaryInitiatedByEnumSerializer();

class _$ResidenceAssignmentSummaryStatusEnumSerializer
    implements PrimitiveSerializer<ResidenceAssignmentSummaryStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'APPLIED': 'APPLIED',
    'PENDING': 'PENDING',
    'ACCEPTED': 'ACCEPTED',
    'DECLINED': 'DECLINED',
    'WITHDRAWN': 'WITHDRAWN',
    'REVOKED': 'REVOKED',
    'RESIGNED': 'RESIGNED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'APPLIED': 'APPLIED',
    'PENDING': 'PENDING',
    'ACCEPTED': 'ACCEPTED',
    'DECLINED': 'DECLINED',
    'WITHDRAWN': 'WITHDRAWN',
    'REVOKED': 'REVOKED',
    'RESIGNED': 'RESIGNED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ResidenceAssignmentSummaryStatusEnum,
  ];
  @override
  final String wireName = 'ResidenceAssignmentSummaryStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    ResidenceAssignmentSummaryStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ResidenceAssignmentSummaryStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ResidenceAssignmentSummaryStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ResidenceAssignmentSummaryInitiatedByEnumSerializer
    implements PrimitiveSerializer<ResidenceAssignmentSummaryInitiatedByEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PRESTATAIRE': 'PRESTATAIRE',
    'AGENT': 'AGENT',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PRESTATAIRE': 'PRESTATAIRE',
    'AGENT': 'AGENT',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ResidenceAssignmentSummaryInitiatedByEnum,
  ];
  @override
  final String wireName = 'ResidenceAssignmentSummaryInitiatedByEnum';

  @override
  Object serialize(
    Serializers serializers,
    ResidenceAssignmentSummaryInitiatedByEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ResidenceAssignmentSummaryInitiatedByEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ResidenceAssignmentSummaryInitiatedByEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ResidenceAssignmentSummary extends ResidenceAssignmentSummary {
  @override
  final String? residenceId;
  @override
  final String? residenceName;
  @override
  final String? agentAccountId;
  @override
  final String? agentName;
  @override
  final String? agentPhotoObjectKey;
  @override
  final ResidenceAssignmentSummaryStatusEnum? status;
  @override
  final ResidenceAssignmentSummaryInitiatedByEnum? initiatedBy;
  @override
  final int? unitCount;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? respondedAt;

  factory _$ResidenceAssignmentSummary([
    void Function(ResidenceAssignmentSummaryBuilder)? updates,
  ]) => (ResidenceAssignmentSummaryBuilder()..update(updates))._build();

  _$ResidenceAssignmentSummary._({
    this.residenceId,
    this.residenceName,
    this.agentAccountId,
    this.agentName,
    this.agentPhotoObjectKey,
    this.status,
    this.initiatedBy,
    this.unitCount,
    this.createdAt,
    this.respondedAt,
  }) : super._();
  @override
  ResidenceAssignmentSummary rebuild(
    void Function(ResidenceAssignmentSummaryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ResidenceAssignmentSummaryBuilder toBuilder() =>
      ResidenceAssignmentSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResidenceAssignmentSummary &&
        residenceId == other.residenceId &&
        residenceName == other.residenceName &&
        agentAccountId == other.agentAccountId &&
        agentName == other.agentName &&
        agentPhotoObjectKey == other.agentPhotoObjectKey &&
        status == other.status &&
        initiatedBy == other.initiatedBy &&
        unitCount == other.unitCount &&
        createdAt == other.createdAt &&
        respondedAt == other.respondedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, residenceId.hashCode);
    _$hash = $jc(_$hash, residenceName.hashCode);
    _$hash = $jc(_$hash, agentAccountId.hashCode);
    _$hash = $jc(_$hash, agentName.hashCode);
    _$hash = $jc(_$hash, agentPhotoObjectKey.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, initiatedBy.hashCode);
    _$hash = $jc(_$hash, unitCount.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, respondedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResidenceAssignmentSummary')
          ..add('residenceId', residenceId)
          ..add('residenceName', residenceName)
          ..add('agentAccountId', agentAccountId)
          ..add('agentName', agentName)
          ..add('agentPhotoObjectKey', agentPhotoObjectKey)
          ..add('status', status)
          ..add('initiatedBy', initiatedBy)
          ..add('unitCount', unitCount)
          ..add('createdAt', createdAt)
          ..add('respondedAt', respondedAt))
        .toString();
  }
}

class ResidenceAssignmentSummaryBuilder
    implements
        Builder<ResidenceAssignmentSummary, ResidenceAssignmentSummaryBuilder> {
  _$ResidenceAssignmentSummary? _$v;

  String? _residenceId;
  String? get residenceId => _$this._residenceId;
  set residenceId(String? residenceId) => _$this._residenceId = residenceId;

  String? _residenceName;
  String? get residenceName => _$this._residenceName;
  set residenceName(String? residenceName) =>
      _$this._residenceName = residenceName;

  String? _agentAccountId;
  String? get agentAccountId => _$this._agentAccountId;
  set agentAccountId(String? agentAccountId) =>
      _$this._agentAccountId = agentAccountId;

  String? _agentName;
  String? get agentName => _$this._agentName;
  set agentName(String? agentName) => _$this._agentName = agentName;

  String? _agentPhotoObjectKey;
  String? get agentPhotoObjectKey => _$this._agentPhotoObjectKey;
  set agentPhotoObjectKey(String? agentPhotoObjectKey) =>
      _$this._agentPhotoObjectKey = agentPhotoObjectKey;

  ResidenceAssignmentSummaryStatusEnum? _status;
  ResidenceAssignmentSummaryStatusEnum? get status => _$this._status;
  set status(ResidenceAssignmentSummaryStatusEnum? status) =>
      _$this._status = status;

  ResidenceAssignmentSummaryInitiatedByEnum? _initiatedBy;
  ResidenceAssignmentSummaryInitiatedByEnum? get initiatedBy =>
      _$this._initiatedBy;
  set initiatedBy(ResidenceAssignmentSummaryInitiatedByEnum? initiatedBy) =>
      _$this._initiatedBy = initiatedBy;

  int? _unitCount;
  int? get unitCount => _$this._unitCount;
  set unitCount(int? unitCount) => _$this._unitCount = unitCount;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _respondedAt;
  DateTime? get respondedAt => _$this._respondedAt;
  set respondedAt(DateTime? respondedAt) => _$this._respondedAt = respondedAt;

  ResidenceAssignmentSummaryBuilder() {
    ResidenceAssignmentSummary._defaults(this);
  }

  ResidenceAssignmentSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _residenceId = $v.residenceId;
      _residenceName = $v.residenceName;
      _agentAccountId = $v.agentAccountId;
      _agentName = $v.agentName;
      _agentPhotoObjectKey = $v.agentPhotoObjectKey;
      _status = $v.status;
      _initiatedBy = $v.initiatedBy;
      _unitCount = $v.unitCount;
      _createdAt = $v.createdAt;
      _respondedAt = $v.respondedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResidenceAssignmentSummary other) {
    _$v = other as _$ResidenceAssignmentSummary;
  }

  @override
  void update(void Function(ResidenceAssignmentSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResidenceAssignmentSummary build() => _build();

  _$ResidenceAssignmentSummary _build() {
    final _$result =
        _$v ??
        _$ResidenceAssignmentSummary._(
          residenceId: residenceId,
          residenceName: residenceName,
          agentAccountId: agentAccountId,
          agentName: agentName,
          agentPhotoObjectKey: agentPhotoObjectKey,
          status: status,
          initiatedBy: initiatedBy,
          unitCount: unitCount,
          createdAt: createdAt,
          respondedAt: respondedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
