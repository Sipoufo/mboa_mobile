//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_plan_request.g.dart';

/// UpdatePlanRequest
///
/// Properties:
/// * [monthlyPrice] 
/// * [activeListingLimit] 
/// * [residenceUnitAllowance] 
@BuiltValue()
abstract class UpdatePlanRequest implements Built<UpdatePlanRequest, UpdatePlanRequestBuilder> {
  @BuiltValueField(wireName: r'monthlyPrice')
  int? get monthlyPrice;

  @BuiltValueField(wireName: r'activeListingLimit')
  int? get activeListingLimit;

  @BuiltValueField(wireName: r'residenceUnitAllowance')
  int? get residenceUnitAllowance;

  UpdatePlanRequest._();

  factory UpdatePlanRequest([void updates(UpdatePlanRequestBuilder b)]) = _$UpdatePlanRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdatePlanRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdatePlanRequest> get serializer => _$UpdatePlanRequestSerializer();
}

class _$UpdatePlanRequestSerializer implements PrimitiveSerializer<UpdatePlanRequest> {
  @override
  final Iterable<Type> types = const [UpdatePlanRequest, _$UpdatePlanRequest];

  @override
  final String wireName = r'UpdatePlanRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdatePlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.monthlyPrice != null) {
      yield r'monthlyPrice';
      yield serializers.serialize(
        object.monthlyPrice,
        specifiedType: const FullType(int),
      );
    }
    if (object.activeListingLimit != null) {
      yield r'activeListingLimit';
      yield serializers.serialize(
        object.activeListingLimit,
        specifiedType: const FullType(int),
      );
    }
    if (object.residenceUnitAllowance != null) {
      yield r'residenceUnitAllowance';
      yield serializers.serialize(
        object.residenceUnitAllowance,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdatePlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdatePlanRequestBuilder result,
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
        case r'activeListingLimit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.activeListingLimit = valueDes;
          break;
        case r'residenceUnitAllowance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.residenceUnitAllowance = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdatePlanRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdatePlanRequestBuilder();
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

