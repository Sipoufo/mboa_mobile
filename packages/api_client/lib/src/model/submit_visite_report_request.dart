//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'submit_visite_report_request.g.dart';

/// SubmitVisiteReportRequest
///
/// Properties:
/// * [overallCondition] 
/// * [listingConformity] 
/// * [comment] 
/// * [photoKeys] 
@BuiltValue()
abstract class SubmitVisiteReportRequest implements Built<SubmitVisiteReportRequest, SubmitVisiteReportRequestBuilder> {
  @BuiltValueField(wireName: r'overallCondition')
  int get overallCondition;

  @BuiltValueField(wireName: r'listingConformity')
  SubmitVisiteReportRequestListingConformityEnum get listingConformity;
  // enum listingConformityEnum {  OUI,  PARTIELLEMENT,  NON,  };

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'photoKeys')
  BuiltList<String> get photoKeys;

  SubmitVisiteReportRequest._();

  factory SubmitVisiteReportRequest([void updates(SubmitVisiteReportRequestBuilder b)]) = _$SubmitVisiteReportRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubmitVisiteReportRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubmitVisiteReportRequest> get serializer => _$SubmitVisiteReportRequestSerializer();
}

class _$SubmitVisiteReportRequestSerializer implements PrimitiveSerializer<SubmitVisiteReportRequest> {
  @override
  final Iterable<Type> types = const [SubmitVisiteReportRequest, _$SubmitVisiteReportRequest];

  @override
  final String wireName = r'SubmitVisiteReportRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubmitVisiteReportRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'overallCondition';
    yield serializers.serialize(
      object.overallCondition,
      specifiedType: const FullType(int),
    );
    yield r'listingConformity';
    yield serializers.serialize(
      object.listingConformity,
      specifiedType: const FullType(SubmitVisiteReportRequestListingConformityEnum),
    );
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(String),
      );
    }
    yield r'photoKeys';
    yield serializers.serialize(
      object.photoKeys,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SubmitVisiteReportRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SubmitVisiteReportRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'overallCondition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.overallCondition = valueDes;
          break;
        case r'listingConformity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SubmitVisiteReportRequestListingConformityEnum),
          ) as SubmitVisiteReportRequestListingConformityEnum;
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
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.photoKeys.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SubmitVisiteReportRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubmitVisiteReportRequestBuilder();
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

class SubmitVisiteReportRequestListingConformityEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'OUI')
  static const SubmitVisiteReportRequestListingConformityEnum OUI = _$submitVisiteReportRequestListingConformityEnum_OUI;
  @BuiltValueEnumConst(wireName: r'PARTIELLEMENT')
  static const SubmitVisiteReportRequestListingConformityEnum PARTIELLEMENT = _$submitVisiteReportRequestListingConformityEnum_PARTIELLEMENT;
  @BuiltValueEnumConst(wireName: r'NON')
  static const SubmitVisiteReportRequestListingConformityEnum NON = _$submitVisiteReportRequestListingConformityEnum_NON;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SubmitVisiteReportRequestListingConformityEnum unknownDefaultOpenApi = _$submitVisiteReportRequestListingConformityEnum_unknownDefaultOpenApi;

  static Serializer<SubmitVisiteReportRequestListingConformityEnum> get serializer => _$submitVisiteReportRequestListingConformityEnumSerializer;

  const SubmitVisiteReportRequestListingConformityEnum._(String name): super(name);

  static BuiltSet<SubmitVisiteReportRequestListingConformityEnum> get values => _$submitVisiteReportRequestListingConformityEnumValues;
  static SubmitVisiteReportRequestListingConformityEnum valueOf(String name) => _$submitVisiteReportRequestListingConformityEnumValueOf(name);
}

