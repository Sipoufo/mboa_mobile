// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visite_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const VisiteResponseStatusEnum _$visiteResponseStatusEnum_SCHEDULED =
    const VisiteResponseStatusEnum._('SCHEDULED');
const VisiteResponseStatusEnum _$visiteResponseStatusEnum_CANCELLED =
    const VisiteResponseStatusEnum._('CANCELLED');
const VisiteResponseStatusEnum _$visiteResponseStatusEnum_COMPLETED =
    const VisiteResponseStatusEnum._('COMPLETED');
const VisiteResponseStatusEnum
_$visiteResponseStatusEnum_unknownDefaultOpenApi =
    const VisiteResponseStatusEnum._('unknownDefaultOpenApi');

VisiteResponseStatusEnum _$visiteResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'SCHEDULED':
      return _$visiteResponseStatusEnum_SCHEDULED;
    case 'CANCELLED':
      return _$visiteResponseStatusEnum_CANCELLED;
    case 'COMPLETED':
      return _$visiteResponseStatusEnum_COMPLETED;
    case 'unknownDefaultOpenApi':
      return _$visiteResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$visiteResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<VisiteResponseStatusEnum> _$visiteResponseStatusEnumValues =
    BuiltSet<VisiteResponseStatusEnum>(const <VisiteResponseStatusEnum>[
      _$visiteResponseStatusEnum_SCHEDULED,
      _$visiteResponseStatusEnum_CANCELLED,
      _$visiteResponseStatusEnum_COMPLETED,
      _$visiteResponseStatusEnum_unknownDefaultOpenApi,
    ]);

const VisiteResponseCancellationReasonEnum
_$visiteResponseCancellationReasonEnum_BY_USER =
    const VisiteResponseCancellationReasonEnum._('BY_USER');
const VisiteResponseCancellationReasonEnum
_$visiteResponseCancellationReasonEnum_BY_AGENT =
    const VisiteResponseCancellationReasonEnum._('BY_AGENT');
const VisiteResponseCancellationReasonEnum
_$visiteResponseCancellationReasonEnum_AGENT_UNAVAILABLE =
    const VisiteResponseCancellationReasonEnum._('AGENT_UNAVAILABLE');
const VisiteResponseCancellationReasonEnum
_$visiteResponseCancellationReasonEnum_AGENT_REMOVED =
    const VisiteResponseCancellationReasonEnum._('AGENT_REMOVED');
const VisiteResponseCancellationReasonEnum
_$visiteResponseCancellationReasonEnum_unknownDefaultOpenApi =
    const VisiteResponseCancellationReasonEnum._('unknownDefaultOpenApi');

