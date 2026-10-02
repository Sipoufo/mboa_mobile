//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/residence_stats.dart';
import 'package:api_client/src/model/listing_stats.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_item.g.dart';

/// DashboardItem
///
/// Properties:
/// * [type] 
/// * [listing] 
/// * [residence] 
@BuiltValue()
abstract class DashboardItem implements Built<DashboardItem, DashboardItemBuilder> {
  @BuiltValueField(wireName: r'type')
  DashboardItemTypeEnum? get type;
  // enum typeEnum {  LISTING,  RESIDENCE,  };

  @BuiltValueField(wireName: r'listing')
  ListingStats? get listing;

  @BuiltValueField(wireName: r'residence')
  ResidenceStats? get residence;

  DashboardItem._();

  factory DashboardItem([void updates(DashboardItemBuilder b)]) = _$DashboardItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DashboardItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DashboardItem> get serializer => _$DashboardItemSerializer();
}

class _$DashboardItemSerializer implements PrimitiveSerializer<DashboardItem> {
  @override
  final Iterable<Type> types = const [DashboardItem, _$DashboardItem];

  @override
  final String wireName = r'DashboardItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DashboardItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(DashboardItemTypeEnum),
      );
    }
    if (object.listing != null) {
      yield r'listing';
      yield serializers.serialize(
        object.listing,
        specifiedType: const FullType(ListingStats),
      );
    }
    if (object.residence != null) {
      yield r'residence';
      yield serializers.serialize(
        object.residence,
        specifiedType: const FullType(ResidenceStats),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DashboardItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DashboardItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DashboardItemTypeEnum),
          ) as DashboardItemTypeEnum?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
        case r'listing':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ListingStats),
          ) as ListingStats?;
          if (valueDes == null) continue;
          result.listing.replace(valueDes);
          break;
        case r'residence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ResidenceStats),
          ) as ResidenceStats?;
          if (valueDes == null) continue;
          result.residence.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DashboardItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DashboardItemBuilder();
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

class DashboardItemTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LISTING')
  static const DashboardItemTypeEnum LISTING = _$dashboardItemTypeEnum_LISTING;
  @BuiltValueEnumConst(wireName: r'RESIDENCE')
  static const DashboardItemTypeEnum RESIDENCE = _$dashboardItemTypeEnum_RESIDENCE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DashboardItemTypeEnum unknownDefaultOpenApi = _$dashboardItemTypeEnum_unknownDefaultOpenApi;

  static Serializer<DashboardItemTypeEnum> get serializer => _$dashboardItemTypeEnumSerializer;

  const DashboardItemTypeEnum._(String name): super(name);

  static BuiltSet<DashboardItemTypeEnum> get values => _$dashboardItemTypeEnumValues;
  static DashboardItemTypeEnum valueOf(String name) => _$dashboardItemTypeEnumValueOf(name);
}

