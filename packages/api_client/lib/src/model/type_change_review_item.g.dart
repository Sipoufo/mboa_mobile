// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_change_review_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TypeChangeReviewItemCurrentTypeEnum
_$typeChangeReviewItemCurrentTypeEnum_PARTICULIER =
    const TypeChangeReviewItemCurrentTypeEnum._('PARTICULIER');
const TypeChangeReviewItemCurrentTypeEnum
_$typeChangeReviewItemCurrentTypeEnum_AGENCE =
    const TypeChangeReviewItemCurrentTypeEnum._('AGENCE');
const TypeChangeReviewItemCurrentTypeEnum
_$typeChangeReviewItemCurrentTypeEnum_PROMOTEUR =
    const TypeChangeReviewItemCurrentTypeEnum._('PROMOTEUR');
const TypeChangeReviewItemCurrentTypeEnum
_$typeChangeReviewItemCurrentTypeEnum_unknownDefaultOpenApi =
    const TypeChangeReviewItemCurrentTypeEnum._('unknownDefaultOpenApi');

TypeChangeReviewItemCurrentTypeEnum
_$typeChangeReviewItemCurrentTypeEnumValueOf(String name) {
  switch (name) {
    case 'PARTICULIER':
      return _$typeChangeReviewItemCurrentTypeEnum_PARTICULIER;
    case 'AGENCE':
      return _$typeChangeReviewItemCurrentTypeEnum_AGENCE;
    case 'PROMOTEUR':
      return _$typeChangeReviewItemCurrentTypeEnum_PROMOTEUR;
    case 'unknownDefaultOpenApi':
      return _$typeChangeReviewItemCurrentTypeEnum_unknownDefaultOpenApi;
    default:
      return _$typeChangeReviewItemCurrentTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<TypeChangeReviewItemCurrentTypeEnum>
_$typeChangeReviewItemCurrentTypeEnumValues =
    BuiltSet<TypeChangeReviewItemCurrentTypeEnum>(
      const <TypeChangeReviewItemCurrentTypeEnum>[
        _$typeChangeReviewItemCurrentTypeEnum_PARTICULIER,
        _$typeChangeReviewItemCurrentTypeEnum_AGENCE,
        _$typeChangeReviewItemCurrentTypeEnum_PROMOTEUR,
        _$typeChangeReviewItemCurrentTypeEnum_unknownDefaultOpenApi,
      ],
    );

const TypeChangeReviewItemRequestedTypeEnum
_$typeChangeReviewItemRequestedTypeEnum_PARTICULIER =
    const TypeChangeReviewItemRequestedTypeEnum._('PARTICULIER');
const TypeChangeReviewItemRequestedTypeEnum
_$typeChangeReviewItemRequestedTypeEnum_AGENCE =
    const TypeChangeReviewItemRequestedTypeEnum._('AGENCE');
const TypeChangeReviewItemRequestedTypeEnum
_$typeChangeReviewItemRequestedTypeEnum_PROMOTEUR =
    const TypeChangeReviewItemRequestedTypeEnum._('PROMOTEUR');
const TypeChangeReviewItemRequestedTypeEnum
_$typeChangeReviewItemRequestedTypeEnum_unknownDefaultOpenApi =
    const TypeChangeReviewItemRequestedTypeEnum._('unknownDefaultOpenApi');

TypeChangeReviewItemRequestedTypeEnum
_$typeChangeReviewItemRequestedTypeEnumValueOf(String name) {
  switch (name) {
    case 'PARTICULIER':
      return _$typeChangeReviewItemRequestedTypeEnum_PARTICULIER;
    case 'AGENCE':
      return _$typeChangeReviewItemRequestedTypeEnum_AGENCE;
    case 'PROMOTEUR':
      return _$typeChangeReviewItemRequestedTypeEnum_PROMOTEUR;
    case 'unknownDefaultOpenApi':
      return _$typeChangeReviewItemRequestedTypeEnum_unknownDefaultOpenApi;
    default:
      return _$typeChangeReviewItemRequestedTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<TypeChangeReviewItemRequestedTypeEnum>
_$typeChangeReviewItemRequestedTypeEnumValues =
    BuiltSet<TypeChangeReviewItemRequestedTypeEnum>(
      const <TypeChangeReviewItemRequestedTypeEnum>[
        _$typeChangeReviewItemRequestedTypeEnum_PARTICULIER,
        _$typeChangeReviewItemRequestedTypeEnum_AGENCE,
        _$typeChangeReviewItemRequestedTypeEnum_PROMOTEUR,
        _$typeChangeReviewItemRequestedTypeEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<TypeChangeReviewItemCurrentTypeEnum>
_$typeChangeReviewItemCurrentTypeEnumSerializer =
    _$TypeChangeReviewItemCurrentTypeEnumSerializer();
Serializer<TypeChangeReviewItemRequestedTypeEnum>
_$typeChangeReviewItemRequestedTypeEnumSerializer =
    _$TypeChangeReviewItemRequestedTypeEnumSerializer();

class _$TypeChangeReviewItemCurrentTypeEnumSerializer
    implements PrimitiveSerializer<TypeChangeReviewItemCurrentTypeEnum> {
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
    TypeChangeReviewItemCurrentTypeEnum,
  ];
  @override
  final String wireName = 'TypeChangeReviewItemCurrentTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    TypeChangeReviewItemCurrentTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TypeChangeReviewItemCurrentTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TypeChangeReviewItemCurrentTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TypeChangeReviewItemRequestedTypeEnumSerializer
    implements PrimitiveSerializer<TypeChangeReviewItemRequestedTypeEnum> {
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
    TypeChangeReviewItemRequestedTypeEnum,
  ];
  @override
  final String wireName = 'TypeChangeReviewItemRequestedTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    TypeChangeReviewItemRequestedTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TypeChangeReviewItemRequestedTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TypeChangeReviewItemRequestedTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TypeChangeReviewItem extends TypeChangeReviewItem {
  @override
  final String? id;
  @override
  final String? accountId;
  @override
  final TypeChangeReviewItemCurrentTypeEnum? currentType;
  @override
  final TypeChangeReviewItemRequestedTypeEnum? requestedType;
  @override
  final String? reason;
  @override
  final DateTime? createdAt;

  factory _$TypeChangeReviewItem([
    void Function(TypeChangeReviewItemBuilder)? updates,
  ]) => (TypeChangeReviewItemBuilder()..update(updates))._build();

  _$TypeChangeReviewItem._({
    this.id,
    this.accountId,
    this.currentType,
    this.requestedType,
    this.reason,
    this.createdAt,
  }) : super._();
  @override
  TypeChangeReviewItem rebuild(
    void Function(TypeChangeReviewItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TypeChangeReviewItemBuilder toBuilder() =>
      TypeChangeReviewItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TypeChangeReviewItem &&
        id == other.id &&
        accountId == other.accountId &&
        currentType == other.currentType &&
        requestedType == other.requestedType &&
        reason == other.reason &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, currentType.hashCode);
    _$hash = $jc(_$hash, requestedType.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TypeChangeReviewItem')
          ..add('id', id)
          ..add('accountId', accountId)
          ..add('currentType', currentType)
          ..add('requestedType', requestedType)
          ..add('reason', reason)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class TypeChangeReviewItemBuilder
    implements Builder<TypeChangeReviewItem, TypeChangeReviewItemBuilder> {
  _$TypeChangeReviewItem? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  TypeChangeReviewItemCurrentTypeEnum? _currentType;
  TypeChangeReviewItemCurrentTypeEnum? get currentType => _$this._currentType;
  set currentType(TypeChangeReviewItemCurrentTypeEnum? currentType) =>
      _$this._currentType = currentType;

  TypeChangeReviewItemRequestedTypeEnum? _requestedType;
  TypeChangeReviewItemRequestedTypeEnum? get requestedType =>
      _$this._requestedType;
  set requestedType(TypeChangeReviewItemRequestedTypeEnum? requestedType) =>
      _$this._requestedType = requestedType;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  TypeChangeReviewItemBuilder() {
    TypeChangeReviewItem._defaults(this);
  }

  TypeChangeReviewItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _accountId = $v.accountId;
      _currentType = $v.currentType;
      _requestedType = $v.requestedType;
      _reason = $v.reason;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TypeChangeReviewItem other) {
    _$v = other as _$TypeChangeReviewItem;
  }

  @override
  void update(void Function(TypeChangeReviewItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TypeChangeReviewItem build() => _build();

  _$TypeChangeReviewItem _build() {
    final _$result =
        _$v ??
        _$TypeChangeReviewItem._(
          id: id,
          accountId: accountId,
          currentType: currentType,
          requestedType: requestedType,
          reason: reason,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
