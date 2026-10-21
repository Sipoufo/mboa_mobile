//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ledger_entry_response.g.dart';

/// LedgerEntryResponse
///
/// Properties:
/// * [id] 
/// * [direction] 
/// * [category] 
/// * [amount] 
/// * [date] 
/// * [annonceId] 
/// * [residenceId] 
/// * [propertyLabel] 
/// * [note] 
/// * [hasAttachment] 
/// * [createdAt] 
/// * [source_] 
/// * [sourceId] 
/// * [readOnly] 
@BuiltValue()
abstract class LedgerEntryResponse implements Built<LedgerEntryResponse, LedgerEntryResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'direction')
  LedgerEntryResponseDirectionEnum? get direction;
  // enum directionEnum {  INCOME,  EXPENSE,  };

  @BuiltValueField(wireName: r'category')
  LedgerEntryResponseCategoryEnum? get category;
  // enum categoryEnum {  RENT,  CHARGES,  WORKS,  PROPERTY_TAX,  SERVICE_PROVIDERS,  OTHER,  };

  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'date')
  Date? get date;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'residenceId')
  String? get residenceId;

  @BuiltValueField(wireName: r'propertyLabel')
  String? get propertyLabel;

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'hasAttachment')
  bool? get hasAttachment;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'source')
  LedgerEntryResponseSource_Enum? get source_;
  // enum source_Enum {  INVOICE,  RENT,  };

  @BuiltValueField(wireName: r'sourceId')
  String? get sourceId;

  @BuiltValueField(wireName: r'readOnly')
  bool? get readOnly;

  LedgerEntryResponse._();

  factory LedgerEntryResponse([void updates(LedgerEntryResponseBuilder b)]) = _$LedgerEntryResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LedgerEntryResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LedgerEntryResponse> get serializer => _$LedgerEntryResponseSerializer();
}

class _$LedgerEntryResponseSerializer implements PrimitiveSerializer<LedgerEntryResponse> {
  @override
  final Iterable<Type> types = const [LedgerEntryResponse, _$LedgerEntryResponse];

