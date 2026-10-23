//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/signalement_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/presigned_download.dart';
import 'package:api_client/src/model/declaration_response.dart';
import 'package:api_client/src/model/home_summary.dart';
import 'package:api_client/src/model/evidence_batch_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dispute_dossier.g.dart';

/// DisputeDossier
///
/// Properties:
/// * [report] 
/// * [raisedBy] 
/// * [home] 
/// * [declaration] 
/// * [declarationProofs] 
/// * [evidence] 
/// * [declarations] 
/// * [evidenceSendings] 
@BuiltValue()
abstract class DisputeDossier implements Built<DisputeDossier, DisputeDossierBuilder> {
  @BuiltValueField(wireName: r'report')
  SignalementResponse? get report;

  @BuiltValueField(wireName: r'raisedBy')
  DisputeDossierRaisedByEnum? get raisedBy;
  // enum raisedByEnum {  TENANT,  LANDLORD,  };

  @BuiltValueField(wireName: r'home')
  HomeSummary? get home;

  @BuiltValueField(wireName: r'declaration')
  DeclarationResponse? get declaration;

  @BuiltValueField(wireName: r'declarationProofs')
  BuiltList<PresignedDownload>? get declarationProofs;

  @BuiltValueField(wireName: r'evidence')
  EvidenceBatchResponse? get evidence;

  @BuiltValueField(wireName: r'declarations')
  BuiltList<DeclarationResponse>? get declarations;

  @BuiltValueField(wireName: r'evidenceSendings')
  BuiltList<EvidenceBatchResponse>? get evidenceSendings;

  DisputeDossier._();

  factory DisputeDossier([void updates(DisputeDossierBuilder b)]) = _$DisputeDossier;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DisputeDossierBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DisputeDossier> get serializer => _$DisputeDossierSerializer();
}

class _$DisputeDossierSerializer implements PrimitiveSerializer<DisputeDossier> {
  @override
  final Iterable<Type> types = const [DisputeDossier, _$DisputeDossier];

  @override
  final String wireName = r'DisputeDossier';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DisputeDossier object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.report != null) {
      yield r'report';
      yield serializers.serialize(
        object.report,
        specifiedType: const FullType(SignalementResponse),
      );
    }
    if (object.raisedBy != null) {
      yield r'raisedBy';
      yield serializers.serialize(
        object.raisedBy,
        specifiedType: const FullType(DisputeDossierRaisedByEnum),
      );
    }
    if (object.home != null) {
      yield r'home';
      yield serializers.serialize(
        object.home,
        specifiedType: const FullType(HomeSummary),
      );
    }
    if (object.declaration != null) {
      yield r'declaration';
      yield serializers.serialize(
        object.declaration,
        specifiedType: const FullType(DeclarationResponse),
      );
    }
    if (object.declarationProofs != null) {
      yield r'declarationProofs';
      yield serializers.serialize(
        object.declarationProofs,
        specifiedType: const FullType(BuiltList, [FullType(PresignedDownload)]),
      );
    }
    if (object.evidence != null) {
      yield r'evidence';
      yield serializers.serialize(
        object.evidence,
        specifiedType: const FullType(EvidenceBatchResponse),
      );
    }
    if (object.declarations != null) {
      yield r'declarations';
      yield serializers.serialize(
        object.declarations,
        specifiedType: const FullType(BuiltList, [FullType(DeclarationResponse)]),
      );
    }
    if (object.evidenceSendings != null) {
      yield r'evidenceSendings';
      yield serializers.serialize(
        object.evidenceSendings,
        specifiedType: const FullType(BuiltList, [FullType(EvidenceBatchResponse)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DisputeDossier object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DisputeDossierBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'report':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SignalementResponse),
          ) as SignalementResponse?;
          if (valueDes == null) continue;
          result.report.replace(valueDes);
          break;
        case r'raisedBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DisputeDossierRaisedByEnum),
          ) as DisputeDossierRaisedByEnum?;
          if (valueDes == null) continue;
          result.raisedBy = valueDes;
          break;
        case r'home':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HomeSummary),
          ) as HomeSummary?;
          if (valueDes == null) continue;
          result.home.replace(valueDes);
          break;
        case r'declaration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DeclarationResponse),
          ) as DeclarationResponse?;
          if (valueDes == null) continue;
          result.declaration.replace(valueDes);
          break;
        case r'declarationProofs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(PresignedDownload)]),
          ) as BuiltList<PresignedDownload>?;
          if (valueDes == null) continue;
          result.declarationProofs.replace(valueDes);
          break;
        case r'evidence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(EvidenceBatchResponse),
          ) as EvidenceBatchResponse?;
          if (valueDes == null) continue;
          result.evidence.replace(valueDes);
          break;
        case r'declarations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(DeclarationResponse)]),
          ) as BuiltList<DeclarationResponse>?;
          if (valueDes == null) continue;
          result.declarations.replace(valueDes);
          break;
        case r'evidenceSendings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(EvidenceBatchResponse)]),
          ) as BuiltList<EvidenceBatchResponse>?;
          if (valueDes == null) continue;
          result.evidenceSendings.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DisputeDossier deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DisputeDossierBuilder();
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

class DisputeDossierRaisedByEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'TENANT')
  static const DisputeDossierRaisedByEnum TENANT = _$disputeDossierRaisedByEnum_TENANT;
  @BuiltValueEnumConst(wireName: r'LANDLORD')
  static const DisputeDossierRaisedByEnum LANDLORD = _$disputeDossierRaisedByEnum_LANDLORD;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DisputeDossierRaisedByEnum unknownDefaultOpenApi = _$disputeDossierRaisedByEnum_unknownDefaultOpenApi;

  static Serializer<DisputeDossierRaisedByEnum> get serializer => _$disputeDossierRaisedByEnumSerializer;

  const DisputeDossierRaisedByEnum._(String name): super(name);

  static BuiltSet<DisputeDossierRaisedByEnum> get values => _$disputeDossierRaisedByEnumValues;
  static DisputeDossierRaisedByEnum valueOf(String name) => _$disputeDossierRaisedByEnumValueOf(name);
}

