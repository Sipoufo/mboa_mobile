// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_signalement_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateSignalementRequestTargetTypeEnum
_$createSignalementRequestTargetTypeEnum_ANNONCE =
    const CreateSignalementRequestTargetTypeEnum._('ANNONCE');
const CreateSignalementRequestTargetTypeEnum
_$createSignalementRequestTargetTypeEnum_MESSAGE =
    const CreateSignalementRequestTargetTypeEnum._('MESSAGE');
const CreateSignalementRequestTargetTypeEnum
_$createSignalementRequestTargetTypeEnum_REVIEW =
    const CreateSignalementRequestTargetTypeEnum._('REVIEW');
const CreateSignalementRequestTargetTypeEnum
_$createSignalementRequestTargetTypeEnum_unknownDefaultOpenApi =
    const CreateSignalementRequestTargetTypeEnum._('unknownDefaultOpenApi');

CreateSignalementRequestTargetTypeEnum
_$createSignalementRequestTargetTypeEnumValueOf(String name) {
  switch (name) {
    case 'ANNONCE':
      return _$createSignalementRequestTargetTypeEnum_ANNONCE;
    case 'MESSAGE':
      return _$createSignalementRequestTargetTypeEnum_MESSAGE;
    case 'REVIEW':
      return _$createSignalementRequestTargetTypeEnum_REVIEW;
    case 'unknownDefaultOpenApi':
      return _$createSignalementRequestTargetTypeEnum_unknownDefaultOpenApi;
    default:
      return _$createSignalementRequestTargetTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CreateSignalementRequestTargetTypeEnum>
_$createSignalementRequestTargetTypeEnumValues =
    BuiltSet<CreateSignalementRequestTargetTypeEnum>(
      const <CreateSignalementRequestTargetTypeEnum>[
        _$createSignalementRequestTargetTypeEnum_ANNONCE,
        _$createSignalementRequestTargetTypeEnum_MESSAGE,
        _$createSignalementRequestTargetTypeEnum_REVIEW,
        _$createSignalementRequestTargetTypeEnum_unknownDefaultOpenApi,
      ],
    );

const CreateSignalementRequestReasonEnum
_$createSignalementRequestReasonEnum_FRAUDULENT_LISTING =
    const CreateSignalementRequestReasonEnum._('FRAUDULENT_LISTING');
const CreateSignalementRequestReasonEnum
_$createSignalementRequestReasonEnum_ABNORMAL_PRICE =
    const CreateSignalementRequestReasonEnum._('ABNORMAL_PRICE');
const CreateSignalementRequestReasonEnum
_$createSignalementRequestReasonEnum_INAPPROPRIATE_CONTENT =
    const CreateSignalementRequestReasonEnum._('INAPPROPRIATE_CONTENT');
const CreateSignalementRequestReasonEnum
_$createSignalementRequestReasonEnum_HARASSMENT =
    const CreateSignalementRequestReasonEnum._('HARASSMENT');
const CreateSignalementRequestReasonEnum
_$createSignalementRequestReasonEnum_unknownDefaultOpenApi =
    const CreateSignalementRequestReasonEnum._('unknownDefaultOpenApi');

CreateSignalementRequestReasonEnum _$createSignalementRequestReasonEnumValueOf(
  String name,
) {
  switch (name) {
    case 'FRAUDULENT_LISTING':
      return _$createSignalementRequestReasonEnum_FRAUDULENT_LISTING;
    case 'ABNORMAL_PRICE':
      return _$createSignalementRequestReasonEnum_ABNORMAL_PRICE;
    case 'INAPPROPRIATE_CONTENT':
      return _$createSignalementRequestReasonEnum_INAPPROPRIATE_CONTENT;
    case 'HARASSMENT':
      return _$createSignalementRequestReasonEnum_HARASSMENT;
    case 'unknownDefaultOpenApi':
      return _$createSignalementRequestReasonEnum_unknownDefaultOpenApi;
    default:
      return _$createSignalementRequestReasonEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CreateSignalementRequestReasonEnum>
_$createSignalementRequestReasonEnumValues =
    BuiltSet<CreateSignalementRequestReasonEnum>(
      const <CreateSignalementRequestReasonEnum>[
        _$createSignalementRequestReasonEnum_FRAUDULENT_LISTING,
        _$createSignalementRequestReasonEnum_ABNORMAL_PRICE,
        _$createSignalementRequestReasonEnum_INAPPROPRIATE_CONTENT,
        _$createSignalementRequestReasonEnum_HARASSMENT,
        _$createSignalementRequestReasonEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<CreateSignalementRequestTargetTypeEnum>
_$createSignalementRequestTargetTypeEnumSerializer =
    _$CreateSignalementRequestTargetTypeEnumSerializer();
Serializer<CreateSignalementRequestReasonEnum>
_$createSignalementRequestReasonEnumSerializer =
    _$CreateSignalementRequestReasonEnumSerializer();

class _$CreateSignalementRequestTargetTypeEnumSerializer
    implements PrimitiveSerializer<CreateSignalementRequestTargetTypeEnum> {
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
  final Iterable<Type> types = const <Type>[
    CreateSignalementRequestTargetTypeEnum,
  ];
  @override
  final String wireName = 'CreateSignalementRequestTargetTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateSignalementRequestTargetTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateSignalementRequestTargetTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateSignalementRequestTargetTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateSignalementRequestReasonEnumSerializer
    implements PrimitiveSerializer<CreateSignalementRequestReasonEnum> {
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
  final Iterable<Type> types = const <Type>[CreateSignalementRequestReasonEnum];
  @override
  final String wireName = 'CreateSignalementRequestReasonEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateSignalementRequestReasonEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateSignalementRequestReasonEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateSignalementRequestReasonEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateSignalementRequest extends CreateSignalementRequest {
  @override
  final CreateSignalementRequestTargetTypeEnum targetType;
  @override
  final String targetId;
  @override
  final CreateSignalementRequestReasonEnum reason;
  @override
  final String? comment;

  factory _$CreateSignalementRequest([
    void Function(CreateSignalementRequestBuilder)? updates,
  ]) => (CreateSignalementRequestBuilder()..update(updates))._build();

  _$CreateSignalementRequest._({
    required this.targetType,
    required this.targetId,
    required this.reason,
    this.comment,
  }) : super._();
  @override
  CreateSignalementRequest rebuild(
    void Function(CreateSignalementRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateSignalementRequestBuilder toBuilder() =>
      CreateSignalementRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateSignalementRequest &&
        targetType == other.targetType &&
        targetId == other.targetId &&
        reason == other.reason &&
        comment == other.comment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, targetType.hashCode);
    _$hash = $jc(_$hash, targetId.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateSignalementRequest')
          ..add('targetType', targetType)
          ..add('targetId', targetId)
          ..add('reason', reason)
          ..add('comment', comment))
        .toString();
  }
}

class CreateSignalementRequestBuilder
    implements
        Builder<CreateSignalementRequest, CreateSignalementRequestBuilder> {
  _$CreateSignalementRequest? _$v;

  CreateSignalementRequestTargetTypeEnum? _targetType;
  CreateSignalementRequestTargetTypeEnum? get targetType => _$this._targetType;
  set targetType(CreateSignalementRequestTargetTypeEnum? targetType) =>
      _$this._targetType = targetType;

  String? _targetId;
  String? get targetId => _$this._targetId;
  set targetId(String? targetId) => _$this._targetId = targetId;

  CreateSignalementRequestReasonEnum? _reason;
  CreateSignalementRequestReasonEnum? get reason => _$this._reason;
  set reason(CreateSignalementRequestReasonEnum? reason) =>
      _$this._reason = reason;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  CreateSignalementRequestBuilder() {
    CreateSignalementRequest._defaults(this);
  }

  CreateSignalementRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _targetType = $v.targetType;
      _targetId = $v.targetId;
      _reason = $v.reason;
      _comment = $v.comment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateSignalementRequest other) {
    _$v = other as _$CreateSignalementRequest;
  }

  @override
  void update(void Function(CreateSignalementRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateSignalementRequest build() => _build();

  _$CreateSignalementRequest _build() {
    final _$result =
        _$v ??
        _$CreateSignalementRequest._(
          targetType: BuiltValueNullFieldError.checkNotNull(
            targetType,
            r'CreateSignalementRequest',
            'targetType',
          ),
          targetId: BuiltValueNullFieldError.checkNotNull(
            targetId,
            r'CreateSignalementRequest',
            'targetId',
          ),
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'CreateSignalementRequest',
            'reason',
          ),
          comment: comment,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
