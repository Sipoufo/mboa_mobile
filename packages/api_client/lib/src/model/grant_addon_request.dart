//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'grant_addon_request.g.dart';

/// GrantAddonRequest
///
/// Properties:
/// * [days] 
/// * [reason] 
@BuiltValue()
abstract class GrantAddonRequest implements Built<GrantAddonRequest, GrantAddonRequestBuilder> {
  @BuiltValueField(wireName: r'days')
  int? get days;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  GrantAddonRequest._();

  factory GrantAddonRequest([void updates(GrantAddonRequestBuilder b)]) = _$GrantAddonRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GrantAddonRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GrantAddonRequest> get serializer => _$GrantAddonRequestSerializer();
}

class _$GrantAddonRequestSerializer implements PrimitiveSerializer<GrantAddonRequest> {
  @override
  final Iterable<Type> types = const [GrantAddonRequest, _$GrantAddonRequest];

  @override
  final String wireName = r'GrantAddonRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GrantAddonRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.days != null) {
      yield r'days';
      yield serializers.serialize(
        object.days,
        specifiedType: const FullType(int),
      );
    }
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GrantAddonRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GrantAddonRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.days = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GrantAddonRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GrantAddonRequestBuilder();
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

