//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'contract_pdf_response.g.dart';

/// ContractPdfResponse
///
/// Properties:
/// * [downloadUrl] 
@BuiltValue()
abstract class ContractPdfResponse implements Built<ContractPdfResponse, ContractPdfResponseBuilder> {
  @BuiltValueField(wireName: r'downloadUrl')
  String? get downloadUrl;

  ContractPdfResponse._();

  factory ContractPdfResponse([void updates(ContractPdfResponseBuilder b)]) = _$ContractPdfResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ContractPdfResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ContractPdfResponse> get serializer => _$ContractPdfResponseSerializer();
}

class _$ContractPdfResponseSerializer implements PrimitiveSerializer<ContractPdfResponse> {
  @override
  final Iterable<Type> types = const [ContractPdfResponse, _$ContractPdfResponse];

  @override
  final String wireName = r'ContractPdfResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ContractPdfResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.downloadUrl != null) {
      yield r'downloadUrl';
      yield serializers.serialize(
        object.downloadUrl,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ContractPdfResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ContractPdfResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'downloadUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.downloadUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ContractPdfResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ContractPdfResponseBuilder();
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

