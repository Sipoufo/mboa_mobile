//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/due.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/participant_summary.dart';
import 'package:api_client/src/model/home_deposit.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'home_summary.g.dart';

/// HomeSummary
///
/// Properties:
/// * [contractId] 
/// * [annonceId] 
/// * [annonceTitle] 
/// * [city] 
/// * [district] 
/// * [exactAddress] 
/// * [coverPhotoKey] 
/// * [prestataire] 
/// * [tenant] 
/// * [state] 
/// * [rent] 
/// * [rentalPeriod] 
/// * [chargesIncluded] 
/// * [depositAmount] 
/// * [deposit] 
/// * [startDate] 
/// * [endDate] 
/// * [tacitRenewal] 
/// * [nextDue] 
/// * [overdueCount] 
/// * [overdueAmount] 
/// * [residenceId] 
/// * [residenceName] 
@BuiltValue()
abstract class HomeSummary implements Built<HomeSummary, HomeSummaryBuilder> {
  @BuiltValueField(wireName: r'contractId')
  String? get contractId;

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

  @BuiltValueField(wireName: r'coverPhotoKey')
  String? get coverPhotoKey;

  @BuiltValueField(wireName: r'prestataire')
  ParticipantSummary? get prestataire;

  @BuiltValueField(wireName: r'tenant')
  ParticipantSummary? get tenant;

  @BuiltValueField(wireName: r'state')
  HomeSummaryStateEnum? get state;
  // enum stateEnum {  UPCOMING,  ACTIVE,  READ_ONLY,  };

  @BuiltValueField(wireName: r'rent')
  int? get rent;

  @BuiltValueField(wireName: r'rentalPeriod')
  HomeSummaryRentalPeriodEnum? get rentalPeriod;
  // enum rentalPeriodEnum {  DAY,  WEEK,  MONTH,  QUARTER,  YEAR,  };

  @BuiltValueField(wireName: r'chargesIncluded')
  bool? get chargesIncluded;

  @BuiltValueField(wireName: r'depositAmount')
  int? get depositAmount;

  @BuiltValueField(wireName: r'deposit')
  HomeDeposit? get deposit;

  @BuiltValueField(wireName: r'startDate')
  Date? get startDate;

  @BuiltValueField(wireName: r'endDate')
  Date? get endDate;

  @BuiltValueField(wireName: r'tacitRenewal')
  bool? get tacitRenewal;

  @BuiltValueField(wireName: r'nextDue')
  Due? get nextDue;

  @BuiltValueField(wireName: r'overdueCount')
  int? get overdueCount;

  @BuiltValueField(wireName: r'overdueAmount')
  int? get overdueAmount;

  @BuiltValueField(wireName: r'residenceId')
  String? get residenceId;

  @BuiltValueField(wireName: r'residenceName')
  String? get residenceName;

  HomeSummary._();

  factory HomeSummary([void updates(HomeSummaryBuilder b)]) = _$HomeSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HomeSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HomeSummary> get serializer => _$HomeSummarySerializer();
}

class _$HomeSummarySerializer implements PrimitiveSerializer<HomeSummary> {
  @override
  final Iterable<Type> types = const [HomeSummary, _$HomeSummary];

