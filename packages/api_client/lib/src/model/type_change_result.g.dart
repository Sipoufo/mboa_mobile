// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_change_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TypeChangeResultRequestedTypeEnum
_$typeChangeResultRequestedTypeEnum_PARTICULIER =
    const TypeChangeResultRequestedTypeEnum._('PARTICULIER');
const TypeChangeResultRequestedTypeEnum
_$typeChangeResultRequestedTypeEnum_AGENCE =
    const TypeChangeResultRequestedTypeEnum._('AGENCE');
const TypeChangeResultRequestedTypeEnum
_$typeChangeResultRequestedTypeEnum_PROMOTEUR =
    const TypeChangeResultRequestedTypeEnum._('PROMOTEUR');
const TypeChangeResultRequestedTypeEnum
_$typeChangeResultRequestedTypeEnum_unknownDefaultOpenApi =
    const TypeChangeResultRequestedTypeEnum._('unknownDefaultOpenApi');

TypeChangeResultRequestedTypeEnum _$typeChangeResultRequestedTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PARTICULIER':
      return _$typeChangeResultRequestedTypeEnum_PARTICULIER;
    case 'AGENCE':
      return _$typeChangeResultRequestedTypeEnum_AGENCE;
    case 'PROMOTEUR':
      return _$typeChangeResultRequestedTypeEnum_PROMOTEUR;
    case 'unknownDefaultOpenApi':
      return _$typeChangeResultRequestedTypeEnum_unknownDefaultOpenApi;
    default:
      return _$typeChangeResultRequestedTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<TypeChangeResultRequestedTypeEnum>
_$typeChangeResultRequestedTypeEnumValues =
    BuiltSet<TypeChangeResultRequestedTypeEnum>(
      const <TypeChangeResultRequestedTypeEnum>[
        _$typeChangeResultRequestedTypeEnum_PARTICULIER,
        _$typeChangeResultRequestedTypeEnum_AGENCE,
        _$typeChangeResultRequestedTypeEnum_PROMOTEUR,
        _$typeChangeResultRequestedTypeEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<TypeChangeResultRequestedTypeEnum>
_$typeChangeResultRequestedTypeEnumSerializer =
    _$TypeChangeResultRequestedTypeEnumSerializer();

class _$TypeChangeResultRequestedTypeEnumSerializer
    implements PrimitiveSerializer<TypeChangeResultRequestedTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PARTICULIER': 'PARTICULIER',
    'AGENCE': 'AGENCE',
    'PROMOTEUR': 'PROMOTEUR',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PARTICULIER': 'PARTICULIER',
    'AGENCE': 'AGENCE',
    'PROMOTEUR': 'PROMOTEUR',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[TypeChangeResultRequestedTypeEnum];
  @override
  final String wireName = 'TypeChangeResultRequestedTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    TypeChangeResultRequestedTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TypeChangeResultRequestedTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TypeChangeResultRequestedTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TypeChangeResult extends TypeChangeResult {
  @override
  final String? outcome;
  @override
  final TypeChangeResultRequestedTypeEnum? requestedType;
  @override
  final String? requestId;

  factory _$TypeChangeResult([
    void Function(TypeChangeResultBuilder)? updates,
  ]) => (TypeChangeResultBuilder()..update(updates))._build();

  _$TypeChangeResult._({this.outcome, this.requestedType, this.requestId})
    : super._();
  @override
  TypeChangeResult rebuild(void Function(TypeChangeResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TypeChangeResultBuilder toBuilder() =>
      TypeChangeResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TypeChangeResult &&
        outcome == other.outcome &&
        requestedType == other.requestedType &&
        requestId == other.requestId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, outcome.hashCode);
    _$hash = $jc(_$hash, requestedType.hashCode);
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TypeChangeResult')
          ..add('outcome', outcome)
          ..add('requestedType', requestedType)
          ..add('requestId', requestId))
        .toString();
  }
}

class TypeChangeResultBuilder
    implements Builder<TypeChangeResult, TypeChangeResultBuilder> {
  _$TypeChangeResult? _$v;

  String? _outcome;
  String? get outcome => _$this._outcome;
  set outcome(String? outcome) => _$this._outcome = outcome;

  TypeChangeResultRequestedTypeEnum? _requestedType;
  TypeChangeResultRequestedTypeEnum? get requestedType => _$this._requestedType;
  set requestedType(TypeChangeResultRequestedTypeEnum? requestedType) =>
      _$this._requestedType = requestedType;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  TypeChangeResultBuilder() {
    TypeChangeResult._defaults(this);
  }

  TypeChangeResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _outcome = $v.outcome;
      _requestedType = $v.requestedType;
      _requestId = $v.requestId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TypeChangeResult other) {
    _$v = other as _$TypeChangeResult;
  }

  @override
  void update(void Function(TypeChangeResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TypeChangeResult build() => _build();

  _$TypeChangeResult _build() {
    final _$result =
        _$v ??
        _$TypeChangeResult._(
          outcome: outcome,
          requestedType: requestedType,
          requestId: requestId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
