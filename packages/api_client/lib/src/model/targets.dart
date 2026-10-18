//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'targets.g.dart';

/// Targets
///
/// Properties:
/// * [activeListings] 
/// * [paidPrestataires] 
/// * [newPrestatairesPer30Days] 
/// * [conversionRate] 
/// * [mrr] 
/// * [monthlyChurn] 
@BuiltValue()
abstract class Targets implements Built<Targets, TargetsBuilder> {
  @BuiltValueField(wireName: r'activeListings')
  int? get activeListings;

  @BuiltValueField(wireName: r'paidPrestataires')
  int? get paidPrestataires;

  @BuiltValueField(wireName: r'newPrestatairesPer30Days')
  int? get newPrestatairesPer30Days;

  @BuiltValueField(wireName: r'conversionRate')
  double? get conversionRate;

  @BuiltValueField(wireName: r'mrr')
  int? get mrr;

  @BuiltValueField(wireName: r'monthlyChurn')
  double? get monthlyChurn;

  Targets._();

  factory Targets([void updates(TargetsBuilder b)]) = _$Targets;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TargetsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Targets> get serializer => _$TargetsSerializer();
}

class _$TargetsSerializer implements PrimitiveSerializer<Targets> {
  @override
  final Iterable<Type> types = const [Targets, _$Targets];

  @override
  final String wireName = r'Targets';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Targets object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.activeListings != null) {
      yield r'activeListings';
      yield serializers.serialize(
        object.activeListings,
        specifiedType: const FullType(int),
      );
    }
    if (object.paidPrestataires != null) {
      yield r'paidPrestataires';
      yield serializers.serialize(
        object.paidPrestataires,
        specifiedType: const FullType(int),
      );
    }
    if (object.newPrestatairesPer30Days != null) {
      yield r'newPrestatairesPer30Days';
      yield serializers.serialize(
        object.newPrestatairesPer30Days,
        specifiedType: const FullType(int),
      );
    }
    if (object.conversionRate != null) {
      yield r'conversionRate';
      yield serializers.serialize(
        object.conversionRate,
        specifiedType: const FullType(double),
      );
    }
    if (object.mrr != null) {
      yield r'mrr';
      yield serializers.serialize(
        object.mrr,
        specifiedType: const FullType(int),
      );
    }
    if (object.monthlyChurn != null) {
      yield r'monthlyChurn';
      yield serializers.serialize(
        object.monthlyChurn,
        specifiedType: const FullType(double),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Targets object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TargetsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'activeListings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.activeListings = valueDes;
          break;
        case r'paidPrestataires':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.paidPrestataires = valueDes;
          break;
        case r'newPrestatairesPer30Days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.newPrestatairesPer30Days = valueDes;
          break;
        case r'conversionRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.conversionRate = valueDes;
          break;
        case r'mrr':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.mrr = valueDes;
          break;
        case r'monthlyChurn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.monthlyChurn = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Targets deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TargetsBuilder();
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

