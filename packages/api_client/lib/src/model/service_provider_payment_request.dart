//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'service_provider_payment_request.g.dart';

/// ServiceProviderPaymentRequest
///
/// Properties:
/// * [amount] 
/// * [paidOn] 
/// * [note] 
/// * [annonceId] 
/// * [residenceId] 
@BuiltValue()
abstract class ServiceProviderPaymentRequest implements Built<ServiceProviderPaymentRequest, ServiceProviderPaymentRequestBuilder> {
  @BuiltValueField(wireName: r'amount')
  int get amount;

  @BuiltValueField(wireName: r'paidOn')
  Date get paidOn;

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'residenceId')
  String? get residenceId;

  ServiceProviderPaymentRequest._();

  factory ServiceProviderPaymentRequest([void updates(ServiceProviderPaymentRequestBuilder b)]) = _$ServiceProviderPaymentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ServiceProviderPaymentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ServiceProviderPaymentRequest> get serializer => _$ServiceProviderPaymentRequestSerializer();
}

class _$ServiceProviderPaymentRequestSerializer implements PrimitiveSerializer<ServiceProviderPaymentRequest> {
  @override
  final Iterable<Type> types = const [ServiceProviderPaymentRequest, _$ServiceProviderPaymentRequest];

  @override
  final String wireName = r'ServiceProviderPaymentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ServiceProviderPaymentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(int),
    );
    yield r'paidOn';
    yield serializers.serialize(
      object.paidOn,
      specifiedType: const FullType(Date),
    );
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType(String),
      );
    }
    if (object.annonceId != null) {
      yield r'annonceId';
      yield serializers.serialize(
        object.annonceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.residenceId != null) {
      yield r'residenceId';
      yield serializers.serialize(
        object.residenceId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ServiceProviderPaymentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ServiceProviderPaymentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.amount = valueDes;
          break;
        case r'paidOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.paidOn = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        case r'annonceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.annonceId = valueDes;
          break;
        case r'residenceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.residenceId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ServiceProviderPaymentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ServiceProviderPaymentRequestBuilder();
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

