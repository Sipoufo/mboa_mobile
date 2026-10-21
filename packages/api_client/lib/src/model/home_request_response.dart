//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/participant_summary.dart';
import 'package:api_client/src/model/home_request_event_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'home_request_response.g.dart';

/// HomeRequestResponse
///
/// Properties:
/// * [id] 
/// * [contractId] 
/// * [annonceId] 
/// * [annonceTitle] 
/// * [tenant] 
/// * [conversationId] 
/// * [type] 
/// * [title] 
/// * [description] 
/// * [status] 
/// * [photoKeys] 
/// * [photoUrls] 
/// * [history] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [canStart] 
/// * [canResolve] 
/// * [canClose] 
/// * [canReopen] 
@BuiltValue()
abstract class HomeRequestResponse implements Built<HomeRequestResponse, HomeRequestResponseBuilder> {
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

  @BuiltValueField(wireName: r'conversationId')
  String? get conversationId;

  @BuiltValueField(wireName: r'type')
  HomeRequestResponseTypeEnum? get type;
  // enum typeEnum {  REMARK,  MAINTENANCE,  QUESTION,  };

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'status')
  HomeRequestResponseStatusEnum? get status;
  // enum statusEnum {  SENT,  SEEN,  IN_PROGRESS,  RESOLVED,  CLOSED,  };

  @BuiltValueField(wireName: r'photoKeys')
  BuiltList<String>? get photoKeys;

  @BuiltValueField(wireName: r'photoUrls')
  BuiltList<String>? get photoUrls;

  @BuiltValueField(wireName: r'history')
  BuiltList<HomeRequestEventResponse>? get history;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updatedAt')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'canStart')
  bool? get canStart;

  @BuiltValueField(wireName: r'canResolve')
  bool? get canResolve;

  @BuiltValueField(wireName: r'canClose')
  bool? get canClose;

  @BuiltValueField(wireName: r'canReopen')
  bool? get canReopen;

  HomeRequestResponse._();

  factory HomeRequestResponse([void updates(HomeRequestResponseBuilder b)]) = _$HomeRequestResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HomeRequestResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HomeRequestResponse> get serializer => _$HomeRequestResponseSerializer();
}

class _$HomeRequestResponseSerializer implements PrimitiveSerializer<HomeRequestResponse> {
  @override
  final Iterable<Type> types = const [HomeRequestResponse, _$HomeRequestResponse];

  @override
  final String wireName = r'HomeRequestResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HomeRequestResponse object, {
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
    if (object.conversationId != null) {
      yield r'conversationId';
      yield serializers.serialize(
        object.conversationId,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(HomeRequestResponseTypeEnum),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(HomeRequestResponseStatusEnum),
      );
    }
    if (object.photoKeys != null) {
      yield r'photoKeys';
      yield serializers.serialize(
        object.photoKeys,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.photoUrls != null) {
      yield r'photoUrls';
      yield serializers.serialize(
        object.photoUrls,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.history != null) {
      yield r'history';
      yield serializers.serialize(
        object.history,
        specifiedType: const FullType(BuiltList, [FullType(HomeRequestEventResponse)]),
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
    if (object.canStart != null) {
      yield r'canStart';
      yield serializers.serialize(
        object.canStart,
        specifiedType: const FullType(bool),
      );
    }
    if (object.canResolve != null) {
      yield r'canResolve';
      yield serializers.serialize(
        object.canResolve,
        specifiedType: const FullType(bool),
      );
    }
    if (object.canClose != null) {
      yield r'canClose';
      yield serializers.serialize(
        object.canClose,
        specifiedType: const FullType(bool),
      );
    }
    if (object.canReopen != null) {
      yield r'canReopen';
      yield serializers.serialize(
        object.canReopen,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HomeRequestResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HomeRequestResponseBuilder result,
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
        case r'conversationId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.conversationId = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HomeRequestResponseTypeEnum),
          ) as HomeRequestResponseTypeEnum?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HomeRequestResponseStatusEnum),
          ) as HomeRequestResponseStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'photoKeys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.photoKeys.replace(valueDes);
          break;
        case r'photoUrls':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.photoUrls.replace(valueDes);
          break;
        case r'history':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(HomeRequestEventResponse)]),
          ) as BuiltList<HomeRequestEventResponse>?;
          if (valueDes == null) continue;
          result.history.replace(valueDes);
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
        case r'canStart':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canStart = valueDes;
          break;
        case r'canResolve':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canResolve = valueDes;
          break;
        case r'canClose':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canClose = valueDes;
          break;
        case r'canReopen':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canReopen = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HomeRequestResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HomeRequestResponseBuilder();
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

class HomeRequestResponseTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'REMARK')
  static const HomeRequestResponseTypeEnum REMARK = _$homeRequestResponseTypeEnum_REMARK;
  @BuiltValueEnumConst(wireName: r'MAINTENANCE')
  static const HomeRequestResponseTypeEnum MAINTENANCE = _$homeRequestResponseTypeEnum_MAINTENANCE;
  @BuiltValueEnumConst(wireName: r'QUESTION')
  static const HomeRequestResponseTypeEnum QUESTION = _$homeRequestResponseTypeEnum_QUESTION;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const HomeRequestResponseTypeEnum unknownDefaultOpenApi = _$homeRequestResponseTypeEnum_unknownDefaultOpenApi;

  static Serializer<HomeRequestResponseTypeEnum> get serializer => _$homeRequestResponseTypeEnumSerializer;

  const HomeRequestResponseTypeEnum._(String name): super(name);

  static BuiltSet<HomeRequestResponseTypeEnum> get values => _$homeRequestResponseTypeEnumValues;
  static HomeRequestResponseTypeEnum valueOf(String name) => _$homeRequestResponseTypeEnumValueOf(name);
}

class HomeRequestResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'SENT')
  static const HomeRequestResponseStatusEnum SENT = _$homeRequestResponseStatusEnum_SENT;
  @BuiltValueEnumConst(wireName: r'SEEN')
  static const HomeRequestResponseStatusEnum SEEN = _$homeRequestResponseStatusEnum_SEEN;
  @BuiltValueEnumConst(wireName: r'IN_PROGRESS')
  static const HomeRequestResponseStatusEnum IN_PROGRESS = _$homeRequestResponseStatusEnum_IN_PROGRESS;
  @BuiltValueEnumConst(wireName: r'RESOLVED')
  static const HomeRequestResponseStatusEnum RESOLVED = _$homeRequestResponseStatusEnum_RESOLVED;
  @BuiltValueEnumConst(wireName: r'CLOSED')
  static const HomeRequestResponseStatusEnum CLOSED = _$homeRequestResponseStatusEnum_CLOSED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const HomeRequestResponseStatusEnum unknownDefaultOpenApi = _$homeRequestResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<HomeRequestResponseStatusEnum> get serializer => _$homeRequestResponseStatusEnumSerializer;

  const HomeRequestResponseStatusEnum._(String name): super(name);

  static BuiltSet<HomeRequestResponseStatusEnum> get values => _$homeRequestResponseStatusEnumValues;
  static HomeRequestResponseStatusEnum valueOf(String name) => _$homeRequestResponseStatusEnumValueOf(name);
}

