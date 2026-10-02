// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_verification_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PhotoVerificationResponseTargetEnum
_$photoVerificationResponseTargetEnum_ANNONCE =
    const PhotoVerificationResponseTargetEnum._('ANNONCE');
const PhotoVerificationResponseTargetEnum
_$photoVerificationResponseTargetEnum_RESIDENCE =
    const PhotoVerificationResponseTargetEnum._('RESIDENCE');
const PhotoVerificationResponseTargetEnum
_$photoVerificationResponseTargetEnum_unknownDefaultOpenApi =
    const PhotoVerificationResponseTargetEnum._('unknownDefaultOpenApi');

PhotoVerificationResponseTargetEnum
_$photoVerificationResponseTargetEnumValueOf(String name) {
  switch (name) {
    case 'ANNONCE':
      return _$photoVerificationResponseTargetEnum_ANNONCE;
    case 'RESIDENCE':
      return _$photoVerificationResponseTargetEnum_RESIDENCE;
    case 'unknownDefaultOpenApi':
      return _$photoVerificationResponseTargetEnum_unknownDefaultOpenApi;
    default:
      return _$photoVerificationResponseTargetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PhotoVerificationResponseTargetEnum>
_$photoVerificationResponseTargetEnumValues =
    BuiltSet<PhotoVerificationResponseTargetEnum>(
      const <PhotoVerificationResponseTargetEnum>[
        _$photoVerificationResponseTargetEnum_ANNONCE,
        _$photoVerificationResponseTargetEnum_RESIDENCE,
        _$photoVerificationResponseTargetEnum_unknownDefaultOpenApi,
      ],
    );

const PhotoVerificationResponseStatusEnum
_$photoVerificationResponseStatusEnum_PENDING =
    const PhotoVerificationResponseStatusEnum._('PENDING');
const PhotoVerificationResponseStatusEnum
_$photoVerificationResponseStatusEnum_APPROVED =
    const PhotoVerificationResponseStatusEnum._('APPROVED');
const PhotoVerificationResponseStatusEnum
_$photoVerificationResponseStatusEnum_REJECTED =
    const PhotoVerificationResponseStatusEnum._('REJECTED');
const PhotoVerificationResponseStatusEnum
_$photoVerificationResponseStatusEnum_REVOKED =
    const PhotoVerificationResponseStatusEnum._('REVOKED');
const PhotoVerificationResponseStatusEnum
_$photoVerificationResponseStatusEnum_unknownDefaultOpenApi =
    const PhotoVerificationResponseStatusEnum._('unknownDefaultOpenApi');

PhotoVerificationResponseStatusEnum
_$photoVerificationResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'PENDING':
      return _$photoVerificationResponseStatusEnum_PENDING;
    case 'APPROVED':
      return _$photoVerificationResponseStatusEnum_APPROVED;
    case 'REJECTED':
      return _$photoVerificationResponseStatusEnum_REJECTED;
    case 'REVOKED':
      return _$photoVerificationResponseStatusEnum_REVOKED;
    case 'unknownDefaultOpenApi':
      return _$photoVerificationResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$photoVerificationResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PhotoVerificationResponseStatusEnum>
_$photoVerificationResponseStatusEnumValues =
    BuiltSet<PhotoVerificationResponseStatusEnum>(
      const <PhotoVerificationResponseStatusEnum>[
        _$photoVerificationResponseStatusEnum_PENDING,
        _$photoVerificationResponseStatusEnum_APPROVED,
        _$photoVerificationResponseStatusEnum_REJECTED,
        _$photoVerificationResponseStatusEnum_REVOKED,
        _$photoVerificationResponseStatusEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<PhotoVerificationResponseTargetEnum>
_$photoVerificationResponseTargetEnumSerializer =
    _$PhotoVerificationResponseTargetEnumSerializer();
Serializer<PhotoVerificationResponseStatusEnum>
_$photoVerificationResponseStatusEnumSerializer =
    _$PhotoVerificationResponseStatusEnumSerializer();

class _$PhotoVerificationResponseTargetEnumSerializer
    implements PrimitiveSerializer<PhotoVerificationResponseTargetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ANNONCE': 'ANNONCE',
    'RESIDENCE': 'RESIDENCE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ANNONCE': 'ANNONCE',
    'RESIDENCE': 'RESIDENCE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PhotoVerificationResponseTargetEnum,
  ];
  @override
  final String wireName = 'PhotoVerificationResponseTargetEnum';

  @override
  Object serialize(
    Serializers serializers,
    PhotoVerificationResponseTargetEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PhotoVerificationResponseTargetEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PhotoVerificationResponseTargetEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PhotoVerificationResponseStatusEnumSerializer
    implements PrimitiveSerializer<PhotoVerificationResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
    'APPROVED': 'APPROVED',
    'REJECTED': 'REJECTED',
    'REVOKED': 'REVOKED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
    'APPROVED': 'APPROVED',
    'REJECTED': 'REJECTED',
    'REVOKED': 'REVOKED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PhotoVerificationResponseStatusEnum,
  ];
  @override
  final String wireName = 'PhotoVerificationResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    PhotoVerificationResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PhotoVerificationResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PhotoVerificationResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PhotoVerificationResponse extends PhotoVerificationResponse {
  @override
  final String? id;
  @override
  final PhotoVerificationResponseTargetEnum? target;
  @override
  final String? targetId;
  @override
  final PhotoVerificationResponseStatusEnum? status;
  @override
  final DateTime? requestedAt;
  @override
  final DateTime? dueAt;
  @override
  final DateTime? decidedAt;
  @override
  final String? reason;

  factory _$PhotoVerificationResponse([
    void Function(PhotoVerificationResponseBuilder)? updates,
  ]) => (PhotoVerificationResponseBuilder()..update(updates))._build();

  _$PhotoVerificationResponse._({
    this.id,
    this.target,
    this.targetId,
    this.status,
    this.requestedAt,
    this.dueAt,
    this.decidedAt,
    this.reason,
  }) : super._();
  @override
  PhotoVerificationResponse rebuild(
    void Function(PhotoVerificationResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PhotoVerificationResponseBuilder toBuilder() =>
      PhotoVerificationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PhotoVerificationResponse &&
        id == other.id &&
        target == other.target &&
        targetId == other.targetId &&
        status == other.status &&
        requestedAt == other.requestedAt &&
        dueAt == other.dueAt &&
        decidedAt == other.decidedAt &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, target.hashCode);
    _$hash = $jc(_$hash, targetId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, requestedAt.hashCode);
    _$hash = $jc(_$hash, dueAt.hashCode);
    _$hash = $jc(_$hash, decidedAt.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PhotoVerificationResponse')
          ..add('id', id)
          ..add('target', target)
          ..add('targetId', targetId)
          ..add('status', status)
          ..add('requestedAt', requestedAt)
          ..add('dueAt', dueAt)
          ..add('decidedAt', decidedAt)
          ..add('reason', reason))
        .toString();
  }
}

class PhotoVerificationResponseBuilder
    implements
        Builder<PhotoVerificationResponse, PhotoVerificationResponseBuilder> {
  _$PhotoVerificationResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  PhotoVerificationResponseTargetEnum? _target;
  PhotoVerificationResponseTargetEnum? get target => _$this._target;
  set target(PhotoVerificationResponseTargetEnum? target) =>
      _$this._target = target;

  String? _targetId;
  String? get targetId => _$this._targetId;
  set targetId(String? targetId) => _$this._targetId = targetId;

  PhotoVerificationResponseStatusEnum? _status;
  PhotoVerificationResponseStatusEnum? get status => _$this._status;
  set status(PhotoVerificationResponseStatusEnum? status) =>
      _$this._status = status;

  DateTime? _requestedAt;
  DateTime? get requestedAt => _$this._requestedAt;
  set requestedAt(DateTime? requestedAt) => _$this._requestedAt = requestedAt;

  DateTime? _dueAt;
  DateTime? get dueAt => _$this._dueAt;
  set dueAt(DateTime? dueAt) => _$this._dueAt = dueAt;

  DateTime? _decidedAt;
  DateTime? get decidedAt => _$this._decidedAt;
  set decidedAt(DateTime? decidedAt) => _$this._decidedAt = decidedAt;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  PhotoVerificationResponseBuilder() {
    PhotoVerificationResponse._defaults(this);
  }

  PhotoVerificationResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _target = $v.target;
      _targetId = $v.targetId;
      _status = $v.status;
      _requestedAt = $v.requestedAt;
      _dueAt = $v.dueAt;
      _decidedAt = $v.decidedAt;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PhotoVerificationResponse other) {
    _$v = other as _$PhotoVerificationResponse;
  }

  @override
  void update(void Function(PhotoVerificationResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PhotoVerificationResponse build() => _build();

  _$PhotoVerificationResponse _build() {
    final _$result =
        _$v ??
        _$PhotoVerificationResponse._(
          id: id,
          target: target,
          targetId: targetId,
          status: status,
          requestedAt: requestedAt,
          dueAt: dueAt,
          decidedAt: decidedAt,
          reason: reason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
