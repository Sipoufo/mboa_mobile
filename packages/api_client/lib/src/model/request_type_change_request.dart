//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'request_type_change_request.g.dart';

/// RequestTypeChangeRequest
///
/// Properties:
/// * [newType] 
/// * [reason] 
@BuiltValue()
abstract class RequestTypeChangeRequest implements Built<RequestTypeChangeRequest, RequestTypeChangeRequestBuilder> {
  @BuiltValueField(wireName: r'newType')
  RequestTypeChangeRequestNewTypeEnum get newType;
  // enum newTypeEnum {  PARTICULIER,  AGENCE,  PROMOTEUR,  };

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  RequestTypeChangeRequest._();

  factory RequestTypeChangeRequest([void updates(RequestTypeChangeRequestBuilder b)]) = _$RequestTypeChangeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RequestTypeChangeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RequestTypeChangeRequest> get serializer => _$RequestTypeChangeRequestSerializer();
}

class _$RequestTypeChangeRequestSerializer implements PrimitiveSerializer<RequestTypeChangeRequest> {
  @override
  final Iterable<Type> types = const [RequestTypeChangeRequest, _$RequestTypeChangeRequest];

  @override
  final String wireName = r'RequestTypeChangeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RequestTypeChangeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'newType';
    yield serializers.serialize(
      object.newType,
      specifiedType: const FullType(RequestTypeChangeRequestNewTypeEnum),
    );
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RequestTypeChangeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RequestTypeChangeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'newType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RequestTypeChangeRequestNewTypeEnum),
          ) as RequestTypeChangeRequestNewTypeEnum;
          result.newType = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RequestTypeChangeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RequestTypeChangeRequestBuilder();
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

class RequestTypeChangeRequestNewTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PARTICULIER')
  static const RequestTypeChangeRequestNewTypeEnum PARTICULIER = _$requestTypeChangeRequestNewTypeEnum_PARTICULIER;
  @BuiltValueEnumConst(wireName: r'AGENCE')
  static const RequestTypeChangeRequestNewTypeEnum AGENCE = _$requestTypeChangeRequestNewTypeEnum_AGENCE;
  @BuiltValueEnumConst(wireName: r'PROMOTEUR')
  static const RequestTypeChangeRequestNewTypeEnum PROMOTEUR = _$requestTypeChangeRequestNewTypeEnum_PROMOTEUR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RequestTypeChangeRequestNewTypeEnum unknownDefaultOpenApi = _$requestTypeChangeRequestNewTypeEnum_unknownDefaultOpenApi;

  static Serializer<RequestTypeChangeRequestNewTypeEnum> get serializer => _$requestTypeChangeRequestNewTypeEnumSerializer;

  const RequestTypeChangeRequestNewTypeEnum._(String name): super(name);

  static BuiltSet<RequestTypeChangeRequestNewTypeEnum> get values => _$requestTypeChangeRequestNewTypeEnumValues;
  static RequestTypeChangeRequestNewTypeEnum valueOf(String name) => _$requestTypeChangeRequestNewTypeEnumValueOf(name);
}

