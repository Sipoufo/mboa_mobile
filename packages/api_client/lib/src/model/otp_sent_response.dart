//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'otp_sent_response.g.dart';

/// OtpSentResponse
///
/// Properties:
/// * [channel] 
@BuiltValue()
abstract class OtpSentResponse implements Built<OtpSentResponse, OtpSentResponseBuilder> {
  @BuiltValueField(wireName: r'channel')
  OtpSentResponseChannelEnum? get channel;
  // enum channelEnum {  WHATSAPP,  SMS,  EMAIL,  };

  OtpSentResponse._();

  factory OtpSentResponse([void updates(OtpSentResponseBuilder b)]) = _$OtpSentResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OtpSentResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OtpSentResponse> get serializer => _$OtpSentResponseSerializer();
}

class _$OtpSentResponseSerializer implements PrimitiveSerializer<OtpSentResponse> {
  @override
  final Iterable<Type> types = const [OtpSentResponse, _$OtpSentResponse];

  @override
  final String wireName = r'OtpSentResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OtpSentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.channel != null) {
      yield r'channel';
      yield serializers.serialize(
        object.channel,
        specifiedType: const FullType(OtpSentResponseChannelEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OtpSentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OtpSentResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'channel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OtpSentResponseChannelEnum),
          ) as OtpSentResponseChannelEnum?;
          if (valueDes == null) continue;
          result.channel = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OtpSentResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OtpSentResponseBuilder();
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

class OtpSentResponseChannelEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'WHATSAPP')
  static const OtpSentResponseChannelEnum WHATSAPP = _$otpSentResponseChannelEnum_WHATSAPP;
  @BuiltValueEnumConst(wireName: r'SMS')
  static const OtpSentResponseChannelEnum SMS = _$otpSentResponseChannelEnum_SMS;
  @BuiltValueEnumConst(wireName: r'EMAIL')
  static const OtpSentResponseChannelEnum EMAIL = _$otpSentResponseChannelEnum_EMAIL;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OtpSentResponseChannelEnum unknownDefaultOpenApi = _$otpSentResponseChannelEnum_unknownDefaultOpenApi;

  static Serializer<OtpSentResponseChannelEnum> get serializer => _$otpSentResponseChannelEnumSerializer;

  const OtpSentResponseChannelEnum._(String name): super(name);

  static BuiltSet<OtpSentResponseChannelEnum> get values => _$otpSentResponseChannelEnumValues;
  static OtpSentResponseChannelEnum valueOf(String name) => _$otpSentResponseChannelEnumValueOf(name);
}

