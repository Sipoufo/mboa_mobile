//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deletion_challenge_response.g.dart';

/// DeletionChallengeResponse
///
/// Properties:
/// * [confirmationToken] 
/// * [expiresAt] 
@BuiltValue()
abstract class DeletionChallengeResponse implements Built<DeletionChallengeResponse, DeletionChallengeResponseBuilder> {
  @BuiltValueField(wireName: r'confirmationToken')
  String? get confirmationToken;

  @BuiltValueField(wireName: r'expiresAt')
  DateTime? get expiresAt;

  DeletionChallengeResponse._();

  factory DeletionChallengeResponse([void updates(DeletionChallengeResponseBuilder b)]) = _$DeletionChallengeResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeletionChallengeResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeletionChallengeResponse> get serializer => _$DeletionChallengeResponseSerializer();
}

class _$DeletionChallengeResponseSerializer implements PrimitiveSerializer<DeletionChallengeResponse> {
  @override
  final Iterable<Type> types = const [DeletionChallengeResponse, _$DeletionChallengeResponse];

  @override
  final String wireName = r'DeletionChallengeResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeletionChallengeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.confirmationToken != null) {
      yield r'confirmationToken';
      yield serializers.serialize(
        object.confirmationToken,
        specifiedType: const FullType(String),
      );
    }
    if (object.expiresAt != null) {
      yield r'expiresAt';
      yield serializers.serialize(
        object.expiresAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DeletionChallengeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeletionChallengeResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'confirmationToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.confirmationToken = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.expiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeletionChallengeResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeletionChallengeResponseBuilder();
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

