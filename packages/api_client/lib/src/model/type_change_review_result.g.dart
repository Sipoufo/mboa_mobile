// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_change_review_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TypeChangeReviewResultStatusEnum
_$typeChangeReviewResultStatusEnum_PENDING =
    const TypeChangeReviewResultStatusEnum._('PENDING');
const TypeChangeReviewResultStatusEnum
_$typeChangeReviewResultStatusEnum_APPROVED =
    const TypeChangeReviewResultStatusEnum._('APPROVED');
const TypeChangeReviewResultStatusEnum
_$typeChangeReviewResultStatusEnum_REJECTED =
    const TypeChangeReviewResultStatusEnum._('REJECTED');
const TypeChangeReviewResultStatusEnum
_$typeChangeReviewResultStatusEnum_unknownDefaultOpenApi =
    const TypeChangeReviewResultStatusEnum._('unknownDefaultOpenApi');

TypeChangeReviewResultStatusEnum _$typeChangeReviewResultStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PENDING':
      return _$typeChangeReviewResultStatusEnum_PENDING;
    case 'APPROVED':
      return _$typeChangeReviewResultStatusEnum_APPROVED;
    case 'REJECTED':
      return _$typeChangeReviewResultStatusEnum_REJECTED;
    case 'unknownDefaultOpenApi':
      return _$typeChangeReviewResultStatusEnum_unknownDefaultOpenApi;
    default:
      return _$typeChangeReviewResultStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<TypeChangeReviewResultStatusEnum>
_$typeChangeReviewResultStatusEnumValues =
    BuiltSet<TypeChangeReviewResultStatusEnum>(
      const <TypeChangeReviewResultStatusEnum>[
        _$typeChangeReviewResultStatusEnum_PENDING,
        _$typeChangeReviewResultStatusEnum_APPROVED,
        _$typeChangeReviewResultStatusEnum_REJECTED,
        _$typeChangeReviewResultStatusEnum_unknownDefaultOpenApi,
      ],
    );

const TypeChangeReviewResultRequestedTypeEnum
_$typeChangeReviewResultRequestedTypeEnum_PARTICULIER =
    const TypeChangeReviewResultRequestedTypeEnum._('PARTICULIER');
const TypeChangeReviewResultRequestedTypeEnum
_$typeChangeReviewResultRequestedTypeEnum_AGENCE =
    const TypeChangeReviewResultRequestedTypeEnum._('AGENCE');
const TypeChangeReviewResultRequestedTypeEnum
_$typeChangeReviewResultRequestedTypeEnum_PROMOTEUR =
    const TypeChangeReviewResultRequestedTypeEnum._('PROMOTEUR');
const TypeChangeReviewResultRequestedTypeEnum
_$typeChangeReviewResultRequestedTypeEnum_unknownDefaultOpenApi =
    const TypeChangeReviewResultRequestedTypeEnum._('unknownDefaultOpenApi');

