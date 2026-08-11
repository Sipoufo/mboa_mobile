//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'signalement_response.g.dart';

/// SignalementResponse
///
/// Properties:
/// * [id] 
/// * [targetType] 
/// * [targetId] 
/// * [reason] 
/// * [comment] 
/// * [status] 
/// * [reporterAccountId] 
/// * [reporterSuspect] 
/// * [targetValidatedCount] 
/// * [providerAlert] 
/// * [reviewedBy] 
/// * [reviewedAt] 
/// * [reviewNote] 
/// * [createdAt] 
@BuiltValue()
abstract class SignalementResponse implements Built<SignalementResponse, SignalementResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'targetType')
  SignalementResponseTargetTypeEnum? get targetType;
  // enum targetTypeEnum {  ANNONCE,  MESSAGE,  };

  @BuiltValueField(wireName: r'targetId')
  String? get targetId;

  @BuiltValueField(wireName: r'reason')
  SignalementResponseReasonEnum? get reason;
  // enum reasonEnum {  FRAUDULENT_LISTING,  ABNORMAL_PRICE,  INAPPROPRIATE_CONTENT,  HARASSMENT,  };

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'status')
  SignalementResponseStatusEnum? get status;
  // enum statusEnum {  PENDING,  VALIDATED,  REJECTED,  };

  @BuiltValueField(wireName: r'reporterAccountId')
  String? get reporterAccountId;

  @BuiltValueField(wireName: r'reporterSuspect')
  bool? get reporterSuspect;

  @BuiltValueField(wireName: r'targetValidatedCount')
  int? get targetValidatedCount;

  @BuiltValueField(wireName: r'providerAlert')
  bool? get providerAlert;

  @BuiltValueField(wireName: r'reviewedBy')
  String? get reviewedBy;

  @BuiltValueField(wireName: r'reviewedAt')
  DateTime? get reviewedAt;

  @BuiltValueField(wireName: r'reviewNote')
  String? get reviewNote;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  SignalementResponse._();

  factory SignalementResponse([void updates(SignalementResponseBuilder b)]) = _$SignalementResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SignalementResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SignalementResponse> get serializer => _$SignalementResponseSerializer();
}

class _$SignalementResponseSerializer implements PrimitiveSerializer<SignalementResponse> {
  @override
  final Iterable<Type> types = const [SignalementResponse, _$SignalementResponse];

