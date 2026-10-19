//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/termination_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'contract_tenancy_response.g.dart';

/// ContractTenancyResponse
///
/// Properties:
/// * [state] 
/// * [endsOn] 
/// * [canTerminate] 
/// * [earliestNoticeDate] 
/// * [termination] 
@BuiltValue()
abstract class ContractTenancyResponse implements Built<ContractTenancyResponse, ContractTenancyResponseBuilder> {
  @BuiltValueField(wireName: r'state')
  ContractTenancyResponseStateEnum? get state;
  // enum stateEnum {  UPCOMING,  RUNNING,  ENDED,  };

  @BuiltValueField(wireName: r'endsOn')
  Date? get endsOn;

  @BuiltValueField(wireName: r'canTerminate')
  bool? get canTerminate;

  @BuiltValueField(wireName: r'earliestNoticeDate')
  Date? get earliestNoticeDate;

  @BuiltValueField(wireName: r'termination')
  TerminationResponse? get termination;

  ContractTenancyResponse._();

  factory ContractTenancyResponse([void updates(ContractTenancyResponseBuilder b)]) = _$ContractTenancyResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ContractTenancyResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ContractTenancyResponse> get serializer => _$ContractTenancyResponseSerializer();
}

class _$ContractTenancyResponseSerializer implements PrimitiveSerializer<ContractTenancyResponse> {
  @override
  final Iterable<Type> types = const [ContractTenancyResponse, _$ContractTenancyResponse];

  @override
  final String wireName = r'ContractTenancyResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ContractTenancyResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.state != null) {
      yield r'state';
      yield serializers.serialize(
        object.state,
        specifiedType: const FullType(ContractTenancyResponseStateEnum),
      );
    }
    if (object.endsOn != null) {
      yield r'endsOn';
      yield serializers.serialize(
        object.endsOn,
        specifiedType: const FullType(Date),
      );
    }
    if (object.canTerminate != null) {
      yield r'canTerminate';
      yield serializers.serialize(
        object.canTerminate,
        specifiedType: const FullType(bool),
      );
    }
    if (object.earliestNoticeDate != null) {
      yield r'earliestNoticeDate';
      yield serializers.serialize(
        object.earliestNoticeDate,
        specifiedType: const FullType(Date),
      );
    }
    if (object.termination != null) {
      yield r'termination';
      yield serializers.serialize(
        object.termination,
        specifiedType: const FullType(TerminationResponse),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ContractTenancyResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ContractTenancyResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ContractTenancyResponseStateEnum),
          ) as ContractTenancyResponseStateEnum?;
          if (valueDes == null) continue;
          result.state = valueDes;
          break;
        case r'endsOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.endsOn = valueDes;
          break;
        case r'canTerminate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canTerminate = valueDes;
          break;
        case r'earliestNoticeDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.earliestNoticeDate = valueDes;
          break;
        case r'termination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TerminationResponse),
          ) as TerminationResponse?;
          if (valueDes == null) continue;
          result.termination.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ContractTenancyResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ContractTenancyResponseBuilder();
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

class ContractTenancyResponseStateEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'UPCOMING')
  static const ContractTenancyResponseStateEnum UPCOMING = _$contractTenancyResponseStateEnum_UPCOMING;
  @BuiltValueEnumConst(wireName: r'RUNNING')
  static const ContractTenancyResponseStateEnum RUNNING = _$contractTenancyResponseStateEnum_RUNNING;
  @BuiltValueEnumConst(wireName: r'ENDED')
  static const ContractTenancyResponseStateEnum ENDED = _$contractTenancyResponseStateEnum_ENDED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ContractTenancyResponseStateEnum unknownDefaultOpenApi = _$contractTenancyResponseStateEnum_unknownDefaultOpenApi;

  static Serializer<ContractTenancyResponseStateEnum> get serializer => _$contractTenancyResponseStateEnumSerializer;

  const ContractTenancyResponseStateEnum._(String name): super(name);

  static BuiltSet<ContractTenancyResponseStateEnum> get values => _$contractTenancyResponseStateEnumValues;
  static ContractTenancyResponseStateEnum valueOf(String name) => _$contractTenancyResponseStateEnumValueOf(name);
}

