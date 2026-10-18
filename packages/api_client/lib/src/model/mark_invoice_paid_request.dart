//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mark_invoice_paid_request.g.dart';

/// MarkInvoicePaidRequest
///
/// Properties:
/// * [paidOn] 
@BuiltValue()
abstract class MarkInvoicePaidRequest implements Built<MarkInvoicePaidRequest, MarkInvoicePaidRequestBuilder> {
  @BuiltValueField(wireName: r'paidOn')
  Date? get paidOn;

  MarkInvoicePaidRequest._();

  factory MarkInvoicePaidRequest([void updates(MarkInvoicePaidRequestBuilder b)]) = _$MarkInvoicePaidRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MarkInvoicePaidRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MarkInvoicePaidRequest> get serializer => _$MarkInvoicePaidRequestSerializer();
}

class _$MarkInvoicePaidRequestSerializer implements PrimitiveSerializer<MarkInvoicePaidRequest> {
  @override
  final Iterable<Type> types = const [MarkInvoicePaidRequest, _$MarkInvoicePaidRequest];

  @override
  final String wireName = r'MarkInvoicePaidRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MarkInvoicePaidRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.paidOn != null) {
      yield r'paidOn';
      yield serializers.serialize(
        object.paidOn,
        specifiedType: const FullType(Date),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MarkInvoicePaidRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MarkInvoicePaidRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'paidOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.paidOn = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MarkInvoicePaidRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MarkInvoicePaidRequestBuilder();
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

