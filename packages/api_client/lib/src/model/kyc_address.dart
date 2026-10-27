//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'kyc_address.g.dart';

/// KycAddress
///
/// Properties:
/// * [districtId] 
/// * [city] 
/// * [district] 
/// * [details] 
@BuiltValue()
abstract class KycAddress implements Built<KycAddress, KycAddressBuilder> {
  @BuiltValueField(wireName: r'districtId')
  String? get districtId;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'district')
  String? get district;

  @BuiltValueField(wireName: r'details')
  String? get details;

  KycAddress._();

  factory KycAddress([void updates(KycAddressBuilder b)]) = _$KycAddress;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KycAddressBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KycAddress> get serializer => _$KycAddressSerializer();
}

class _$KycAddressSerializer implements PrimitiveSerializer<KycAddress> {
  @override
  final Iterable<Type> types = const [KycAddress, _$KycAddress];

  @override
  final String wireName = r'KycAddress';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KycAddress object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.districtId != null) {
      yield r'districtId';
      yield serializers.serialize(
        object.districtId,
        specifiedType: const FullType(String),
      );
    }
    if (object.city != null) {
      yield r'city';
      yield serializers.serialize(
        object.city,
        specifiedType: const FullType(String),
      );
    }
    if (object.district != null) {
      yield r'district';
      yield serializers.serialize(
        object.district,
        specifiedType: const FullType(String),
      );
    }
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
    KycAddress object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KycAddressBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'districtId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.districtId = valueDes;
          break;
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.city = valueDes;
          break;
        case r'district':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.district = valueDes;
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
  KycAddress deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KycAddressBuilder();
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

