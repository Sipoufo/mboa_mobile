//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reject_kyc_request.g.dart';

/// RejectKycRequest
///
/// Properties:
/// * [reason] 
@BuiltValue()
abstract class RejectKycRequest implements Built<RejectKycRequest, RejectKycRequestBuilder> {
  @BuiltValueField(wireName: r'reason')
  String get reason;

  RejectKycRequest._();

  factory RejectKycRequest([void updates(RejectKycRequestBuilder b)]) = _$RejectKycRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RejectKycRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RejectKycRequest> get serializer => _$RejectKycRequestSerializer();
}

class _$RejectKycRequestSerializer implements PrimitiveSerializer<RejectKycRequest> {
  @override
  final Iterable<Type> types = const [RejectKycRequest, _$RejectKycRequest];

  @override
  final String wireName = r'RejectKycRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RejectKycRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RejectKycRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RejectKycRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  RejectKycRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RejectKycRequestBuilder();
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

