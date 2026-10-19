//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/participant_summary.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reservation_response.g.dart';

/// ReservationResponse
///
/// Properties:
/// * [id] 
/// * [annonceId] 
/// * [annonceTitle] 
/// * [userAccountId] 
/// * [client] 
/// * [prestataire] 
/// * [desiredStartDate] 
/// * [durationUnits] 
/// * [rentalPeriod] 
/// * [message] 
/// * [status] 
/// * [expiresAt] 
/// * [reservedUntil] 
/// * [extended] 
/// * [ownerReason] 
/// * [ownerNote] 
/// * [cancelledBy] 
/// * [conversationId] 
/// * [createdAt] 
/// * [answeredAt] 
/// * [canAccept] 
/// * [canRefuse] 
/// * [canExtend] 
/// * [canCancel] 
/// * [canDraftContract] 
@BuiltValue()
abstract class ReservationResponse implements Built<ReservationResponse, ReservationResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'annonceId')
  String? get annonceId;

  @BuiltValueField(wireName: r'annonceTitle')
  String? get annonceTitle;

  @BuiltValueField(wireName: r'userAccountId')
  String? get userAccountId;

  @BuiltValueField(wireName: r'client')
  ParticipantSummary? get client;

  @BuiltValueField(wireName: r'prestataire')
  ParticipantSummary? get prestataire;

  @BuiltValueField(wireName: r'desiredStartDate')
  Date? get desiredStartDate;

  @BuiltValueField(wireName: r'durationUnits')
  int? get durationUnits;

  @BuiltValueField(wireName: r'rentalPeriod')
  ReservationResponseRentalPeriodEnum? get rentalPeriod;
  // enum rentalPeriodEnum {  DAY,  WEEK,  MONTH,  QUARTER,  YEAR,  };

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'status')
  ReservationResponseStatusEnum? get status;
  // enum statusEnum {  PENDING,  ACCEPTED,  REFUSED,  NOT_RETAINED,  EXPIRED,  CANCELLED,  LAPSED,  CONTRACTED,  };

  @BuiltValueField(wireName: r'expiresAt')
  DateTime? get expiresAt;

  @BuiltValueField(wireName: r'reservedUntil')
  DateTime? get reservedUntil;

  @BuiltValueField(wireName: r'extended')
  bool? get extended;

  @BuiltValueField(wireName: r'ownerReason')
  ReservationResponseOwnerReasonEnum? get ownerReason;
  // enum ownerReasonEnum {  RESERVED_ELSEWHERE,  PROFILE_NOT_RETAINED,  DATES_INCOMPATIBLE,  OTHER,  };

  @BuiltValueField(wireName: r'ownerNote')
  String? get ownerNote;

  @BuiltValueField(wireName: r'cancelledBy')
  ReservationResponseCancelledByEnum? get cancelledBy;
  // enum cancelledByEnum {  CLIENT,  PRESTATAIRE,  SYSTEM,  };

  @BuiltValueField(wireName: r'conversationId')
  String? get conversationId;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'answeredAt')
  DateTime? get answeredAt;

  @BuiltValueField(wireName: r'canAccept')
  bool? get canAccept;

  @BuiltValueField(wireName: r'canRefuse')
  bool? get canRefuse;

  @BuiltValueField(wireName: r'canExtend')
  bool? get canExtend;

  @BuiltValueField(wireName: r'canCancel')
  bool? get canCancel;

  @BuiltValueField(wireName: r'canDraftContract')
  bool? get canDraftContract;

  ReservationResponse._();

  factory ReservationResponse([void updates(ReservationResponseBuilder b)]) = _$ReservationResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReservationResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReservationResponse> get serializer => _$ReservationResponseSerializer();
}

class _$ReservationResponseSerializer implements PrimitiveSerializer<ReservationResponse> {
  @override
  final Iterable<Type> types = const [ReservationResponse, _$ReservationResponse];

