// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_visite_detail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AgentVisiteDetailStatusEnum _$agentVisiteDetailStatusEnum_REQUESTED =
    const AgentVisiteDetailStatusEnum._('REQUESTED');
const AgentVisiteDetailStatusEnum _$agentVisiteDetailStatusEnum_SCHEDULED =
    const AgentVisiteDetailStatusEnum._('SCHEDULED');
const AgentVisiteDetailStatusEnum _$agentVisiteDetailStatusEnum_CANCELLED =
    const AgentVisiteDetailStatusEnum._('CANCELLED');
const AgentVisiteDetailStatusEnum _$agentVisiteDetailStatusEnum_COMPLETED =
    const AgentVisiteDetailStatusEnum._('COMPLETED');
const AgentVisiteDetailStatusEnum _$agentVisiteDetailStatusEnum_NOT_FULFILLED =
    const AgentVisiteDetailStatusEnum._('NOT_FULFILLED');
const AgentVisiteDetailStatusEnum
_$agentVisiteDetailStatusEnum_unknownDefaultOpenApi =
    const AgentVisiteDetailStatusEnum._('unknownDefaultOpenApi');

AgentVisiteDetailStatusEnum _$agentVisiteDetailStatusEnumValueOf(String name) {
  switch (name) {
    case 'REQUESTED':
      return _$agentVisiteDetailStatusEnum_REQUESTED;
    case 'SCHEDULED':
      return _$agentVisiteDetailStatusEnum_SCHEDULED;
    case 'CANCELLED':
      return _$agentVisiteDetailStatusEnum_CANCELLED;
    case 'COMPLETED':
      return _$agentVisiteDetailStatusEnum_COMPLETED;
    case 'NOT_FULFILLED':
      return _$agentVisiteDetailStatusEnum_NOT_FULFILLED;
    case 'unknownDefaultOpenApi':
      return _$agentVisiteDetailStatusEnum_unknownDefaultOpenApi;
    default:
      return _$agentVisiteDetailStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AgentVisiteDetailStatusEnum>
_$agentVisiteDetailStatusEnumValues =
    BuiltSet<AgentVisiteDetailStatusEnum>(const <AgentVisiteDetailStatusEnum>[
      _$agentVisiteDetailStatusEnum_REQUESTED,
      _$agentVisiteDetailStatusEnum_SCHEDULED,
      _$agentVisiteDetailStatusEnum_CANCELLED,
      _$agentVisiteDetailStatusEnum_COMPLETED,
      _$agentVisiteDetailStatusEnum_NOT_FULFILLED,
      _$agentVisiteDetailStatusEnum_unknownDefaultOpenApi,
    ]);

const AgentVisiteDetailCancellationReasonEnum
_$agentVisiteDetailCancellationReasonEnum_BY_USER =
    const AgentVisiteDetailCancellationReasonEnum._('BY_USER');
const AgentVisiteDetailCancellationReasonEnum
_$agentVisiteDetailCancellationReasonEnum_BY_AGENT =
    const AgentVisiteDetailCancellationReasonEnum._('BY_AGENT');
const AgentVisiteDetailCancellationReasonEnum
_$agentVisiteDetailCancellationReasonEnum_AGENT_UNAVAILABLE =
    const AgentVisiteDetailCancellationReasonEnum._('AGENT_UNAVAILABLE');
const AgentVisiteDetailCancellationReasonEnum
_$agentVisiteDetailCancellationReasonEnum_AGENT_REMOVED =
    const AgentVisiteDetailCancellationReasonEnum._('AGENT_REMOVED');
const AgentVisiteDetailCancellationReasonEnum
_$agentVisiteDetailCancellationReasonEnum_LISTING_UNAVAILABLE =
    const AgentVisiteDetailCancellationReasonEnum._('LISTING_UNAVAILABLE');
const AgentVisiteDetailCancellationReasonEnum
_$agentVisiteDetailCancellationReasonEnum_unknownDefaultOpenApi =
    const AgentVisiteDetailCancellationReasonEnum._('unknownDefaultOpenApi');

AgentVisiteDetailCancellationReasonEnum
_$agentVisiteDetailCancellationReasonEnumValueOf(String name) {
  switch (name) {
    case 'BY_USER':
      return _$agentVisiteDetailCancellationReasonEnum_BY_USER;
    case 'BY_AGENT':
      return _$agentVisiteDetailCancellationReasonEnum_BY_AGENT;
    case 'AGENT_UNAVAILABLE':
      return _$agentVisiteDetailCancellationReasonEnum_AGENT_UNAVAILABLE;
    case 'AGENT_REMOVED':
      return _$agentVisiteDetailCancellationReasonEnum_AGENT_REMOVED;
    case 'LISTING_UNAVAILABLE':
      return _$agentVisiteDetailCancellationReasonEnum_LISTING_UNAVAILABLE;
    case 'unknownDefaultOpenApi':
      return _$agentVisiteDetailCancellationReasonEnum_unknownDefaultOpenApi;
    default:
      return _$agentVisiteDetailCancellationReasonEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AgentVisiteDetailCancellationReasonEnum>
_$agentVisiteDetailCancellationReasonEnumValues =
    BuiltSet<AgentVisiteDetailCancellationReasonEnum>(
      const <AgentVisiteDetailCancellationReasonEnum>[
        _$agentVisiteDetailCancellationReasonEnum_BY_USER,
        _$agentVisiteDetailCancellationReasonEnum_BY_AGENT,
        _$agentVisiteDetailCancellationReasonEnum_AGENT_UNAVAILABLE,
        _$agentVisiteDetailCancellationReasonEnum_AGENT_REMOVED,
        _$agentVisiteDetailCancellationReasonEnum_LISTING_UNAVAILABLE,
        _$agentVisiteDetailCancellationReasonEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<AgentVisiteDetailStatusEnum>
_$agentVisiteDetailStatusEnumSerializer =
    _$AgentVisiteDetailStatusEnumSerializer();
Serializer<AgentVisiteDetailCancellationReasonEnum>
_$agentVisiteDetailCancellationReasonEnumSerializer =
    _$AgentVisiteDetailCancellationReasonEnumSerializer();

class _$AgentVisiteDetailStatusEnumSerializer
    implements PrimitiveSerializer<AgentVisiteDetailStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'REQUESTED': 'REQUESTED',
    'SCHEDULED': 'SCHEDULED',
    'CANCELLED': 'CANCELLED',
    'COMPLETED': 'COMPLETED',
    'NOT_FULFILLED': 'NOT_FULFILLED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'REQUESTED': 'REQUESTED',
    'SCHEDULED': 'SCHEDULED',
    'CANCELLED': 'CANCELLED',
    'COMPLETED': 'COMPLETED',
    'NOT_FULFILLED': 'NOT_FULFILLED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AgentVisiteDetailStatusEnum];
  @override
  final String wireName = 'AgentVisiteDetailStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    AgentVisiteDetailStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AgentVisiteDetailStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AgentVisiteDetailStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AgentVisiteDetailCancellationReasonEnumSerializer
    implements PrimitiveSerializer<AgentVisiteDetailCancellationReasonEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BY_USER': 'BY_USER',
    'BY_AGENT': 'BY_AGENT',
    'AGENT_UNAVAILABLE': 'AGENT_UNAVAILABLE',
    'AGENT_REMOVED': 'AGENT_REMOVED',
    'LISTING_UNAVAILABLE': 'LISTING_UNAVAILABLE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BY_USER': 'BY_USER',
    'BY_AGENT': 'BY_AGENT',
    'AGENT_UNAVAILABLE': 'AGENT_UNAVAILABLE',
    'AGENT_REMOVED': 'AGENT_REMOVED',
    'LISTING_UNAVAILABLE': 'LISTING_UNAVAILABLE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AgentVisiteDetailCancellationReasonEnum,
  ];
  @override
  final String wireName = 'AgentVisiteDetailCancellationReasonEnum';

  @override
  Object serialize(
    Serializers serializers,
    AgentVisiteDetailCancellationReasonEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AgentVisiteDetailCancellationReasonEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AgentVisiteDetailCancellationReasonEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AgentVisiteDetail extends AgentVisiteDetail {
  @override
  final String? id;
  @override
  final String? annonceId;
  @override
  final String? annonceTitle;
  @override
  final String? exactAddress;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final DateTime? scheduledAt;
  @override
  final AgentVisiteDetailStatusEnum? status;
  @override
  final String? userName;
  @override
  final String? userPhone;
  @override
  final String? prestataireName;
  @override
  final String? prestatairePhone;
  @override
  final DateTime? visitorConfirmedAt;
  @override
  final DateTime? clientConfirmedAt;
  @override
  final bool? canConfirm;
  @override
  final String? userAccountId;
  @override
  final VisitorSummary? visitor;
  @override
  final AgentVisiteDetailCancellationReasonEnum? cancellationReason;
  @override
  final String? reviewId;
  @override
  final bool? readOnly;

  factory _$AgentVisiteDetail([
    void Function(AgentVisiteDetailBuilder)? updates,
  ]) => (AgentVisiteDetailBuilder()..update(updates))._build();

  _$AgentVisiteDetail._({
    this.id,
    this.annonceId,
    this.annonceTitle,
    this.exactAddress,
    this.latitude,
    this.longitude,
    this.scheduledAt,
    this.status,
    this.userName,
    this.userPhone,
    this.prestataireName,
    this.prestatairePhone,
    this.visitorConfirmedAt,
    this.clientConfirmedAt,
    this.canConfirm,
    this.userAccountId,
    this.visitor,
    this.cancellationReason,
    this.reviewId,
    this.readOnly,
  }) : super._();
  @override
  AgentVisiteDetail rebuild(void Function(AgentVisiteDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AgentVisiteDetailBuilder toBuilder() =>
      AgentVisiteDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AgentVisiteDetail &&
        id == other.id &&
        annonceId == other.annonceId &&
        annonceTitle == other.annonceTitle &&
        exactAddress == other.exactAddress &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        scheduledAt == other.scheduledAt &&
        status == other.status &&
        userName == other.userName &&
        userPhone == other.userPhone &&
        prestataireName == other.prestataireName &&
        prestatairePhone == other.prestatairePhone &&
        visitorConfirmedAt == other.visitorConfirmedAt &&
        clientConfirmedAt == other.clientConfirmedAt &&
        canConfirm == other.canConfirm &&
        userAccountId == other.userAccountId &&
        visitor == other.visitor &&
        cancellationReason == other.cancellationReason &&
        reviewId == other.reviewId &&
        readOnly == other.readOnly;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, annonceTitle.hashCode);
    _$hash = $jc(_$hash, exactAddress.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, scheduledAt.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, userPhone.hashCode);
    _$hash = $jc(_$hash, prestataireName.hashCode);
    _$hash = $jc(_$hash, prestatairePhone.hashCode);
    _$hash = $jc(_$hash, visitorConfirmedAt.hashCode);
    _$hash = $jc(_$hash, clientConfirmedAt.hashCode);
    _$hash = $jc(_$hash, canConfirm.hashCode);
    _$hash = $jc(_$hash, userAccountId.hashCode);
    _$hash = $jc(_$hash, visitor.hashCode);
    _$hash = $jc(_$hash, cancellationReason.hashCode);
    _$hash = $jc(_$hash, reviewId.hashCode);
    _$hash = $jc(_$hash, readOnly.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AgentVisiteDetail')
          ..add('id', id)
          ..add('annonceId', annonceId)
          ..add('annonceTitle', annonceTitle)
          ..add('exactAddress', exactAddress)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('scheduledAt', scheduledAt)
          ..add('status', status)
          ..add('userName', userName)
          ..add('userPhone', userPhone)
          ..add('prestataireName', prestataireName)
          ..add('prestatairePhone', prestatairePhone)
          ..add('visitorConfirmedAt', visitorConfirmedAt)
          ..add('clientConfirmedAt', clientConfirmedAt)
          ..add('canConfirm', canConfirm)
          ..add('userAccountId', userAccountId)
          ..add('visitor', visitor)
          ..add('cancellationReason', cancellationReason)
          ..add('reviewId', reviewId)
          ..add('readOnly', readOnly))
        .toString();
  }
}

class AgentVisiteDetailBuilder
    implements Builder<AgentVisiteDetail, AgentVisiteDetailBuilder> {
  _$AgentVisiteDetail? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _annonceTitle;
  String? get annonceTitle => _$this._annonceTitle;
  set annonceTitle(String? annonceTitle) => _$this._annonceTitle = annonceTitle;

  String? _exactAddress;
  String? get exactAddress => _$this._exactAddress;
  set exactAddress(String? exactAddress) => _$this._exactAddress = exactAddress;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  DateTime? _scheduledAt;
  DateTime? get scheduledAt => _$this._scheduledAt;
  set scheduledAt(DateTime? scheduledAt) => _$this._scheduledAt = scheduledAt;

  AgentVisiteDetailStatusEnum? _status;
  AgentVisiteDetailStatusEnum? get status => _$this._status;
  set status(AgentVisiteDetailStatusEnum? status) => _$this._status = status;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _userPhone;
  String? get userPhone => _$this._userPhone;
  set userPhone(String? userPhone) => _$this._userPhone = userPhone;

  String? _prestataireName;
  String? get prestataireName => _$this._prestataireName;
  set prestataireName(String? prestataireName) =>
      _$this._prestataireName = prestataireName;

  String? _prestatairePhone;
  String? get prestatairePhone => _$this._prestatairePhone;
  set prestatairePhone(String? prestatairePhone) =>
      _$this._prestatairePhone = prestatairePhone;

  DateTime? _visitorConfirmedAt;
  DateTime? get visitorConfirmedAt => _$this._visitorConfirmedAt;
  set visitorConfirmedAt(DateTime? visitorConfirmedAt) =>
      _$this._visitorConfirmedAt = visitorConfirmedAt;

  DateTime? _clientConfirmedAt;
  DateTime? get clientConfirmedAt => _$this._clientConfirmedAt;
  set clientConfirmedAt(DateTime? clientConfirmedAt) =>
      _$this._clientConfirmedAt = clientConfirmedAt;

  bool? _canConfirm;
  bool? get canConfirm => _$this._canConfirm;
  set canConfirm(bool? canConfirm) => _$this._canConfirm = canConfirm;

  String? _userAccountId;
  String? get userAccountId => _$this._userAccountId;
  set userAccountId(String? userAccountId) =>
      _$this._userAccountId = userAccountId;

  VisitorSummaryBuilder? _visitor;
  VisitorSummaryBuilder get visitor =>
      _$this._visitor ??= VisitorSummaryBuilder();
  set visitor(VisitorSummaryBuilder? visitor) => _$this._visitor = visitor;

  AgentVisiteDetailCancellationReasonEnum? _cancellationReason;
  AgentVisiteDetailCancellationReasonEnum? get cancellationReason =>
      _$this._cancellationReason;
  set cancellationReason(
    AgentVisiteDetailCancellationReasonEnum? cancellationReason,
  ) => _$this._cancellationReason = cancellationReason;

  String? _reviewId;
  String? get reviewId => _$this._reviewId;
  set reviewId(String? reviewId) => _$this._reviewId = reviewId;

  bool? _readOnly;
  bool? get readOnly => _$this._readOnly;
  set readOnly(bool? readOnly) => _$this._readOnly = readOnly;

  AgentVisiteDetailBuilder() {
    AgentVisiteDetail._defaults(this);
  }

  AgentVisiteDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _annonceId = $v.annonceId;
      _annonceTitle = $v.annonceTitle;
      _exactAddress = $v.exactAddress;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _scheduledAt = $v.scheduledAt;
      _status = $v.status;
      _userName = $v.userName;
      _userPhone = $v.userPhone;
      _prestataireName = $v.prestataireName;
      _prestatairePhone = $v.prestatairePhone;
      _visitorConfirmedAt = $v.visitorConfirmedAt;
      _clientConfirmedAt = $v.clientConfirmedAt;
      _canConfirm = $v.canConfirm;
      _userAccountId = $v.userAccountId;
      _visitor = $v.visitor?.toBuilder();
      _cancellationReason = $v.cancellationReason;
      _reviewId = $v.reviewId;
      _readOnly = $v.readOnly;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AgentVisiteDetail other) {
    _$v = other as _$AgentVisiteDetail;
  }

  @override
  void update(void Function(AgentVisiteDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AgentVisiteDetail build() => _build();

  _$AgentVisiteDetail _build() {
    _$AgentVisiteDetail _$result;
    try {
      _$result =
          _$v ??
          _$AgentVisiteDetail._(
            id: id,
            annonceId: annonceId,
            annonceTitle: annonceTitle,
            exactAddress: exactAddress,
            latitude: latitude,
            longitude: longitude,
            scheduledAt: scheduledAt,
            status: status,
            userName: userName,
            userPhone: userPhone,
            prestataireName: prestataireName,
            prestatairePhone: prestatairePhone,
            visitorConfirmedAt: visitorConfirmedAt,
            clientConfirmedAt: clientConfirmedAt,
            canConfirm: canConfirm,
            userAccountId: userAccountId,
            visitor: _visitor?.build(),
            cancellationReason: cancellationReason,
            reviewId: reviewId,
            readOnly: readOnly,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'visitor';
        _visitor?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AgentVisiteDetail',
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
