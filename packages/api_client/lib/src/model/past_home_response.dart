//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/past_home_expenses.dart';
import 'package:api_client/src/model/past_home_review.dart';
import 'package:api_client/src/model/home_summary.dart';
import 'package:api_client/src/model/property_rating.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'past_home_response.g.dart';

/// PastHomeResponse
///
/// Properties:
/// * [home] 
/// * [listingOnline] 
/// * [verificationCode] 
/// * [expenses] 
/// * [requestCount] 
/// * [openRequestCount] 
/// * [rating] 
/// * [myReview] 
@BuiltValue()
abstract class PastHomeResponse implements Built<PastHomeResponse, PastHomeResponseBuilder> {
  @BuiltValueField(wireName: r'home')
  HomeSummary? get home;

  @BuiltValueField(wireName: r'listingOnline')
  bool? get listingOnline;

  @BuiltValueField(wireName: r'verificationCode')
  String? get verificationCode;

  @BuiltValueField(wireName: r'expenses')
  PastHomeExpenses? get expenses;

  @BuiltValueField(wireName: r'requestCount')
  int? get requestCount;

  @BuiltValueField(wireName: r'openRequestCount')
  int? get openRequestCount;

  @BuiltValueField(wireName: r'rating')
  PropertyRating? get rating;

  @BuiltValueField(wireName: r'myReview')
  PastHomeReview? get myReview;

  PastHomeResponse._();

  factory PastHomeResponse([void updates(PastHomeResponseBuilder b)]) = _$PastHomeResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PastHomeResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PastHomeResponse> get serializer => _$PastHomeResponseSerializer();
}

class _$PastHomeResponseSerializer implements PrimitiveSerializer<PastHomeResponse> {
  @override
  final Iterable<Type> types = const [PastHomeResponse, _$PastHomeResponse];

  @override
  final String wireName = r'PastHomeResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PastHomeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.home != null) {
      yield r'home';
      yield serializers.serialize(
        object.home,
        specifiedType: const FullType(HomeSummary),
      );
    }
    if (object.listingOnline != null) {
      yield r'listingOnline';
      yield serializers.serialize(
        object.listingOnline,
        specifiedType: const FullType(bool),
      );
    }
    if (object.verificationCode != null) {
      yield r'verificationCode';
      yield serializers.serialize(
        object.verificationCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.expenses != null) {
      yield r'expenses';
      yield serializers.serialize(
        object.expenses,
        specifiedType: const FullType(PastHomeExpenses),
      );
    }
    if (object.requestCount != null) {
      yield r'requestCount';
      yield serializers.serialize(
        object.requestCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.openRequestCount != null) {
      yield r'openRequestCount';
      yield serializers.serialize(
        object.openRequestCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.rating != null) {
      yield r'rating';
      yield serializers.serialize(
        object.rating,
        specifiedType: const FullType(PropertyRating),
      );
    }
    if (object.myReview != null) {
      yield r'myReview';
      yield serializers.serialize(
        object.myReview,
        specifiedType: const FullType(PastHomeReview),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PastHomeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PastHomeResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'home':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HomeSummary),
          ) as HomeSummary?;
          if (valueDes == null) continue;
          result.home.replace(valueDes);
          break;
        case r'listingOnline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.listingOnline = valueDes;
          break;
        case r'verificationCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.verificationCode = valueDes;
          break;
        case r'expenses':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PastHomeExpenses),
          ) as PastHomeExpenses?;
          if (valueDes == null) continue;
          result.expenses.replace(valueDes);
          break;
        case r'requestCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.requestCount = valueDes;
          break;
        case r'openRequestCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.openRequestCount = valueDes;
          break;
        case r'rating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PropertyRating),
          ) as PropertyRating?;
          if (valueDes == null) continue;
          result.rating.replace(valueDes);
          break;
        case r'myReview':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PastHomeReview),
          ) as PastHomeReview?;
          if (valueDes == null) continue;
          result.myReview.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PastHomeResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PastHomeResponseBuilder();
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

