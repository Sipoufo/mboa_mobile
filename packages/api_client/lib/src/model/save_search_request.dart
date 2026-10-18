//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/search_criteria.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'save_search_request.g.dart';

/// SaveSearchRequest
///
/// Properties:
/// * [criteria] 
/// * [name] 
/// * [alertsEnabled] 
@BuiltValue()
abstract class SaveSearchRequest implements Built<SaveSearchRequest, SaveSearchRequestBuilder> {
  @BuiltValueField(wireName: r'criteria')
  SearchCriteria get criteria;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'alertsEnabled')
  bool? get alertsEnabled;

  SaveSearchRequest._();

  factory SaveSearchRequest([void updates(SaveSearchRequestBuilder b)]) = _$SaveSearchRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SaveSearchRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SaveSearchRequest> get serializer => _$SaveSearchRequestSerializer();
}

class _$SaveSearchRequestSerializer implements PrimitiveSerializer<SaveSearchRequest> {
  @override
  final Iterable<Type> types = const [SaveSearchRequest, _$SaveSearchRequest];

  @override
  final String wireName = r'SaveSearchRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SaveSearchRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'criteria';
    yield serializers.serialize(
      object.criteria,
      specifiedType: const FullType(SearchCriteria),
    );
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
    SaveSearchRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SaveSearchRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'criteria':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SearchCriteria),
          ) as SearchCriteria;
          result.criteria.replace(valueDes);
          break;
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
  SaveSearchRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SaveSearchRequestBuilder();
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

