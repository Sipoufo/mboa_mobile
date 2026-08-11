// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AssignmentResponseStatusEnum _$assignmentResponseStatusEnum_APPLIED =
    const AssignmentResponseStatusEnum._('APPLIED');
const AssignmentResponseStatusEnum _$assignmentResponseStatusEnum_PENDING =
    const AssignmentResponseStatusEnum._('PENDING');
const AssignmentResponseStatusEnum _$assignmentResponseStatusEnum_ACCEPTED =
    const AssignmentResponseStatusEnum._('ACCEPTED');
const AssignmentResponseStatusEnum _$assignmentResponseStatusEnum_DECLINED =
    const AssignmentResponseStatusEnum._('DECLINED');
const AssignmentResponseStatusEnum _$assignmentResponseStatusEnum_WITHDRAWN =
    const AssignmentResponseStatusEnum._('WITHDRAWN');
const AssignmentResponseStatusEnum _$assignmentResponseStatusEnum_REVOKED =
    const AssignmentResponseStatusEnum._('REVOKED');
const AssignmentResponseStatusEnum _$assignmentResponseStatusEnum_RESIGNED =
    const AssignmentResponseStatusEnum._('RESIGNED');
const AssignmentResponseStatusEnum
_$assignmentResponseStatusEnum_unknownDefaultOpenApi =
    const AssignmentResponseStatusEnum._('unknownDefaultOpenApi');

AssignmentResponseStatusEnum _$assignmentResponseStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'APPLIED':
      return _$assignmentResponseStatusEnum_APPLIED;
    case 'PENDING':
      return _$assignmentResponseStatusEnum_PENDING;
    case 'ACCEPTED':
      return _$assignmentResponseStatusEnum_ACCEPTED;
    case 'DECLINED':
      return _$assignmentResponseStatusEnum_DECLINED;
    case 'WITHDRAWN':
      return _$assignmentResponseStatusEnum_WITHDRAWN;
    case 'REVOKED':
      return _$assignmentResponseStatusEnum_REVOKED;
    case 'RESIGNED':
      return _$assignmentResponseStatusEnum_RESIGNED;
    case 'unknownDefaultOpenApi':
      return _$assignmentResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$assignmentResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AssignmentResponseStatusEnum>
_$assignmentResponseStatusEnumValues =
    BuiltSet<AssignmentResponseStatusEnum>(const <AssignmentResponseStatusEnum>[
      _$assignmentResponseStatusEnum_APPLIED,
      _$assignmentResponseStatusEnum_PENDING,
      _$assignmentResponseStatusEnum_ACCEPTED,
      _$assignmentResponseStatusEnum_DECLINED,
      _$assignmentResponseStatusEnum_WITHDRAWN,
      _$assignmentResponseStatusEnum_REVOKED,
      _$assignmentResponseStatusEnum_RESIGNED,
      _$assignmentResponseStatusEnum_unknownDefaultOpenApi,
    ]);

const AssignmentResponseInitiatedByEnum
_$assignmentResponseInitiatedByEnum_PRESTATAIRE =
    const AssignmentResponseInitiatedByEnum._('PRESTATAIRE');
const AssignmentResponseInitiatedByEnum
_$assignmentResponseInitiatedByEnum_AGENT =
    const AssignmentResponseInitiatedByEnum._('AGENT');
const AssignmentResponseInitiatedByEnum
_$assignmentResponseInitiatedByEnum_unknownDefaultOpenApi =
    const AssignmentResponseInitiatedByEnum._('unknownDefaultOpenApi');

AssignmentResponseInitiatedByEnum _$assignmentResponseInitiatedByEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PRESTATAIRE':
      return _$assignmentResponseInitiatedByEnum_PRESTATAIRE;
    case 'AGENT':
      return _$assignmentResponseInitiatedByEnum_AGENT;
    case 'unknownDefaultOpenApi':
      return _$assignmentResponseInitiatedByEnum_unknownDefaultOpenApi;
    default:
      return _$assignmentResponseInitiatedByEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AssignmentResponseInitiatedByEnum>
