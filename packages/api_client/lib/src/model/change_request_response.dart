//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'change_request_response.g.dart';

/// ChangeRequestResponse
///
/// Properties:
/// * [id] 
/// * [comment] 
/// * [contestedTerms] 
/// * [createdAt] 
/// * [response] 
/// * [respondedAt] 
/// * [withdrawnAt] 
/// * [pending] 
@BuiltValue()
abstract class ChangeRequestResponse implements Built<ChangeRequestResponse, ChangeRequestResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'contestedTerms')
  BuiltList<ChangeRequestResponseContestedTermsEnum>? get contestedTerms;
  // enum contestedTermsEnum {  PRICE,  RENTAL_PERIOD,  DEPOSIT_AMOUNT,  CHARGES_INCLUDED,  START_DATE,  DURATION_UNITS,  TACIT_RENEWAL,  };

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'response')
  String? get response;

  @BuiltValueField(wireName: r'respondedAt')
  DateTime? get respondedAt;

  @BuiltValueField(wireName: r'withdrawnAt')
  DateTime? get withdrawnAt;

  @BuiltValueField(wireName: r'pending')
  bool? get pending;

  ChangeRequestResponse._();

  factory ChangeRequestResponse([void updates(ChangeRequestResponseBuilder b)]) = _$ChangeRequestResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChangeRequestResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChangeRequestResponse> get serializer => _$ChangeRequestResponseSerializer();
}

class _$ChangeRequestResponseSerializer implements PrimitiveSerializer<ChangeRequestResponse> {
  @override
  final Iterable<Type> types = const [ChangeRequestResponse, _$ChangeRequestResponse];

  @override
  final String wireName = r'ChangeRequestResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChangeRequestResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(String),
      );
    }
    if (object.contestedTerms != null) {
      yield r'contestedTerms';
      yield serializers.serialize(
        object.contestedTerms,
        specifiedType: const FullType(BuiltList, [FullType(ChangeRequestResponseContestedTermsEnum)]),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.response != null) {
      yield r'response';
      yield serializers.serialize(
        object.response,
        specifiedType: const FullType(String),
      );
    }
    if (object.respondedAt != null) {
      yield r'respondedAt';
      yield serializers.serialize(
        object.respondedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.withdrawnAt != null) {
      yield r'withdrawnAt';
      yield serializers.serialize(
        object.withdrawnAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.pending != null) {
      yield r'pending';
      yield serializers.serialize(
        object.pending,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ChangeRequestResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChangeRequestResponseBuilder result,
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
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        case r'contestedTerms':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(ChangeRequestResponseContestedTermsEnum)]),
          ) as BuiltList<ChangeRequestResponseContestedTermsEnum>?;
          if (valueDes == null) continue;
          result.contestedTerms.replace(valueDes);
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'response':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.response = valueDes;
          break;
        case r'respondedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.respondedAt = valueDes;
          break;
        case r'withdrawnAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.withdrawnAt = valueDes;
          break;
        case r'pending':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.pending = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChangeRequestResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChangeRequestResponseBuilder();
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

class ChangeRequestResponseContestedTermsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PRICE')
  static const ChangeRequestResponseContestedTermsEnum PRICE = _$changeRequestResponseContestedTermsEnum_PRICE;
  @BuiltValueEnumConst(wireName: r'RENTAL_PERIOD')
  static const ChangeRequestResponseContestedTermsEnum RENTAL_PERIOD = _$changeRequestResponseContestedTermsEnum_RENTAL_PERIOD;
  @BuiltValueEnumConst(wireName: r'DEPOSIT_AMOUNT')
  static const ChangeRequestResponseContestedTermsEnum DEPOSIT_AMOUNT = _$changeRequestResponseContestedTermsEnum_DEPOSIT_AMOUNT;
  @BuiltValueEnumConst(wireName: r'CHARGES_INCLUDED')
  static const ChangeRequestResponseContestedTermsEnum CHARGES_INCLUDED = _$changeRequestResponseContestedTermsEnum_CHARGES_INCLUDED;
  @BuiltValueEnumConst(wireName: r'START_DATE')
  static const ChangeRequestResponseContestedTermsEnum START_DATE = _$changeRequestResponseContestedTermsEnum_START_DATE;
  @BuiltValueEnumConst(wireName: r'DURATION_UNITS')
  static const ChangeRequestResponseContestedTermsEnum DURATION_UNITS = _$changeRequestResponseContestedTermsEnum_DURATION_UNITS;
  @BuiltValueEnumConst(wireName: r'TACIT_RENEWAL')
  static const ChangeRequestResponseContestedTermsEnum TACIT_RENEWAL = _$changeRequestResponseContestedTermsEnum_TACIT_RENEWAL;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ChangeRequestResponseContestedTermsEnum unknownDefaultOpenApi = _$changeRequestResponseContestedTermsEnum_unknownDefaultOpenApi;

  static Serializer<ChangeRequestResponseContestedTermsEnum> get serializer => _$changeRequestResponseContestedTermsEnumSerializer;

  const ChangeRequestResponseContestedTermsEnum._(String name): super(name);

  static BuiltSet<ChangeRequestResponseContestedTermsEnum> get values => _$changeRequestResponseContestedTermsEnumValues;
  static ChangeRequestResponseContestedTermsEnum valueOf(String name) => _$changeRequestResponseContestedTermsEnumValueOf(name);
}

