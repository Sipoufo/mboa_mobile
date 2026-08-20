//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'request_changes_request.g.dart';

/// RequestChangesRequest
///
/// Properties:
/// * [comment] 
/// * [contestedTerms] 
@BuiltValue()
abstract class RequestChangesRequest implements Built<RequestChangesRequest, RequestChangesRequestBuilder> {
  @BuiltValueField(wireName: r'comment')
  String get comment;

  @BuiltValueField(wireName: r'contestedTerms')
  BuiltList<RequestChangesRequestContestedTermsEnum>? get contestedTerms;
  // enum contestedTermsEnum {  PRICE,  RENTAL_PERIOD,  DEPOSIT_AMOUNT,  CHARGES_INCLUDED,  START_DATE,  DURATION_UNITS,  TACIT_RENEWAL,  };

  RequestChangesRequest._();

  factory RequestChangesRequest([void updates(RequestChangesRequestBuilder b)]) = _$RequestChangesRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RequestChangesRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RequestChangesRequest> get serializer => _$RequestChangesRequestSerializer();
}

class _$RequestChangesRequestSerializer implements PrimitiveSerializer<RequestChangesRequest> {
  @override
  final Iterable<Type> types = const [RequestChangesRequest, _$RequestChangesRequest];

  @override
  final String wireName = r'RequestChangesRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RequestChangesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'comment';
    yield serializers.serialize(
      object.comment,
      specifiedType: const FullType(String),
    );
    if (object.contestedTerms != null) {
      yield r'contestedTerms';
      yield serializers.serialize(
        object.contestedTerms,
        specifiedType: const FullType(BuiltList, [FullType(RequestChangesRequestContestedTermsEnum)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RequestChangesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RequestChangesRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.comment = valueDes;
          break;
        case r'contestedTerms':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(RequestChangesRequestContestedTermsEnum)]),
          ) as BuiltList<RequestChangesRequestContestedTermsEnum>?;
          if (valueDes == null) continue;
          result.contestedTerms.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RequestChangesRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RequestChangesRequestBuilder();
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

class RequestChangesRequestContestedTermsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PRICE')
  static const RequestChangesRequestContestedTermsEnum PRICE = _$requestChangesRequestContestedTermsEnum_PRICE;
  @BuiltValueEnumConst(wireName: r'RENTAL_PERIOD')
  static const RequestChangesRequestContestedTermsEnum RENTAL_PERIOD = _$requestChangesRequestContestedTermsEnum_RENTAL_PERIOD;
  @BuiltValueEnumConst(wireName: r'DEPOSIT_AMOUNT')
  static const RequestChangesRequestContestedTermsEnum DEPOSIT_AMOUNT = _$requestChangesRequestContestedTermsEnum_DEPOSIT_AMOUNT;
  @BuiltValueEnumConst(wireName: r'CHARGES_INCLUDED')
  static const RequestChangesRequestContestedTermsEnum CHARGES_INCLUDED = _$requestChangesRequestContestedTermsEnum_CHARGES_INCLUDED;
  @BuiltValueEnumConst(wireName: r'START_DATE')
  static const RequestChangesRequestContestedTermsEnum START_DATE = _$requestChangesRequestContestedTermsEnum_START_DATE;
  @BuiltValueEnumConst(wireName: r'DURATION_UNITS')
  static const RequestChangesRequestContestedTermsEnum DURATION_UNITS = _$requestChangesRequestContestedTermsEnum_DURATION_UNITS;
  @BuiltValueEnumConst(wireName: r'TACIT_RENEWAL')
  static const RequestChangesRequestContestedTermsEnum TACIT_RENEWAL = _$requestChangesRequestContestedTermsEnum_TACIT_RENEWAL;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RequestChangesRequestContestedTermsEnum unknownDefaultOpenApi = _$requestChangesRequestContestedTermsEnum_unknownDefaultOpenApi;

  static Serializer<RequestChangesRequestContestedTermsEnum> get serializer => _$requestChangesRequestContestedTermsEnumSerializer;

  const RequestChangesRequestContestedTermsEnum._(String name): super(name);

  static BuiltSet<RequestChangesRequestContestedTermsEnum> get values => _$requestChangesRequestContestedTermsEnumValues;
  static RequestChangesRequestContestedTermsEnum valueOf(String name) => _$requestChangesRequestContestedTermsEnumValueOf(name);
}

