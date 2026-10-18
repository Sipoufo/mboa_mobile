//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ledger_entry_request.g.dart';

/// LedgerEntryRequest
///
/// Properties:
/// * [direction] 
/// * [category] 
/// * [amount] 
/// * [date] 
/// * [annonceId] 
/// * [residenceId] 
/// * [note] 
/// * [attachmentKey] 
@BuiltValue()
abstract class LedgerEntryRequest implements Built<LedgerEntryRequest, LedgerEntryRequestBuilder> {
  @BuiltValueField(wireName: r'direction')
  LedgerEntryRequestDirectionEnum get direction;
  // enum directionEnum {  INCOME,  EXPENSE,  };

  @BuiltValueField(wireName: r'category')
  LedgerEntryRequestCategoryEnum get category;
  // enum categoryEnum {  RENT,  CHARGES,  WORKS,  PROPERTY_TAX,  SERVICE_PROVIDERS,  OTHER,  };

  @BuiltValueField(wireName: r'amount')
  int get amount;

  @BuiltValueField(wireName: r'date')
  Date get date;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'residenceId')
  String? get residenceId;

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'attachmentKey')
  String? get attachmentKey;

  LedgerEntryRequest._();

  factory LedgerEntryRequest([void updates(LedgerEntryRequestBuilder b)]) = _$LedgerEntryRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LedgerEntryRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LedgerEntryRequest> get serializer => _$LedgerEntryRequestSerializer();
}

class _$LedgerEntryRequestSerializer implements PrimitiveSerializer<LedgerEntryRequest> {
  @override
  final Iterable<Type> types = const [LedgerEntryRequest, _$LedgerEntryRequest];

  @override
  final String wireName = r'LedgerEntryRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LedgerEntryRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'direction';
    yield serializers.serialize(
      object.direction,
      specifiedType: const FullType(LedgerEntryRequestDirectionEnum),
    );
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(LedgerEntryRequestCategoryEnum),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(int),
    );
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(Date),
    );
    if (object.annonceId != null) {
      yield r'annonceId';
      yield serializers.serialize(
        object.annonceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.residenceId != null) {
      yield r'residenceId';
      yield serializers.serialize(
        object.residenceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType(String),
      );
    }
    if (object.attachmentKey != null) {
      yield r'attachmentKey';
      yield serializers.serialize(
        object.attachmentKey,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LedgerEntryRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LedgerEntryRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'direction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LedgerEntryRequestDirectionEnum),
          ) as LedgerEntryRequestDirectionEnum;
          result.direction = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LedgerEntryRequestCategoryEnum),
          ) as LedgerEntryRequestCategoryEnum;
          result.category = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.amount = valueDes;
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.date = valueDes;
          break;
        case r'annonceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.annonceId = valueDes;
          break;
        case r'residenceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.residenceId = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        case r'attachmentKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.attachmentKey = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LedgerEntryRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LedgerEntryRequestBuilder();
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

class LedgerEntryRequestDirectionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'INCOME')
  static const LedgerEntryRequestDirectionEnum INCOME = _$ledgerEntryRequestDirectionEnum_INCOME;
  @BuiltValueEnumConst(wireName: r'EXPENSE')
  static const LedgerEntryRequestDirectionEnum EXPENSE = _$ledgerEntryRequestDirectionEnum_EXPENSE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LedgerEntryRequestDirectionEnum unknownDefaultOpenApi = _$ledgerEntryRequestDirectionEnum_unknownDefaultOpenApi;

  static Serializer<LedgerEntryRequestDirectionEnum> get serializer => _$ledgerEntryRequestDirectionEnumSerializer;

  const LedgerEntryRequestDirectionEnum._(String name): super(name);

  static BuiltSet<LedgerEntryRequestDirectionEnum> get values => _$ledgerEntryRequestDirectionEnumValues;
  static LedgerEntryRequestDirectionEnum valueOf(String name) => _$ledgerEntryRequestDirectionEnumValueOf(name);
}

class LedgerEntryRequestCategoryEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'RENT')
  static const LedgerEntryRequestCategoryEnum RENT = _$ledgerEntryRequestCategoryEnum_RENT;
  @BuiltValueEnumConst(wireName: r'CHARGES')
  static const LedgerEntryRequestCategoryEnum CHARGES = _$ledgerEntryRequestCategoryEnum_CHARGES;
  @BuiltValueEnumConst(wireName: r'WORKS')
  static const LedgerEntryRequestCategoryEnum WORKS = _$ledgerEntryRequestCategoryEnum_WORKS;
  @BuiltValueEnumConst(wireName: r'PROPERTY_TAX')
  static const LedgerEntryRequestCategoryEnum PROPERTY_TAX = _$ledgerEntryRequestCategoryEnum_PROPERTY_TAX;
  @BuiltValueEnumConst(wireName: r'SERVICE_PROVIDERS')
  static const LedgerEntryRequestCategoryEnum SERVICE_PROVIDERS = _$ledgerEntryRequestCategoryEnum_SERVICE_PROVIDERS;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const LedgerEntryRequestCategoryEnum OTHER = _$ledgerEntryRequestCategoryEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LedgerEntryRequestCategoryEnum unknownDefaultOpenApi = _$ledgerEntryRequestCategoryEnum_unknownDefaultOpenApi;

  static Serializer<LedgerEntryRequestCategoryEnum> get serializer => _$ledgerEntryRequestCategoryEnumSerializer;

  const LedgerEntryRequestCategoryEnum._(String name): super(name);

  static BuiltSet<LedgerEntryRequestCategoryEnum> get values => _$ledgerEntryRequestCategoryEnumValues;
  static LedgerEntryRequestCategoryEnum valueOf(String name) => _$ledgerEntryRequestCategoryEnumValueOf(name);
}

