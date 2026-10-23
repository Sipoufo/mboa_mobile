//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'receipt_regeneration.g.dart';

/// ReceiptRegeneration
///
/// Properties:
/// * [receiptId] 
/// * [ready] 
@BuiltValue()
abstract class ReceiptRegeneration implements Built<ReceiptRegeneration, ReceiptRegenerationBuilder> {
  @BuiltValueField(wireName: r'receiptId')
  String? get receiptId;

  @BuiltValueField(wireName: r'ready')
  bool? get ready;

  ReceiptRegeneration._();

  factory ReceiptRegeneration([void updates(ReceiptRegenerationBuilder b)]) = _$ReceiptRegeneration;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReceiptRegenerationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReceiptRegeneration> get serializer => _$ReceiptRegenerationSerializer();
}

class _$ReceiptRegenerationSerializer implements PrimitiveSerializer<ReceiptRegeneration> {
  @override
  final Iterable<Type> types = const [ReceiptRegeneration, _$ReceiptRegeneration];

  @override
  final String wireName = r'ReceiptRegeneration';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReceiptRegeneration object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.receiptId != null) {
      yield r'receiptId';
      yield serializers.serialize(
        object.receiptId,
        specifiedType: const FullType(String),
      );
    }
    if (object.ready != null) {
      yield r'ready';
      yield serializers.serialize(
        object.ready,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReceiptRegeneration object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReceiptRegenerationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'receiptId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.receiptId = valueDes;
          break;
        case r'ready':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.ready = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReceiptRegeneration deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReceiptRegenerationBuilder();
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

