// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_metric.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DashboardMetricRequiredTierEnum _$dashboardMetricRequiredTierEnum_FREE =
    const DashboardMetricRequiredTierEnum._('FREE');
const DashboardMetricRequiredTierEnum
_$dashboardMetricRequiredTierEnum_BASIC_PLUS =
    const DashboardMetricRequiredTierEnum._('BASIC_PLUS');
const DashboardMetricRequiredTierEnum _$dashboardMetricRequiredTierEnum_PRO =
    const DashboardMetricRequiredTierEnum._('PRO');
const DashboardMetricRequiredTierEnum
_$dashboardMetricRequiredTierEnum_PRO_PLUS =
    const DashboardMetricRequiredTierEnum._('PRO_PLUS');
const DashboardMetricRequiredTierEnum
_$dashboardMetricRequiredTierEnum_unknownDefaultOpenApi =
    const DashboardMetricRequiredTierEnum._('unknownDefaultOpenApi');

DashboardMetricRequiredTierEnum _$dashboardMetricRequiredTierEnumValueOf(
  String name,
) {
  switch (name) {
    case 'FREE':
      return _$dashboardMetricRequiredTierEnum_FREE;
    case 'BASIC_PLUS':
      return _$dashboardMetricRequiredTierEnum_BASIC_PLUS;
    case 'PRO':
      return _$dashboardMetricRequiredTierEnum_PRO;
    case 'PRO_PLUS':
      return _$dashboardMetricRequiredTierEnum_PRO_PLUS;
    case 'unknownDefaultOpenApi':
      return _$dashboardMetricRequiredTierEnum_unknownDefaultOpenApi;
    default:
      return _$dashboardMetricRequiredTierEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DashboardMetricRequiredTierEnum>
_$dashboardMetricRequiredTierEnumValues =
    BuiltSet<DashboardMetricRequiredTierEnum>(
      const <DashboardMetricRequiredTierEnum>[
        _$dashboardMetricRequiredTierEnum_FREE,
        _$dashboardMetricRequiredTierEnum_BASIC_PLUS,
        _$dashboardMetricRequiredTierEnum_PRO,
        _$dashboardMetricRequiredTierEnum_PRO_PLUS,
        _$dashboardMetricRequiredTierEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<DashboardMetricRequiredTierEnum>
_$dashboardMetricRequiredTierEnumSerializer =
    _$DashboardMetricRequiredTierEnumSerializer();

class _$DashboardMetricRequiredTierEnumSerializer
    implements PrimitiveSerializer<DashboardMetricRequiredTierEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'FREE': 'FREE',
    'BASIC_PLUS': 'BASIC_PLUS',
    'PRO': 'PRO',
    'PRO_PLUS': 'PRO_PLUS',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'FREE': 'FREE',
    'BASIC_PLUS': 'BASIC_PLUS',
    'PRO': 'PRO',
    'PRO_PLUS': 'PRO_PLUS',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DashboardMetricRequiredTierEnum];
  @override
  final String wireName = 'DashboardMetricRequiredTierEnum';

  @override
  Object serialize(
    Serializers serializers,
    DashboardMetricRequiredTierEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DashboardMetricRequiredTierEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DashboardMetricRequiredTierEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DashboardMetric extends DashboardMetric {
  @override
  final num? value;
  @override
  final bool? locked;
  @override
  final DashboardMetricRequiredTierEnum? requiredTier;
  @override
  final bool? available;

  factory _$DashboardMetric([void Function(DashboardMetricBuilder)? updates]) =>
      (DashboardMetricBuilder()..update(updates))._build();

  _$DashboardMetric._({
    this.value,
    this.locked,
    this.requiredTier,
    this.available,
  }) : super._();
  @override
  DashboardMetric rebuild(void Function(DashboardMetricBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardMetricBuilder toBuilder() => DashboardMetricBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardMetric &&
        value == other.value &&
        locked == other.locked &&
        requiredTier == other.requiredTier &&
        available == other.available;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, locked.hashCode);
    _$hash = $jc(_$hash, requiredTier.hashCode);
    _$hash = $jc(_$hash, available.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardMetric')
          ..add('value', value)
          ..add('locked', locked)
          ..add('requiredTier', requiredTier)
          ..add('available', available))
        .toString();
  }
}

class DashboardMetricBuilder
    implements Builder<DashboardMetric, DashboardMetricBuilder> {
  _$DashboardMetric? _$v;

  num? _value;
  num? get value => _$this._value;
  set value(num? value) => _$this._value = value;

  bool? _locked;
  bool? get locked => _$this._locked;
  set locked(bool? locked) => _$this._locked = locked;

  DashboardMetricRequiredTierEnum? _requiredTier;
  DashboardMetricRequiredTierEnum? get requiredTier => _$this._requiredTier;
  set requiredTier(DashboardMetricRequiredTierEnum? requiredTier) =>
      _$this._requiredTier = requiredTier;

  bool? _available;
  bool? get available => _$this._available;
  set available(bool? available) => _$this._available = available;

  DashboardMetricBuilder() {
    DashboardMetric._defaults(this);
  }

  DashboardMetricBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _locked = $v.locked;
      _requiredTier = $v.requiredTier;
      _available = $v.available;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardMetric other) {
    _$v = other as _$DashboardMetric;
  }

  @override
  void update(void Function(DashboardMetricBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardMetric build() => _build();

  _$DashboardMetric _build() {
    final _$result =
        _$v ??
        _$DashboardMetric._(
          value: value,
          locked: locked,
          requiredTier: requiredTier,
          available: available,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