VisiteResponseCancellationReasonEnum
_$visiteResponseCancellationReasonEnumValueOf(String name) {
  switch (name) {
    case 'BY_USER':
      return _$visiteResponseCancellationReasonEnum_BY_USER;
    case 'BY_AGENT':
      return _$visiteResponseCancellationReasonEnum_BY_AGENT;
    case 'AGENT_UNAVAILABLE':
      return _$visiteResponseCancellationReasonEnum_AGENT_UNAVAILABLE;
    case 'AGENT_REMOVED':
      return _$visiteResponseCancellationReasonEnum_AGENT_REMOVED;
    case 'unknownDefaultOpenApi':
      return _$visiteResponseCancellationReasonEnum_unknownDefaultOpenApi;
    default:
      return _$visiteResponseCancellationReasonEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<VisiteResponseCancellationReasonEnum>
_$visiteResponseCancellationReasonEnumValues =
    BuiltSet<VisiteResponseCancellationReasonEnum>(
      const <VisiteResponseCancellationReasonEnum>[
        _$visiteResponseCancellationReasonEnum_BY_USER,
        _$visiteResponseCancellationReasonEnum_BY_AGENT,
        _$visiteResponseCancellationReasonEnum_AGENT_UNAVAILABLE,
        _$visiteResponseCancellationReasonEnum_AGENT_REMOVED,
        _$visiteResponseCancellationReasonEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<VisiteResponseStatusEnum> _$visiteResponseStatusEnumSerializer =
    _$VisiteResponseStatusEnumSerializer();
Serializer<VisiteResponseCancellationReasonEnum>
_$visiteResponseCancellationReasonEnumSerializer =
    _$VisiteResponseCancellationReasonEnumSerializer();

class _$VisiteResponseStatusEnumSerializer
    implements PrimitiveSerializer<VisiteResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'SCHEDULED': 'SCHEDULED',
    'CANCELLED': 'CANCELLED',
    'COMPLETED': 'COMPLETED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'SCHEDULED': 'SCHEDULED',
    'CANCELLED': 'CANCELLED',
    'COMPLETED': 'COMPLETED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[VisiteResponseStatusEnum];
  @override
  final String wireName = 'VisiteResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    VisiteResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  VisiteResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => VisiteResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$VisiteResponseCancellationReasonEnumSerializer
    implements PrimitiveSerializer<VisiteResponseCancellationReasonEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BY_USER': 'BY_USER',
    'BY_AGENT': 'BY_AGENT',
    'AGENT_UNAVAILABLE': 'AGENT_UNAVAILABLE',
    'AGENT_REMOVED': 'AGENT_REMOVED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BY_USER': 'BY_USER',
    'BY_AGENT': 'BY_AGENT',
    'AGENT_UNAVAILABLE': 'AGENT_UNAVAILABLE',
    'AGENT_REMOVED': 'AGENT_REMOVED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    VisiteResponseCancellationReasonEnum,
  ];
  @override
  final String wireName = 'VisiteResponseCancellationReasonEnum';

  @override
  Object serialize(
    Serializers serializers,
    VisiteResponseCancellationReasonEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  VisiteResponseCancellationReasonEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => VisiteResponseCancellationReasonEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$VisiteResponse extends VisiteResponse {
  @override
  final String? id;
  @override
  final String? annonceId;
  @override
  final String? annonceTitle;
  @override
  final String? agentAccountId;
  @override
  final DateTime? scheduledAt;
  @override
  final VisiteResponseStatusEnum? status;
  @override
  final VisiteResponseCancellationReasonEnum? cancellationReason;
  @override
  final DateTime? createdAt;

  factory _$VisiteResponse([void Function(VisiteResponseBuilder)? updates]) =>
      (VisiteResponseBuilder()..update(updates))._build();

  _$VisiteResponse._({
    this.id,
    this.annonceId,
    this.annonceTitle,
    this.agentAccountId,
    this.scheduledAt,
    this.status,
    this.cancellationReason,
    this.createdAt,
  }) : super._();
  @override
  VisiteResponse rebuild(void Function(VisiteResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VisiteResponseBuilder toBuilder() => VisiteResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VisiteResponse &&
        id == other.id &&
        annonceId == other.annonceId &&
        annonceTitle == other.annonceTitle &&
        agentAccountId == other.agentAccountId &&
        scheduledAt == other.scheduledAt &&
        status == other.status &&
        cancellationReason == other.cancellationReason &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, annonceTitle.hashCode);
    _$hash = $jc(_$hash, agentAccountId.hashCode);
    _$hash = $jc(_$hash, scheduledAt.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, cancellationReason.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VisiteResponse')
          ..add('id', id)
          ..add('annonceId', annonceId)
          ..add('annonceTitle', annonceTitle)
          ..add('agentAccountId', agentAccountId)
          ..add('scheduledAt', scheduledAt)
          ..add('status', status)
          ..add('cancellationReason', cancellationReason)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class VisiteResponseBuilder
    implements Builder<VisiteResponse, VisiteResponseBuilder> {
  _$VisiteResponse? _$v;

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

  DateTime? _scheduledAt;
  DateTime? get scheduledAt => _$this._scheduledAt;
  set scheduledAt(DateTime? scheduledAt) => _$this._scheduledAt = scheduledAt;

  VisiteResponseStatusEnum? _status;
  VisiteResponseStatusEnum? get status => _$this._status;
  set status(VisiteResponseStatusEnum? status) => _$this._status = status;

  VisiteResponseCancellationReasonEnum? _cancellationReason;
  VisiteResponseCancellationReasonEnum? get cancellationReason =>
      _$this._cancellationReason;
  set cancellationReason(
    VisiteResponseCancellationReasonEnum? cancellationReason,
  ) => _$this._cancellationReason = cancellationReason;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  VisiteResponseBuilder() {
    VisiteResponse._defaults(this);
  }

  VisiteResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _annonceId = $v.annonceId;
      _annonceTitle = $v.annonceTitle;
      _agentAccountId = $v.agentAccountId;
      _scheduledAt = $v.scheduledAt;
      _status = $v.status;
      _cancellationReason = $v.cancellationReason;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VisiteResponse other) {
    _$v = other as _$VisiteResponse;
  }

  @override
  void update(void Function(VisiteResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VisiteResponse build() => _build();

  _$VisiteResponse _build() {
    final _$result =
        _$v ??
        _$VisiteResponse._(
          id: id,
          annonceId: annonceId,
          annonceTitle: annonceTitle,
          agentAccountId: agentAccountId,
          scheduledAt: scheduledAt,
          status: status,
          cancellationReason: cancellationReason,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
