//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/search_criteria.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'saved_search_response.g.dart';

/// SavedSearchResponse
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [criteria] 
/// * [alertsEnabled] 
/// * [newMatchCount] 
/// * [lastViewedAt] 
/// * [lastAlertAt] 
/// * [createdAt] 
@BuiltValue()
abstract class SavedSearchResponse implements Built<SavedSearchResponse, SavedSearchResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'criteria')
  SearchCriteria? get criteria;

  @BuiltValueField(wireName: r'alertsEnabled')
  bool? get alertsEnabled;

  @BuiltValueField(wireName: r'newMatchCount')
  int? get newMatchCount;

  @BuiltValueField(wireName: r'lastViewedAt')
  DateTime? get lastViewedAt;

  @BuiltValueField(wireName: r'lastAlertAt')
  DateTime? get lastAlertAt;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  SavedSearchResponse._();

  factory SavedSearchResponse([void updates(SavedSearchResponseBuilder b)]) = _$SavedSearchResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SavedSearchResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SavedSearchResponse> get serializer => _$SavedSearchResponseSerializer();
}

class _$SavedSearchResponseSerializer implements PrimitiveSerializer<SavedSearchResponse> {
  @override
  final Iterable<Type> types = const [SavedSearchResponse, _$SavedSearchResponse];

  @override
  final String wireName = r'SavedSearchResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SavedSearchResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.criteria != null) {
      yield r'criteria';
      yield serializers.serialize(
        object.criteria,
        specifiedType: const FullType(SearchCriteria),
      );
    }
    if (object.alertsEnabled != null) {
      yield r'alertsEnabled';
      yield serializers.serialize(
        object.alertsEnabled,
        specifiedType: const FullType(bool),
      );
    }
    if (object.newMatchCount != null) {
      yield r'newMatchCount';
      yield serializers.serialize(
        object.newMatchCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.lastViewedAt != null) {
      yield r'lastViewedAt';
      yield serializers.serialize(
        object.lastViewedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.lastAlertAt != null) {
      yield r'lastAlertAt';
      yield serializers.serialize(
        object.lastAlertAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SavedSearchResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SavedSearchResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.id = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'criteria':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SearchCriteria),
          ) as SearchCriteria?;
          if (valueDes == null) continue;
          result.criteria.replace(valueDes);
          break;
        case r'alertsEnabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.alertsEnabled = valueDes;
          break;
        case r'newMatchCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.newMatchCount = valueDes;
          break;
        case r'lastViewedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastViewedAt = valueDes;
          break;
        case r'lastAlertAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastAlertAt = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SavedSearchResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SavedSearchResponseBuilder();
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

