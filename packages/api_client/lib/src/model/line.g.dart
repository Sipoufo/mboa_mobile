// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LineTierEnum _$lineTierEnum_FREE = const LineTierEnum._('FREE');
const LineTierEnum _$lineTierEnum_BASIC_PLUS = const LineTierEnum._(
  'BASIC_PLUS',
);
const LineTierEnum _$lineTierEnum_PRO = const LineTierEnum._('PRO');
const LineTierEnum _$lineTierEnum_PRO_PLUS = const LineTierEnum._('PRO_PLUS');
const LineTierEnum _$lineTierEnum_unknownDefaultOpenApi = const LineTierEnum._(
  'unknownDefaultOpenApi',
);

LineTierEnum _$lineTierEnumValueOf(String name) {
  switch (name) {
    case 'FREE':
      return _$lineTierEnum_FREE;
    case 'BASIC_PLUS':
      return _$lineTierEnum_BASIC_PLUS;
    case 'PRO':
      return _$lineTierEnum_PRO;
    case 'PRO_PLUS':
      return _$lineTierEnum_PRO_PLUS;
    case 'unknownDefaultOpenApi':
      return _$lineTierEnum_unknownDefaultOpenApi;
    default:
      return _$lineTierEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LineTierEnum> _$lineTierEnumValues =
    BuiltSet<LineTierEnum>(const <LineTierEnum>[
      _$lineTierEnum_FREE,
      _$lineTierEnum_BASIC_PLUS,
      _$lineTierEnum_PRO,
      _$lineTierEnum_PRO_PLUS,
      _$lineTierEnum_unknownDefaultOpenApi,
    ]);

Serializer<LineTierEnum> _$lineTierEnumSerializer = _$LineTierEnumSerializer();

class _$LineTierEnumSerializer implements PrimitiveSerializer<LineTierEnum> {
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
  final Iterable<Type> types = const <Type>[LineTierEnum];
  @override
  final String wireName = 'LineTierEnum';

  @override
  Object serialize(
    Serializers serializers,
    LineTierEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  LineTierEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => LineTierEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$Line extends Line {
  @override
  final LineTierEnum? tier;
  @override
  final int? paymentCount;
  @override
  final int? revenue;
  @override
  final int? refunded;
  @override
  final int? net;
  @override
  final int? activePaid;
  @override
  final int? activeUnpaid;
  @override
  final int? mrr;

  factory _$Line([void Function(LineBuilder)? updates]) =>
      (LineBuilder()..update(updates))._build();

  _$Line._({
    this.tier,
    this.paymentCount,
    this.revenue,
    this.refunded,
    this.net,
    this.activePaid,
    this.activeUnpaid,
    this.mrr,
  }) : super._();
  @override
  Line rebuild(void Function(LineBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LineBuilder toBuilder() => LineBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Line &&
        tier == other.tier &&
        paymentCount == other.paymentCount &&
        revenue == other.revenue &&
        refunded == other.refunded &&
        net == other.net &&
        activePaid == other.activePaid &&
        activeUnpaid == other.activeUnpaid &&
        mrr == other.mrr;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, paymentCount.hashCode);
    _$hash = $jc(_$hash, revenue.hashCode);
    _$hash = $jc(_$hash, refunded.hashCode);
    _$hash = $jc(_$hash, net.hashCode);
    _$hash = $jc(_$hash, activePaid.hashCode);
    _$hash = $jc(_$hash, activeUnpaid.hashCode);
    _$hash = $jc(_$hash, mrr.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Line')
          ..add('tier', tier)
          ..add('paymentCount', paymentCount)
          ..add('revenue', revenue)
          ..add('refunded', refunded)
          ..add('net', net)
          ..add('activePaid', activePaid)
          ..add('activeUnpaid', activeUnpaid)
          ..add('mrr', mrr))
        .toString();
  }
}

class LineBuilder implements Builder<Line, LineBuilder> {
  _$Line? _$v;

  LineTierEnum? _tier;
  LineTierEnum? get tier => _$this._tier;
  set tier(LineTierEnum? tier) => _$this._tier = tier;

  int? _paymentCount;
  int? get paymentCount => _$this._paymentCount;
  set paymentCount(int? paymentCount) => _$this._paymentCount = paymentCount;

  int? _revenue;
  int? get revenue => _$this._revenue;
  set revenue(int? revenue) => _$this._revenue = revenue;

  int? _refunded;
  int? get refunded => _$this._refunded;
  set refunded(int? refunded) => _$this._refunded = refunded;

  int? _net;
  int? get net => _$this._net;
  set net(int? net) => _$this._net = net;

  int? _activePaid;
  int? get activePaid => _$this._activePaid;
  set activePaid(int? activePaid) => _$this._activePaid = activePaid;

  int? _activeUnpaid;
  int? get activeUnpaid => _$this._activeUnpaid;
  set activeUnpaid(int? activeUnpaid) => _$this._activeUnpaid = activeUnpaid;

  int? _mrr;
  int? get mrr => _$this._mrr;
  set mrr(int? mrr) => _$this._mrr = mrr;

  LineBuilder() {
    Line._defaults(this);
  }

  LineBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tier = $v.tier;
      _paymentCount = $v.paymentCount;
      _revenue = $v.revenue;
      _refunded = $v.refunded;
      _net = $v.net;
      _activePaid = $v.activePaid;
      _activeUnpaid = $v.activeUnpaid;
      _mrr = $v.mrr;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Line other) {
    _$v = other as _$Line;
  }

  @override
  void update(void Function(LineBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Line build() => _build();

  _$Line _build() {
    final _$result =
        _$v ??
        _$Line._(
          tier: tier,
          paymentCount: paymentCount,
          revenue: revenue,
          refunded: refunded,
          net: net,
          activePaid: activePaid,
          activeUnpaid: activeUnpaid,
          mrr: mrr,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
