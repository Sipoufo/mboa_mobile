//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_reservation_request.g.dart';

/// CreateReservationRequest
///
/// Properties:
/// * [annonceId] 
/// * [desiredStartDate] 
/// * [durationUnits] 
/// * [message] 
@BuiltValue()
abstract class CreateReservationRequest implements Built<CreateReservationRequest, CreateReservationRequestBuilder> {
  @BuiltValueField(wireName: r'annonceId')
  String get annonceId;

  @BuiltValueField(wireName: r'desiredStartDate')
  Date get desiredStartDate;

  @BuiltValueField(wireName: r'durationUnits')
  int get durationUnits;

  @BuiltValueField(wireName: r'message')
  String? get message;

  CreateReservationRequest._();

  factory CreateReservationRequest([void updates(CreateReservationRequestBuilder b)]) = _$CreateReservationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateReservationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateReservationRequest> get serializer => _$CreateReservationRequestSerializer();
}

class _$CreateReservationRequestSerializer implements PrimitiveSerializer<CreateReservationRequest> {
  @override
  final Iterable<Type> types = const [CreateReservationRequest, _$CreateReservationRequest];

  @override
  final String wireName = r'CreateReservationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateReservationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'annonceId';
    yield serializers.serialize(
      object.annonceId,
      specifiedType: const FullType(String),
    );
    yield r'desiredStartDate';
    yield serializers.serialize(
      object.desiredStartDate,
      specifiedType: const FullType(Date),
    );
    yield r'durationUnits';
    yield serializers.serialize(
      object.durationUnits,
      specifiedType: const FullType(int),
    );
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateReservationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateReservationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'annonceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.annonceId = valueDes;
          break;
        case r'desiredStartDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.desiredStartDate = valueDes;
          break;
        case r'durationUnits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.durationUnits = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateReservationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateReservationRequestBuilder();
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

