//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_service_provider_request.g.dart';

/// UpdateServiceProviderRequest
///
/// Properties:
/// * [name] 
/// * [kind] 
/// * [kindLabel] 
/// * [note] 
@BuiltValue()
abstract class UpdateServiceProviderRequest implements Built<UpdateServiceProviderRequest, UpdateServiceProviderRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'kind')
  UpdateServiceProviderRequestKindEnum? get kind;
  // enum kindEnum {  CLEANING,  PLUMBING,  ELECTRICAL,  OTHER,  };

  @BuiltValueField(wireName: r'kindLabel')
  String? get kindLabel;

  @BuiltValueField(wireName: r'note')
  String? get note;

  UpdateServiceProviderRequest._();

  factory UpdateServiceProviderRequest([void updates(UpdateServiceProviderRequestBuilder b)]) = _$UpdateServiceProviderRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateServiceProviderRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateServiceProviderRequest> get serializer => _$UpdateServiceProviderRequestSerializer();
}

class _$UpdateServiceProviderRequestSerializer implements PrimitiveSerializer<UpdateServiceProviderRequest> {
  @override
  final Iterable<Type> types = const [UpdateServiceProviderRequest, _$UpdateServiceProviderRequest];

  @override
  final String wireName = r'UpdateServiceProviderRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateServiceProviderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.kind != null) {
      yield r'kind';
      yield serializers.serialize(
        object.kind,
        specifiedType: const FullType(UpdateServiceProviderRequestKindEnum),
      );
    }
    if (object.kindLabel != null) {
      yield r'kindLabel';
      yield serializers.serialize(
        object.kindLabel,
        specifiedType: const FullType(String),
      );
    }
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateServiceProviderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateServiceProviderRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UpdateServiceProviderRequestKindEnum),
          ) as UpdateServiceProviderRequestKindEnum?;
          if (valueDes == null) continue;
          result.kind = valueDes;
          break;
        case r'kindLabel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.kindLabel = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateServiceProviderRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateServiceProviderRequestBuilder();
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

class UpdateServiceProviderRequestKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CLEANING')
  static const UpdateServiceProviderRequestKindEnum CLEANING = _$updateServiceProviderRequestKindEnum_CLEANING;
  @BuiltValueEnumConst(wireName: r'PLUMBING')
  static const UpdateServiceProviderRequestKindEnum PLUMBING = _$updateServiceProviderRequestKindEnum_PLUMBING;
  @BuiltValueEnumConst(wireName: r'ELECTRICAL')
  static const UpdateServiceProviderRequestKindEnum ELECTRICAL = _$updateServiceProviderRequestKindEnum_ELECTRICAL;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const UpdateServiceProviderRequestKindEnum OTHER = _$updateServiceProviderRequestKindEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UpdateServiceProviderRequestKindEnum unknownDefaultOpenApi = _$updateServiceProviderRequestKindEnum_unknownDefaultOpenApi;

  static Serializer<UpdateServiceProviderRequestKindEnum> get serializer => _$updateServiceProviderRequestKindEnumSerializer;

  const UpdateServiceProviderRequestKindEnum._(String name): super(name);

  static BuiltSet<UpdateServiceProviderRequestKindEnum> get values => _$updateServiceProviderRequestKindEnumValues;
  static UpdateServiceProviderRequestKindEnum valueOf(String name) => _$updateServiceProviderRequestKindEnumValueOf(name);
}

