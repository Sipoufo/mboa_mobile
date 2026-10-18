// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_visit_line.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdminVisitLineStatusEnum _$adminVisitLineStatusEnum_REQUESTED =
    const AdminVisitLineStatusEnum._('REQUESTED');
const AdminVisitLineStatusEnum _$adminVisitLineStatusEnum_SCHEDULED =
    const AdminVisitLineStatusEnum._('SCHEDULED');
const AdminVisitLineStatusEnum _$adminVisitLineStatusEnum_CANCELLED =
    const AdminVisitLineStatusEnum._('CANCELLED');
const AdminVisitLineStatusEnum _$adminVisitLineStatusEnum_COMPLETED =
    const AdminVisitLineStatusEnum._('COMPLETED');
const AdminVisitLineStatusEnum _$adminVisitLineStatusEnum_NOT_FULFILLED =
    const AdminVisitLineStatusEnum._('NOT_FULFILLED');
const AdminVisitLineStatusEnum
_$adminVisitLineStatusEnum_unknownDefaultOpenApi =
    const AdminVisitLineStatusEnum._('unknownDefaultOpenApi');

AdminVisitLineStatusEnum _$adminVisitLineStatusEnumValueOf(String name) {
  switch (name) {
    case 'REQUESTED':
      return _$adminVisitLineStatusEnum_REQUESTED;
    case 'SCHEDULED':
      return _$adminVisitLineStatusEnum_SCHEDULED;
    case 'CANCELLED':
      return _$adminVisitLineStatusEnum_CANCELLED;
    case 'COMPLETED':
      return _$adminVisitLineStatusEnum_COMPLETED;
    case 'NOT_FULFILLED':
      return _$adminVisitLineStatusEnum_NOT_FULFILLED;
    case 'unknownDefaultOpenApi':
      return _$adminVisitLineStatusEnum_unknownDefaultOpenApi;
    default:
      return _$adminVisitLineStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminVisitLineStatusEnum> _$adminVisitLineStatusEnumValues =
    BuiltSet<AdminVisitLineStatusEnum>(const <AdminVisitLineStatusEnum>[
      _$adminVisitLineStatusEnum_REQUESTED,
      _$adminVisitLineStatusEnum_SCHEDULED,
      _$adminVisitLineStatusEnum_CANCELLED,
      _$adminVisitLineStatusEnum_COMPLETED,
      _$adminVisitLineStatusEnum_NOT_FULFILLED,
      _$adminVisitLineStatusEnum_unknownDefaultOpenApi,
    ]);

const AdminVisitLineCancellationReasonEnum
_$adminVisitLineCancellationReasonEnum_BY_USER =
    const AdminVisitLineCancellationReasonEnum._('BY_USER');
const AdminVisitLineCancellationReasonEnum
_$adminVisitLineCancellationReasonEnum_BY_AGENT =
    const AdminVisitLineCancellationReasonEnum._('BY_AGENT');
const AdminVisitLineCancellationReasonEnum
_$adminVisitLineCancellationReasonEnum_AGENT_UNAVAILABLE =
    const AdminVisitLineCancellationReasonEnum._('AGENT_UNAVAILABLE');
const AdminVisitLineCancellationReasonEnum
_$adminVisitLineCancellationReasonEnum_AGENT_REMOVED =
    const AdminVisitLineCancellationReasonEnum._('AGENT_REMOVED');
const AdminVisitLineCancellationReasonEnum
_$adminVisitLineCancellationReasonEnum_LISTING_UNAVAILABLE =
    const AdminVisitLineCancellationReasonEnum._('LISTING_UNAVAILABLE');
const AdminVisitLineCancellationReasonEnum
_$adminVisitLineCancellationReasonEnum_unknownDefaultOpenApi =
    const AdminVisitLineCancellationReasonEnum._('unknownDefaultOpenApi');

AdminVisitLineCancellationReasonEnum
_$adminVisitLineCancellationReasonEnumValueOf(String name) {
  switch (name) {
    case 'BY_USER':
      return _$adminVisitLineCancellationReasonEnum_BY_USER;
    case 'BY_AGENT':
      return _$adminVisitLineCancellationReasonEnum_BY_AGENT;
    case 'AGENT_UNAVAILABLE':
      return _$adminVisitLineCancellationReasonEnum_AGENT_UNAVAILABLE;
    case 'AGENT_REMOVED':
      return _$adminVisitLineCancellationReasonEnum_AGENT_REMOVED;
    case 'LISTING_UNAVAILABLE':
      return _$adminVisitLineCancellationReasonEnum_LISTING_UNAVAILABLE;
    case 'unknownDefaultOpenApi':
      return _$adminVisitLineCancellationReasonEnum_unknownDefaultOpenApi;
    default:
      return _$adminVisitLineCancellationReasonEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminVisitLineCancellationReasonEnum>
_$adminVisitLineCancellationReasonEnumValues =
    BuiltSet<AdminVisitLineCancellationReasonEnum>(
      const <AdminVisitLineCancellationReasonEnum>[
        _$adminVisitLineCancellationReasonEnum_BY_USER,
        _$adminVisitLineCancellationReasonEnum_BY_AGENT,
        _$adminVisitLineCancellationReasonEnum_AGENT_UNAVAILABLE,
        _$adminVisitLineCancellationReasonEnum_AGENT_REMOVED,
        _$adminVisitLineCancellationReasonEnum_LISTING_UNAVAILABLE,
        _$adminVisitLineCancellationReasonEnum_unknownDefaultOpenApi,
      ],
    );

const AdminVisitLineVisitorKindEnum _$adminVisitLineVisitorKindEnum_AGENT =
    const AdminVisitLineVisitorKindEnum._('AGENT');
const AdminVisitLineVisitorKindEnum _$adminVisitLineVisitorKindEnum_OWNER =
    const AdminVisitLineVisitorKindEnum._('OWNER');
const AdminVisitLineVisitorKindEnum
_$adminVisitLineVisitorKindEnum_unknownDefaultOpenApi =
    const AdminVisitLineVisitorKindEnum._('unknownDefaultOpenApi');

AdminVisitLineVisitorKindEnum _$adminVisitLineVisitorKindEnumValueOf(
  String name,
) {
  switch (name) {
    case 'AGENT':
      return _$adminVisitLineVisitorKindEnum_AGENT;
    case 'OWNER':
      return _$adminVisitLineVisitorKindEnum_OWNER;
    case 'unknownDefaultOpenApi':
      return _$adminVisitLineVisitorKindEnum_unknownDefaultOpenApi;
    default:
      return _$adminVisitLineVisitorKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminVisitLineVisitorKindEnum>
_$adminVisitLineVisitorKindEnumValues = BuiltSet<AdminVisitLineVisitorKindEnum>(
  const <AdminVisitLineVisitorKindEnum>[
    _$adminVisitLineVisitorKindEnum_AGENT,
    _$adminVisitLineVisitorKindEnum_OWNER,
    _$adminVisitLineVisitorKindEnum_unknownDefaultOpenApi,
  ],
);

Serializer<AdminVisitLineStatusEnum> _$adminVisitLineStatusEnumSerializer =
    _$AdminVisitLineStatusEnumSerializer();
Serializer<AdminVisitLineCancellationReasonEnum>
_$adminVisitLineCancellationReasonEnumSerializer =
    _$AdminVisitLineCancellationReasonEnumSerializer();
Serializer<AdminVisitLineVisitorKindEnum>
_$adminVisitLineVisitorKindEnumSerializer =
    _$AdminVisitLineVisitorKindEnumSerializer();

class _$AdminVisitLineStatusEnumSerializer
    implements PrimitiveSerializer<AdminVisitLineStatusEnum> {
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
  final Iterable<Type> types = const <Type>[AdminVisitLineStatusEnum];
  @override
  final String wireName = 'AdminVisitLineStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminVisitLineStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminVisitLineStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminVisitLineStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminVisitLineCancellationReasonEnumSerializer
    implements PrimitiveSerializer<AdminVisitLineCancellationReasonEnum> {
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
    AdminVisitLineCancellationReasonEnum,
  ];
  @override
  final String wireName = 'AdminVisitLineCancellationReasonEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminVisitLineCancellationReasonEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminVisitLineCancellationReasonEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminVisitLineCancellationReasonEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminVisitLineVisitorKindEnumSerializer
    implements PrimitiveSerializer<AdminVisitLineVisitorKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'AGENT': 'AGENT',
    'OWNER': 'OWNER',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'AGENT': 'AGENT',
    'OWNER': 'OWNER',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AdminVisitLineVisitorKindEnum];
  @override
  final String wireName = 'AdminVisitLineVisitorKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminVisitLineVisitorKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminVisitLineVisitorKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminVisitLineVisitorKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminVisitLine extends AdminVisitLine {
  @override
  final String? visiteId;
  @override
  final String? annonceId;
  @override
  final String? annonceTitle;
  @override
  final DateTime? scheduledAt;
  @override
  final AdminVisitLineStatusEnum? status;
  @override
  final AdminVisitLineCancellationReasonEnum? cancellationReason;
  @override
  final AdminVisitLineVisitorKindEnum? visitorKind;

  factory _$AdminVisitLine([void Function(AdminVisitLineBuilder)? updates]) =>
      (AdminVisitLineBuilder()..update(updates))._build();

  _$AdminVisitLine._({
    this.visiteId,
    this.annonceId,
    this.annonceTitle,
    this.scheduledAt,
    this.status,
    this.cancellationReason,
    this.visitorKind,
  }) : super._();
  @override
  AdminVisitLine rebuild(void Function(AdminVisitLineBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdminVisitLineBuilder toBuilder() => AdminVisitLineBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminVisitLine &&
        visiteId == other.visiteId &&
        annonceId == other.annonceId &&
        annonceTitle == other.annonceTitle &&
        scheduledAt == other.scheduledAt &&
        status == other.status &&
        cancellationReason == other.cancellationReason &&
        visitorKind == other.visitorKind;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, visiteId.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, annonceTitle.hashCode);
    _$hash = $jc(_$hash, scheduledAt.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, cancellationReason.hashCode);
    _$hash = $jc(_$hash, visitorKind.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminVisitLine')
          ..add('visiteId', visiteId)
          ..add('annonceId', annonceId)
          ..add('annonceTitle', annonceTitle)
          ..add('scheduledAt', scheduledAt)
          ..add('status', status)
          ..add('cancellationReason', cancellationReason)
          ..add('visitorKind', visitorKind))
        .toString();
  }
}

class AdminVisitLineBuilder
    implements Builder<AdminVisitLine, AdminVisitLineBuilder> {
  _$AdminVisitLine? _$v;

  String? _visiteId;
  String? get visiteId => _$this._visiteId;
  set visiteId(String? visiteId) => _$this._visiteId = visiteId;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _annonceTitle;
  String? get annonceTitle => _$this._annonceTitle;
  set annonceTitle(String? annonceTitle) => _$this._annonceTitle = annonceTitle;

  DateTime? _scheduledAt;
  DateTime? get scheduledAt => _$this._scheduledAt;
  set scheduledAt(DateTime? scheduledAt) => _$this._scheduledAt = scheduledAt;

  AdminVisitLineStatusEnum? _status;
  AdminVisitLineStatusEnum? get status => _$this._status;
  set status(AdminVisitLineStatusEnum? status) => _$this._status = status;

  AdminVisitLineCancellationReasonEnum? _cancellationReason;
  AdminVisitLineCancellationReasonEnum? get cancellationReason =>
      _$this._cancellationReason;
  set cancellationReason(
    AdminVisitLineCancellationReasonEnum? cancellationReason,
  ) => _$this._cancellationReason = cancellationReason;

  AdminVisitLineVisitorKindEnum? _visitorKind;
  AdminVisitLineVisitorKindEnum? get visitorKind => _$this._visitorKind;
  set visitorKind(AdminVisitLineVisitorKindEnum? visitorKind) =>
      _$this._visitorKind = visitorKind;

  AdminVisitLineBuilder() {
    AdminVisitLine._defaults(this);
  }

  AdminVisitLineBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _visiteId = $v.visiteId;
      _annonceId = $v.annonceId;
      _annonceTitle = $v.annonceTitle;
      _scheduledAt = $v.scheduledAt;
      _status = $v.status;
      _cancellationReason = $v.cancellationReason;
      _visitorKind = $v.visitorKind;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminVisitLine other) {
    _$v = other as _$AdminVisitLine;
  }

  @override
  void update(void Function(AdminVisitLineBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminVisitLine build() => _build();

  _$AdminVisitLine _build() {
    final _$result =
        _$v ??
        _$AdminVisitLine._(
          visiteId: visiteId,
          annonceId: annonceId,
          annonceTitle: annonceTitle,
          scheduledAt: scheduledAt,
          status: status,
          cancellationReason: cancellationReason,
          visitorKind: visitorKind,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
