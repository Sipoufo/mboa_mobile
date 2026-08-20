//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/reply.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'property_review.g.dart';

/// PropertyReview
///
/// Properties:
/// * [type] 
/// * [id] 
/// * [annonceId] 
/// * [authorName] 
/// * [rating] 
/// * [comment] 
/// * [pros] 
/// * [cons] 
/// * [photoKeys] 
/// * [perceivedCondition] 
/// * [residenceMonths] 
/// * [publishedAt] 
/// * [editedAt] 
/// * [replies] 
@BuiltValue()
abstract class PropertyReview implements Built<PropertyReview, PropertyReviewBuilder> {
  @BuiltValueField(wireName: r'type')
  PropertyReviewTypeEnum? get type;
  // enum typeEnum {  VISIT,  RESIDENT,  };

  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'authorName')
  String? get authorName;

  @BuiltValueField(wireName: r'rating')
  int? get rating;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'pros')
  BuiltList<String>? get pros;

  @BuiltValueField(wireName: r'cons')
  BuiltList<String>? get cons;

  @BuiltValueField(wireName: r'photoKeys')
  BuiltList<String>? get photoKeys;

  @BuiltValueField(wireName: r'perceivedCondition')
  int? get perceivedCondition;

  @BuiltValueField(wireName: r'residenceMonths')
  int? get residenceMonths;

  @BuiltValueField(wireName: r'publishedAt')
  DateTime? get publishedAt;

  @BuiltValueField(wireName: r'editedAt')
  DateTime? get editedAt;

  @BuiltValueField(wireName: r'replies')
  BuiltList<Reply>? get replies;

  PropertyReview._();

  factory PropertyReview([void updates(PropertyReviewBuilder b)]) = _$PropertyReview;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PropertyReviewBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PropertyReview> get serializer => _$PropertyReviewSerializer();
}

class _$PropertyReviewSerializer implements PrimitiveSerializer<PropertyReview> {
  @override
  final Iterable<Type> types = const [PropertyReview, _$PropertyReview];

  @override
  final String wireName = r'PropertyReview';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PropertyReview object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(PropertyReviewTypeEnum),
      );
    }
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.annonceId != null) {
      yield r'annonceId';
      yield serializers.serialize(
        object.annonceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.authorName != null) {
      yield r'authorName';
      yield serializers.serialize(
        object.authorName,
        specifiedType: const FullType(String),
      );
    }
    if (object.rating != null) {
      yield r'rating';
      yield serializers.serialize(
        object.rating,
        specifiedType: const FullType(int),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(String),
      );
    }
    if (object.pros != null) {
      yield r'pros';
      yield serializers.serialize(
        object.pros,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.cons != null) {
      yield r'cons';
      yield serializers.serialize(
        object.cons,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.photoKeys != null) {
      yield r'photoKeys';
      yield serializers.serialize(
        object.photoKeys,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.perceivedCondition != null) {
      yield r'perceivedCondition';
      yield serializers.serialize(
        object.perceivedCondition,
        specifiedType: const FullType(int),
      );
    }
    if (object.residenceMonths != null) {
      yield r'residenceMonths';
      yield serializers.serialize(
        object.residenceMonths,
        specifiedType: const FullType(int),
      );
    }
    if (object.publishedAt != null) {
      yield r'publishedAt';
      yield serializers.serialize(
        object.publishedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.editedAt != null) {
      yield r'editedAt';
      yield serializers.serialize(
        object.editedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.replies != null) {
      yield r'replies';
      yield serializers.serialize(
        object.replies,
        specifiedType: const FullType(BuiltList, [FullType(Reply)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PropertyReview object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PropertyReviewBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PropertyReviewTypeEnum),
          ) as PropertyReviewTypeEnum?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.id = valueDes;
          break;
        case r'annonceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.annonceId = valueDes;
          break;
        case r'authorName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.authorName = valueDes;
          break;
        case r'rating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.rating = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        case r'pros':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.pros.replace(valueDes);
          break;
        case r'cons':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.cons.replace(valueDes);
          break;
        case r'photoKeys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.photoKeys.replace(valueDes);
          break;
        case r'perceivedCondition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.perceivedCondition = valueDes;
          break;
        case r'residenceMonths':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.residenceMonths = valueDes;
          break;
        case r'publishedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.publishedAt = valueDes;
          break;
        case r'editedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.editedAt = valueDes;
          break;
        case r'replies':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(Reply)]),
          ) as BuiltList<Reply>?;
          if (valueDes == null) continue;
          result.replies.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PropertyReview deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PropertyReviewBuilder();
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

class PropertyReviewTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'VISIT')
  static const PropertyReviewTypeEnum VISIT = _$propertyReviewTypeEnum_VISIT;
  @BuiltValueEnumConst(wireName: r'RESIDENT')
  static const PropertyReviewTypeEnum RESIDENT = _$propertyReviewTypeEnum_RESIDENT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PropertyReviewTypeEnum unknownDefaultOpenApi = _$propertyReviewTypeEnum_unknownDefaultOpenApi;

  static Serializer<PropertyReviewTypeEnum> get serializer => _$propertyReviewTypeEnumSerializer;

  const PropertyReviewTypeEnum._(String name): super(name);

  static BuiltSet<PropertyReviewTypeEnum> get values => _$propertyReviewTypeEnumValues;
  static PropertyReviewTypeEnum valueOf(String name) => _$propertyReviewTypeEnumValueOf(name);
}

