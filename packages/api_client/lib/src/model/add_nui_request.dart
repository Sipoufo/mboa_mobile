//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'add_nui_request.g.dart';

/// AddNuiRequest
///
/// Properties:
/// * [nui] 
@BuiltValue()
abstract class AddNuiRequest implements Built<AddNuiRequest, AddNuiRequestBuilder> {
  @BuiltValueField(wireName: r'nui')
  String get nui;

  AddNuiRequest._();

  factory AddNuiRequest([void updates(AddNuiRequestBuilder b)]) = _$AddNuiRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddNuiRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddNuiRequest> get serializer => _$AddNuiRequestSerializer();
}

class _$AddNuiRequestSerializer implements PrimitiveSerializer<AddNuiRequest> {
  @override
  final Iterable<Type> types = const [AddNuiRequest, _$AddNuiRequest];

  @override
  final String wireName = r'AddNuiRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddNuiRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'nui';
    yield serializers.serialize(
      object.nui,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AddNuiRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AddNuiRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'nui':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nui = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AddNuiRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddNuiRequestBuilder();
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

