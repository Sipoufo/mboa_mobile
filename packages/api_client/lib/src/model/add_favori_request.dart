//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'add_favori_request.g.dart';

/// AddFavoriRequest
///
/// Properties:
/// * [annonceId] 
@BuiltValue()
abstract class AddFavoriRequest implements Built<AddFavoriRequest, AddFavoriRequestBuilder> {
  @BuiltValueField(wireName: r'annonceId')
  String get annonceId;

  AddFavoriRequest._();

  factory AddFavoriRequest([void updates(AddFavoriRequestBuilder b)]) = _$AddFavoriRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddFavoriRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddFavoriRequest> get serializer => _$AddFavoriRequestSerializer();
}

class _$AddFavoriRequestSerializer implements PrimitiveSerializer<AddFavoriRequest> {
  @override
  final Iterable<Type> types = const [AddFavoriRequest, _$AddFavoriRequest];

  @override
  final String wireName = r'AddFavoriRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddFavoriRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'annonceId';
    yield serializers.serialize(
      object.annonceId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AddFavoriRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AddFavoriRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'annonceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.annonceId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AddFavoriRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddFavoriRequestBuilder();
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

