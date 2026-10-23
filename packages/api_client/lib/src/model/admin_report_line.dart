//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_report_line.g.dart';

/// AdminReportLine
///
/// Properties:
/// * [reportId] 
/// * [targetType] 
/// * [targetId] 
/// * [reason] 
/// * [status] 
/// * [createdAt] 
/// * [reviewedAt] 
@BuiltValue()
abstract class AdminReportLine implements Built<AdminReportLine, AdminReportLineBuilder> {
  @BuiltValueField(wireName: r'reportId')
  String? get reportId;

  @BuiltValueField(wireName: r'targetType')
  AdminReportLineTargetTypeEnum? get targetType;
  // enum targetTypeEnum {  ANNONCE,  MESSAGE,  REVIEW,  CONTRACT,  DECLARATION,  EVIDENCE,  };

  @BuiltValueField(wireName: r'targetId')
  String? get targetId;

  @BuiltValueField(wireName: r'reason')
  AdminReportLineReasonEnum? get reason;
  // enum reasonEnum {  FRAUDULENT_LISTING,  ABNORMAL_PRICE,  INAPPROPRIATE_CONTENT,  HARASSMENT,  ASKED_FOR_MONEY,  DISPUTE,  };

  @BuiltValueField(wireName: r'status')
  AdminReportLineStatusEnum? get status;
  // enum statusEnum {  PENDING,  VALIDATED,  REJECTED,  };

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'reviewedAt')
  DateTime? get reviewedAt;

  AdminReportLine._();

  factory AdminReportLine([void updates(AdminReportLineBuilder b)]) = _$AdminReportLine;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminReportLineBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminReportLine> get serializer => _$AdminReportLineSerializer();
}

class _$AdminReportLineSerializer implements PrimitiveSerializer<AdminReportLine> {
  @override
  final Iterable<Type> types = const [AdminReportLine, _$AdminReportLine];

  @override
  final String wireName = r'AdminReportLine';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminReportLine object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.reportId != null) {
      yield r'reportId';
      yield serializers.serialize(
        object.reportId,
        specifiedType: const FullType(String),
      );
    }
    if (object.targetType != null) {
      yield r'targetType';
      yield serializers.serialize(
        object.targetType,
        specifiedType: const FullType(AdminReportLineTargetTypeEnum),
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
        specifiedType: const FullType(AdminReportLineReasonEnum),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(AdminReportLineStatusEnum),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.reviewedAt != null) {
      yield r'reviewedAt';
      yield serializers.serialize(
        object.reviewedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminReportLine object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminReportLineBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reportId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reportId = valueDes;
          break;
        case r'targetType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminReportLineTargetTypeEnum),
          ) as AdminReportLineTargetTypeEnum?;
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
            specifiedType: const FullType.nullable(AdminReportLineReasonEnum),
          ) as AdminReportLineReasonEnum?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminReportLineStatusEnum),
          ) as AdminReportLineStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'reviewedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.reviewedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminReportLine deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminReportLineBuilder();
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

class AdminReportLineTargetTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ANNONCE')
  static const AdminReportLineTargetTypeEnum ANNONCE = _$adminReportLineTargetTypeEnum_ANNONCE;
  @BuiltValueEnumConst(wireName: r'MESSAGE')
  static const AdminReportLineTargetTypeEnum MESSAGE = _$adminReportLineTargetTypeEnum_MESSAGE;
  @BuiltValueEnumConst(wireName: r'REVIEW')
  static const AdminReportLineTargetTypeEnum REVIEW = _$adminReportLineTargetTypeEnum_REVIEW;
  @BuiltValueEnumConst(wireName: r'CONTRACT')
  static const AdminReportLineTargetTypeEnum CONTRACT = _$adminReportLineTargetTypeEnum_CONTRACT;
  @BuiltValueEnumConst(wireName: r'DECLARATION')
  static const AdminReportLineTargetTypeEnum DECLARATION = _$adminReportLineTargetTypeEnum_DECLARATION;
  @BuiltValueEnumConst(wireName: r'EVIDENCE')
  static const AdminReportLineTargetTypeEnum EVIDENCE = _$adminReportLineTargetTypeEnum_EVIDENCE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminReportLineTargetTypeEnum unknownDefaultOpenApi = _$adminReportLineTargetTypeEnum_unknownDefaultOpenApi;

  static Serializer<AdminReportLineTargetTypeEnum> get serializer => _$adminReportLineTargetTypeEnumSerializer;

  const AdminReportLineTargetTypeEnum._(String name): super(name);

  static BuiltSet<AdminReportLineTargetTypeEnum> get values => _$adminReportLineTargetTypeEnumValues;
  static AdminReportLineTargetTypeEnum valueOf(String name) => _$adminReportLineTargetTypeEnumValueOf(name);
}

class AdminReportLineReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FRAUDULENT_LISTING')
  static const AdminReportLineReasonEnum FRAUDULENT_LISTING = _$adminReportLineReasonEnum_FRAUDULENT_LISTING;
  @BuiltValueEnumConst(wireName: r'ABNORMAL_PRICE')
  static const AdminReportLineReasonEnum ABNORMAL_PRICE = _$adminReportLineReasonEnum_ABNORMAL_PRICE;
  @BuiltValueEnumConst(wireName: r'INAPPROPRIATE_CONTENT')
  static const AdminReportLineReasonEnum INAPPROPRIATE_CONTENT = _$adminReportLineReasonEnum_INAPPROPRIATE_CONTENT;
  @BuiltValueEnumConst(wireName: r'HARASSMENT')
  static const AdminReportLineReasonEnum HARASSMENT = _$adminReportLineReasonEnum_HARASSMENT;
  @BuiltValueEnumConst(wireName: r'ASKED_FOR_MONEY')
  static const AdminReportLineReasonEnum ASKED_FOR_MONEY = _$adminReportLineReasonEnum_ASKED_FOR_MONEY;
  @BuiltValueEnumConst(wireName: r'DISPUTE')
  static const AdminReportLineReasonEnum DISPUTE = _$adminReportLineReasonEnum_DISPUTE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminReportLineReasonEnum unknownDefaultOpenApi = _$adminReportLineReasonEnum_unknownDefaultOpenApi;

  static Serializer<AdminReportLineReasonEnum> get serializer => _$adminReportLineReasonEnumSerializer;

  const AdminReportLineReasonEnum._(String name): super(name);

  static BuiltSet<AdminReportLineReasonEnum> get values => _$adminReportLineReasonEnumValues;
  static AdminReportLineReasonEnum valueOf(String name) => _$adminReportLineReasonEnumValueOf(name);
}

class AdminReportLineStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const AdminReportLineStatusEnum PENDING = _$adminReportLineStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'VALIDATED')
  static const AdminReportLineStatusEnum VALIDATED = _$adminReportLineStatusEnum_VALIDATED;
  @BuiltValueEnumConst(wireName: r'REJECTED')
  static const AdminReportLineStatusEnum REJECTED = _$adminReportLineStatusEnum_REJECTED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdminReportLineStatusEnum unknownDefaultOpenApi = _$adminReportLineStatusEnum_unknownDefaultOpenApi;

  static Serializer<AdminReportLineStatusEnum> get serializer => _$adminReportLineStatusEnumSerializer;

  const AdminReportLineStatusEnum._(String name): super(name);

  static BuiltSet<AdminReportLineStatusEnum> get values => _$adminReportLineStatusEnumValues;
  static AdminReportLineStatusEnum valueOf(String name) => _$adminReportLineStatusEnumValueOf(name);
}

