//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/account_contract_history.dart';
import 'package:api_client/src/model/account_report_history.dart';
import 'package:api_client/src/model/admin_user_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/account_reservation_history.dart';
import 'package:api_client/src/model/kyc_status_response.dart';
import 'package:api_client/src/model/account_visit_history.dart';
import 'package:api_client/src/model/account_moderation_entry.dart';
import 'package:api_client/src/model/admin_mboa_score_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_user_detail.g.dart';

/// AdminUserDetail
///
/// Properties:
/// * [account] 
/// * [firstSignInAt] 
/// * [kyc] 
/// * [moderation] 
/// * [visits] 
/// * [contracts] 
/// * [reports] 
/// * [mboaScore] 
/// * [reservations] 
@BuiltValue()
abstract class AdminUserDetail implements Built<AdminUserDetail, AdminUserDetailBuilder> {
  @BuiltValueField(wireName: r'account')
  AdminUserSummary? get account;

  @BuiltValueField(wireName: r'firstSignInAt')
  DateTime? get firstSignInAt;

  @BuiltValueField(wireName: r'kyc')
  KycStatusResponse? get kyc;

  @BuiltValueField(wireName: r'moderation')
  BuiltList<AccountModerationEntry>? get moderation;

  @BuiltValueField(wireName: r'visits')
  AccountVisitHistory? get visits;

  @BuiltValueField(wireName: r'contracts')
  AccountContractHistory? get contracts;

  @BuiltValueField(wireName: r'reports')
  AccountReportHistory? get reports;

  @BuiltValueField(wireName: r'mboaScore')
  AdminMboaScoreResponse? get mboaScore;

  @BuiltValueField(wireName: r'reservations')
  AccountReservationHistory? get reservations;

  AdminUserDetail._();

  factory AdminUserDetail([void updates(AdminUserDetailBuilder b)]) = _$AdminUserDetail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminUserDetailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminUserDetail> get serializer => _$AdminUserDetailSerializer();
}

class _$AdminUserDetailSerializer implements PrimitiveSerializer<AdminUserDetail> {
  @override
  final Iterable<Type> types = const [AdminUserDetail, _$AdminUserDetail];

  @override
  final String wireName = r'AdminUserDetail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminUserDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.account != null) {
      yield r'account';
      yield serializers.serialize(
        object.account,
        specifiedType: const FullType(AdminUserSummary),
      );
    }
    if (object.firstSignInAt != null) {
      yield r'firstSignInAt';
      yield serializers.serialize(
        object.firstSignInAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.kyc != null) {
      yield r'kyc';
      yield serializers.serialize(
        object.kyc,
        specifiedType: const FullType(KycStatusResponse),
      );
    }
    if (object.moderation != null) {
      yield r'moderation';
      yield serializers.serialize(
        object.moderation,
        specifiedType: const FullType(BuiltList, [FullType(AccountModerationEntry)]),
      );
    }
    if (object.visits != null) {
      yield r'visits';
      yield serializers.serialize(
        object.visits,
        specifiedType: const FullType(AccountVisitHistory),
      );
    }
    if (object.contracts != null) {
      yield r'contracts';
      yield serializers.serialize(
        object.contracts,
        specifiedType: const FullType(AccountContractHistory),
      );
    }
    if (object.reports != null) {
      yield r'reports';
      yield serializers.serialize(
        object.reports,
        specifiedType: const FullType(AccountReportHistory),
      );
    }
    if (object.mboaScore != null) {
      yield r'mboaScore';
      yield serializers.serialize(
        object.mboaScore,
        specifiedType: const FullType(AdminMboaScoreResponse),
      );
    }
    if (object.reservations != null) {
      yield r'reservations';
      yield serializers.serialize(
        object.reservations,
        specifiedType: const FullType(AccountReservationHistory),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminUserDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminUserDetailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'account':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminUserSummary),
          ) as AdminUserSummary?;
          if (valueDes == null) continue;
          result.account.replace(valueDes);
          break;
        case r'firstSignInAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.firstSignInAt = valueDes;
          break;
        case r'kyc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(KycStatusResponse),
          ) as KycStatusResponse?;
          if (valueDes == null) continue;
          result.kyc.replace(valueDes);
          break;
        case r'moderation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(AccountModerationEntry)]),
          ) as BuiltList<AccountModerationEntry>?;
          if (valueDes == null) continue;
          result.moderation.replace(valueDes);
          break;
        case r'visits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AccountVisitHistory),
          ) as AccountVisitHistory?;
          if (valueDes == null) continue;
          result.visits.replace(valueDes);
          break;
        case r'contracts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AccountContractHistory),
          ) as AccountContractHistory?;
          if (valueDes == null) continue;
          result.contracts.replace(valueDes);
          break;
        case r'reports':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AccountReportHistory),
          ) as AccountReportHistory?;
          if (valueDes == null) continue;
          result.reports.replace(valueDes);
          break;
        case r'mboaScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminMboaScoreResponse),
          ) as AdminMboaScoreResponse?;
          if (valueDes == null) continue;
          result.mboaScore.replace(valueDes);
          break;
        case r'reservations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AccountReservationHistory),
          ) as AccountReservationHistory?;
          if (valueDes == null) continue;
          result.reservations.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminUserDetail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminUserDetailBuilder();
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

