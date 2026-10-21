//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'receipt_pdf_response.g.dart';

/// ReceiptPdfResponse
///
/// Properties:
/// * [downloadUrl] 
@BuiltValue()
abstract class ReceiptPdfResponse implements Built<ReceiptPdfResponse, ReceiptPdfResponseBuilder> {
  @BuiltValueField(wireName: r'downloadUrl')
  String? get downloadUrl;

  ReceiptPdfResponse._();

  factory ReceiptPdfResponse([void updates(ReceiptPdfResponseBuilder b)]) = _$ReceiptPdfResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReceiptPdfResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReceiptPdfResponse> get serializer => _$ReceiptPdfResponseSerializer();
}

class _$ReceiptPdfResponseSerializer implements PrimitiveSerializer<ReceiptPdfResponse> {
  @override
  final Iterable<Type> types = const [ReceiptPdfResponse, _$ReceiptPdfResponse];

  @override
  final String wireName = r'ReceiptPdfResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReceiptPdfResponse object, {
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
    ReceiptPdfResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReceiptPdfResponseBuilder result,
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
  ReceiptPdfResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReceiptPdfResponseBuilder();
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

