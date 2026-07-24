//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'kyc_review_item.g.dart';

/// KycReviewItem
///
/// Properties:
/// * [id] 
/// * [accountId] 
/// * [status] 
/// * [submittedAt] 
/// * [idDocumentFrontUrl] 
/// * [idDocumentBackUrl] 
/// * [selfieUrl] 
@BuiltValue()
abstract class KycReviewItem implements Built<KycReviewItem, KycReviewItemBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'accountId')
  String? get accountId;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'submittedAt')
  DateTime? get submittedAt;

  @BuiltValueField(wireName: r'idDocumentFrontUrl')
  String? get idDocumentFrontUrl;

  @BuiltValueField(wireName: r'idDocumentBackUrl')
  String? get idDocumentBackUrl;

  @BuiltValueField(wireName: r'selfieUrl')
  String? get selfieUrl;

  KycReviewItem._();

  factory KycReviewItem([void updates(KycReviewItemBuilder b)]) = _$KycReviewItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KycReviewItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KycReviewItem> get serializer => _$KycReviewItemSerializer();
}

class _$KycReviewItemSerializer implements PrimitiveSerializer<KycReviewItem> {
  @override
  final Iterable<Type> types = const [KycReviewItem, _$KycReviewItem];

  @override
  final String wireName = r'KycReviewItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KycReviewItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.accountId != null) {
      yield r'accountId';
      yield serializers.serialize(
        object.accountId,
        specifiedType: const FullType(String),
      );
    }
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
    if (object.idDocumentFrontUrl != null) {
      yield r'idDocumentFrontUrl';
      yield serializers.serialize(
        object.idDocumentFrontUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.idDocumentBackUrl != null) {
      yield r'idDocumentBackUrl';
      yield serializers.serialize(
        object.idDocumentBackUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.selfieUrl != null) {
      yield r'selfieUrl';
      yield serializers.serialize(
        object.selfieUrl,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    KycReviewItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KycReviewItemBuilder result,
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
        case r'accountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.accountId = valueDes;
          break;
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
        case r'idDocumentFrontUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.idDocumentFrontUrl = valueDes;
          break;
        case r'idDocumentBackUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.idDocumentBackUrl = valueDes;
          break;
        case r'selfieUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.selfieUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  KycReviewItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KycReviewItemBuilder();
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

