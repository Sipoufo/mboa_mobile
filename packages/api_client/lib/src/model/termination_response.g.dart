// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termination_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TerminationResponseRequestedByEnum
_$terminationResponseRequestedByEnum_PRESTATAIRE =
    const TerminationResponseRequestedByEnum._('PRESTATAIRE');
const TerminationResponseRequestedByEnum
_$terminationResponseRequestedByEnum_TENANT =
    const TerminationResponseRequestedByEnum._('TENANT');
const TerminationResponseRequestedByEnum
_$terminationResponseRequestedByEnum_BOTH =
    const TerminationResponseRequestedByEnum._('BOTH');
const TerminationResponseRequestedByEnum
_$terminationResponseRequestedByEnum_NOBODY =
    const TerminationResponseRequestedByEnum._('NOBODY');
const TerminationResponseRequestedByEnum
_$terminationResponseRequestedByEnum_unknownDefaultOpenApi =
    const TerminationResponseRequestedByEnum._('unknownDefaultOpenApi');

TerminationResponseRequestedByEnum _$terminationResponseRequestedByEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PRESTATAIRE':
      return _$terminationResponseRequestedByEnum_PRESTATAIRE;
    case 'TENANT':
      return _$terminationResponseRequestedByEnum_TENANT;
    case 'BOTH':
      return _$terminationResponseRequestedByEnum_BOTH;
    case 'NOBODY':
      return _$terminationResponseRequestedByEnum_NOBODY;
    case 'unknownDefaultOpenApi':
      return _$terminationResponseRequestedByEnum_unknownDefaultOpenApi;
    default:
      return _$terminationResponseRequestedByEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<TerminationResponseRequestedByEnum>
_$terminationResponseRequestedByEnumValues =
    BuiltSet<TerminationResponseRequestedByEnum>(
      const <TerminationResponseRequestedByEnum>[
        _$terminationResponseRequestedByEnum_PRESTATAIRE,
        _$terminationResponseRequestedByEnum_TENANT,
        _$terminationResponseRequestedByEnum_BOTH,
        _$terminationResponseRequestedByEnum_NOBODY,
        _$terminationResponseRequestedByEnum_unknownDefaultOpenApi,
      ],
    );

const TerminationResponseStatusEnum _$terminationResponseStatusEnum_PROPOSED =
    const TerminationResponseStatusEnum._('PROPOSED');
const TerminationResponseStatusEnum _$terminationResponseStatusEnum_NOTIFIED =
    const TerminationResponseStatusEnum._('NOTIFIED');
const TerminationResponseStatusEnum _$terminationResponseStatusEnum_CONFIRMED =
    const TerminationResponseStatusEnum._('CONFIRMED');
const TerminationResponseStatusEnum _$terminationResponseStatusEnum_DECLINED =
    const TerminationResponseStatusEnum._('DECLINED');
const TerminationResponseStatusEnum _$terminationResponseStatusEnum_WITHDRAWN =
    const TerminationResponseStatusEnum._('WITHDRAWN');
const TerminationResponseStatusEnum
_$terminationResponseStatusEnum_unknownDefaultOpenApi =
    const TerminationResponseStatusEnum._('unknownDefaultOpenApi');

TerminationResponseStatusEnum _$terminationResponseStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PROPOSED':
      return _$terminationResponseStatusEnum_PROPOSED;
    case 'NOTIFIED':
      return _$terminationResponseStatusEnum_NOTIFIED;
    case 'CONFIRMED':
      return _$terminationResponseStatusEnum_CONFIRMED;
    case 'DECLINED':
      return _$terminationResponseStatusEnum_DECLINED;
    case 'WITHDRAWN':
      return _$terminationResponseStatusEnum_WITHDRAWN;
    case 'unknownDefaultOpenApi':
      return _$terminationResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$terminationResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<TerminationResponseStatusEnum>
_$terminationResponseStatusEnumValues = BuiltSet<TerminationResponseStatusEnum>(
  const <TerminationResponseStatusEnum>[
    _$terminationResponseStatusEnum_PROPOSED,
    _$terminationResponseStatusEnum_NOTIFIED,
    _$terminationResponseStatusEnum_CONFIRMED,
    _$terminationResponseStatusEnum_DECLINED,
    _$terminationResponseStatusEnum_WITHDRAWN,
    _$terminationResponseStatusEnum_unknownDefaultOpenApi,
  ],
);

Serializer<TerminationResponseRequestedByEnum>
_$terminationResponseRequestedByEnumSerializer =
    _$TerminationResponseRequestedByEnumSerializer();
Serializer<TerminationResponseStatusEnum>
_$terminationResponseStatusEnumSerializer =
    _$TerminationResponseStatusEnumSerializer();