  @override
  final String wireName = r'ReservationResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReservationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    if (object.annonceTitle != null) {
      yield r'annonceTitle';
      yield serializers.serialize(
        object.annonceTitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.userAccountId != null) {
      yield r'userAccountId';
      yield serializers.serialize(
        object.userAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.client != null) {
      yield r'client';
      yield serializers.serialize(
        object.client,
        specifiedType: const FullType(ParticipantSummary),
      );
    }
    if (object.prestataire != null) {
      yield r'prestataire';
      yield serializers.serialize(
        object.prestataire,
        specifiedType: const FullType(ParticipantSummary),
      );
    }
    if (object.desiredStartDate != null) {
      yield r'desiredStartDate';
      yield serializers.serialize(
        object.desiredStartDate,
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
    if (object.rentalPeriod != null) {
      yield r'rentalPeriod';
      yield serializers.serialize(
        object.rentalPeriod,
        specifiedType: const FullType(ReservationResponseRentalPeriodEnum),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(ReservationResponseStatusEnum),
      );
    }
    if (object.expiresAt != null) {
      yield r'expiresAt';
      yield serializers.serialize(
        object.expiresAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.reservedUntil != null) {
      yield r'reservedUntil';
      yield serializers.serialize(
        object.reservedUntil,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.extended != null) {
      yield r'extended';
      yield serializers.serialize(
        object.extended,
        specifiedType: const FullType(bool),
      );
    }
    if (object.ownerReason != null) {
      yield r'ownerReason';
      yield serializers.serialize(
        object.ownerReason,
        specifiedType: const FullType(ReservationResponseOwnerReasonEnum),
      );
    }
    if (object.ownerNote != null) {
      yield r'ownerNote';
      yield serializers.serialize(
        object.ownerNote,
        specifiedType: const FullType(String),
      );
    }
    if (object.cancelledBy != null) {
      yield r'cancelledBy';
      yield serializers.serialize(
        object.cancelledBy,
        specifiedType: const FullType(ReservationResponseCancelledByEnum),
      );
    }
    if (object.conversationId != null) {
      yield r'conversationId';
      yield serializers.serialize(
        object.conversationId,
        specifiedType: const FullType(String),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
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
    if (object.canAccept != null) {
      yield r'canAccept';
      yield serializers.serialize(
        object.canAccept,
        specifiedType: const FullType(bool),
      );
    }
    if (object.canRefuse != null) {
      yield r'canRefuse';
      yield serializers.serialize(
        object.canRefuse,
        specifiedType: const FullType(bool),
      );
    }
    if (object.canExtend != null) {
      yield r'canExtend';
      yield serializers.serialize(
        object.canExtend,
        specifiedType: const FullType(bool),
      );
    }
    if (object.canCancel != null) {
      yield r'canCancel';
      yield serializers.serialize(
        object.canCancel,
        specifiedType: const FullType(bool),
      );
    }
    if (object.canDraftContract != null) {
      yield r'canDraftContract';
      yield serializers.serialize(
        object.canDraftContract,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReservationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReservationResponseBuilder result,
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
        case r'userAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.userAccountId = valueDes;
          break;
        case r'client':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ParticipantSummary),
          ) as ParticipantSummary?;
          if (valueDes == null) continue;
          result.client.replace(valueDes);
          break;
        case r'prestataire':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ParticipantSummary),
          ) as ParticipantSummary?;
          if (valueDes == null) continue;
          result.prestataire.replace(valueDes);
          break;
        case r'desiredStartDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.desiredStartDate = valueDes;
          break;
        case r'durationUnits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.durationUnits = valueDes;
          break;
        case r'rentalPeriod':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ReservationResponseRentalPeriodEnum),
          ) as ReservationResponseRentalPeriodEnum?;
          if (valueDes == null) continue;
          result.rentalPeriod = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.message = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ReservationResponseStatusEnum),
          ) as ReservationResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.expiresAt = valueDes;
          break;
        case r'reservedUntil':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.reservedUntil = valueDes;
          break;
        case r'extended':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.extended = valueDes;
          break;
        case r'ownerReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ReservationResponseOwnerReasonEnum),
          ) as ReservationResponseOwnerReasonEnum?;
          if (valueDes == null) continue;
          result.ownerReason = valueDes;
          break;
        case r'ownerNote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.ownerNote = valueDes;
          break;
        case r'cancelledBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ReservationResponseCancelledByEnum),
          ) as ReservationResponseCancelledByEnum?;
          if (valueDes == null) continue;
          result.cancelledBy = valueDes;
          break;
        case r'conversationId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.conversationId = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'answeredAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.answeredAt = valueDes;
          break;
        case r'canAccept':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canAccept = valueDes;
          break;
        case r'canRefuse':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canRefuse = valueDes;
          break;
        case r'canExtend':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canExtend = valueDes;
          break;
        case r'canCancel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canCancel = valueDes;
          break;
        case r'canDraftContract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canDraftContract = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReservationResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReservationResponseBuilder();
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

class ReservationResponseRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DAY')
  static const ReservationResponseRentalPeriodEnum DAY = _$reservationResponseRentalPeriodEnum_DAY;
  @BuiltValueEnumConst(wireName: r'WEEK')
  static const ReservationResponseRentalPeriodEnum WEEK = _$reservationResponseRentalPeriodEnum_WEEK;
  @BuiltValueEnumConst(wireName: r'MONTH')
  static const ReservationResponseRentalPeriodEnum MONTH = _$reservationResponseRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const ReservationResponseRentalPeriodEnum QUARTER = _$reservationResponseRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const ReservationResponseRentalPeriodEnum YEAR = _$reservationResponseRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ReservationResponseRentalPeriodEnum unknownDefaultOpenApi = _$reservationResponseRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<ReservationResponseRentalPeriodEnum> get serializer => _$reservationResponseRentalPeriodEnumSerializer;

  const ReservationResponseRentalPeriodEnum._(String name): super(name);

  static BuiltSet<ReservationResponseRentalPeriodEnum> get values => _$reservationResponseRentalPeriodEnumValues;
  static ReservationResponseRentalPeriodEnum valueOf(String name) => _$reservationResponseRentalPeriodEnumValueOf(name);
}

class ReservationResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const ReservationResponseStatusEnum PENDING = _$reservationResponseStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'ACCEPTED')
  static const ReservationResponseStatusEnum ACCEPTED = _$reservationResponseStatusEnum_ACCEPTED;
  @BuiltValueEnumConst(wireName: r'REFUSED')
  static const ReservationResponseStatusEnum REFUSED = _$reservationResponseStatusEnum_REFUSED;
  @BuiltValueEnumConst(wireName: r'NOT_RETAINED')
  static const ReservationResponseStatusEnum NOT_RETAINED = _$reservationResponseStatusEnum_NOT_RETAINED;
  @BuiltValueEnumConst(wireName: r'EXPIRED')
  static const ReservationResponseStatusEnum EXPIRED = _$reservationResponseStatusEnum_EXPIRED;
  @BuiltValueEnumConst(wireName: r'CANCELLED')
  static const ReservationResponseStatusEnum CANCELLED = _$reservationResponseStatusEnum_CANCELLED;
  @BuiltValueEnumConst(wireName: r'LAPSED')
  static const ReservationResponseStatusEnum LAPSED = _$reservationResponseStatusEnum_LAPSED;
  @BuiltValueEnumConst(wireName: r'CONTRACTED')
  static const ReservationResponseStatusEnum CONTRACTED = _$reservationResponseStatusEnum_CONTRACTED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ReservationResponseStatusEnum unknownDefaultOpenApi = _$reservationResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<ReservationResponseStatusEnum> get serializer => _$reservationResponseStatusEnumSerializer;

  const ReservationResponseStatusEnum._(String name): super(name);

  static BuiltSet<ReservationResponseStatusEnum> get values => _$reservationResponseStatusEnumValues;
  static ReservationResponseStatusEnum valueOf(String name) => _$reservationResponseStatusEnumValueOf(name);
}

class ReservationResponseOwnerReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'RESERVED_ELSEWHERE')
  static const ReservationResponseOwnerReasonEnum RESERVED_ELSEWHERE = _$reservationResponseOwnerReasonEnum_RESERVED_ELSEWHERE;
  @BuiltValueEnumConst(wireName: r'PROFILE_NOT_RETAINED')
  static const ReservationResponseOwnerReasonEnum PROFILE_NOT_RETAINED = _$reservationResponseOwnerReasonEnum_PROFILE_NOT_RETAINED;
  @BuiltValueEnumConst(wireName: r'DATES_INCOMPATIBLE')
  static const ReservationResponseOwnerReasonEnum DATES_INCOMPATIBLE = _$reservationResponseOwnerReasonEnum_DATES_INCOMPATIBLE;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const ReservationResponseOwnerReasonEnum OTHER = _$reservationResponseOwnerReasonEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ReservationResponseOwnerReasonEnum unknownDefaultOpenApi = _$reservationResponseOwnerReasonEnum_unknownDefaultOpenApi;

  static Serializer<ReservationResponseOwnerReasonEnum> get serializer => _$reservationResponseOwnerReasonEnumSerializer;

  const ReservationResponseOwnerReasonEnum._(String name): super(name);

  static BuiltSet<ReservationResponseOwnerReasonEnum> get values => _$reservationResponseOwnerReasonEnumValues;
  static ReservationResponseOwnerReasonEnum valueOf(String name) => _$reservationResponseOwnerReasonEnumValueOf(name);
}

class ReservationResponseCancelledByEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CLIENT')
  static const ReservationResponseCancelledByEnum CLIENT = _$reservationResponseCancelledByEnum_CLIENT;
  @BuiltValueEnumConst(wireName: r'PRESTATAIRE')
  static const ReservationResponseCancelledByEnum PRESTATAIRE = _$reservationResponseCancelledByEnum_PRESTATAIRE;
  @BuiltValueEnumConst(wireName: r'SYSTEM')
  static const ReservationResponseCancelledByEnum SYSTEM = _$reservationResponseCancelledByEnum_SYSTEM;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ReservationResponseCancelledByEnum unknownDefaultOpenApi = _$reservationResponseCancelledByEnum_unknownDefaultOpenApi;

  static Serializer<ReservationResponseCancelledByEnum> get serializer => _$reservationResponseCancelledByEnumSerializer;

  const ReservationResponseCancelledByEnum._(String name): super(name);

  static BuiltSet<ReservationResponseCancelledByEnum> get values => _$reservationResponseCancelledByEnumValues;
  static ReservationResponseCancelledByEnum valueOf(String name) => _$reservationResponseCancelledByEnumValueOf(name);
}

