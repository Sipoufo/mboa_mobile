//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/participant_summary.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'declaration_response.g.dart';

/// DeclarationResponse
///
/// Properties:
/// * [id] 
/// * [contractId] 
/// * [annonceId] 
/// * [annonceTitle] 
/// * [tenant] 
/// * [kind] 
/// * [dueIndexes] 
/// * [invoiceId] 
/// * [amount] 
/// * [paidOn] 
/// * [method] 
/// * [reference] 
/// * [note] 
/// * [proofKeys] 
/// * [hasProof] 
/// * [status] 
/// * [contestReason] 
/// * [declaredAt] 
/// * [answeredAt] 
/// * [canConfirm] 
/// * [canContest] 
/// * [receiptId] 
/// * [receiptReady] 
/// * [residenceId] 
/// * [residenceName] 
@BuiltValue()
abstract class DeclarationResponse implements Built<DeclarationResponse, DeclarationResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'contractId')
  String? get contractId;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'annonceTitle')
  String? get annonceTitle;

  @BuiltValueField(wireName: r'tenant')
  ParticipantSummary? get tenant;

  @BuiltValueField(wireName: r'kind')
  DeclarationResponseKindEnum? get kind;
  // enum kindEnum {  RENT,  DEPOSIT,  INVOICE,  };

  @BuiltValueField(wireName: r'dueIndexes')
  BuiltList<int>? get dueIndexes;

  @BuiltValueField(wireName: r'invoiceId')
  String? get invoiceId;

  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'paidOn')
  Date? get paidOn;

  @BuiltValueField(wireName: r'method')
  DeclarationResponseMethodEnum? get method;
  // enum methodEnum {  MOBILE_MONEY,  ORANGE_MONEY,  CASH,  TRANSFER,  OTHER,  };

  @BuiltValueField(wireName: r'reference')
  String? get reference;

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'proofKeys')
  BuiltList<String>? get proofKeys;

  @BuiltValueField(wireName: r'hasProof')
  bool? get hasProof;

  @BuiltValueField(wireName: r'status')
  DeclarationResponseStatusEnum? get status;
  // enum statusEnum {  DECLARED,  UNCONFIRMED,  CONFIRMED,  CONTESTED,  };

  @BuiltValueField(wireName: r'contestReason')
  String? get contestReason;

  @BuiltValueField(wireName: r'declaredAt')
  DateTime? get declaredAt;

  @BuiltValueField(wireName: r'answeredAt')
  DateTime? get answeredAt;

  @BuiltValueField(wireName: r'canConfirm')
  bool? get canConfirm;

  @BuiltValueField(wireName: r'canContest')
  bool? get canContest;

  @BuiltValueField(wireName: r'receiptId')
  String? get receiptId;

  @BuiltValueField(wireName: r'receiptReady')
  bool? get receiptReady;

  @BuiltValueField(wireName: r'residenceId')
  String? get residenceId;

  @BuiltValueField(wireName: r'residenceName')
  String? get residenceName;

  DeclarationResponse._();

  factory DeclarationResponse([void updates(DeclarationResponseBuilder b)]) = _$DeclarationResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeclarationResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeclarationResponse> get serializer => _$DeclarationResponseSerializer();
}

class _$DeclarationResponseSerializer implements PrimitiveSerializer<DeclarationResponse> {
  @override
  final Iterable<Type> types = const [DeclarationResponse, _$DeclarationResponse];

