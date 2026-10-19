//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'terminate_contract_request.g.dart';

/// TerminateContractRequest
///
/// Properties:
/// * [effectiveDate] 
/// * [reason] 
/// * [mutual] 
@BuiltValue()
abstract class TerminateContractRequest implements Built<TerminateContractRequest, TerminateContractRequestBuilder> {
  @BuiltValueField(wireName: r'effectiveDate')
  Date get effectiveDate;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  @BuiltValueField(wireName: r'mutual')
  bool? get mutual;

  TerminateContractRequest._();

  factory TerminateContractRequest([void updates(TerminateContractRequestBuilder b)]) = _$TerminateContractRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TerminateContractRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TerminateContractRequest> get serializer => _$TerminateContractRequestSerializer();
}

class _$TerminateContractRequestSerializer implements PrimitiveSerializer<TerminateContractRequest> {
  @override
  final Iterable<Type> types = const [TerminateContractRequest, _$TerminateContractRequest];

  @override
  final String wireName = r'TerminateContractRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TerminateContractRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'effectiveDate';
    yield serializers.serialize(
      object.effectiveDate,
      specifiedType: const FullType(Date),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
    if (object.mutual != null) {
      yield r'mutual';
      yield serializers.serialize(
        object.mutual,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TerminateContractRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TerminateContractRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'effectiveDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.effectiveDate = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        case r'mutual':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.mutual = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TerminateContractRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TerminateContractRequestBuilder();
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