TypeChangeReviewResultRequestedTypeEnum
_$typeChangeReviewResultRequestedTypeEnumValueOf(String name) {
  switch (name) {
    case 'PARTICULIER':
      return _$typeChangeReviewResultRequestedTypeEnum_PARTICULIER;
    case 'AGENCE':
      return _$typeChangeReviewResultRequestedTypeEnum_AGENCE;
    case 'PROMOTEUR':
      return _$typeChangeReviewResultRequestedTypeEnum_PROMOTEUR;
    case 'unknownDefaultOpenApi':
      return _$typeChangeReviewResultRequestedTypeEnum_unknownDefaultOpenApi;
    default:
      return _$typeChangeReviewResultRequestedTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<TypeChangeReviewResultRequestedTypeEnum>
_$typeChangeReviewResultRequestedTypeEnumValues =
    BuiltSet<TypeChangeReviewResultRequestedTypeEnum>(
      const <TypeChangeReviewResultRequestedTypeEnum>[
        _$typeChangeReviewResultRequestedTypeEnum_PARTICULIER,
        _$typeChangeReviewResultRequestedTypeEnum_AGENCE,
        _$typeChangeReviewResultRequestedTypeEnum_PROMOTEUR,
        _$typeChangeReviewResultRequestedTypeEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<TypeChangeReviewResultStatusEnum>
_$typeChangeReviewResultStatusEnumSerializer =
    _$TypeChangeReviewResultStatusEnumSerializer();
Serializer<TypeChangeReviewResultRequestedTypeEnum>
_$typeChangeReviewResultRequestedTypeEnumSerializer =
    _$TypeChangeReviewResultRequestedTypeEnumSerializer();

class _$TypeChangeReviewResultStatusEnumSerializer
    implements PrimitiveSerializer<TypeChangeReviewResultStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
    'APPROVED': 'APPROVED',
    'REJECTED': 'REJECTED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
    'APPROVED': 'APPROVED',
    'REJECTED': 'REJECTED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[TypeChangeReviewResultStatusEnum];
  @override
  final String wireName = 'TypeChangeReviewResultStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    TypeChangeReviewResultStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TypeChangeReviewResultStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TypeChangeReviewResultStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TypeChangeReviewResultRequestedTypeEnumSerializer
    implements PrimitiveSerializer<TypeChangeReviewResultRequestedTypeEnum> {
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
  final Iterable<Type> types = const <Type>[
    TypeChangeReviewResultRequestedTypeEnum,
  ];
  @override
  final String wireName = 'TypeChangeReviewResultRequestedTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    TypeChangeReviewResultRequestedTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TypeChangeReviewResultRequestedTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TypeChangeReviewResultRequestedTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TypeChangeReviewResult extends TypeChangeReviewResult {
  @override
  final String? id;
  @override
  final TypeChangeReviewResultStatusEnum? status;
  @override
  final TypeChangeReviewResultRequestedTypeEnum? requestedType;
  @override
  final String? adminReason;

  factory _$TypeChangeReviewResult([
    void Function(TypeChangeReviewResultBuilder)? updates,
  ]) => (TypeChangeReviewResultBuilder()..update(updates))._build();

  _$TypeChangeReviewResult._({
    this.id,
    this.status,
    this.requestedType,
    this.adminReason,
  }) : super._();
  @override
  TypeChangeReviewResult rebuild(
    void Function(TypeChangeReviewResultBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TypeChangeReviewResultBuilder toBuilder() =>
      TypeChangeReviewResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TypeChangeReviewResult &&
        id == other.id &&
        status == other.status &&
        requestedType == other.requestedType &&
        adminReason == other.adminReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, requestedType.hashCode);
    _$hash = $jc(_$hash, adminReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TypeChangeReviewResult')
          ..add('id', id)
          ..add('status', status)
          ..add('requestedType', requestedType)
          ..add('adminReason', adminReason))
        .toString();
  }
}

class TypeChangeReviewResultBuilder
    implements Builder<TypeChangeReviewResult, TypeChangeReviewResultBuilder> {
  _$TypeChangeReviewResult? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  TypeChangeReviewResultStatusEnum? _status;
  TypeChangeReviewResultStatusEnum? get status => _$this._status;
  set status(TypeChangeReviewResultStatusEnum? status) =>
      _$this._status = status;

  TypeChangeReviewResultRequestedTypeEnum? _requestedType;
  TypeChangeReviewResultRequestedTypeEnum? get requestedType =>
      _$this._requestedType;
  set requestedType(TypeChangeReviewResultRequestedTypeEnum? requestedType) =>
      _$this._requestedType = requestedType;

  String? _adminReason;
  String? get adminReason => _$this._adminReason;
  set adminReason(String? adminReason) => _$this._adminReason = adminReason;

  TypeChangeReviewResultBuilder() {
    TypeChangeReviewResult._defaults(this);
  }

  TypeChangeReviewResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _status = $v.status;
      _requestedType = $v.requestedType;
      _adminReason = $v.adminReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TypeChangeReviewResult other) {
    _$v = other as _$TypeChangeReviewResult;
  }

  @override
  void update(void Function(TypeChangeReviewResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TypeChangeReviewResult build() => _build();

  _$TypeChangeReviewResult _build() {
    final _$result =
        _$v ??
        _$TypeChangeReviewResult._(
          id: id,
          status: status,
          requestedType: requestedType,
          adminReason: adminReason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
