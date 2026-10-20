//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'contest_declaration_request.g.dart';

/// ContestDeclarationRequest
///
/// Properties:
/// * [reason] 
@BuiltValue()
abstract class ContestDeclarationRequest implements Built<ContestDeclarationRequest, ContestDeclarationRequestBuilder> {
  @BuiltValueField(wireName: r'reason')
  String? get reason;

  ContestDeclarationRequest._();

  factory ContestDeclarationRequest([void updates(ContestDeclarationRequestBuilder b)]) = _$ContestDeclarationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ContestDeclarationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ContestDeclarationRequest> get serializer => _$ContestDeclarationRequestSerializer();
}

class _$ContestDeclarationRequestSerializer implements PrimitiveSerializer<ContestDeclarationRequest> {
  @override
  final Iterable<Type> types = const [ContestDeclarationRequest, _$ContestDeclarationRequest];

  @override
  final String wireName = r'ContestDeclarationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ContestDeclarationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ContestDeclarationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ContestDeclarationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
  ContestDeclarationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ContestDeclarationRequestBuilder();
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

