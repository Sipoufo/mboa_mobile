//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_user_profile_request.g.dart';

/// UpdateUserProfileRequest
///
/// Properties:
/// * [firstName] 
/// * [lastName] 
/// * [searchCityId] 
/// * [photoObjectKey] 
/// * [cniNumber] 
@BuiltValue()
abstract class UpdateUserProfileRequest implements Built<UpdateUserProfileRequest, UpdateUserProfileRequestBuilder> {
  @BuiltValueField(wireName: r'firstName')
  String? get firstName;

  @BuiltValueField(wireName: r'lastName')
  String? get lastName;

  @BuiltValueField(wireName: r'searchCityId')
  String? get searchCityId;

  @BuiltValueField(wireName: r'photoObjectKey')
  String? get photoObjectKey;

  @BuiltValueField(wireName: r'cniNumber')
  String? get cniNumber;

  UpdateUserProfileRequest._();

  factory UpdateUserProfileRequest([void updates(UpdateUserProfileRequestBuilder b)]) = _$UpdateUserProfileRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateUserProfileRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateUserProfileRequest> get serializer => _$UpdateUserProfileRequestSerializer();
}

class _$UpdateUserProfileRequestSerializer implements PrimitiveSerializer<UpdateUserProfileRequest> {
  @override
  final Iterable<Type> types = const [UpdateUserProfileRequest, _$UpdateUserProfileRequest];

  @override
  final String wireName = r'UpdateUserProfileRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateUserProfileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.firstName != null) {
      yield r'firstName';
      yield serializers.serialize(
        object.firstName,
        specifiedType: const FullType(String),
      );
    }
    if (object.lastName != null) {
      yield r'lastName';
      yield serializers.serialize(
        object.lastName,
        specifiedType: const FullType(String),
      );
    }
    if (object.searchCityId != null) {
      yield r'searchCityId';
      yield serializers.serialize(
        object.searchCityId,
        specifiedType: const FullType(String),
      );
    }
    if (object.photoObjectKey != null) {
      yield r'photoObjectKey';
      yield serializers.serialize(
        object.photoObjectKey,
        specifiedType: const FullType(String),
      );
    }
    if (object.cniNumber != null) {
      yield r'cniNumber';
      yield serializers.serialize(
        object.cniNumber,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateUserProfileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateUserProfileRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'firstName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.firstName = valueDes;
          break;
        case r'lastName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.lastName = valueDes;
          break;
        case r'searchCityId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.searchCityId = valueDes;
          break;
        case r'photoObjectKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.photoObjectKey = valueDes;
          break;
        case r'cniNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.cniNumber = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateUserProfileRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateUserProfileRequestBuilder();
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

