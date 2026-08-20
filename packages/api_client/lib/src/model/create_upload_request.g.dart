// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_upload_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateUploadRequestCategoryEnum
_$createUploadRequestCategoryEnum_KYC_DOCUMENT =
    const CreateUploadRequestCategoryEnum._('KYC_DOCUMENT');
const CreateUploadRequestCategoryEnum
_$createUploadRequestCategoryEnum_LISTING_PHOTO =
    const CreateUploadRequestCategoryEnum._('LISTING_PHOTO');
const CreateUploadRequestCategoryEnum
_$createUploadRequestCategoryEnum_PROFILE_PHOTO =
    const CreateUploadRequestCategoryEnum._('PROFILE_PHOTO');
const CreateUploadRequestCategoryEnum
_$createUploadRequestCategoryEnum_MESSAGE_ATTACHMENT =
    const CreateUploadRequestCategoryEnum._('MESSAGE_ATTACHMENT');
const CreateUploadRequestCategoryEnum
_$createUploadRequestCategoryEnum_VISIT_REPORT =
    const CreateUploadRequestCategoryEnum._('VISIT_REPORT');
const CreateUploadRequestCategoryEnum
_$createUploadRequestCategoryEnum_RECEIPT =
    const CreateUploadRequestCategoryEnum._('RECEIPT');
const CreateUploadRequestCategoryEnum
_$createUploadRequestCategoryEnum_CONTRACT =
    const CreateUploadRequestCategoryEnum._('CONTRACT');
const CreateUploadRequestCategoryEnum
_$createUploadRequestCategoryEnum_unknownDefaultOpenApi =
    const CreateUploadRequestCategoryEnum._('unknownDefaultOpenApi');

CreateUploadRequestCategoryEnum _$createUploadRequestCategoryEnumValueOf(
  String name,
) {
  switch (name) {
    case 'KYC_DOCUMENT':
      return _$createUploadRequestCategoryEnum_KYC_DOCUMENT;
    case 'LISTING_PHOTO':
      return _$createUploadRequestCategoryEnum_LISTING_PHOTO;
    case 'PROFILE_PHOTO':
      return _$createUploadRequestCategoryEnum_PROFILE_PHOTO;
    case 'MESSAGE_ATTACHMENT':
      return _$createUploadRequestCategoryEnum_MESSAGE_ATTACHMENT;
    case 'VISIT_REPORT':
      return _$createUploadRequestCategoryEnum_VISIT_REPORT;
    case 'RECEIPT':
      return _$createUploadRequestCategoryEnum_RECEIPT;
    case 'CONTRACT':
      return _$createUploadRequestCategoryEnum_CONTRACT;
    case 'unknownDefaultOpenApi':
      return _$createUploadRequestCategoryEnum_unknownDefaultOpenApi;
    default:
      return _$createUploadRequestCategoryEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CreateUploadRequestCategoryEnum>
_$createUploadRequestCategoryEnumValues =
    BuiltSet<CreateUploadRequestCategoryEnum>(
      const <CreateUploadRequestCategoryEnum>[
        _$createUploadRequestCategoryEnum_KYC_DOCUMENT,
        _$createUploadRequestCategoryEnum_LISTING_PHOTO,
        _$createUploadRequestCategoryEnum_PROFILE_PHOTO,
        _$createUploadRequestCategoryEnum_MESSAGE_ATTACHMENT,
        _$createUploadRequestCategoryEnum_VISIT_REPORT,
        _$createUploadRequestCategoryEnum_RECEIPT,
        _$createUploadRequestCategoryEnum_CONTRACT,
        _$createUploadRequestCategoryEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<CreateUploadRequestCategoryEnum>
_$createUploadRequestCategoryEnumSerializer =
    _$CreateUploadRequestCategoryEnumSerializer();

class _$CreateUploadRequestCategoryEnumSerializer
    implements PrimitiveSerializer<CreateUploadRequestCategoryEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'KYC_DOCUMENT': 'KYC_DOCUMENT',
    'LISTING_PHOTO': 'LISTING_PHOTO',
    'PROFILE_PHOTO': 'PROFILE_PHOTO',
    'MESSAGE_ATTACHMENT': 'MESSAGE_ATTACHMENT',
    'VISIT_REPORT': 'VISIT_REPORT',
    'RECEIPT': 'RECEIPT',
    'CONTRACT': 'CONTRACT',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'KYC_DOCUMENT': 'KYC_DOCUMENT',
    'LISTING_PHOTO': 'LISTING_PHOTO',
    'PROFILE_PHOTO': 'PROFILE_PHOTO',
    'MESSAGE_ATTACHMENT': 'MESSAGE_ATTACHMENT',
    'VISIT_REPORT': 'VISIT_REPORT',
    'RECEIPT': 'RECEIPT',
    'CONTRACT': 'CONTRACT',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateUploadRequestCategoryEnum];
  @override
  final String wireName = 'CreateUploadRequestCategoryEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateUploadRequestCategoryEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateUploadRequestCategoryEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateUploadRequestCategoryEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateUploadRequest extends CreateUploadRequest {
  @override
  final CreateUploadRequestCategoryEnum category;
  @override
  final String contentType;
  @override
  final int contentLength;

  factory _$CreateUploadRequest([
    void Function(CreateUploadRequestBuilder)? updates,
  ]) => (CreateUploadRequestBuilder()..update(updates))._build();

  _$CreateUploadRequest._({
    required this.category,
    required this.contentType,
    required this.contentLength,
  }) : super._();
  @override
  CreateUploadRequest rebuild(
    void Function(CreateUploadRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateUploadRequestBuilder toBuilder() =>
      CreateUploadRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateUploadRequest &&
        category == other.category &&
        contentType == other.contentType &&
        contentLength == other.contentLength;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, contentType.hashCode);
    _$hash = $jc(_$hash, contentLength.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateUploadRequest')
          ..add('category', category)
          ..add('contentType', contentType)
          ..add('contentLength', contentLength))
        .toString();
  }
}

class CreateUploadRequestBuilder
    implements Builder<CreateUploadRequest, CreateUploadRequestBuilder> {
  _$CreateUploadRequest? _$v;

  CreateUploadRequestCategoryEnum? _category;
  CreateUploadRequestCategoryEnum? get category => _$this._category;
  set category(CreateUploadRequestCategoryEnum? category) =>
      _$this._category = category;

  String? _contentType;
  String? get contentType => _$this._contentType;
  set contentType(String? contentType) => _$this._contentType = contentType;

  int? _contentLength;
  int? get contentLength => _$this._contentLength;
  set contentLength(int? contentLength) =>
      _$this._contentLength = contentLength;

  CreateUploadRequestBuilder() {
    CreateUploadRequest._defaults(this);
  }

  CreateUploadRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _category = $v.category;
      _contentType = $v.contentType;
      _contentLength = $v.contentLength;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateUploadRequest other) {
    _$v = other as _$CreateUploadRequest;
  }

  @override
  void update(void Function(CreateUploadRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateUploadRequest build() => _build();

  _$CreateUploadRequest _build() {
    final _$result =
        _$v ??
        _$CreateUploadRequest._(
          category: BuiltValueNullFieldError.checkNotNull(
            category,
            r'CreateUploadRequest',
            'category',
          ),
          contentType: BuiltValueNullFieldError.checkNotNull(
            contentType,
            r'CreateUploadRequest',
            'contentType',
          ),
          contentLength: BuiltValueNullFieldError.checkNotNull(
            contentLength,
            r'CreateUploadRequest',
            'contentLength',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
