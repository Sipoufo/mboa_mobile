//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_tenant_rating_response.g.dart';

/// AdminTenantRatingResponse
///
/// Properties:
/// * [contractId] 
/// * [tenantAccountId] 
/// * [prestataireAccountId] 
/// * [stars] 
/// * [comment] 
/// * [ratedAt] 
@BuiltValue()
abstract class AdminTenantRatingResponse implements Built<AdminTenantRatingResponse, AdminTenantRatingResponseBuilder> {
  @BuiltValueField(wireName: r'contractId')
  String? get contractId;

  @BuiltValueField(wireName: r'tenantAccountId')
  String? get tenantAccountId;

  @BuiltValueField(wireName: r'prestataireAccountId')
  String? get prestataireAccountId;

  @BuiltValueField(wireName: r'stars')
  int? get stars;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'ratedAt')
  DateTime? get ratedAt;

  AdminTenantRatingResponse._();

  factory AdminTenantRatingResponse([void updates(AdminTenantRatingResponseBuilder b)]) = _$AdminTenantRatingResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminTenantRatingResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminTenantRatingResponse> get serializer => _$AdminTenantRatingResponseSerializer();
}

class _$AdminTenantRatingResponseSerializer implements PrimitiveSerializer<AdminTenantRatingResponse> {
  @override
  final Iterable<Type> types = const [AdminTenantRatingResponse, _$AdminTenantRatingResponse];

  @override
  final String wireName = r'AdminTenantRatingResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminTenantRatingResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.contractId != null) {
      yield r'contractId';
      yield serializers.serialize(
        object.contractId,
        specifiedType: const FullType(String),
      );
    }
    if (object.tenantAccountId != null) {
      yield r'tenantAccountId';
      yield serializers.serialize(
        object.tenantAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.prestataireAccountId != null) {
      yield r'prestataireAccountId';
      yield serializers.serialize(
        object.prestataireAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.stars != null) {
      yield r'stars';
      yield serializers.serialize(
        object.stars,
        specifiedType: const FullType(int),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(String),
      );
    }
    if (object.ratedAt != null) {
      yield r'ratedAt';
      yield serializers.serialize(
        object.ratedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminTenantRatingResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminTenantRatingResponseBuilder result,
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
        case r'tenantAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.tenantAccountId = valueDes;
          break;
        case r'prestataireAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.prestataireAccountId = valueDes;
          break;
        case r'stars':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.stars = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        case r'ratedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.ratedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminTenantRatingResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminTenantRatingResponseBuilder();
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

