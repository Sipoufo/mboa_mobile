//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'service_provider_payment_response.g.dart';

/// ServiceProviderPaymentResponse
///
/// Properties:
/// * [id] 
/// * [providerId] 
/// * [amount] 
/// * [paidOn] 
/// * [note] 
/// * [annonceId] 
/// * [residenceId] 
/// * [propertyLabel] 
/// * [inLedger] 
/// * [createdAt] 
@BuiltValue()
abstract class ServiceProviderPaymentResponse implements Built<ServiceProviderPaymentResponse, ServiceProviderPaymentResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'providerId')
  String? get providerId;

  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'paidOn')
  Date? get paidOn;

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'residenceId')
  String? get residenceId;

  @BuiltValueField(wireName: r'propertyLabel')
  String? get propertyLabel;

  @BuiltValueField(wireName: r'inLedger')
  bool? get inLedger;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  ServiceProviderPaymentResponse._();

  factory ServiceProviderPaymentResponse([void updates(ServiceProviderPaymentResponseBuilder b)]) = _$ServiceProviderPaymentResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ServiceProviderPaymentResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ServiceProviderPaymentResponse> get serializer => _$ServiceProviderPaymentResponseSerializer();
}

class _$ServiceProviderPaymentResponseSerializer implements PrimitiveSerializer<ServiceProviderPaymentResponse> {
  @override
  final Iterable<Type> types = const [ServiceProviderPaymentResponse, _$ServiceProviderPaymentResponse];

  @override
  final String wireName = r'ServiceProviderPaymentResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ServiceProviderPaymentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.providerId != null) {
      yield r'providerId';
      yield serializers.serialize(
        object.providerId,
        specifiedType: const FullType(String),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(int),
      );
    }
    if (object.paidOn != null) {
      yield r'paidOn';
      yield serializers.serialize(
        object.paidOn,
        specifiedType: const FullType(Date),
      );
    }
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
    if (object.propertyLabel != null) {
      yield r'propertyLabel';
      yield serializers.serialize(
        object.propertyLabel,
        specifiedType: const FullType(String),
      );
    }
    if (object.inLedger != null) {
      yield r'inLedger';
      yield serializers.serialize(
        object.inLedger,
        specifiedType: const FullType(bool),
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
    ServiceProviderPaymentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ServiceProviderPaymentResponseBuilder result,
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
        case r'providerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.providerId = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'paidOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
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
        case r'propertyLabel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.propertyLabel = valueDes;
          break;
        case r'inLedger':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.inLedger = valueDes;
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
  ServiceProviderPaymentResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ServiceProviderPaymentResponseBuilder();
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

