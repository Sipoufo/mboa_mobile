//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/change_request_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/participant_summary.dart';
import 'package:api_client/src/model/signature_response.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'contract_response.g.dart';

/// ContractResponse
///
/// Properties:
/// * [id] 
/// * [status] 
/// * [annonceId] 
/// * [annonceTitle] 
/// * [city] 
/// * [district] 
/// * [exactAddress] 
/// * [prestataire] 
/// * [tenant] 
/// * [agent] 
/// * [price] 
/// * [rentalPeriod] 
/// * [monthlyRent] 
/// * [depositAmount] 
/// * [chargesIncluded] 
/// * [startDate] 
/// * [endDate] 
/// * [durationUnits] 
/// * [tacitRenewal] 
/// * [signatures] 
/// * [changeRequests] 
/// * [awaiting] 
/// * [canSign] 
/// * [residentReviewEligible] 
/// * [lockedAt] 
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class ContractResponse implements Built<ContractResponse, ContractResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'status')
  ContractResponseStatusEnum? get status;
  // enum statusEnum {  DRAFT,  SENT,  CHANGES_REQUESTED,  ACCEPTED,  SIGNED,  CANCELLED,  };

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'annonceTitle')
  String? get annonceTitle;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'district')
  String? get district;

  @BuiltValueField(wireName: r'exactAddress')
  String? get exactAddress;

  @BuiltValueField(wireName: r'prestataire')
  ParticipantSummary? get prestataire;

  @BuiltValueField(wireName: r'tenant')
  ParticipantSummary? get tenant;

  @BuiltValueField(wireName: r'agent')
  ParticipantSummary? get agent;

  @BuiltValueField(wireName: r'price')
  int? get price;

  @BuiltValueField(wireName: r'rentalPeriod')
  ContractResponseRentalPeriodEnum? get rentalPeriod;
  // enum rentalPeriodEnum {  DAY,  WEEK,  MONTH,  QUARTER,  YEAR,  };

  @BuiltValueField(wireName: r'monthlyRent')
  int? get monthlyRent;

  @BuiltValueField(wireName: r'depositAmount')
  int? get depositAmount;

  @BuiltValueField(wireName: r'chargesIncluded')
  bool? get chargesIncluded;

  @BuiltValueField(wireName: r'startDate')
  Date? get startDate;

  @BuiltValueField(wireName: r'endDate')
  Date? get endDate;

  @BuiltValueField(wireName: r'durationUnits')
  int? get durationUnits;

  @BuiltValueField(wireName: r'tacitRenewal')
  bool? get tacitRenewal;

  @BuiltValueField(wireName: r'signatures')
  BuiltList<SignatureResponse>? get signatures;

  @BuiltValueField(wireName: r'changeRequests')
  BuiltList<ChangeRequestResponse>? get changeRequests;

  @BuiltValueField(wireName: r'awaiting')
  ContractResponseAwaitingEnum? get awaiting;
  // enum awaitingEnum {  PRESTATAIRE,  TENANT,  BOTH,  NOBODY,  };

  @BuiltValueField(wireName: r'canSign')
  bool? get canSign;

  @BuiltValueField(wireName: r'residentReviewEligible')
  bool? get residentReviewEligible;

  @BuiltValueField(wireName: r'lockedAt')
  DateTime? get lockedAt;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updatedAt')
  DateTime? get updatedAt;

  ContractResponse._();

  factory ContractResponse([void updates(ContractResponseBuilder b)]) = _$ContractResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ContractResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ContractResponse> get serializer => _$ContractResponseSerializer();
}

class _$ContractResponseSerializer implements PrimitiveSerializer<ContractResponse> {
  @override
  final Iterable<Type> types = const [ContractResponse, _$ContractResponse];