  @override
  final String wireName = r'HomeSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HomeSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    if (object.coverPhotoKey != null) {
      yield r'coverPhotoKey';
      yield serializers.serialize(
        object.coverPhotoKey,
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
    if (object.state != null) {
      yield r'state';
      yield serializers.serialize(
        object.state,
        specifiedType: const FullType(HomeSummaryStateEnum),
      );
    }
    if (object.rent != null) {
      yield r'rent';
      yield serializers.serialize(
        object.rent,
        specifiedType: const FullType(int),
      );
    }
    if (object.rentalPeriod != null) {
      yield r'rentalPeriod';
      yield serializers.serialize(
        object.rentalPeriod,
        specifiedType: const FullType(HomeSummaryRentalPeriodEnum),
      );
    }
    if (object.chargesIncluded != null) {
      yield r'chargesIncluded';
      yield serializers.serialize(
        object.chargesIncluded,
        specifiedType: const FullType(bool),
      );
    }
    if (object.depositAmount != null) {
      yield r'depositAmount';
      yield serializers.serialize(
        object.depositAmount,
        specifiedType: const FullType(int),
      );
    }
    if (object.deposit != null) {
      yield r'deposit';
      yield serializers.serialize(
        object.deposit,
        specifiedType: const FullType(HomeDeposit),
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
    if (object.tacitRenewal != null) {
      yield r'tacitRenewal';
      yield serializers.serialize(
        object.tacitRenewal,
        specifiedType: const FullType(bool),
      );
    }
    if (object.nextDue != null) {
      yield r'nextDue';
      yield serializers.serialize(
        object.nextDue,
        specifiedType: const FullType(Due),
      );
    }
    if (object.overdueCount != null) {
      yield r'overdueCount';
      yield serializers.serialize(
        object.overdueCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.overdueAmount != null) {
      yield r'overdueAmount';
      yield serializers.serialize(
        object.overdueAmount,
        specifiedType: const FullType(int),
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
    HomeSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HomeSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'coverPhotoKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.coverPhotoKey = valueDes;
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
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HomeSummaryStateEnum),
          ) as HomeSummaryStateEnum?;
          if (valueDes == null) continue;
          result.state = valueDes;
          break;
        case r'rent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.rent = valueDes;
          break;
        case r'rentalPeriod':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HomeSummaryRentalPeriodEnum),
          ) as HomeSummaryRentalPeriodEnum?;
          if (valueDes == null) continue;
          result.rentalPeriod = valueDes;
          break;
        case r'chargesIncluded':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.chargesIncluded = valueDes;
          break;
        case r'depositAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.depositAmount = valueDes;
          break;
        case r'deposit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HomeDeposit),
          ) as HomeDeposit?;
          if (valueDes == null) continue;
          result.deposit.replace(valueDes);
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
        case r'tacitRenewal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.tacitRenewal = valueDes;
          break;
        case r'nextDue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Due),
          ) as Due?;
          if (valueDes == null) continue;
          result.nextDue.replace(valueDes);
          break;
        case r'overdueCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.overdueCount = valueDes;
          break;
        case r'overdueAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.overdueAmount = valueDes;
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
  HomeSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HomeSummaryBuilder();
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

class HomeSummaryStateEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'UPCOMING')
  static const HomeSummaryStateEnum UPCOMING = _$homeSummaryStateEnum_UPCOMING;
  @BuiltValueEnumConst(wireName: r'ACTIVE')
  static const HomeSummaryStateEnum ACTIVE = _$homeSummaryStateEnum_ACTIVE;
  @BuiltValueEnumConst(wireName: r'READ_ONLY')
  static const HomeSummaryStateEnum READ_ONLY = _$homeSummaryStateEnum_READ_ONLY;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const HomeSummaryStateEnum unknownDefaultOpenApi = _$homeSummaryStateEnum_unknownDefaultOpenApi;

  static Serializer<HomeSummaryStateEnum> get serializer => _$homeSummaryStateEnumSerializer;

  const HomeSummaryStateEnum._(String name): super(name);

  static BuiltSet<HomeSummaryStateEnum> get values => _$homeSummaryStateEnumValues;
  static HomeSummaryStateEnum valueOf(String name) => _$homeSummaryStateEnumValueOf(name);
}

class HomeSummaryRentalPeriodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DAY')
  static const HomeSummaryRentalPeriodEnum DAY = _$homeSummaryRentalPeriodEnum_DAY;
  @BuiltValueEnumConst(wireName: r'WEEK')
  static const HomeSummaryRentalPeriodEnum WEEK = _$homeSummaryRentalPeriodEnum_WEEK;
  @BuiltValueEnumConst(wireName: r'MONTH')
  static const HomeSummaryRentalPeriodEnum MONTH = _$homeSummaryRentalPeriodEnum_MONTH;
  @BuiltValueEnumConst(wireName: r'QUARTER')
  static const HomeSummaryRentalPeriodEnum QUARTER = _$homeSummaryRentalPeriodEnum_QUARTER;
  @BuiltValueEnumConst(wireName: r'YEAR')
  static const HomeSummaryRentalPeriodEnum YEAR = _$homeSummaryRentalPeriodEnum_YEAR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const HomeSummaryRentalPeriodEnum unknownDefaultOpenApi = _$homeSummaryRentalPeriodEnum_unknownDefaultOpenApi;

  static Serializer<HomeSummaryRentalPeriodEnum> get serializer => _$homeSummaryRentalPeriodEnumSerializer;

  const HomeSummaryRentalPeriodEnum._(String name): super(name);

  static BuiltSet<HomeSummaryRentalPeriodEnum> get values => _$homeSummaryRentalPeriodEnumValues;
  static HomeSummaryRentalPeriodEnum valueOf(String name) => _$homeSummaryRentalPeriodEnumValueOf(name);
}

