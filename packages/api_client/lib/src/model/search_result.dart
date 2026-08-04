//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/search_result_item.dart';
import 'package:api_client/src/model/residence_search_card.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'search_result.g.dart';

/// SearchResult
///
/// Properties:
/// * [type] 
/// * [listing] 
/// * [residence] 
@BuiltValue()
abstract class SearchResult implements Built<SearchResult, SearchResultBuilder> {
  @BuiltValueField(wireName: r'type')
  SearchResultTypeEnum? get type;
  // enum typeEnum {  LISTING,  RESIDENCE,  };

  @BuiltValueField(wireName: r'listing')
  SearchResultItem? get listing;

  @BuiltValueField(wireName: r'residence')
  ResidenceSearchCard? get residence;

  SearchResult._();

  factory SearchResult([void updates(SearchResultBuilder b)]) = _$SearchResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SearchResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SearchResult> get serializer => _$SearchResultSerializer();
}

class _$SearchResultSerializer implements PrimitiveSerializer<SearchResult> {
  @override
  final Iterable<Type> types = const [SearchResult, _$SearchResult];

  @override
  final String wireName = r'SearchResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SearchResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(SearchResultTypeEnum),
      );
    }
    if (object.listing != null) {
      yield r'listing';
      yield serializers.serialize(
        object.listing,
        specifiedType: const FullType(SearchResultItem),
      );
    }
    if (object.residence != null) {
      yield r'residence';
      yield serializers.serialize(
        object.residence,
        specifiedType: const FullType(ResidenceSearchCard),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SearchResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SearchResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SearchResultTypeEnum),
          ) as SearchResultTypeEnum?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
        case r'listing':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SearchResultItem),
          ) as SearchResultItem?;
          if (valueDes == null) continue;
          result.listing.replace(valueDes);
          break;
        case r'residence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ResidenceSearchCard),
          ) as ResidenceSearchCard?;
          if (valueDes == null) continue;
          result.residence.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SearchResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SearchResultBuilder();
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

class SearchResultTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LISTING')
  static const SearchResultTypeEnum LISTING = _$searchResultTypeEnum_LISTING;
  @BuiltValueEnumConst(wireName: r'RESIDENCE')
  static const SearchResultTypeEnum RESIDENCE = _$searchResultTypeEnum_RESIDENCE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SearchResultTypeEnum unknownDefaultOpenApi = _$searchResultTypeEnum_unknownDefaultOpenApi;

  static Serializer<SearchResultTypeEnum> get serializer => _$searchResultTypeEnumSerializer;

  const SearchResultTypeEnum._(String name): super(name);

  static BuiltSet<SearchResultTypeEnum> get values => _$searchResultTypeEnumValues;
  static SearchResultTypeEnum valueOf(String name) => _$searchResultTypeEnumValueOf(name);
}

