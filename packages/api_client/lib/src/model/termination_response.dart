//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'termination_response.g.dart';

/// TerminationResponse
///
/// Properties:
/// * [id] 
/// * [requestedBy] 
/// * [mutual] 
/// * [reason] 
/// * [effectiveDate] 
/// * [status] 
/// * [requestedAt] 
/// * [answeredAt] 
/// * [canAnswer] 
/// * [canWithdraw] 
@BuiltValue()
abstract class TerminationResponse implements Built<TerminationResponse, TerminationResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'requestedBy')
  TerminationResponseRequestedByEnum? get requestedBy;
  // enum requestedByEnum {  PRESTATAIRE,  TENANT,  BOTH,  NOBODY,  };

  @BuiltValueField(wireName: r'mutual')
  bool? get mutual;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  @BuiltValueField(wireName: r'effectiveDate')
  Date? get effectiveDate;

  @BuiltValueField(wireName: r'status')
  TerminationResponseStatusEnum? get status;
  // enum statusEnum {  PROPOSED,  NOTIFIED,  CONFIRMED,  DECLINED,  WITHDRAWN,  };

  @BuiltValueField(wireName: r'requestedAt')
  DateTime? get requestedAt;

  @BuiltValueField(wireName: r'answeredAt')
  DateTime? get answeredAt;

  @BuiltValueField(wireName: r'canAnswer')
  bool? get canAnswer;

  @BuiltValueField(wireName: r'canWithdraw')
  bool? get canWithdraw;

  TerminationResponse._();

  factory TerminationResponse([void updates(TerminationResponseBuilder b)]) = _$TerminationResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TerminationResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TerminationResponse> get serializer => _$TerminationResponseSerializer();
}

class _$TerminationResponseSerializer implements PrimitiveSerializer<TerminationResponse> {
  @override
  final Iterable<Type> types = const [TerminationResponse, _$TerminationResponse];

  @override
  final String wireName = r'TerminationResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TerminationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.requestedBy != null) {
      yield r'requestedBy';
      yield serializers.serialize(
        object.requestedBy,
        specifiedType: const FullType(TerminationResponseRequestedByEnum),
      );
    }
    if (object.mutual != null) {
      yield r'mutual';
      yield serializers.serialize(
        object.mutual,
        specifiedType: const FullType(bool),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
    if (object.effectiveDate != null) {
      yield r'effectiveDate';
      yield serializers.serialize(
        object.effectiveDate,
        specifiedType: const FullType(Date),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(TerminationResponseStatusEnum),
      );
    }
    if (object.requestedAt != null) {
      yield r'requestedAt';
      yield serializers.serialize(
        object.requestedAt,
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
    if (object.canAnswer != null) {
      yield r'canAnswer';
      yield serializers.serialize(
        object.canAnswer,
        specifiedType: const FullType(bool),
      );
    }
    if (object.canWithdraw != null) {
      yield r'canWithdraw';
      yield serializers.serialize(
        object.canWithdraw,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TerminationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TerminationResponseBuilder result,
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
        case r'requestedBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TerminationResponseRequestedByEnum),
          ) as TerminationResponseRequestedByEnum?;
          if (valueDes == null) continue;
          result.requestedBy = valueDes;
          break;
        case r'mutual':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.mutual = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        case r'effectiveDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.effectiveDate = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TerminationResponseStatusEnum),
          ) as TerminationResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'requestedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.requestedAt = valueDes;
          break;
        case r'answeredAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.answeredAt = valueDes;
          break;
        case r'canAnswer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canAnswer = valueDes;
          break;
        case r'canWithdraw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canWithdraw = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TerminationResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TerminationResponseBuilder();
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

class TerminationResponseRequestedByEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PRESTATAIRE')
  static const TerminationResponseRequestedByEnum PRESTATAIRE = _$terminationResponseRequestedByEnum_PRESTATAIRE;
  @BuiltValueEnumConst(wireName: r'TENANT')
  static const TerminationResponseRequestedByEnum TENANT = _$terminationResponseRequestedByEnum_TENANT;
  @BuiltValueEnumConst(wireName: r'BOTH')
  static const TerminationResponseRequestedByEnum BOTH = _$terminationResponseRequestedByEnum_BOTH;
  @BuiltValueEnumConst(wireName: r'NOBODY')
  static const TerminationResponseRequestedByEnum NOBODY = _$terminationResponseRequestedByEnum_NOBODY;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TerminationResponseRequestedByEnum unknownDefaultOpenApi = _$terminationResponseRequestedByEnum_unknownDefaultOpenApi;

  static Serializer<TerminationResponseRequestedByEnum> get serializer => _$terminationResponseRequestedByEnumSerializer;

  const TerminationResponseRequestedByEnum._(String name): super(name);

  static BuiltSet<TerminationResponseRequestedByEnum> get values => _$terminationResponseRequestedByEnumValues;
  static TerminationResponseRequestedByEnum valueOf(String name) => _$terminationResponseRequestedByEnumValueOf(name);
}

class TerminationResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PROPOSED')
  static const TerminationResponseStatusEnum PROPOSED = _$terminationResponseStatusEnum_PROPOSED;
  @BuiltValueEnumConst(wireName: r'NOTIFIED')
  static const TerminationResponseStatusEnum NOTIFIED = _$terminationResponseStatusEnum_NOTIFIED;
  @BuiltValueEnumConst(wireName: r'CONFIRMED')
  static const TerminationResponseStatusEnum CONFIRMED = _$terminationResponseStatusEnum_CONFIRMED;
  @BuiltValueEnumConst(wireName: r'DECLINED')
  static const TerminationResponseStatusEnum DECLINED = _$terminationResponseStatusEnum_DECLINED;
  @BuiltValueEnumConst(wireName: r'WITHDRAWN')
  static const TerminationResponseStatusEnum WITHDRAWN = _$terminationResponseStatusEnum_WITHDRAWN;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TerminationResponseStatusEnum unknownDefaultOpenApi = _$terminationResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<TerminationResponseStatusEnum> get serializer => _$terminationResponseStatusEnumSerializer;

  const TerminationResponseStatusEnum._(String name): super(name);

  static BuiltSet<TerminationResponseStatusEnum> get values => _$terminationResponseStatusEnumValues;
  static TerminationResponseStatusEnum valueOf(String name) => _$terminationResponseStatusEnumValueOf(name);
}

