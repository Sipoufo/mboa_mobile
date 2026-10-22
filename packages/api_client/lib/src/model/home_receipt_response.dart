//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'home_receipt_response.g.dart';

/// HomeReceiptResponse
///
/// Properties:
/// * [id] 
/// * [declarationId] 
/// * [contractId] 
/// * [kind] 
/// * [periodStart] 
/// * [periodEnd] 
/// * [amount] 
/// * [issuedAt] 
/// * [ready] 
@BuiltValue()
abstract class HomeReceiptResponse implements Built<HomeReceiptResponse, HomeReceiptResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'declarationId')
  String? get declarationId;

  @BuiltValueField(wireName: r'contractId')
  String? get contractId;

  @BuiltValueField(wireName: r'kind')
  HomeReceiptResponseKindEnum? get kind;
  // enum kindEnum {  RENT,  RENT_PARTIAL,  DEPOSIT,  INVOICE,  };

  @BuiltValueField(wireName: r'periodStart')
  Date? get periodStart;

  @BuiltValueField(wireName: r'periodEnd')
  Date? get periodEnd;

  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'issuedAt')
  DateTime? get issuedAt;

  @BuiltValueField(wireName: r'ready')
  bool? get ready;

  HomeReceiptResponse._();

  factory HomeReceiptResponse([void updates(HomeReceiptResponseBuilder b)]) = _$HomeReceiptResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HomeReceiptResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HomeReceiptResponse> get serializer => _$HomeReceiptResponseSerializer();
}

class _$HomeReceiptResponseSerializer implements PrimitiveSerializer<HomeReceiptResponse> {
  @override
  final Iterable<Type> types = const [HomeReceiptResponse, _$HomeReceiptResponse];

  @override
  final String wireName = r'HomeReceiptResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HomeReceiptResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.declarationId != null) {
      yield r'declarationId';
      yield serializers.serialize(
        object.declarationId,
        specifiedType: const FullType(String),
      );
    }
    if (object.contractId != null) {
      yield r'contractId';
      yield serializers.serialize(
        object.contractId,
        specifiedType: const FullType(String),
      );
    }
    if (object.kind != null) {
      yield r'kind';
      yield serializers.serialize(
        object.kind,
        specifiedType: const FullType(HomeReceiptResponseKindEnum),
      );
    }
    if (object.periodStart != null) {
      yield r'periodStart';
      yield serializers.serialize(
        object.periodStart,
        specifiedType: const FullType(Date),
      );
    }
    if (object.periodEnd != null) {
      yield r'periodEnd';
      yield serializers.serialize(
        object.periodEnd,
        specifiedType: const FullType(Date),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(int),
      );
    }
    if (object.issuedAt != null) {
      yield r'issuedAt';
      yield serializers.serialize(
        object.issuedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.ready != null) {
      yield r'ready';
      yield serializers.serialize(
        object.ready,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HomeReceiptResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HomeReceiptResponseBuilder result,
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
        case r'declarationId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.declarationId = valueDes;
          break;
        case r'contractId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contractId = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HomeReceiptResponseKindEnum),
          ) as HomeReceiptResponseKindEnum?;
          if (valueDes == null) continue;
          result.kind = valueDes;
          break;
        case r'periodStart':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.periodStart = valueDes;
          break;
        case r'periodEnd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.periodEnd = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'issuedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.issuedAt = valueDes;
          break;
        case r'ready':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.ready = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HomeReceiptResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HomeReceiptResponseBuilder();
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

class HomeReceiptResponseKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'RENT')
  static const HomeReceiptResponseKindEnum RENT = _$homeReceiptResponseKindEnum_RENT;
  @BuiltValueEnumConst(wireName: r'RENT_PARTIAL')
  static const HomeReceiptResponseKindEnum RENT_PARTIAL = _$homeReceiptResponseKindEnum_RENT_PARTIAL;
  @BuiltValueEnumConst(wireName: r'DEPOSIT')
  static const HomeReceiptResponseKindEnum DEPOSIT = _$homeReceiptResponseKindEnum_DEPOSIT;
  @BuiltValueEnumConst(wireName: r'INVOICE')
  static const HomeReceiptResponseKindEnum INVOICE = _$homeReceiptResponseKindEnum_INVOICE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const HomeReceiptResponseKindEnum unknownDefaultOpenApi = _$homeReceiptResponseKindEnum_unknownDefaultOpenApi;

  static Serializer<HomeReceiptResponseKindEnum> get serializer => _$homeReceiptResponseKindEnumSerializer;

  const HomeReceiptResponseKindEnum._(String name): super(name);

  static BuiltSet<HomeReceiptResponseKindEnum> get values => _$homeReceiptResponseKindEnumValues;
  static HomeReceiptResponseKindEnum valueOf(String name) => _$homeReceiptResponseKindEnumValueOf(name);
}

