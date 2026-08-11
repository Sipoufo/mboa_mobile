//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'visite_report_response.g.dart';

/// VisiteReportResponse
///
/// Properties:
/// * [visiteId] 
/// * [annonceId] 
/// * [agentAccountId] 
/// * [overallCondition] 
/// * [listingConformity] 
/// * [comment] 
/// * [photoKeys] 
/// * [submittedAt] 
@BuiltValue()
abstract class VisiteReportResponse implements Built<VisiteReportResponse, VisiteReportResponseBuilder> {
  @BuiltValueField(wireName: r'visiteId')
  String? get visiteId;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'agentAccountId')
  String? get agentAccountId;

  @BuiltValueField(wireName: r'overallCondition')
  int? get overallCondition;

  @BuiltValueField(wireName: r'listingConformity')
  VisiteReportResponseListingConformityEnum? get listingConformity;
  // enum listingConformityEnum {  OUI,  PARTIELLEMENT,  NON,  };

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'photoKeys')
  BuiltList<String>? get photoKeys;

  @BuiltValueField(wireName: r'submittedAt')
  DateTime? get submittedAt;

  VisiteReportResponse._();

  factory VisiteReportResponse([void updates(VisiteReportResponseBuilder b)]) = _$VisiteReportResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VisiteReportResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<VisiteReportResponse> get serializer => _$VisiteReportResponseSerializer();
}

class _$VisiteReportResponseSerializer implements PrimitiveSerializer<VisiteReportResponse> {
  @override
  final Iterable<Type> types = const [VisiteReportResponse, _$VisiteReportResponse];

  @override
  final String wireName = r'VisiteReportResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VisiteReportResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.visiteId != null) {
      yield r'visiteId';
      yield serializers.serialize(
        object.visiteId,
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
    if (object.agentAccountId != null) {
      yield r'agentAccountId';
      yield serializers.serialize(
        object.agentAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.overallCondition != null) {
      yield r'overallCondition';
      yield serializers.serialize(
        object.overallCondition,
        specifiedType: const FullType(int),
      );
    }
    if (object.listingConformity != null) {
      yield r'listingConformity';
      yield serializers.serialize(
        object.listingConformity,
        specifiedType: const FullType(VisiteReportResponseListingConformityEnum),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(String),
      );
    }
    if (object.photoKeys != null) {
      yield r'photoKeys';
      yield serializers.serialize(
        object.photoKeys,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.submittedAt != null) {
      yield r'submittedAt';
      yield serializers.serialize(
        object.submittedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    VisiteReportResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VisiteReportResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'visiteId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.visiteId = valueDes;
          break;
        case r'annonceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.annonceId = valueDes;
          break;
        case r'agentAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.agentAccountId = valueDes;
          break;
        case r'overallCondition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.overallCondition = valueDes;
          break;
        case r'listingConformity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(VisiteReportResponseListingConformityEnum),
          ) as VisiteReportResponseListingConformityEnum?;
          if (valueDes == null) continue;
          result.listingConformity = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        case r'photoKeys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.photoKeys.replace(valueDes);
          break;
        case r'submittedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.submittedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  VisiteReportResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VisiteReportResponseBuilder();
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

class VisiteReportResponseListingConformityEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'OUI')
  static const VisiteReportResponseListingConformityEnum OUI = _$visiteReportResponseListingConformityEnum_OUI;
  @BuiltValueEnumConst(wireName: r'PARTIELLEMENT')
  static const VisiteReportResponseListingConformityEnum PARTIELLEMENT = _$visiteReportResponseListingConformityEnum_PARTIELLEMENT;
  @BuiltValueEnumConst(wireName: r'NON')
  static const VisiteReportResponseListingConformityEnum NON = _$visiteReportResponseListingConformityEnum_NON;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const VisiteReportResponseListingConformityEnum unknownDefaultOpenApi = _$visiteReportResponseListingConformityEnum_unknownDefaultOpenApi;

  static Serializer<VisiteReportResponseListingConformityEnum> get serializer => _$visiteReportResponseListingConformityEnumSerializer;

  const VisiteReportResponseListingConformityEnum._(String name): super(name);

  static BuiltSet<VisiteReportResponseListingConformityEnum> get values => _$visiteReportResponseListingConformityEnumValues;
  static VisiteReportResponseListingConformityEnum valueOf(String name) => _$visiteReportResponseListingConformityEnumValueOf(name);
}

