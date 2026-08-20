//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'contract_verification.g.dart';

/// ContractVerification
///
/// Properties:
/// * [contractId] 
/// * [signed] 
/// * [signedAt] 
/// * [city] 
/// * [district] 
@BuiltValue()
abstract class ContractVerification implements Built<ContractVerification, ContractVerificationBuilder> {
  @BuiltValueField(wireName: r'contractId')
  String? get contractId;

  @BuiltValueField(wireName: r'signed')
  bool? get signed;

  @BuiltValueField(wireName: r'signedAt')
  DateTime? get signedAt;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'district')
  String? get district;

  ContractVerification._();

  factory ContractVerification([void updates(ContractVerificationBuilder b)]) = _$ContractVerification;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ContractVerificationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ContractVerification> get serializer => _$ContractVerificationSerializer();
}

class _$ContractVerificationSerializer implements PrimitiveSerializer<ContractVerification> {
  @override
  final Iterable<Type> types = const [ContractVerification, _$ContractVerification];

  @override
  final String wireName = r'ContractVerification';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ContractVerification object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.contractId != null) {
      yield r'contractId';
      yield serializers.serialize(
        object.contractId,
        specifiedType: const FullType(String),
      );
    }
    if (object.signed != null) {
      yield r'signed';
      yield serializers.serialize(
        object.signed,
        specifiedType: const FullType(bool),
      );
    }
    if (object.signedAt != null) {
      yield r'signedAt';
      yield serializers.serialize(
        object.signedAt,
        specifiedType: const FullType(DateTime),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ContractVerification object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ContractVerificationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'contractId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contractId = valueDes;
          break;
        case r'signed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.signed = valueDes;
          break;
        case r'signedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.signedAt = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ContractVerification deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ContractVerificationBuilder();
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