  @override
  final String wireName = r'LedgerEntryResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LedgerEntryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.direction != null) {
      yield r'direction';
      yield serializers.serialize(
        object.direction,
        specifiedType: const FullType(LedgerEntryResponseDirectionEnum),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(LedgerEntryResponseCategoryEnum),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(int),
      );
    }
    if (object.date != null) {
      yield r'date';
      yield serializers.serialize(
        object.date,
        specifiedType: const FullType(Date),
      );
    }
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
    if (object.propertyLabel != null) {
      yield r'propertyLabel';
      yield serializers.serialize(
        object.propertyLabel,
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
    if (object.hasAttachment != null) {
      yield r'hasAttachment';
      yield serializers.serialize(
        object.hasAttachment,
        specifiedType: const FullType(bool),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.source_ != null) {
      yield r'source';
      yield serializers.serialize(
        object.source_,
        specifiedType: const FullType(LedgerEntryResponseSource_Enum),
      );
    }
    if (object.sourceId != null) {
      yield r'sourceId';
      yield serializers.serialize(
        object.sourceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.readOnly != null) {
      yield r'readOnly';
      yield serializers.serialize(
        object.readOnly,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LedgerEntryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LedgerEntryResponseBuilder result,
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
        case r'direction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(LedgerEntryResponseDirectionEnum),
          ) as LedgerEntryResponseDirectionEnum?;
          if (valueDes == null) continue;
          result.direction = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(LedgerEntryResponseCategoryEnum),
          ) as LedgerEntryResponseCategoryEnum?;
          if (valueDes == null) continue;
          result.category = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
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
        case r'propertyLabel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.propertyLabel = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        case r'hasAttachment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.hasAttachment = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(LedgerEntryResponseSource_Enum),
          ) as LedgerEntryResponseSource_Enum?;
          if (valueDes == null) continue;
          result.source_ = valueDes;
          break;
        case r'sourceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.sourceId = valueDes;
          break;
        case r'readOnly':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.readOnly = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LedgerEntryResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LedgerEntryResponseBuilder();
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

class LedgerEntryResponseDirectionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'INCOME')
  static const LedgerEntryResponseDirectionEnum INCOME = _$ledgerEntryResponseDirectionEnum_INCOME;
  @BuiltValueEnumConst(wireName: r'EXPENSE')
  static const LedgerEntryResponseDirectionEnum EXPENSE = _$ledgerEntryResponseDirectionEnum_EXPENSE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LedgerEntryResponseDirectionEnum unknownDefaultOpenApi = _$ledgerEntryResponseDirectionEnum_unknownDefaultOpenApi;

  static Serializer<LedgerEntryResponseDirectionEnum> get serializer => _$ledgerEntryResponseDirectionEnumSerializer;

  const LedgerEntryResponseDirectionEnum._(String name): super(name);

  static BuiltSet<LedgerEntryResponseDirectionEnum> get values => _$ledgerEntryResponseDirectionEnumValues;
  static LedgerEntryResponseDirectionEnum valueOf(String name) => _$ledgerEntryResponseDirectionEnumValueOf(name);
}

class LedgerEntryResponseCategoryEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'RENT')
  static const LedgerEntryResponseCategoryEnum RENT = _$ledgerEntryResponseCategoryEnum_RENT;
  @BuiltValueEnumConst(wireName: r'CHARGES')
  static const LedgerEntryResponseCategoryEnum CHARGES = _$ledgerEntryResponseCategoryEnum_CHARGES;
  @BuiltValueEnumConst(wireName: r'WORKS')
  static const LedgerEntryResponseCategoryEnum WORKS = _$ledgerEntryResponseCategoryEnum_WORKS;
  @BuiltValueEnumConst(wireName: r'PROPERTY_TAX')
  static const LedgerEntryResponseCategoryEnum PROPERTY_TAX = _$ledgerEntryResponseCategoryEnum_PROPERTY_TAX;
  @BuiltValueEnumConst(wireName: r'SERVICE_PROVIDERS')
  static const LedgerEntryResponseCategoryEnum SERVICE_PROVIDERS = _$ledgerEntryResponseCategoryEnum_SERVICE_PROVIDERS;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const LedgerEntryResponseCategoryEnum OTHER = _$ledgerEntryResponseCategoryEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LedgerEntryResponseCategoryEnum unknownDefaultOpenApi = _$ledgerEntryResponseCategoryEnum_unknownDefaultOpenApi;

  static Serializer<LedgerEntryResponseCategoryEnum> get serializer => _$ledgerEntryResponseCategoryEnumSerializer;

  const LedgerEntryResponseCategoryEnum._(String name): super(name);

  static BuiltSet<LedgerEntryResponseCategoryEnum> get values => _$ledgerEntryResponseCategoryEnumValues;
  static LedgerEntryResponseCategoryEnum valueOf(String name) => _$ledgerEntryResponseCategoryEnumValueOf(name);
}

class LedgerEntryResponseSource_Enum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'INVOICE')
  static const LedgerEntryResponseSource_Enum INVOICE = _$ledgerEntryResponseSourceEnum_INVOICE;
  @BuiltValueEnumConst(wireName: r'RENT')
  static const LedgerEntryResponseSource_Enum RENT = _$ledgerEntryResponseSourceEnum_RENT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LedgerEntryResponseSource_Enum unknownDefaultOpenApi = _$ledgerEntryResponseSourceEnum_unknownDefaultOpenApi;

  static Serializer<LedgerEntryResponseSource_Enum> get serializer => _$ledgerEntryResponseSourceEnumSerializer;

  const LedgerEntryResponseSource_Enum._(String name): super(name);

  static BuiltSet<LedgerEntryResponseSource_Enum> get values => _$ledgerEntryResponseSourceEnumValues;
  static LedgerEntryResponseSource_Enum valueOf(String name) => _$ledgerEntryResponseSourceEnumValueOf(name);
}

