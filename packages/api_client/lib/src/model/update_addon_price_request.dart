//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_addon_price_request.g.dart';

/// UpdateAddonPriceRequest
///
/// Properties:
/// * [monthlyPrice] 
@BuiltValue()
abstract class UpdateAddonPriceRequest implements Built<UpdateAddonPriceRequest, UpdateAddonPriceRequestBuilder> {
  @BuiltValueField(wireName: r'monthlyPrice')
  int? get monthlyPrice;

  UpdateAddonPriceRequest._();

  factory UpdateAddonPriceRequest([void updates(UpdateAddonPriceRequestBuilder b)]) = _$UpdateAddonPriceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateAddonPriceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateAddonPriceRequest> get serializer => _$UpdateAddonPriceRequestSerializer();
}

class _$UpdateAddonPriceRequestSerializer implements PrimitiveSerializer<UpdateAddonPriceRequest> {
  @override
  final Iterable<Type> types = const [UpdateAddonPriceRequest, _$UpdateAddonPriceRequest];

  @override
  final String wireName = r'UpdateAddonPriceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateAddonPriceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.monthlyPrice != null) {
      yield r'monthlyPrice';
      yield serializers.serialize(
        object.monthlyPrice,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateAddonPriceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateAddonPriceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'monthlyPrice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.monthlyPrice = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateAddonPriceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateAddonPriceRequestBuilder();
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

