//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'useful_contact_request.g.dart';

/// UsefulContactRequest
///
/// Properties:
/// * [name] 
/// * [role] 
/// * [phone] 
/// * [serviceProviderId] 
/// * [shared] 
/// * [annonceIds] 
@BuiltValue()
abstract class UsefulContactRequest implements Built<UsefulContactRequest, UsefulContactRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'role')
  String get role;

  @BuiltValueField(wireName: r'phone')
  String get phone;

  @BuiltValueField(wireName: r'serviceProviderId')
  String? get serviceProviderId;

  @BuiltValueField(wireName: r'shared')
  bool? get shared;

  @BuiltValueField(wireName: r'annonceIds')
  BuiltSet<String>? get annonceIds;

  UsefulContactRequest._();

  factory UsefulContactRequest([void updates(UsefulContactRequestBuilder b)]) = _$UsefulContactRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UsefulContactRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UsefulContactRequest> get serializer => _$UsefulContactRequestSerializer();
}

class _$UsefulContactRequestSerializer implements PrimitiveSerializer<UsefulContactRequest> {
  @override
  final Iterable<Type> types = const [UsefulContactRequest, _$UsefulContactRequest];

  @override
  final String wireName = r'UsefulContactRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UsefulContactRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(String),
    );
    yield r'phone';
    yield serializers.serialize(
      object.phone,
      specifiedType: const FullType(String),
    );
    if (object.serviceProviderId != null) {
      yield r'serviceProviderId';
      yield serializers.serialize(
        object.serviceProviderId,
        specifiedType: const FullType(String),
      );
    }
    if (object.shared != null) {
      yield r'shared';
      yield serializers.serialize(
        object.shared,
        specifiedType: const FullType(bool),
      );
    }
    if (object.annonceIds != null) {
      yield r'annonceIds';
      yield serializers.serialize(
        object.annonceIds,
        specifiedType: const FullType(BuiltSet, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UsefulContactRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UsefulContactRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.role = valueDes;
          break;
        case r'phone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.phone = valueDes;
          break;
        case r'serviceProviderId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.serviceProviderId = valueDes;
          break;
        case r'shared':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.shared = valueDes;
          break;
        case r'annonceIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>?;
          if (valueDes == null) continue;
          result.annonceIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UsefulContactRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UsefulContactRequestBuilder();
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