  @override
  final String wireName = r'DeclarationResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeclarationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
    if (object.annonceId != null) {
      yield r'annonceId';
      yield serializers.serialize(
        object.annonceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.annonceTitle != null) {
      yield r'annonceTitle';
      yield serializers.serialize(
        object.annonceTitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.tenant != null) {
      yield r'tenant';
      yield serializers.serialize(
        object.tenant,
        specifiedType: const FullType(ParticipantSummary),
      );
    }
    if (object.kind != null) {
      yield r'kind';
      yield serializers.serialize(
        object.kind,
        specifiedType: const FullType(DeclarationResponseKindEnum),
      );
    }
    if (object.dueIndexes != null) {
      yield r'dueIndexes';
      yield serializers.serialize(
        object.dueIndexes,
        specifiedType: const FullType(BuiltList, [FullType(int)]),
      );
    }
    if (object.invoiceId != null) {
      yield r'invoiceId';
      yield serializers.serialize(
        object.invoiceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(int),
      );
    }
    if (object.paidOn != null) {
      yield r'paidOn';
      yield serializers.serialize(
        object.paidOn,
        specifiedType: const FullType(Date),
      );
    }
    if (object.method != null) {
      yield r'method';
      yield serializers.serialize(
        object.method,
        specifiedType: const FullType(DeclarationResponseMethodEnum),
      );
    }
    if (object.reference != null) {
      yield r'reference';
      yield serializers.serialize(
        object.reference,
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
    if (object.proofKeys != null) {
      yield r'proofKeys';
      yield serializers.serialize(
        object.proofKeys,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.hasProof != null) {
      yield r'hasProof';
      yield serializers.serialize(
        object.hasProof,
        specifiedType: const FullType(bool),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(DeclarationResponseStatusEnum),
      );
    }
    if (object.contestReason != null) {
      yield r'contestReason';
      yield serializers.serialize(
        object.contestReason,
        specifiedType: const FullType(String),
      );
    }
    if (object.declaredAt != null) {
      yield r'declaredAt';
      yield serializers.serialize(
        object.declaredAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.answeredAt != null) {
      yield r'answeredAt';
      yield serializers.serialize(
        object.answeredAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.canConfirm != null) {
      yield r'canConfirm';
      yield serializers.serialize(
        object.canConfirm,
        specifiedType: const FullType(bool),
      );
    }
    if (object.canContest != null) {
      yield r'canContest';
      yield serializers.serialize(
        object.canContest,
        specifiedType: const FullType(bool),
      );
    }
    if (object.receiptId != null) {
      yield r'receiptId';
      yield serializers.serialize(
        object.receiptId,
        specifiedType: const FullType(String),
      );
    }
    if (object.receiptReady != null) {
      yield r'receiptReady';
      yield serializers.serialize(
        object.receiptReady,
        specifiedType: const FullType(bool),
      );
    }
    if (object.residenceId != null) {
      yield r'residenceId';
      yield serializers.serialize(
        object.residenceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.residenceName != null) {
      yield r'residenceName';
      yield serializers.serialize(
        object.residenceName,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DeclarationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeclarationResponseBuilder result,
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
        case r'contractId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contractId = valueDes;
          break;
        case r'annonceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.annonceId = valueDes;
          break;
        case r'annonceTitle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.annonceTitle = valueDes;
          break;
        case r'tenant':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ParticipantSummary),
          ) as ParticipantSummary?;
          if (valueDes == null) continue;
          result.tenant.replace(valueDes);
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DeclarationResponseKindEnum),
          ) as DeclarationResponseKindEnum?;
          if (valueDes == null) continue;
          result.kind = valueDes;
          break;
        case r'dueIndexes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(int)]),
          ) as BuiltList<int>?;
          if (valueDes == null) continue;
          result.dueIndexes.replace(valueDes);
          break;
        case r'invoiceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.invoiceId = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'paidOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.paidOn = valueDes;
          break;
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DeclarationResponseMethodEnum),
          ) as DeclarationResponseMethodEnum?;
          if (valueDes == null) continue;
          result.method = valueDes;
          break;
        case r'reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reference = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        case r'proofKeys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.proofKeys.replace(valueDes);
          break;
        case r'hasProof':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.hasProof = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DeclarationResponseStatusEnum),
          ) as DeclarationResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'contestReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contestReason = valueDes;
          break;
        case r'declaredAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.declaredAt = valueDes;
          break;
        case r'answeredAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.answeredAt = valueDes;
          break;
        case r'canConfirm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canConfirm = valueDes;
          break;
        case r'canContest':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canContest = valueDes;
          break;
        case r'receiptId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.receiptId = valueDes;
          break;
        case r'receiptReady':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.receiptReady = valueDes;
          break;
        case r'residenceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.residenceId = valueDes;
          break;
        case r'residenceName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.residenceName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeclarationResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeclarationResponseBuilder();
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

class DeclarationResponseKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'RENT')
  static const DeclarationResponseKindEnum RENT = _$declarationResponseKindEnum_RENT;
  @BuiltValueEnumConst(wireName: r'DEPOSIT')
  static const DeclarationResponseKindEnum DEPOSIT = _$declarationResponseKindEnum_DEPOSIT;
  @BuiltValueEnumConst(wireName: r'INVOICE')
  static const DeclarationResponseKindEnum INVOICE = _$declarationResponseKindEnum_INVOICE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DeclarationResponseKindEnum unknownDefaultOpenApi = _$declarationResponseKindEnum_unknownDefaultOpenApi;

