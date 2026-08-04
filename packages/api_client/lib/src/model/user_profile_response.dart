//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_profile_response.g.dart';

/// UserProfileResponse
///
/// Properties:
/// * [id] 
/// * [firstName] 
/// * [lastName] 
/// * [searchCityId] 
/// * [searchCity] 
/// * [photoObjectKey] 
/// * [cniNumber] 
/// * [profileComplete] 
/// * [createdAt] 
@BuiltValue()
abstract class UserProfileResponse implements Built<UserProfileResponse, UserProfileResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'firstName')
  String? get firstName;

  @BuiltValueField(wireName: r'lastName')
  String? get lastName;

  @BuiltValueField(wireName: r'searchCityId')
  String? get searchCityId;

  @BuiltValueField(wireName: r'searchCity')
  String? get searchCity;

  @BuiltValueField(wireName: r'photoObjectKey')
  String? get photoObjectKey;

  @BuiltValueField(wireName: r'cniNumber')
  String? get cniNumber;

  @BuiltValueField(wireName: r'profileComplete')
  bool? get profileComplete;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  UserProfileResponse._();

  factory UserProfileResponse([void updates(UserProfileResponseBuilder b)]) = _$UserProfileResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserProfileResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserProfileResponse> get serializer => _$UserProfileResponseSerializer();
}

class _$UserProfileResponseSerializer implements PrimitiveSerializer<UserProfileResponse> {
  @override
  final Iterable<Type> types = const [UserProfileResponse, _$UserProfileResponse];

  @override
  final String wireName = r'UserProfileResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserProfileResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
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
    if (object.searchCity != null) {
      yield r'searchCity';
      yield serializers.serialize(
        object.searchCity,
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
    if (object.profileComplete != null) {
      yield r'profileComplete';
      yield serializers.serialize(
        object.profileComplete,
        specifiedType: const FullType(bool),
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
    UserProfileResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserProfileResponseBuilder result,
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
        case r'searchCity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.searchCity = valueDes;
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
        case r'profileComplete':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.profileComplete = valueDes;
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
  UserProfileResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserProfileResponseBuilder();
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

