//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/kyc_corrections.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'confirm_kyc_document_request.g.dart';

/// ConfirmKycDocumentRequest
///
/// Properties:
/// * [corrections] 
@BuiltValue()
abstract class ConfirmKycDocumentRequest implements Built<ConfirmKycDocumentRequest, ConfirmKycDocumentRequestBuilder> {
  @BuiltValueField(wireName: r'corrections')
  KycCorrections? get corrections;

  ConfirmKycDocumentRequest._();

  factory ConfirmKycDocumentRequest([void updates(ConfirmKycDocumentRequestBuilder b)]) = _$ConfirmKycDocumentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConfirmKycDocumentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConfirmKycDocumentRequest> get serializer => _$ConfirmKycDocumentRequestSerializer();
}

class _$ConfirmKycDocumentRequestSerializer implements PrimitiveSerializer<ConfirmKycDocumentRequest> {
  @override
  final Iterable<Type> types = const [ConfirmKycDocumentRequest, _$ConfirmKycDocumentRequest];

  @override
  final String wireName = r'ConfirmKycDocumentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConfirmKycDocumentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.corrections != null) {
      yield r'corrections';
      yield serializers.serialize(
        object.corrections,
        specifiedType: const FullType(KycCorrections),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ConfirmKycDocumentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ConfirmKycDocumentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'corrections':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(KycCorrections),
          ) as KycCorrections?;
          if (valueDes == null) continue;
          result.corrections.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ConfirmKycDocumentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConfirmKycDocumentRequestBuilder();
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

