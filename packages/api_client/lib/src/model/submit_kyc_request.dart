//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'submit_kyc_request.g.dart';

/// SubmitKycRequest
///
/// Properties:
/// * [idDocumentFrontKey] 
/// * [idDocumentBackKey] 
/// * [selfieKey] 
@BuiltValue()
abstract class SubmitKycRequest implements Built<SubmitKycRequest, SubmitKycRequestBuilder> {
  @BuiltValueField(wireName: r'idDocumentFrontKey')
  String get idDocumentFrontKey;

  @BuiltValueField(wireName: r'idDocumentBackKey')
  String get idDocumentBackKey;

  @BuiltValueField(wireName: r'selfieKey')
  String get selfieKey;

  SubmitKycRequest._();

  factory SubmitKycRequest([void updates(SubmitKycRequestBuilder b)]) = _$SubmitKycRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubmitKycRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubmitKycRequest> get serializer => _$SubmitKycRequestSerializer();
}

class _$SubmitKycRequestSerializer implements PrimitiveSerializer<SubmitKycRequest> {
  @override
  final Iterable<Type> types = const [SubmitKycRequest, _$SubmitKycRequest];

  @override
  final String wireName = r'SubmitKycRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubmitKycRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'idDocumentFrontKey';
    yield serializers.serialize(
      object.idDocumentFrontKey,
      specifiedType: const FullType(String),
    );
    yield r'idDocumentBackKey';
    yield serializers.serialize(
      object.idDocumentBackKey,
      specifiedType: const FullType(String),
    );
    yield r'selfieKey';
    yield serializers.serialize(
      object.selfieKey,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SubmitKycRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SubmitKycRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'idDocumentFrontKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idDocumentFrontKey = valueDes;
          break;
        case r'idDocumentBackKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idDocumentBackKey = valueDes;
          break;
        case r'selfieKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.selfieKey = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SubmitKycRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubmitKycRequestBuilder();
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

