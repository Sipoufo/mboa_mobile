//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'book_visite_request.g.dart';

/// BookVisiteRequest
///
/// Properties:
/// * [annonceId] 
/// * [startsAt] 
@BuiltValue()
abstract class BookVisiteRequest implements Built<BookVisiteRequest, BookVisiteRequestBuilder> {
  @BuiltValueField(wireName: r'annonceId')
  String get annonceId;

  @BuiltValueField(wireName: r'startsAt')
  DateTime get startsAt;

  BookVisiteRequest._();

  factory BookVisiteRequest([void updates(BookVisiteRequestBuilder b)]) = _$BookVisiteRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BookVisiteRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BookVisiteRequest> get serializer => _$BookVisiteRequestSerializer();
}

class _$BookVisiteRequestSerializer implements PrimitiveSerializer<BookVisiteRequest> {
  @override
  final Iterable<Type> types = const [BookVisiteRequest, _$BookVisiteRequest];

  @override
  final String wireName = r'BookVisiteRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BookVisiteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'annonceId';
    yield serializers.serialize(
      object.annonceId,
      specifiedType: const FullType(String),
    );
    yield r'startsAt';
    yield serializers.serialize(
      object.startsAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BookVisiteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BookVisiteRequestBuilder result,
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
        case r'startsAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startsAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BookVisiteRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BookVisiteRequestBuilder();
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

