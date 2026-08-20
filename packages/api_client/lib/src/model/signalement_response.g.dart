// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signalement_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SignalementResponseTargetTypeEnum
_$signalementResponseTargetTypeEnum_ANNONCE =
    const SignalementResponseTargetTypeEnum._('ANNONCE');
const SignalementResponseTargetTypeEnum
_$signalementResponseTargetTypeEnum_MESSAGE =
    const SignalementResponseTargetTypeEnum._('MESSAGE');
const SignalementResponseTargetTypeEnum
_$signalementResponseTargetTypeEnum_REVIEW =
    const SignalementResponseTargetTypeEnum._('REVIEW');
const SignalementResponseTargetTypeEnum
_$signalementResponseTargetTypeEnum_unknownDefaultOpenApi =
    const SignalementResponseTargetTypeEnum._('unknownDefaultOpenApi');

SignalementResponseTargetTypeEnum _$signalementResponseTargetTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'ANNONCE':
      return _$signalementResponseTargetTypeEnum_ANNONCE;
    case 'MESSAGE':
      return _$signalementResponseTargetTypeEnum_MESSAGE;
    case 'REVIEW':
      return _$signalementResponseTargetTypeEnum_REVIEW;
    case 'unknownDefaultOpenApi':
      return _$signalementResponseTargetTypeEnum_unknownDefaultOpenApi;
    default:
      return _$signalementResponseTargetTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<SignalementResponseTargetTypeEnum>
_$signalementResponseTargetTypeEnumValues =
    BuiltSet<SignalementResponseTargetTypeEnum>(
      const <SignalementResponseTargetTypeEnum>[
        _$signalementResponseTargetTypeEnum_ANNONCE,
        _$signalementResponseTargetTypeEnum_MESSAGE,
        _$signalementResponseTargetTypeEnum_REVIEW,
        _$signalementResponseTargetTypeEnum_unknownDefaultOpenApi,
      ],
    );

const SignalementResponseReasonEnum
_$signalementResponseReasonEnum_FRAUDULENT_LISTING =
    const SignalementResponseReasonEnum._('FRAUDULENT_LISTING');
const SignalementResponseReasonEnum
_$signalementResponseReasonEnum_ABNORMAL_PRICE =
    const SignalementResponseReasonEnum._('ABNORMAL_PRICE');
const SignalementResponseReasonEnum
_$signalementResponseReasonEnum_INAPPROPRIATE_CONTENT =
    const SignalementResponseReasonEnum._('INAPPROPRIATE_CONTENT');
const SignalementResponseReasonEnum _$signalementResponseReasonEnum_HARASSMENT =
    const SignalementResponseReasonEnum._('HARASSMENT');
const SignalementResponseReasonEnum
_$signalementResponseReasonEnum_unknownDefaultOpenApi =
    const SignalementResponseReasonEnum._('unknownDefaultOpenApi');

