//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/admin_subscription_item.dart';
import 'package:api_client/src/model/admin_payment_item.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/adjustment_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_subscription_detail.g.dart';

/// AdminSubscriptionDetail
///
/// Properties:
/// * [subscription] 
/// * [payments] 
/// * [adjustments] 
@BuiltValue()
abstract class AdminSubscriptionDetail implements Built<AdminSubscriptionDetail, AdminSubscriptionDetailBuilder> {
  @BuiltValueField(wireName: r'subscription')
  AdminSubscriptionItem? get subscription;

  @BuiltValueField(wireName: r'payments')
  BuiltList<AdminPaymentItem>? get payments;

  @BuiltValueField(wireName: r'adjustments')
  BuiltList<AdjustmentResponse>? get adjustments;

  AdminSubscriptionDetail._();

  factory AdminSubscriptionDetail([void updates(AdminSubscriptionDetailBuilder b)]) = _$AdminSubscriptionDetail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminSubscriptionDetailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminSubscriptionDetail> get serializer => _$AdminSubscriptionDetailSerializer();
}

class _$AdminSubscriptionDetailSerializer implements PrimitiveSerializer<AdminSubscriptionDetail> {
  @override
  final Iterable<Type> types = const [AdminSubscriptionDetail, _$AdminSubscriptionDetail];

  @override
  final String wireName = r'AdminSubscriptionDetail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminSubscriptionDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.subscription != null) {
      yield r'subscription';
      yield serializers.serialize(
        object.subscription,
        specifiedType: const FullType(AdminSubscriptionItem),
      );
    }
    if (object.payments != null) {
      yield r'payments';
      yield serializers.serialize(
        object.payments,
        specifiedType: const FullType(BuiltList, [FullType(AdminPaymentItem)]),
      );
    }
    if (object.adjustments != null) {
      yield r'adjustments';
      yield serializers.serialize(
        object.adjustments,
        specifiedType: const FullType(BuiltList, [FullType(AdjustmentResponse)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminSubscriptionDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminSubscriptionDetailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'subscription':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminSubscriptionItem),
          ) as AdminSubscriptionItem?;
          if (valueDes == null) continue;
          result.subscription.replace(valueDes);
          break;
        case r'payments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(AdminPaymentItem)]),
          ) as BuiltList<AdminPaymentItem>?;
          if (valueDes == null) continue;
          result.payments.replace(valueDes);
          break;
        case r'adjustments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(AdjustmentResponse)]),
          ) as BuiltList<AdjustmentResponse>?;
          if (valueDes == null) continue;
          result.adjustments.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminSubscriptionDetail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminSubscriptionDetailBuilder();
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

