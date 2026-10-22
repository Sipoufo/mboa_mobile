//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accept_reservation_request.g.dart';

/// AcceptReservationRequest
///
/// Properties:
/// * [unitId] 
@BuiltValue()
abstract class AcceptReservationRequest implements Built<AcceptReservationRequest, AcceptReservationRequestBuilder> {
  @BuiltValueField(wireName: r'unitId')
  String? get unitId;

  AcceptReservationRequest._();

  factory AcceptReservationRequest([void updates(AcceptReservationRequestBuilder b)]) = _$AcceptReservationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AcceptReservationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AcceptReservationRequest> get serializer => _$AcceptReservationRequestSerializer();
}

class _$AcceptReservationRequestSerializer implements PrimitiveSerializer<AcceptReservationRequest> {
  @override
  final Iterable<Type> types = const [AcceptReservationRequest, _$AcceptReservationRequest];

  @override
  final String wireName = r'AcceptReservationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AcceptReservationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.unitId != null) {
      yield r'unitId';
      yield serializers.serialize(
        object.unitId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AcceptReservationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AcceptReservationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'unitId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.unitId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AcceptReservationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AcceptReservationRequestBuilder();
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