  static Serializer<DeclarationResponseKindEnum> get serializer => _$declarationResponseKindEnumSerializer;

  const DeclarationResponseKindEnum._(String name): super(name);

  static BuiltSet<DeclarationResponseKindEnum> get values => _$declarationResponseKindEnumValues;
  static DeclarationResponseKindEnum valueOf(String name) => _$declarationResponseKindEnumValueOf(name);
}

class DeclarationResponseMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MOBILE_MONEY')
  static const DeclarationResponseMethodEnum MOBILE_MONEY = _$declarationResponseMethodEnum_MOBILE_MONEY;
  @BuiltValueEnumConst(wireName: r'ORANGE_MONEY')
  static const DeclarationResponseMethodEnum ORANGE_MONEY = _$declarationResponseMethodEnum_ORANGE_MONEY;
  @BuiltValueEnumConst(wireName: r'CASH')
  static const DeclarationResponseMethodEnum CASH = _$declarationResponseMethodEnum_CASH;
  @BuiltValueEnumConst(wireName: r'TRANSFER')
  static const DeclarationResponseMethodEnum TRANSFER = _$declarationResponseMethodEnum_TRANSFER;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const DeclarationResponseMethodEnum OTHER = _$declarationResponseMethodEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DeclarationResponseMethodEnum unknownDefaultOpenApi = _$declarationResponseMethodEnum_unknownDefaultOpenApi;

  static Serializer<DeclarationResponseMethodEnum> get serializer => _$declarationResponseMethodEnumSerializer;

  const DeclarationResponseMethodEnum._(String name): super(name);

  static BuiltSet<DeclarationResponseMethodEnum> get values => _$declarationResponseMethodEnumValues;
  static DeclarationResponseMethodEnum valueOf(String name) => _$declarationResponseMethodEnumValueOf(name);
}

class DeclarationResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DECLARED')
  static const DeclarationResponseStatusEnum DECLARED = _$declarationResponseStatusEnum_DECLARED;
  @BuiltValueEnumConst(wireName: r'UNCONFIRMED')
  static const DeclarationResponseStatusEnum UNCONFIRMED = _$declarationResponseStatusEnum_UNCONFIRMED;
  @BuiltValueEnumConst(wireName: r'CONFIRMED')
  static const DeclarationResponseStatusEnum CONFIRMED = _$declarationResponseStatusEnum_CONFIRMED;
  @BuiltValueEnumConst(wireName: r'CONTESTED')
  static const DeclarationResponseStatusEnum CONTESTED = _$declarationResponseStatusEnum_CONTESTED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DeclarationResponseStatusEnum unknownDefaultOpenApi = _$declarationResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<DeclarationResponseStatusEnum> get serializer => _$declarationResponseStatusEnumSerializer;

  const DeclarationResponseStatusEnum._(String name): super(name);

  static BuiltSet<DeclarationResponseStatusEnum> get values => _$declarationResponseStatusEnumValues;
  static DeclarationResponseStatusEnum valueOf(String name) => _$declarationResponseStatusEnumValueOf(name);
}

