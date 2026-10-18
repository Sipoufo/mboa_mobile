//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'service_provider_response.g.dart';

/// ServiceProviderResponse
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [kind] 
/// * [kindLabel] 
/// * [note] 
/// * [linkedAccountId] 
/// * [archived] 
/// * [totalPaid] 
/// * [paymentCount] 
/// * [lastPaidOn] 
/// * [createdAt] 
@BuiltValue()
abstract class ServiceProviderResponse implements Built<ServiceProviderResponse, ServiceProviderResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'kind')
  ServiceProviderResponseKindEnum? get kind;
  // enum kindEnum {  CLEANING,  PLUMBING,  ELECTRICAL,  OTHER,  };

  @BuiltValueField(wireName: r'kindLabel')
  String? get kindLabel;

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'linkedAccountId')
  String? get linkedAccountId;

  @BuiltValueField(wireName: r'archived')
  bool? get archived;

  @BuiltValueField(wireName: r'totalPaid')
  int? get totalPaid;

  @BuiltValueField(wireName: r'paymentCount')
  int? get paymentCount;

  @BuiltValueField(wireName: r'lastPaidOn')
  Date? get lastPaidOn;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  ServiceProviderResponse._();

  factory ServiceProviderResponse([void updates(ServiceProviderResponseBuilder b)]) = _$ServiceProviderResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ServiceProviderResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ServiceProviderResponse> get serializer => _$ServiceProviderResponseSerializer();
}

class _$ServiceProviderResponseSerializer implements PrimitiveSerializer<ServiceProviderResponse> {
  @override
  final Iterable<Type> types = const [ServiceProviderResponse, _$ServiceProviderResponse];

  @override
  final String wireName = r'ServiceProviderResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ServiceProviderResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
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
        specifiedType: const FullType(ServiceProviderResponseKindEnum),
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
    if (object.linkedAccountId != null) {
      yield r'linkedAccountId';
      yield serializers.serialize(
        object.linkedAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.archived != null) {
      yield r'archived';
      yield serializers.serialize(
        object.archived,
        specifiedType: const FullType(bool),
      );
    }
    if (object.totalPaid != null) {
      yield r'totalPaid';
      yield serializers.serialize(
        object.totalPaid,
        specifiedType: const FullType(int),
      );
    }
    if (object.paymentCount != null) {
      yield r'paymentCount';
      yield serializers.serialize(
        object.paymentCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.lastPaidOn != null) {
      yield r'lastPaidOn';
      yield serializers.serialize(
        object.lastPaidOn,
        specifiedType: const FullType(Date),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ServiceProviderResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ServiceProviderResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.id = valueDes;
          break;
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
            specifiedType: const FullType.nullable(ServiceProviderResponseKindEnum),
          ) as ServiceProviderResponseKindEnum?;
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
        case r'linkedAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.linkedAccountId = valueDes;
          break;
        case r'archived':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.archived = valueDes;
          break;
        case r'totalPaid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.totalPaid = valueDes;
          break;
        case r'paymentCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.paymentCount = valueDes;
          break;
        case r'lastPaidOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.lastPaidOn = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ServiceProviderResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ServiceProviderResponseBuilder();
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

class ServiceProviderResponseKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CLEANING')
  static const ServiceProviderResponseKindEnum CLEANING = _$serviceProviderResponseKindEnum_CLEANING;
  @BuiltValueEnumConst(wireName: r'PLUMBING')
  static const ServiceProviderResponseKindEnum PLUMBING = _$serviceProviderResponseKindEnum_PLUMBING;
  @BuiltValueEnumConst(wireName: r'ELECTRICAL')
  static const ServiceProviderResponseKindEnum ELECTRICAL = _$serviceProviderResponseKindEnum_ELECTRICAL;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const ServiceProviderResponseKindEnum OTHER = _$serviceProviderResponseKindEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ServiceProviderResponseKindEnum unknownDefaultOpenApi = _$serviceProviderResponseKindEnum_unknownDefaultOpenApi;

  static Serializer<ServiceProviderResponseKindEnum> get serializer => _$serviceProviderResponseKindEnumSerializer;

  const ServiceProviderResponseKindEnum._(String name): super(name);

  static BuiltSet<ServiceProviderResponseKindEnum> get values => _$serviceProviderResponseKindEnumValues;
  static ServiceProviderResponseKindEnum valueOf(String name) => _$serviceProviderResponseKindEnumValueOf(name);
}