class _$TerminationResponseRequestedByEnumSerializer
    implements PrimitiveSerializer<TerminationResponseRequestedByEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PRESTATAIRE': 'PRESTATAIRE',
    'TENANT': 'TENANT',
    'BOTH': 'BOTH',
    'NOBODY': 'NOBODY',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PRESTATAIRE': 'PRESTATAIRE',
    'TENANT': 'TENANT',
    'BOTH': 'BOTH',
    'NOBODY': 'NOBODY',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[TerminationResponseRequestedByEnum];
  @override
  final String wireName = 'TerminationResponseRequestedByEnum';

  @override
  Object serialize(
    Serializers serializers,
    TerminationResponseRequestedByEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TerminationResponseRequestedByEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TerminationResponseRequestedByEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TerminationResponseStatusEnumSerializer
    implements PrimitiveSerializer<TerminationResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PROPOSED': 'PROPOSED',
    'NOTIFIED': 'NOTIFIED',
    'CONFIRMED': 'CONFIRMED',
    'DECLINED': 'DECLINED',
    'WITHDRAWN': 'WITHDRAWN',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PROPOSED': 'PROPOSED',
    'NOTIFIED': 'NOTIFIED',
    'CONFIRMED': 'CONFIRMED',
    'DECLINED': 'DECLINED',
    'WITHDRAWN': 'WITHDRAWN',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[TerminationResponseStatusEnum];
  @override
  final String wireName = 'TerminationResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    TerminationResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TerminationResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TerminationResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TerminationResponse extends TerminationResponse {
  @override
  final String? id;
  @override
  final TerminationResponseRequestedByEnum? requestedBy;
  @override
  final bool? mutual;
  @override
  final String? reason;
  @override
  final Date? effectiveDate;
  @override
  final TerminationResponseStatusEnum? status;
  @override
  final DateTime? requestedAt;
  @override
  final DateTime? answeredAt;
  @override
  final bool? canAnswer;
  @override
  final bool? canWithdraw;

  factory _$TerminationResponse([
    void Function(TerminationResponseBuilder)? updates,
  ]) => (TerminationResponseBuilder()..update(updates))._build();

  _$TerminationResponse._({
    this.id,
    this.requestedBy,
    this.mutual,
    this.reason,
    this.effectiveDate,
    this.status,
    this.requestedAt,
    this.answeredAt,
    this.canAnswer,
    this.canWithdraw,
  }) : super._();
  @override
  TerminationResponse rebuild(
    void Function(TerminationResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TerminationResponseBuilder toBuilder() =>
      TerminationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TerminationResponse &&
        id == other.id &&
        requestedBy == other.requestedBy &&
        mutual == other.mutual &&
        reason == other.reason &&
        effectiveDate == other.effectiveDate &&
        status == other.status &&
        requestedAt == other.requestedAt &&
        answeredAt == other.answeredAt &&
        canAnswer == other.canAnswer &&
        canWithdraw == other.canWithdraw;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, requestedBy.hashCode);
    _$hash = $jc(_$hash, mutual.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, effectiveDate.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, requestedAt.hashCode);
    _$hash = $jc(_$hash, answeredAt.hashCode);
    _$hash = $jc(_$hash, canAnswer.hashCode);
    _$hash = $jc(_$hash, canWithdraw.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TerminationResponse')
          ..add('id', id)
          ..add('requestedBy', requestedBy)
          ..add('mutual', mutual)
          ..add('reason', reason)
          ..add('effectiveDate', effectiveDate)
          ..add('status', status)
          ..add('requestedAt', requestedAt)
          ..add('answeredAt', answeredAt)
          ..add('canAnswer', canAnswer)
          ..add('canWithdraw', canWithdraw))
        .toString();
  }
}

class TerminationResponseBuilder
    implements Builder<TerminationResponse, TerminationResponseBuilder> {
  _$TerminationResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  TerminationResponseRequestedByEnum? _requestedBy;
  TerminationResponseRequestedByEnum? get requestedBy => _$this._requestedBy;
  set requestedBy(TerminationResponseRequestedByEnum? requestedBy) =>
      _$this._requestedBy = requestedBy;

  bool? _mutual;
  bool? get mutual => _$this._mutual;
  set mutual(bool? mutual) => _$this._mutual = mutual;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  Date? _effectiveDate;
  Date? get effectiveDate => _$this._effectiveDate;
  set effectiveDate(Date? effectiveDate) =>
      _$this._effectiveDate = effectiveDate;

  TerminationResponseStatusEnum? _status;
  TerminationResponseStatusEnum? get status => _$this._status;
  set status(TerminationResponseStatusEnum? status) => _$this._status = status;

  DateTime? _requestedAt;
  DateTime? get requestedAt => _$this._requestedAt;
  set requestedAt(DateTime? requestedAt) => _$this._requestedAt = requestedAt;

  DateTime? _answeredAt;
  DateTime? get answeredAt => _$this._answeredAt;
  set answeredAt(DateTime? answeredAt) => _$this._answeredAt = answeredAt;

  bool? _canAnswer;
  bool? get canAnswer => _$this._canAnswer;
  set canAnswer(bool? canAnswer) => _$this._canAnswer = canAnswer;

  bool? _canWithdraw;
  bool? get canWithdraw => _$this._canWithdraw;
  set canWithdraw(bool? canWithdraw) => _$this._canWithdraw = canWithdraw;

  TerminationResponseBuilder() {
    TerminationResponse._defaults(this);
  }

  TerminationResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _requestedBy = $v.requestedBy;
      _mutual = $v.mutual;
      _reason = $v.reason;
      _effectiveDate = $v.effectiveDate;
      _status = $v.status;
      _requestedAt = $v.requestedAt;
      _answeredAt = $v.answeredAt;
      _canAnswer = $v.canAnswer;
      _canWithdraw = $v.canWithdraw;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TerminationResponse other) {
    _$v = other as _$TerminationResponse;
  }

  @override
  void update(void Function(TerminationResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TerminationResponse build() => _build();

  _$TerminationResponse _build() {
    final _$result =
        _$v ??
        _$TerminationResponse._(
          id: id,
          requestedBy: requestedBy,
          mutual: mutual,
          reason: reason,
          effectiveDate: effectiveDate,
          status: status,
          requestedAt: requestedAt,
          answeredAt: answeredAt,
          canAnswer: canAnswer,
          canWithdraw: canWithdraw,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
