//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_upload_request.g.dart';

/// CreateUploadRequest
///
/// Properties:
/// * [category] 
/// * [contentType] 
@BuiltValue()
abstract class CreateUploadRequest implements Built<CreateUploadRequest, CreateUploadRequestBuilder> {
  @BuiltValueField(wireName: r'category')
  CreateUploadRequestCategoryEnum get category;
  // enum categoryEnum {  KYC_DOCUMENT,  LISTING_PHOTO,  PROFILE_PHOTO,  VISIT_REPORT,  };

  @BuiltValueField(wireName: r'contentType')
  String get contentType;

  CreateUploadRequest._();

  factory CreateUploadRequest([void updates(CreateUploadRequestBuilder b)]) = _$CreateUploadRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateUploadRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateUploadRequest> get serializer => _$CreateUploadRequestSerializer();
}

class _$CreateUploadRequestSerializer implements PrimitiveSerializer<CreateUploadRequest> {
  @override
  final Iterable<Type> types = const [CreateUploadRequest, _$CreateUploadRequest];

  @override
  final String wireName = r'CreateUploadRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateUploadRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(CreateUploadRequestCategoryEnum),
    );
    yield r'contentType';
    yield serializers.serialize(
      object.contentType,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateUploadRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateUploadRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateUploadRequestCategoryEnum),
          ) as CreateUploadRequestCategoryEnum;
          result.category = valueDes;
          break;
        case r'contentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.contentType = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateUploadRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateUploadRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class CreateUploadRequestCategoryEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'KYC_DOCUMENT')
  static const CreateUploadRequestCategoryEnum KYC_DOCUMENT = _$createUploadRequestCategoryEnum_KYC_DOCUMENT;
  @BuiltValueEnumConst(wireName: r'LISTING_PHOTO')
  static const CreateUploadRequestCategoryEnum LISTING_PHOTO = _$createUploadRequestCategoryEnum_LISTING_PHOTO;
  @BuiltValueEnumConst(wireName: r'PROFILE_PHOTO')
  static const CreateUploadRequestCategoryEnum PROFILE_PHOTO = _$createUploadRequestCategoryEnum_PROFILE_PHOTO;
  @BuiltValueEnumConst(wireName: r'VISIT_REPORT')
  static const CreateUploadRequestCategoryEnum VISIT_REPORT = _$createUploadRequestCategoryEnum_VISIT_REPORT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateUploadRequestCategoryEnum unknownDefaultOpenApi = _$createUploadRequestCategoryEnum_unknownDefaultOpenApi;

  static Serializer<CreateUploadRequestCategoryEnum> get serializer => _$createUploadRequestCategoryEnumSerializer;

  const CreateUploadRequestCategoryEnum._(String name): super(name);

  static BuiltSet<CreateUploadRequestCategoryEnum> get values => _$createUploadRequestCategoryEnumValues;
  static CreateUploadRequestCategoryEnum valueOf(String name) => _$createUploadRequestCategoryEnumValueOf(name);
}

