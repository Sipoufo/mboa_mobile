//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'service_provider_request.g.dart';

/// ServiceProviderRequest
///
/// Properties:
/// * [name] 
/// * [kind] 
/// * [kindLabel] 
/// * [note] 
/// * [linkedAccountId] 
@BuiltValue()
abstract class ServiceProviderRequest implements Built<ServiceProviderRequest, ServiceProviderRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'kind')
  ServiceProviderRequestKindEnum get kind;
  // enum kindEnum {  CLEANING,  PLUMBING,  ELECTRICAL,  OTHER,  };

  @BuiltValueField(wireName: r'kindLabel')
  String? get kindLabel;

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'linkedAccountId')
  String? get linkedAccountId;

  ServiceProviderRequest._();

  factory ServiceProviderRequest([void updates(ServiceProviderRequestBuilder b)]) = _$ServiceProviderRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ServiceProviderRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ServiceProviderRequest> get serializer => _$ServiceProviderRequestSerializer();
}

class _$ServiceProviderRequestSerializer implements PrimitiveSerializer<ServiceProviderRequest> {
  @override
  final Iterable<Type> types = const [ServiceProviderRequest, _$ServiceProviderRequest];

  @override
  final String wireName = r'ServiceProviderRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ServiceProviderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(ServiceProviderRequestKindEnum),
    );
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
    if (object.linkedAccountId != null) {
      yield r'linkedAccountId';
      yield serializers.serialize(
        object.linkedAccountId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ServiceProviderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ServiceProviderRequestBuilder result,
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
            specifiedType: const FullType(ServiceProviderRequestKindEnum),
          ) as ServiceProviderRequestKindEnum;
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
        case r'linkedAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.linkedAccountId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ServiceProviderRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ServiceProviderRequestBuilder();
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

class ServiceProviderRequestKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CLEANING')
  static const ServiceProviderRequestKindEnum CLEANING = _$serviceProviderRequestKindEnum_CLEANING;
  @BuiltValueEnumConst(wireName: r'PLUMBING')
  static const ServiceProviderRequestKindEnum PLUMBING = _$serviceProviderRequestKindEnum_PLUMBING;
  @BuiltValueEnumConst(wireName: r'ELECTRICAL')
  static const ServiceProviderRequestKindEnum ELECTRICAL = _$serviceProviderRequestKindEnum_ELECTRICAL;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const ServiceProviderRequestKindEnum OTHER = _$serviceProviderRequestKindEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ServiceProviderRequestKindEnum unknownDefaultOpenApi = _$serviceProviderRequestKindEnum_unknownDefaultOpenApi;

  static Serializer<ServiceProviderRequestKindEnum> get serializer => _$serviceProviderRequestKindEnumSerializer;

  const ServiceProviderRequestKindEnum._(String name): super(name);

  static BuiltSet<ServiceProviderRequestKindEnum> get values => _$serviceProviderRequestKindEnumValues;
  static ServiceProviderRequestKindEnum valueOf(String name) => _$serviceProviderRequestKindEnumValueOf(name);
}