  @override
  final String wireName = r'SignalementResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SignalementResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.targetType != null) {
      yield r'targetType';
      yield serializers.serialize(
        object.targetType,
        specifiedType: const FullType(SignalementResponseTargetTypeEnum),
      );
    }
    if (object.targetId != null) {
      yield r'targetId';
      yield serializers.serialize(
        object.targetId,
        specifiedType: const FullType(String),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(SignalementResponseReasonEnum),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(SignalementResponseStatusEnum),
      );
    }
    if (object.reporterAccountId != null) {
      yield r'reporterAccountId';
      yield serializers.serialize(
        object.reporterAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.reporterSuspect != null) {
      yield r'reporterSuspect';
      yield serializers.serialize(
        object.reporterSuspect,
        specifiedType: const FullType(bool),
      );
    }
    if (object.targetValidatedCount != null) {
      yield r'targetValidatedCount';
      yield serializers.serialize(
        object.targetValidatedCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.providerAlert != null) {
      yield r'providerAlert';
      yield serializers.serialize(
        object.providerAlert,
        specifiedType: const FullType(bool),
      );
    }
    if (object.reviewedBy != null) {
      yield r'reviewedBy';
      yield serializers.serialize(
        object.reviewedBy,
        specifiedType: const FullType(String),
      );
    }
    if (object.reviewedAt != null) {
      yield r'reviewedAt';
      yield serializers.serialize(
        object.reviewedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.reviewNote != null) {
      yield r'reviewNote';
      yield serializers.serialize(
        object.reviewNote,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    SignalementResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SignalementResponseBuilder result,
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
        case r'targetType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SignalementResponseTargetTypeEnum),
          ) as SignalementResponseTargetTypeEnum?;
          if (valueDes == null) continue;
          result.targetType = valueDes;
          break;
        case r'targetId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.targetId = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SignalementResponseReasonEnum),
          ) as SignalementResponseReasonEnum?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SignalementResponseStatusEnum),
          ) as SignalementResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'reporterAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reporterAccountId = valueDes;
          break;
        case r'reporterSuspect':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.reporterSuspect = valueDes;
          break;
        case r'targetValidatedCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.targetValidatedCount = valueDes;
          break;
        case r'providerAlert':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.providerAlert = valueDes;
          break;
        case r'reviewedBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reviewedBy = valueDes;
          break;
        case r'reviewedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.reviewedAt = valueDes;
          break;
        case r'reviewNote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reviewNote = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SignalementResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SignalementResponseBuilder();
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

class SignalementResponseTargetTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ANNONCE')
  static const SignalementResponseTargetTypeEnum ANNONCE = _$signalementResponseTargetTypeEnum_ANNONCE;
  @BuiltValueEnumConst(wireName: r'MESSAGE')
  static const SignalementResponseTargetTypeEnum MESSAGE = _$signalementResponseTargetTypeEnum_MESSAGE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SignalementResponseTargetTypeEnum unknownDefaultOpenApi = _$signalementResponseTargetTypeEnum_unknownDefaultOpenApi;

  static Serializer<SignalementResponseTargetTypeEnum> get serializer => _$signalementResponseTargetTypeEnumSerializer;

  const SignalementResponseTargetTypeEnum._(String name): super(name);

  static BuiltSet<SignalementResponseTargetTypeEnum> get values => _$signalementResponseTargetTypeEnumValues;
  static SignalementResponseTargetTypeEnum valueOf(String name) => _$signalementResponseTargetTypeEnumValueOf(name);
}

class SignalementResponseReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FRAUDULENT_LISTING')
  static const SignalementResponseReasonEnum FRAUDULENT_LISTING = _$signalementResponseReasonEnum_FRAUDULENT_LISTING;
  @BuiltValueEnumConst(wireName: r'ABNORMAL_PRICE')
  static const SignalementResponseReasonEnum ABNORMAL_PRICE = _$signalementResponseReasonEnum_ABNORMAL_PRICE;
  @BuiltValueEnumConst(wireName: r'INAPPROPRIATE_CONTENT')
  static const SignalementResponseReasonEnum INAPPROPRIATE_CONTENT = _$signalementResponseReasonEnum_INAPPROPRIATE_CONTENT;
  @BuiltValueEnumConst(wireName: r'HARASSMENT')
  static const SignalementResponseReasonEnum HARASSMENT = _$signalementResponseReasonEnum_HARASSMENT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SignalementResponseReasonEnum unknownDefaultOpenApi = _$signalementResponseReasonEnum_unknownDefaultOpenApi;

  static Serializer<SignalementResponseReasonEnum> get serializer => _$signalementResponseReasonEnumSerializer;

  const SignalementResponseReasonEnum._(String name): super(name);

  static BuiltSet<SignalementResponseReasonEnum> get values => _$signalementResponseReasonEnumValues;
  static SignalementResponseReasonEnum valueOf(String name) => _$signalementResponseReasonEnumValueOf(name);
}

class SignalementResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const SignalementResponseStatusEnum PENDING = _$signalementResponseStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'VALIDATED')
  static const SignalementResponseStatusEnum VALIDATED = _$signalementResponseStatusEnum_VALIDATED;
  @BuiltValueEnumConst(wireName: r'REJECTED')
  static const SignalementResponseStatusEnum REJECTED = _$signalementResponseStatusEnum_REJECTED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SignalementResponseStatusEnum unknownDefaultOpenApi = _$signalementResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<SignalementResponseStatusEnum> get serializer => _$signalementResponseStatusEnumSerializer;

  const SignalementResponseStatusEnum._(String name): super(name);

  static BuiltSet<SignalementResponseStatusEnum> get values => _$signalementResponseStatusEnumValues;
  static SignalementResponseStatusEnum valueOf(String name) => _$signalementResponseStatusEnumValueOf(name);
}

