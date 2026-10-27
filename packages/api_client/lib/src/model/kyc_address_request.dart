//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'kyc_address_request.g.dart';

/// KycAddressRequest
///
/// Properties:
/// * [districtId] 
/// * [details] 
@BuiltValue()
abstract class KycAddressRequest implements Built<KycAddressRequest, KycAddressRequestBuilder> {
  @BuiltValueField(wireName: r'districtId')
  String get districtId;

  @BuiltValueField(wireName: r'details')
  String? get details;

  KycAddressRequest._();

  factory KycAddressRequest([void updates(KycAddressRequestBuilder b)]) = _$KycAddressRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KycAddressRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KycAddressRequest> get serializer => _$KycAddressRequestSerializer();
}

class _$KycAddressRequestSerializer implements PrimitiveSerializer<KycAddressRequest> {
  @override
  final Iterable<Type> types = const [KycAddressRequest, _$KycAddressRequest];

  @override
  final String wireName = r'KycAddressRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KycAddressRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'districtId';
    yield serializers.serialize(
      object.districtId,
      specifiedType: const FullType(String),
    );
    if (object.details != null) {
      yield r'details';
      yield serializers.serialize(
        object.details,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    KycAddressRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KycAddressRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'districtId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.districtId = valueDes;
          break;
        case r'details':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.details = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  KycAddressRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KycAddressRequestBuilder();
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

