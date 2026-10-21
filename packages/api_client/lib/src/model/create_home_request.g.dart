// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_home_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateHomeRequestTypeEnum _$createHomeRequestTypeEnum_REMARK =
    const CreateHomeRequestTypeEnum._('REMARK');
const CreateHomeRequestTypeEnum _$createHomeRequestTypeEnum_MAINTENANCE =
    const CreateHomeRequestTypeEnum._('MAINTENANCE');
const CreateHomeRequestTypeEnum _$createHomeRequestTypeEnum_QUESTION =
    const CreateHomeRequestTypeEnum._('QUESTION');
const CreateHomeRequestTypeEnum
_$createHomeRequestTypeEnum_unknownDefaultOpenApi =
    const CreateHomeRequestTypeEnum._('unknownDefaultOpenApi');

CreateHomeRequestTypeEnum _$createHomeRequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'REMARK':
      return _$createHomeRequestTypeEnum_REMARK;
    case 'MAINTENANCE':
      return _$createHomeRequestTypeEnum_MAINTENANCE;
    case 'QUESTION':
      return _$createHomeRequestTypeEnum_QUESTION;
    case 'unknownDefaultOpenApi':
      return _$createHomeRequestTypeEnum_unknownDefaultOpenApi;
    default:
      return _$createHomeRequestTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CreateHomeRequestTypeEnum> _$createHomeRequestTypeEnumValues =
    BuiltSet<CreateHomeRequestTypeEnum>(const <CreateHomeRequestTypeEnum>[
      _$createHomeRequestTypeEnum_REMARK,
      _$createHomeRequestTypeEnum_MAINTENANCE,
      _$createHomeRequestTypeEnum_QUESTION,
      _$createHomeRequestTypeEnum_unknownDefaultOpenApi,
    ]);

Serializer<CreateHomeRequestTypeEnum> _$createHomeRequestTypeEnumSerializer =
    _$CreateHomeRequestTypeEnumSerializer();

class _$CreateHomeRequestTypeEnumSerializer
    implements PrimitiveSerializer<CreateHomeRequestTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'REMARK': 'REMARK',
    'MAINTENANCE': 'MAINTENANCE',
    'QUESTION': 'QUESTION',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'REMARK': 'REMARK',
    'MAINTENANCE': 'MAINTENANCE',
    'QUESTION': 'QUESTION',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateHomeRequestTypeEnum];
  @override
  final String wireName = 'CreateHomeRequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateHomeRequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateHomeRequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateHomeRequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateHomeRequest extends CreateHomeRequest {
  @override
  final CreateHomeRequestTypeEnum type;
  @override
  final String title;
  @override
  final String description;
  @override
  final BuiltList<String>? photoKeys;

  factory _$CreateHomeRequest([
    void Function(CreateHomeRequestBuilder)? updates,
  ]) => (CreateHomeRequestBuilder()..update(updates))._build();

  _$CreateHomeRequest._({
    required this.type,
    required this.title,
    required this.description,
    this.photoKeys,
  }) : super._();
  @override
  CreateHomeRequest rebuild(void Function(CreateHomeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateHomeRequestBuilder toBuilder() =>
      CreateHomeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateHomeRequest &&
        type == other.type &&
        title == other.title &&
        description == other.description &&
        photoKeys == other.photoKeys;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, photoKeys.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateHomeRequest')
          ..add('type', type)
          ..add('title', title)
          ..add('description', description)
          ..add('photoKeys', photoKeys))
        .toString();
  }
}

class CreateHomeRequestBuilder
    implements Builder<CreateHomeRequest, CreateHomeRequestBuilder> {
  _$CreateHomeRequest? _$v;

  CreateHomeRequestTypeEnum? _type;
  CreateHomeRequestTypeEnum? get type => _$this._type;
  set type(CreateHomeRequestTypeEnum? type) => _$this._type = type;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ListBuilder<String>? _photoKeys;
  ListBuilder<String> get photoKeys =>
      _$this._photoKeys ??= ListBuilder<String>();
  set photoKeys(ListBuilder<String>? photoKeys) =>
      _$this._photoKeys = photoKeys;

  CreateHomeRequestBuilder() {
    CreateHomeRequest._defaults(this);
  }

  CreateHomeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _title = $v.title;
      _description = $v.description;
      _photoKeys = $v.photoKeys?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateHomeRequest other) {
    _$v = other as _$CreateHomeRequest;
  }

  @override
  void update(void Function(CreateHomeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateHomeRequest build() => _build();

  _$CreateHomeRequest _build() {
    _$CreateHomeRequest _$result;
    try {
      _$result =
          _$v ??
          _$CreateHomeRequest._(
            type: BuiltValueNullFieldError.checkNotNull(
              type,
              r'CreateHomeRequest',
              'type',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'CreateHomeRequest',
              'title',
            ),
            description: BuiltValueNullFieldError.checkNotNull(
              description,
              r'CreateHomeRequest',
              'description',
            ),
            photoKeys: _photoKeys?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'photoKeys';
        _photoKeys?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CreateHomeRequest',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
