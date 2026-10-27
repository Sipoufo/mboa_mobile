//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/kyc_address.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'kyc_status_response.g.dart';

/// KycStatusResponse
///
/// Properties:
/// * [status] 
/// * [submittedAt] 
/// * [reviewedAt] 
/// * [rejectionReason] 
/// * [nui] 
/// * [address] 
@BuiltValue()
abstract class KycStatusResponse implements Built<KycStatusResponse, KycStatusResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'submittedAt')
  DateTime? get submittedAt;

  @BuiltValueField(wireName: r'reviewedAt')
  DateTime? get reviewedAt;

  @BuiltValueField(wireName: r'rejectionReason')
  String? get rejectionReason;

  @BuiltValueField(wireName: r'nui')
  String? get nui;

  @BuiltValueField(wireName: r'address')
  KycAddress? get address;

  KycStatusResponse._();

  factory KycStatusResponse([void updates(KycStatusResponseBuilder b)]) = _$KycStatusResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KycStatusResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KycStatusResponse> get serializer => _$KycStatusResponseSerializer();
}

class _$KycStatusResponseSerializer implements PrimitiveSerializer<KycStatusResponse> {
  @override
  final Iterable<Type> types = const [KycStatusResponse, _$KycStatusResponse];

  @override
  final String wireName = r'KycStatusResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KycStatusResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.submittedAt != null) {
      yield r'submittedAt';
      yield serializers.serialize(
        object.submittedAt,
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
    if (object.rejectionReason != null) {
      yield r'rejectionReason';
      yield serializers.serialize(
        object.rejectionReason,
        specifiedType: const FullType(String),
      );
    }
    if (object.nui != null) {
      yield r'nui';
      yield serializers.serialize(
        object.nui,
        specifiedType: const FullType(String),
      );
    }
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType(KycAddress),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    KycStatusResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KycStatusResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'submittedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.submittedAt = valueDes;
          break;
        case r'reviewedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.reviewedAt = valueDes;
          break;
        case r'rejectionReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.rejectionReason = valueDes;
          break;
        case r'nui':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nui = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(KycAddress),
          ) as KycAddress?;
          if (valueDes == null) continue;
          result.address.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  KycStatusResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KycStatusResponseBuilder();
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

