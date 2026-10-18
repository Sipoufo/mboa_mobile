//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_saved_search_request.g.dart';

/// UpdateSavedSearchRequest
///
/// Properties:
/// * [name] 
/// * [alertsEnabled] 
@BuiltValue()
abstract class UpdateSavedSearchRequest implements Built<UpdateSavedSearchRequest, UpdateSavedSearchRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'alertsEnabled')
  bool? get alertsEnabled;

  UpdateSavedSearchRequest._();

  factory UpdateSavedSearchRequest([void updates(UpdateSavedSearchRequestBuilder b)]) = _$UpdateSavedSearchRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateSavedSearchRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateSavedSearchRequest> get serializer => _$UpdateSavedSearchRequestSerializer();
}

class _$UpdateSavedSearchRequestSerializer implements PrimitiveSerializer<UpdateSavedSearchRequest> {
  @override
  final Iterable<Type> types = const [UpdateSavedSearchRequest, _$UpdateSavedSearchRequest];

  @override
  final String wireName = r'UpdateSavedSearchRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateSavedSearchRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.alertsEnabled != null) {
      yield r'alertsEnabled';
      yield serializers.serialize(
        object.alertsEnabled,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateSavedSearchRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateSavedSearchRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'alertsEnabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.alertsEnabled = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateSavedSearchRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateSavedSearchRequestBuilder();
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