SignalementResponseReasonEnum _$signalementResponseReasonEnumValueOf(
  String name,
) {
  switch (name) {
    case 'FRAUDULENT_LISTING':
      return _$signalementResponseReasonEnum_FRAUDULENT_LISTING;
    case 'ABNORMAL_PRICE':
      return _$signalementResponseReasonEnum_ABNORMAL_PRICE;
    case 'INAPPROPRIATE_CONTENT':
      return _$signalementResponseReasonEnum_INAPPROPRIATE_CONTENT;
    case 'HARASSMENT':
      return _$signalementResponseReasonEnum_HARASSMENT;
    case 'unknownDefaultOpenApi':
      return _$signalementResponseReasonEnum_unknownDefaultOpenApi;
    default:
      return _$signalementResponseReasonEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<SignalementResponseReasonEnum>
_$signalementResponseReasonEnumValues = BuiltSet<SignalementResponseReasonEnum>(
  const <SignalementResponseReasonEnum>[
    _$signalementResponseReasonEnum_FRAUDULENT_LISTING,
    _$signalementResponseReasonEnum_ABNORMAL_PRICE,
    _$signalementResponseReasonEnum_INAPPROPRIATE_CONTENT,
    _$signalementResponseReasonEnum_HARASSMENT,
    _$signalementResponseReasonEnum_unknownDefaultOpenApi,
  ],
);

const SignalementResponseStatusEnum _$signalementResponseStatusEnum_PENDING =
    const SignalementResponseStatusEnum._('PENDING');
const SignalementResponseStatusEnum _$signalementResponseStatusEnum_VALIDATED =
    const SignalementResponseStatusEnum._('VALIDATED');
const SignalementResponseStatusEnum _$signalementResponseStatusEnum_REJECTED =
    const SignalementResponseStatusEnum._('REJECTED');
const SignalementResponseStatusEnum
_$signalementResponseStatusEnum_unknownDefaultOpenApi =
    const SignalementResponseStatusEnum._('unknownDefaultOpenApi');

SignalementResponseStatusEnum _$signalementResponseStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PENDING':
      return _$signalementResponseStatusEnum_PENDING;
    case 'VALIDATED':
      return _$signalementResponseStatusEnum_VALIDATED;
    case 'REJECTED':
      return _$signalementResponseStatusEnum_REJECTED;
    case 'unknownDefaultOpenApi':
      return _$signalementResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$signalementResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<SignalementResponseStatusEnum>
_$signalementResponseStatusEnumValues = BuiltSet<SignalementResponseStatusEnum>(
  const <SignalementResponseStatusEnum>[
    _$signalementResponseStatusEnum_PENDING,
    _$signalementResponseStatusEnum_VALIDATED,
    _$signalementResponseStatusEnum_REJECTED,
    _$signalementResponseStatusEnum_unknownDefaultOpenApi,
  ],
);

Serializer<SignalementResponseTargetTypeEnum>
_$signalementResponseTargetTypeEnumSerializer =
    _$SignalementResponseTargetTypeEnumSerializer();
Serializer<SignalementResponseReasonEnum>
_$signalementResponseReasonEnumSerializer =
    _$SignalementResponseReasonEnumSerializer();
Serializer<SignalementResponseStatusEnum>
_$signalementResponseStatusEnumSerializer =
    _$SignalementResponseStatusEnumSerializer();

class _$SignalementResponseTargetTypeEnumSerializer
    implements PrimitiveSerializer<SignalementResponseTargetTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ANNONCE': 'ANNONCE',
    'MESSAGE': 'MESSAGE',
    'REVIEW': 'REVIEW',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ANNONCE': 'ANNONCE',
    'MESSAGE': 'MESSAGE',
    'REVIEW': 'REVIEW',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[SignalementResponseTargetTypeEnum];
  @override
  final String wireName = 'SignalementResponseTargetTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    SignalementResponseTargetTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SignalementResponseTargetTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SignalementResponseTargetTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SignalementResponseReasonEnumSerializer
    implements PrimitiveSerializer<SignalementResponseReasonEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'FRAUDULENT_LISTING': 'FRAUDULENT_LISTING',
    'ABNORMAL_PRICE': 'ABNORMAL_PRICE',
    'INAPPROPRIATE_CONTENT': 'INAPPROPRIATE_CONTENT',
    'HARASSMENT': 'HARASSMENT',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'FRAUDULENT_LISTING': 'FRAUDULENT_LISTING',
    'ABNORMAL_PRICE': 'ABNORMAL_PRICE',
    'INAPPROPRIATE_CONTENT': 'INAPPROPRIATE_CONTENT',
    'HARASSMENT': 'HARASSMENT',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[SignalementResponseReasonEnum];
  @override
  final String wireName = 'SignalementResponseReasonEnum';

  @override
  Object serialize(
    Serializers serializers,
    SignalementResponseReasonEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SignalementResponseReasonEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SignalementResponseReasonEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SignalementResponseStatusEnumSerializer
    implements PrimitiveSerializer<SignalementResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
    'VALIDATED': 'VALIDATED',
    'REJECTED': 'REJECTED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
    'VALIDATED': 'VALIDATED',
    'REJECTED': 'REJECTED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[SignalementResponseStatusEnum];
  @override
  final String wireName = 'SignalementResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    SignalementResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SignalementResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SignalementResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SignalementResponse extends SignalementResponse {
  @override
  final String? id;
  @override
  final SignalementResponseTargetTypeEnum? targetType;
  @override
  final String? targetId;
  @override
  final SignalementResponseReasonEnum? reason;
  @override
  final String? comment;
  @override
  final SignalementResponseStatusEnum? status;
  @override
  final String? reporterAccountId;
  @override
  final bool? reporterSuspect;
  @override
  final int? targetValidatedCount;
  @override
  final bool? providerAlert;
  @override
  final String? reviewedBy;
  @override
  final DateTime? reviewedAt;
  @override
  final String? reviewNote;
  @override
  final DateTime? createdAt;

  factory _$SignalementResponse([
    void Function(SignalementResponseBuilder)? updates,
  ]) => (SignalementResponseBuilder()..update(updates))._build();

  _$SignalementResponse._({
    this.id,
    this.targetType,
    this.targetId,
    this.reason,
    this.comment,
    this.status,
    this.reporterAccountId,
    this.reporterSuspect,
    this.targetValidatedCount,
    this.providerAlert,
    this.reviewedBy,
    this.reviewedAt,
    this.reviewNote,
    this.createdAt,
  }) : super._();
  @override
  SignalementResponse rebuild(
    void Function(SignalementResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SignalementResponseBuilder toBuilder() =>
      SignalementResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignalementResponse &&
        id == other.id &&
        targetType == other.targetType &&
        targetId == other.targetId &&
        reason == other.reason &&
        comment == other.comment &&
        status == other.status &&
        reporterAccountId == other.reporterAccountId &&
        reporterSuspect == other.reporterSuspect &&
        targetValidatedCount == other.targetValidatedCount &&
        providerAlert == other.providerAlert &&
        reviewedBy == other.reviewedBy &&
        reviewedAt == other.reviewedAt &&
        reviewNote == other.reviewNote &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, targetType.hashCode);
    _$hash = $jc(_$hash, targetId.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, reporterAccountId.hashCode);
    _$hash = $jc(_$hash, reporterSuspect.hashCode);
    _$hash = $jc(_$hash, targetValidatedCount.hashCode);
    _$hash = $jc(_$hash, providerAlert.hashCode);
    _$hash = $jc(_$hash, reviewedBy.hashCode);
    _$hash = $jc(_$hash, reviewedAt.hashCode);
    _$hash = $jc(_$hash, reviewNote.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignalementResponse')
          ..add('id', id)
          ..add('targetType', targetType)
          ..add('targetId', targetId)
          ..add('reason', reason)
          ..add('comment', comment)
          ..add('status', status)
          ..add('reporterAccountId', reporterAccountId)
          ..add('reporterSuspect', reporterSuspect)
          ..add('targetValidatedCount', targetValidatedCount)
          ..add('providerAlert', providerAlert)
          ..add('reviewedBy', reviewedBy)
          ..add('reviewedAt', reviewedAt)
          ..add('reviewNote', reviewNote)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class SignalementResponseBuilder
    implements Builder<SignalementResponse, SignalementResponseBuilder> {
  _$SignalementResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  SignalementResponseTargetTypeEnum? _targetType;
  SignalementResponseTargetTypeEnum? get targetType => _$this._targetType;
  set targetType(SignalementResponseTargetTypeEnum? targetType) =>
      _$this._targetType = targetType;

  String? _targetId;
  String? get targetId => _$this._targetId;
  set targetId(String? targetId) => _$this._targetId = targetId;

  SignalementResponseReasonEnum? _reason;
  SignalementResponseReasonEnum? get reason => _$this._reason;
  set reason(SignalementResponseReasonEnum? reason) => _$this._reason = reason;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  SignalementResponseStatusEnum? _status;
  SignalementResponseStatusEnum? get status => _$this._status;
  set status(SignalementResponseStatusEnum? status) => _$this._status = status;

  String? _reporterAccountId;
  String? get reporterAccountId => _$this._reporterAccountId;
  set reporterAccountId(String? reporterAccountId) =>
      _$this._reporterAccountId = reporterAccountId;

  bool? _reporterSuspect;
  bool? get reporterSuspect => _$this._reporterSuspect;
  set reporterSuspect(bool? reporterSuspect) =>
      _$this._reporterSuspect = reporterSuspect;

  int? _targetValidatedCount;
  int? get targetValidatedCount => _$this._targetValidatedCount;
  set targetValidatedCount(int? targetValidatedCount) =>
      _$this._targetValidatedCount = targetValidatedCount;

  bool? _providerAlert;
  bool? get providerAlert => _$this._providerAlert;
  set providerAlert(bool? providerAlert) =>
      _$this._providerAlert = providerAlert;

  String? _reviewedBy;
  String? get reviewedBy => _$this._reviewedBy;
  set reviewedBy(String? reviewedBy) => _$this._reviewedBy = reviewedBy;

  DateTime? _reviewedAt;
  DateTime? get reviewedAt => _$this._reviewedAt;
  set reviewedAt(DateTime? reviewedAt) => _$this._reviewedAt = reviewedAt;

  String? _reviewNote;
  String? get reviewNote => _$this._reviewNote;
  set reviewNote(String? reviewNote) => _$this._reviewNote = reviewNote;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  SignalementResponseBuilder() {
    SignalementResponse._defaults(this);
  }

  SignalementResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _targetType = $v.targetType;
      _targetId = $v.targetId;
      _reason = $v.reason;
      _comment = $v.comment;
      _status = $v.status;
      _reporterAccountId = $v.reporterAccountId;
      _reporterSuspect = $v.reporterSuspect;
      _targetValidatedCount = $v.targetValidatedCount;
      _providerAlert = $v.providerAlert;
      _reviewedBy = $v.reviewedBy;
      _reviewedAt = $v.reviewedAt;
      _reviewNote = $v.reviewNote;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignalementResponse other) {
    _$v = other as _$SignalementResponse;
  }

  @override
  void update(void Function(SignalementResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignalementResponse build() => _build();

  _$SignalementResponse _build() {
    final _$result =
        _$v ??
        _$SignalementResponse._(
          id: id,
          targetType: targetType,
          targetId: targetId,
          reason: reason,
          comment: comment,
          status: status,
          reporterAccountId: reporterAccountId,
          reporterSuspect: reporterSuspect,
          targetValidatedCount: targetValidatedCount,
          providerAlert: providerAlert,
          reviewedBy: reviewedBy,
          reviewedAt: reviewedAt,
          reviewNote: reviewNote,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
