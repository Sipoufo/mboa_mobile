// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_decision_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OwnerDecisionRequestReasonEnum
_$ownerDecisionRequestReasonEnum_RESERVED_ELSEWHERE =
    const OwnerDecisionRequestReasonEnum._('RESERVED_ELSEWHERE');
const OwnerDecisionRequestReasonEnum
_$ownerDecisionRequestReasonEnum_PROFILE_NOT_RETAINED =
    const OwnerDecisionRequestReasonEnum._('PROFILE_NOT_RETAINED');
const OwnerDecisionRequestReasonEnum
_$ownerDecisionRequestReasonEnum_DATES_INCOMPATIBLE =
    const OwnerDecisionRequestReasonEnum._('DATES_INCOMPATIBLE');
const OwnerDecisionRequestReasonEnum _$ownerDecisionRequestReasonEnum_OTHER =
    const OwnerDecisionRequestReasonEnum._('OTHER');
const OwnerDecisionRequestReasonEnum
_$ownerDecisionRequestReasonEnum_unknownDefaultOpenApi =
    const OwnerDecisionRequestReasonEnum._('unknownDefaultOpenApi');

OwnerDecisionRequestReasonEnum _$ownerDecisionRequestReasonEnumValueOf(
  String name,
) {
  switch (name) {
    case 'RESERVED_ELSEWHERE':
      return _$ownerDecisionRequestReasonEnum_RESERVED_ELSEWHERE;
    case 'PROFILE_NOT_RETAINED':
      return _$ownerDecisionRequestReasonEnum_PROFILE_NOT_RETAINED;
    case 'DATES_INCOMPATIBLE':
      return _$ownerDecisionRequestReasonEnum_DATES_INCOMPATIBLE;
    case 'OTHER':
      return _$ownerDecisionRequestReasonEnum_OTHER;
    case 'unknownDefaultOpenApi':
      return _$ownerDecisionRequestReasonEnum_unknownDefaultOpenApi;
    default:
      return _$ownerDecisionRequestReasonEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OwnerDecisionRequestReasonEnum>
_$ownerDecisionRequestReasonEnumValues =
    BuiltSet<OwnerDecisionRequestReasonEnum>(
      const <OwnerDecisionRequestReasonEnum>[
        _$ownerDecisionRequestReasonEnum_RESERVED_ELSEWHERE,
        _$ownerDecisionRequestReasonEnum_PROFILE_NOT_RETAINED,
        _$ownerDecisionRequestReasonEnum_DATES_INCOMPATIBLE,
        _$ownerDecisionRequestReasonEnum_OTHER,
        _$ownerDecisionRequestReasonEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<OwnerDecisionRequestReasonEnum>
_$ownerDecisionRequestReasonEnumSerializer =
    _$OwnerDecisionRequestReasonEnumSerializer();

class _$OwnerDecisionRequestReasonEnumSerializer
    implements PrimitiveSerializer<OwnerDecisionRequestReasonEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'RESERVED_ELSEWHERE': 'RESERVED_ELSEWHERE',
    'PROFILE_NOT_RETAINED': 'PROFILE_NOT_RETAINED',
    'DATES_INCOMPATIBLE': 'DATES_INCOMPATIBLE',
    'OTHER': 'OTHER',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'RESERVED_ELSEWHERE': 'RESERVED_ELSEWHERE',
    'PROFILE_NOT_RETAINED': 'PROFILE_NOT_RETAINED',
    'DATES_INCOMPATIBLE': 'DATES_INCOMPATIBLE',
    'OTHER': 'OTHER',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OwnerDecisionRequestReasonEnum];
  @override
  final String wireName = 'OwnerDecisionRequestReasonEnum';

  @override
  Object serialize(
    Serializers serializers,
    OwnerDecisionRequestReasonEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  OwnerDecisionRequestReasonEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => OwnerDecisionRequestReasonEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$OwnerDecisionRequest extends OwnerDecisionRequest {
  @override
  final OwnerDecisionRequestReasonEnum reason;
  @override
  final String? note;

  factory _$OwnerDecisionRequest([
    void Function(OwnerDecisionRequestBuilder)? updates,
  ]) => (OwnerDecisionRequestBuilder()..update(updates))._build();

  _$OwnerDecisionRequest._({required this.reason, this.note}) : super._();
  @override
  OwnerDecisionRequest rebuild(
    void Function(OwnerDecisionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OwnerDecisionRequestBuilder toBuilder() =>
      OwnerDecisionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OwnerDecisionRequest &&
        reason == other.reason &&
        note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OwnerDecisionRequest')
          ..add('reason', reason)
          ..add('note', note))
        .toString();
  }
}

class OwnerDecisionRequestBuilder
    implements Builder<OwnerDecisionRequest, OwnerDecisionRequestBuilder> {
  _$OwnerDecisionRequest? _$v;

  OwnerDecisionRequestReasonEnum? _reason;
  OwnerDecisionRequestReasonEnum? get reason => _$this._reason;
  set reason(OwnerDecisionRequestReasonEnum? reason) => _$this._reason = reason;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  OwnerDecisionRequestBuilder() {
    OwnerDecisionRequest._defaults(this);
  }

  OwnerDecisionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OwnerDecisionRequest other) {
    _$v = other as _$OwnerDecisionRequest;
  }

  @override
  void update(void Function(OwnerDecisionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OwnerDecisionRequest build() => _build();

  _$OwnerDecisionRequest _build() {
    final _$result =
        _$v ??
        _$OwnerDecisionRequest._(
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'OwnerDecisionRequest',
            'reason',
          ),
          note: note,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
