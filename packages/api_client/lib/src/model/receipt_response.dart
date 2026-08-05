//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'receipt_response.g.dart';

/// ReceiptResponse
///
/// Properties:
/// * [downloadUrl] 
@BuiltValue()
abstract class ReceiptResponse implements Built<ReceiptResponse, ReceiptResponseBuilder> {
  @BuiltValueField(wireName: r'downloadUrl')
  String? get downloadUrl;

  ReceiptResponse._();

  factory ReceiptResponse([void updates(ReceiptResponseBuilder b)]) = _$ReceiptResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReceiptResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReceiptResponse> get serializer => _$ReceiptResponseSerializer();
}

class _$ReceiptResponseSerializer implements PrimitiveSerializer<ReceiptResponse> {
  @override
  final Iterable<Type> types = const [ReceiptResponse, _$ReceiptResponse];

  @override
  final String wireName = r'ReceiptResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReceiptResponse object, {
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
    ReceiptResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReceiptResponseBuilder result,
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
  ReceiptResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReceiptResponseBuilder();
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

