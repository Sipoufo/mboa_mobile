//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'window.g.dart';

/// Window
///
/// Properties:
/// * [last7Days] 
/// * [last30Days] 
@BuiltValue()
abstract class Window implements Built<Window, WindowBuilder> {
  @BuiltValueField(wireName: r'last7Days')
  int? get last7Days;

  @BuiltValueField(wireName: r'last30Days')
  int? get last30Days;

  Window._();

  factory Window([void updates(WindowBuilder b)]) = _$Window;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WindowBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Window> get serializer => _$WindowSerializer();
}

class _$WindowSerializer implements PrimitiveSerializer<Window> {
  @override
  final Iterable<Type> types = const [Window, _$Window];

  @override
  final String wireName = r'Window';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Window object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.last7Days != null) {
      yield r'last7Days';
      yield serializers.serialize(
        object.last7Days,
        specifiedType: const FullType(int),
      );
    }
    if (object.last30Days != null) {
      yield r'last30Days';
      yield serializers.serialize(
        object.last30Days,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Window object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WindowBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'last7Days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.last7Days = valueDes;
          break;
        case r'last30Days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.last30Days = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Window deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WindowBuilder();
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

