//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'home_request_note_request.g.dart';

/// HomeRequestNoteRequest
///
/// Properties:
/// * [note] 
@BuiltValue()
abstract class HomeRequestNoteRequest implements Built<HomeRequestNoteRequest, HomeRequestNoteRequestBuilder> {
  @BuiltValueField(wireName: r'note')
  String? get note;

  HomeRequestNoteRequest._();

  factory HomeRequestNoteRequest([void updates(HomeRequestNoteRequestBuilder b)]) = _$HomeRequestNoteRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HomeRequestNoteRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HomeRequestNoteRequest> get serializer => _$HomeRequestNoteRequestSerializer();
}

class _$HomeRequestNoteRequestSerializer implements PrimitiveSerializer<HomeRequestNoteRequest> {
  @override
  final Iterable<Type> types = const [HomeRequestNoteRequest, _$HomeRequestNoteRequest];

  @override
  final String wireName = r'HomeRequestNoteRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HomeRequestNoteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HomeRequestNoteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HomeRequestNoteRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HomeRequestNoteRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HomeRequestNoteRequestBuilder();
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