_$assignmentResponseInitiatedByEnumValues =
    BuiltSet<AssignmentResponseInitiatedByEnum>(
      const <AssignmentResponseInitiatedByEnum>[
        _$assignmentResponseInitiatedByEnum_PRESTATAIRE,
        _$assignmentResponseInitiatedByEnum_AGENT,
        _$assignmentResponseInitiatedByEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<AssignmentResponseStatusEnum>
_$assignmentResponseStatusEnumSerializer =
    _$AssignmentResponseStatusEnumSerializer();
Serializer<AssignmentResponseInitiatedByEnum>
_$assignmentResponseInitiatedByEnumSerializer =
    _$AssignmentResponseInitiatedByEnumSerializer();

class _$AssignmentResponseStatusEnumSerializer
    implements PrimitiveSerializer<AssignmentResponseStatusEnum> {
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
  final Iterable<Type> types = const <Type>[AssignmentResponseStatusEnum];
  @override
  final String wireName = 'AssignmentResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    AssignmentResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AssignmentResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AssignmentResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AssignmentResponseInitiatedByEnumSerializer
    implements PrimitiveSerializer<AssignmentResponseInitiatedByEnum> {
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
  final Iterable<Type> types = const <Type>[AssignmentResponseInitiatedByEnum];
  @override
  final String wireName = 'AssignmentResponseInitiatedByEnum';

  @override
  Object serialize(
    Serializers serializers,
    AssignmentResponseInitiatedByEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AssignmentResponseInitiatedByEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AssignmentResponseInitiatedByEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AssignmentResponse extends AssignmentResponse {
  @override
  final String? id;
  @override
  final String? annonceId;
  @override
  final String? annonceTitle;
  @override
  final String? agentAccountId;
  @override
  final String? agentName;
  @override
  final String? agentPhotoObjectKey;
  @override
  final AssignmentResponseStatusEnum? status;
  @override
  final AssignmentResponseInitiatedByEnum? initiatedBy;
  @override
  final String? residenceId;
  @override
  final DateTime? respondedAt;
  @override
  final DateTime? createdAt;

  factory _$AssignmentResponse([
    void Function(AssignmentResponseBuilder)? updates,
  ]) => (AssignmentResponseBuilder()..update(updates))._build();

  _$AssignmentResponse._({
    this.id,
    this.annonceId,
    this.annonceTitle,
    this.agentAccountId,
    this.agentName,
    this.agentPhotoObjectKey,
    this.status,
    this.initiatedBy,
    this.residenceId,
    this.respondedAt,
    this.createdAt,
  }) : super._();
  @override
  AssignmentResponse rebuild(
    void Function(AssignmentResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AssignmentResponseBuilder toBuilder() =>
      AssignmentResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssignmentResponse &&
        id == other.id &&
        annonceId == other.annonceId &&
        annonceTitle == other.annonceTitle &&
        agentAccountId == other.agentAccountId &&
        agentName == other.agentName &&
        agentPhotoObjectKey == other.agentPhotoObjectKey &&
        status == other.status &&
        initiatedBy == other.initiatedBy &&
        residenceId == other.residenceId &&
        respondedAt == other.respondedAt &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, annonceTitle.hashCode);
    _$hash = $jc(_$hash, agentAccountId.hashCode);
    _$hash = $jc(_$hash, agentName.hashCode);
    _$hash = $jc(_$hash, agentPhotoObjectKey.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, initiatedBy.hashCode);
    _$hash = $jc(_$hash, residenceId.hashCode);
    _$hash = $jc(_$hash, respondedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssignmentResponse')
          ..add('id', id)
          ..add('annonceId', annonceId)
          ..add('annonceTitle', annonceTitle)
          ..add('agentAccountId', agentAccountId)
          ..add('agentName', agentName)
          ..add('agentPhotoObjectKey', agentPhotoObjectKey)
          ..add('status', status)
          ..add('initiatedBy', initiatedBy)
          ..add('residenceId', residenceId)
          ..add('respondedAt', respondedAt)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class AssignmentResponseBuilder
    implements Builder<AssignmentResponse, AssignmentResponseBuilder> {
  _$AssignmentResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _annonceTitle;
  String? get annonceTitle => _$this._annonceTitle;
  set annonceTitle(String? annonceTitle) => _$this._annonceTitle = annonceTitle;

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

  AssignmentResponseStatusEnum? _status;
  AssignmentResponseStatusEnum? get status => _$this._status;
  set status(AssignmentResponseStatusEnum? status) => _$this._status = status;

  AssignmentResponseInitiatedByEnum? _initiatedBy;
  AssignmentResponseInitiatedByEnum? get initiatedBy => _$this._initiatedBy;
  set initiatedBy(AssignmentResponseInitiatedByEnum? initiatedBy) =>
      _$this._initiatedBy = initiatedBy;

  String? _residenceId;
  String? get residenceId => _$this._residenceId;
  set residenceId(String? residenceId) => _$this._residenceId = residenceId;

  DateTime? _respondedAt;
  DateTime? get respondedAt => _$this._respondedAt;
  set respondedAt(DateTime? respondedAt) => _$this._respondedAt = respondedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  AssignmentResponseBuilder() {
    AssignmentResponse._defaults(this);
  }

  AssignmentResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _annonceId = $v.annonceId;
      _annonceTitle = $v.annonceTitle;
      _agentAccountId = $v.agentAccountId;
      _agentName = $v.agentName;
      _agentPhotoObjectKey = $v.agentPhotoObjectKey;
      _status = $v.status;
      _initiatedBy = $v.initiatedBy;
      _residenceId = $v.residenceId;
      _respondedAt = $v.respondedAt;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssignmentResponse other) {
    _$v = other as _$AssignmentResponse;
  }

  @override
  void update(void Function(AssignmentResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssignmentResponse build() => _build();

  _$AssignmentResponse _build() {
    final _$result =
        _$v ??
        _$AssignmentResponse._(
          id: id,
          annonceId: annonceId,
          annonceTitle: annonceTitle,
          agentAccountId: agentAccountId,
          agentName: agentName,
          agentPhotoObjectKey: agentPhotoObjectKey,
          status: status,
          initiatedBy: initiatedBy,
          residenceId: residenceId,
          respondedAt: respondedAt,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