  @override
  final String wireName = r'ContractResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ContractResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(ContractResponseStatusEnum),
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
    if (object.city != null) {
      yield r'city';
      yield serializers.serialize(
        object.city,
        specifiedType: const FullType(String),
      );
    }
    if (object.district != null) {
      yield r'district';
      yield serializers.serialize(
        object.district,
        specifiedType: const FullType(String),
      );
    }
    if (object.exactAddress != null) {
      yield r'exactAddress';
      yield serializers.serialize(
        object.exactAddress,
        specifiedType: const FullType(String),
      );
    }
    if (object.prestataire != null) {
      yield r'prestataire';
      yield serializers.serialize(
        object.prestataire,
        specifiedType: const FullType(ParticipantSummary),
      );
    }
    if (object.tenant != null) {
      yield r'tenant';
      yield serializers.serialize(
        object.tenant,
        specifiedType: const FullType(ParticipantSummary),
      );
    }
    if (object.agent != null) {
      yield r'agent';
      yield serializers.serialize(
        object.agent,
        specifiedType: const FullType(ParticipantSummary),
      );
    }
    if (object.price != null) {
      yield r'price';
      yield serializers.serialize(
        object.price,
        specifiedType: const FullType(int),
      );
    }
    if (object.rentalPeriod != null) {
      yield r'rentalPeriod';
      yield serializers.serialize(
        object.rentalPeriod,
        specifiedType: const FullType(ContractResponseRentalPeriodEnum),
      );
    }
    if (object.monthlyRent != null) {
      yield r'monthlyRent';
      yield serializers.serialize(
        object.monthlyRent,
        specifiedType: const FullType(int),
      );
    }
    if (object.depositAmount != null) {
      yield r'depositAmount';
      yield serializers.serialize(
        object.depositAmount,
        specifiedType: const FullType(int),
      );
    }
    if (object.chargesIncluded != null) {
      yield r'chargesIncluded';
      yield serializers.serialize(
        object.chargesIncluded,
        specifiedType: const FullType(bool),
      );
    }
    if (object.startDate != null) {
      yield r'startDate';
      yield serializers.serialize(
        object.startDate,
        specifiedType: const FullType(Date),
      );
    }
    if (object.endDate != null) {
      yield r'endDate';
      yield serializers.serialize(
        object.endDate,
        specifiedType: const FullType(Date),
      );
    }
    if (object.durationUnits != null) {
      yield r'durationUnits';
      yield serializers.serialize(
        object.durationUnits,
        specifiedType: const FullType(int),
      );
    }
    if (object.tacitRenewal != null) {
      yield r'tacitRenewal';
      yield serializers.serialize(
        object.tacitRenewal,
        specifiedType: const FullType(bool),
      );
    }
    if (object.signatures != null) {
      yield r'signatures';
      yield serializers.serialize(
        object.signatures,
        specifiedType: const FullType(BuiltList, [FullType(SignatureResponse)]),
      );
    }
    if (object.changeRequests != null) {
      yield r'changeRequests';
      yield serializers.serialize(
        object.changeRequests,
        specifiedType: const FullType(BuiltList, [FullType(ChangeRequestResponse)]),
      );
    }
    if (object.awaiting != null) {
      yield r'awaiting';
      yield serializers.serialize(
        object.awaiting,
        specifiedType: const FullType(ContractResponseAwaitingEnum),
      );
    }
    if (object.canSign != null) {
      yield r'canSign';
      yield serializers.serialize(
        object.canSign,
        specifiedType: const FullType(bool),
      );
    }
    if (object.residentReviewEligible != null) {
      yield r'residentReviewEligible';
      yield serializers.serialize(
        object.residentReviewEligible,
        specifiedType: const FullType(bool),
      );
    }
    if (object.lockedAt != null) {
      yield r'lockedAt';
      yield serializers.serialize(
        object.lockedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.updatedAt != null) {
      yield r'updatedAt';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ContractResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ContractResponseBuilder result,
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ContractResponseStatusEnum),
          ) as ContractResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
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
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.city = valueDes;
          break;
        case r'district':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.district = valueDes;
          break;
        case r'exactAddress':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.exactAddress = valueDes;
          break;
        case r'prestataire':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ParticipantSummary),
          ) as ParticipantSummary?;
          if (valueDes == null) continue;
          result.prestataire.replace(valueDes);
          break;
        case r'tenant':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ParticipantSummary),
          ) as ParticipantSummary?;
          if (valueDes == null) continue;
          result.tenant.replace(valueDes);
          break;
        case r'agent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ParticipantSummary),
          ) as ParticipantSummary?;
          if (valueDes == null) continue;
          result.agent.replace(valueDes);
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.price = valueDes;
          break;
        case r'rentalPeriod':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ContractResponseRentalPeriodEnum),
          ) as ContractResponseRentalPeriodEnum?;
          if (valueDes == null) continue;
          result.rentalPeriod = valueDes;
          break;
        case r'monthlyRent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.monthlyRent = valueDes;
          break;
        case r'depositAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.depositAmount = valueDes;
          break;
        case r'chargesIncluded':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.chargesIncluded = valueDes;
          break;
        case r'startDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.startDate = valueDes;
          break;
        case r'endDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.endDate = valueDes;
          break;
        case r'durationUnits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.durationUnits = valueDes;
          break;
        case r'tacitRenewal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.tacitRenewal = valueDes;
          break;
        case r'signatures':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SignatureResponse)]),
          ) as BuiltList<SignatureResponse>?;
          if (valueDes == null) continue;
          result.signatures.replace(valueDes);
          break;
        case r'changeRequests':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(ChangeRequestResponse)]),
          ) as BuiltList<ChangeRequestResponse>?;
          if (valueDes == null) continue;
          result.changeRequests.replace(valueDes);
          break;
        case r'awaiting':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ContractResponseAwaitingEnum),
          ) as ContractResponseAwaitingEnum?;
          if (valueDes == null) continue;
          result.awaiting = valueDes;
          break;
        case r'canSign':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canSign = valueDes;
          break;
        case r'residentReviewEligible':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.residentReviewEligible = valueDes;
          break;
        case r'lockedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lockedAt = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'updatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ContractResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ContractResponseBuilder();
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

class ContractResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DRAFT')
  static const ContractResponseStatusEnum DRAFT = _$contractResponseStatusEnum_DRAFT;
  @BuiltValueEnumConst(wireName: r'SENT')
  static const ContractResponseStatusEnum SENT = _$contractResponseStatusEnum_SENT;
  @BuiltValueEnumConst(wireName: r'CHANGES_REQUESTED')
  static const ContractResponseStatusEnum CHANGES_REQUESTED = _$contractResponseStatusEnum_CHANGES_REQUESTED;
  @BuiltValueEnumConst(wireName: r'ACCEPTED')
  static const ContractResponseStatusEnum ACCEPTED = _$contractResponseStatusEnum_ACCEPTED;
  @BuiltValueEnumConst(wireName: r'SIGNED')
  static const ContractResponseStatusEnum SIGNED = _$contractResponseStatusEnum_SIGNED;
  @BuiltValueEnumConst(wireName: r'CANCELLED')
  static const ContractResponseStatusEnum CANCELLED = _$contractResponseStatusEnum_CANCELLED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ContractResponseStatusEnum unknownDefaultOpenApi = _$contractResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<ContractResponseStatusEnum> get serializer => _$contractResponseStatusEnumSerializer;

  const ContractResponseStatusEnum._(String name): super(name);

  static BuiltSet<ContractResponseStatusEnum> get values => _$contractResponseStatusEnumValues;
  static ContractResponseStatusEnum valueOf(String name) => _$contractResponseStatusEnumValueOf(name);
}

class ContractResponseRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DAY')
  static const ContractResponseRentalPeriodEnum DAY = _$contractResponseRentalPeriodEnum_DAY;
  @BuiltValueEnumConst(wireName: r'WEEK')
  static const ContractResponseRentalPeriodEnum WEEK = _$contractResponseRentalPeriodEnum_WEEK;
  @BuiltValueEnumConst(wireName: r'MONTH')
  static const ContractResponseRentalPeriodEnum MONTH = _$contractResponseRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const ContractResponseRentalPeriodEnum QUARTER = _$contractResponseRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const ContractResponseRentalPeriodEnum YEAR = _$contractResponseRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ContractResponseRentalPeriodEnum unknownDefaultOpenApi = _$contractResponseRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<ContractResponseRentalPeriodEnum> get serializer => _$contractResponseRentalPeriodEnumSerializer;

  const ContractResponseRentalPeriodEnum._(String name): super(name);

  static BuiltSet<ContractResponseRentalPeriodEnum> get values => _$contractResponseRentalPeriodEnumValues;
  static ContractResponseRentalPeriodEnum valueOf(String name) => _$contractResponseRentalPeriodEnumValueOf(name);
}

class ContractResponseAwaitingEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PRESTATAIRE')
  static const ContractResponseAwaitingEnum PRESTATAIRE = _$contractResponseAwaitingEnum_PRESTATAIRE;
  @BuiltValueEnumConst(wireName: r'TENANT')
  static const ContractResponseAwaitingEnum TENANT = _$contractResponseAwaitingEnum_TENANT;
  @BuiltValueEnumConst(wireName: r'BOTH')
  static const ContractResponseAwaitingEnum BOTH = _$contractResponseAwaitingEnum_BOTH;
  @BuiltValueEnumConst(wireName: r'NOBODY')
  static const ContractResponseAwaitingEnum NOBODY = _$contractResponseAwaitingEnum_NOBODY;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ContractResponseAwaitingEnum unknownDefaultOpenApi = _$contractResponseAwaitingEnum_unknownDefaultOpenApi;

  static Serializer<ContractResponseAwaitingEnum> get serializer => _$contractResponseAwaitingEnumSerializer;

  const ContractResponseAwaitingEnum._(String name): super(name);

  static BuiltSet<ContractResponseAwaitingEnum> get values => _$contractResponseAwaitingEnumValues;
  static ContractResponseAwaitingEnum valueOf(String name) => _$contractResponseAwaitingEnumValueOf(name);
}

