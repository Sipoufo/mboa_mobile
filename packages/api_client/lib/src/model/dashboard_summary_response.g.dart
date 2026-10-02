// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_summary_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DashboardSummaryResponseTierEnum _$dashboardSummaryResponseTierEnum_FREE =
    const DashboardSummaryResponseTierEnum._('FREE');
const DashboardSummaryResponseTierEnum
_$dashboardSummaryResponseTierEnum_BASIC_PLUS =
    const DashboardSummaryResponseTierEnum._('BASIC_PLUS');
const DashboardSummaryResponseTierEnum _$dashboardSummaryResponseTierEnum_PRO =
    const DashboardSummaryResponseTierEnum._('PRO');
const DashboardSummaryResponseTierEnum
_$dashboardSummaryResponseTierEnum_PRO_PLUS =
    const DashboardSummaryResponseTierEnum._('PRO_PLUS');
const DashboardSummaryResponseTierEnum
_$dashboardSummaryResponseTierEnum_unknownDefaultOpenApi =
    const DashboardSummaryResponseTierEnum._('unknownDefaultOpenApi');

DashboardSummaryResponseTierEnum _$dashboardSummaryResponseTierEnumValueOf(
  String name,
) {
  switch (name) {
    case 'FREE':
      return _$dashboardSummaryResponseTierEnum_FREE;
    case 'BASIC_PLUS':
      return _$dashboardSummaryResponseTierEnum_BASIC_PLUS;
    case 'PRO':
      return _$dashboardSummaryResponseTierEnum_PRO;
    case 'PRO_PLUS':
      return _$dashboardSummaryResponseTierEnum_PRO_PLUS;
    case 'unknownDefaultOpenApi':
      return _$dashboardSummaryResponseTierEnum_unknownDefaultOpenApi;
    default:
      return _$dashboardSummaryResponseTierEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DashboardSummaryResponseTierEnum>
_$dashboardSummaryResponseTierEnumValues =
    BuiltSet<DashboardSummaryResponseTierEnum>(
      const <DashboardSummaryResponseTierEnum>[
        _$dashboardSummaryResponseTierEnum_FREE,
        _$dashboardSummaryResponseTierEnum_BASIC_PLUS,
        _$dashboardSummaryResponseTierEnum_PRO,
        _$dashboardSummaryResponseTierEnum_PRO_PLUS,
        _$dashboardSummaryResponseTierEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<DashboardSummaryResponseTierEnum>
_$dashboardSummaryResponseTierEnumSerializer =
    _$DashboardSummaryResponseTierEnumSerializer();

class _$DashboardSummaryResponseTierEnumSerializer
    implements PrimitiveSerializer<DashboardSummaryResponseTierEnum> {
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
  final Iterable<Type> types = const <Type>[DashboardSummaryResponseTierEnum];
  @override
  final String wireName = 'DashboardSummaryResponseTierEnum';

  @override
  Object serialize(
    Serializers serializers,
    DashboardSummaryResponseTierEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DashboardSummaryResponseTierEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DashboardSummaryResponseTierEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DashboardSummaryResponse extends DashboardSummaryResponse {
  @override
  final DashboardSummaryResponseTierEnum? tier;
  @override
  final DashboardFigures? totals;
  @override
  final DashboardMetric? averagePosition;

  factory _$DashboardSummaryResponse([
    void Function(DashboardSummaryResponseBuilder)? updates,
  ]) => (DashboardSummaryResponseBuilder()..update(updates))._build();

  _$DashboardSummaryResponse._({this.tier, this.totals, this.averagePosition})
    : super._();
  @override
  DashboardSummaryResponse rebuild(
    void Function(DashboardSummaryResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DashboardSummaryResponseBuilder toBuilder() =>
      DashboardSummaryResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardSummaryResponse &&
        tier == other.tier &&
        totals == other.totals &&
        averagePosition == other.averagePosition;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, totals.hashCode);
    _$hash = $jc(_$hash, averagePosition.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardSummaryResponse')
          ..add('tier', tier)
          ..add('totals', totals)
          ..add('averagePosition', averagePosition))
        .toString();
  }
}

class DashboardSummaryResponseBuilder
    implements
        Builder<DashboardSummaryResponse, DashboardSummaryResponseBuilder> {
  _$DashboardSummaryResponse? _$v;

  DashboardSummaryResponseTierEnum? _tier;
  DashboardSummaryResponseTierEnum? get tier => _$this._tier;
  set tier(DashboardSummaryResponseTierEnum? tier) => _$this._tier = tier;

  DashboardFiguresBuilder? _totals;
  DashboardFiguresBuilder get totals =>
      _$this._totals ??= DashboardFiguresBuilder();
  set totals(DashboardFiguresBuilder? totals) => _$this._totals = totals;

  DashboardMetricBuilder? _averagePosition;
  DashboardMetricBuilder get averagePosition =>
      _$this._averagePosition ??= DashboardMetricBuilder();
  set averagePosition(DashboardMetricBuilder? averagePosition) =>
      _$this._averagePosition = averagePosition;

  DashboardSummaryResponseBuilder() {
    DashboardSummaryResponse._defaults(this);
  }

  DashboardSummaryResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tier = $v.tier;
      _totals = $v.totals?.toBuilder();
      _averagePosition = $v.averagePosition?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardSummaryResponse other) {
    _$v = other as _$DashboardSummaryResponse;
  }

  @override
  void update(void Function(DashboardSummaryResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardSummaryResponse build() => _build();

  _$DashboardSummaryResponse _build() {
    _$DashboardSummaryResponse _$result;
    try {
      _$result =
          _$v ??
          _$DashboardSummaryResponse._(
            tier: tier,
            totals: _totals?.build(),
            averagePosition: _averagePosition?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'totals';
        _totals?.build();
        _$failedField = 'averagePosition';
        _averagePosition?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DashboardSummaryResponse',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
