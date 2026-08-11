//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'suspend_annonce_request.g.dart';

/// SuspendAnnonceRequest
///
/// Properties:
/// * [reason] 
@BuiltValue()
abstract class SuspendAnnonceRequest implements Built<SuspendAnnonceRequest, SuspendAnnonceRequestBuilder> {
  @BuiltValueField(wireName: r'reason')
  String get reason;

  SuspendAnnonceRequest._();

  factory SuspendAnnonceRequest([void updates(SuspendAnnonceRequestBuilder b)]) = _$SuspendAnnonceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SuspendAnnonceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SuspendAnnonceRequest> get serializer => _$SuspendAnnonceRequestSerializer();
}

class _$SuspendAnnonceRequestSerializer implements PrimitiveSerializer<SuspendAnnonceRequest> {
  @override
  final Iterable<Type> types = const [SuspendAnnonceRequest, _$SuspendAnnonceRequest];

  @override
  final String wireName = r'SuspendAnnonceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SuspendAnnonceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SuspendAnnonceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SuspendAnnonceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  SuspendAnnonceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SuspendAnnonceRequestBuilder();
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

