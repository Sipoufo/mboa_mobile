// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SubscriptionResponseTierEnum _$subscriptionResponseTierEnum_FREE =
    const SubscriptionResponseTierEnum._('FREE');
const SubscriptionResponseTierEnum _$subscriptionResponseTierEnum_BASIC_PLUS =
    const SubscriptionResponseTierEnum._('BASIC_PLUS');
const SubscriptionResponseTierEnum _$subscriptionResponseTierEnum_PRO =
    const SubscriptionResponseTierEnum._('PRO');
const SubscriptionResponseTierEnum _$subscriptionResponseTierEnum_PRO_PLUS =
    const SubscriptionResponseTierEnum._('PRO_PLUS');
const SubscriptionResponseTierEnum
_$subscriptionResponseTierEnum_unknownDefaultOpenApi =
    const SubscriptionResponseTierEnum._('unknownDefaultOpenApi');

SubscriptionResponseTierEnum _$subscriptionResponseTierEnumValueOf(
  String name,
) {
  switch (name) {
    case 'FREE':
      return _$subscriptionResponseTierEnum_FREE;
    case 'BASIC_PLUS':
      return _$subscriptionResponseTierEnum_BASIC_PLUS;
    case 'PRO':
      return _$subscriptionResponseTierEnum_PRO;
    case 'PRO_PLUS':
      return _$subscriptionResponseTierEnum_PRO_PLUS;
    case 'unknownDefaultOpenApi':
      return _$subscriptionResponseTierEnum_unknownDefaultOpenApi;
    default:
      return _$subscriptionResponseTierEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<SubscriptionResponseTierEnum>
_$subscriptionResponseTierEnumValues =
    BuiltSet<SubscriptionResponseTierEnum>(const <SubscriptionResponseTierEnum>[
      _$subscriptionResponseTierEnum_FREE,
      _$subscriptionResponseTierEnum_BASIC_PLUS,
      _$subscriptionResponseTierEnum_PRO,
      _$subscriptionResponseTierEnum_PRO_PLUS,
      _$subscriptionResponseTierEnum_unknownDefaultOpenApi,
    ]);

Serializer<SubscriptionResponseTierEnum>
_$subscriptionResponseTierEnumSerializer =
    _$SubscriptionResponseTierEnumSerializer();

class _$SubscriptionResponseTierEnumSerializer
    implements PrimitiveSerializer<SubscriptionResponseTierEnum> {
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
  final Iterable<Type> types = const <Type>[SubscriptionResponseTierEnum];
  @override
  final String wireName = 'SubscriptionResponseTierEnum';

  @override
  Object serialize(
    Serializers serializers,
    SubscriptionResponseTierEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SubscriptionResponseTierEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SubscriptionResponseTierEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SubscriptionResponse extends SubscriptionResponse {
  @override
  final SubscriptionResponseTierEnum? tier;
  @override
  final DateTime? periodEnd;
  @override
  final int? activeListingLimit;
  @override
  final String? currentPaymentId;
  @override
  final bool? currentPaymentHasReceipt;

  factory _$SubscriptionResponse([
    void Function(SubscriptionResponseBuilder)? updates,
  ]) => (SubscriptionResponseBuilder()..update(updates))._build();

  _$SubscriptionResponse._({
    this.tier,
    this.periodEnd,
    this.activeListingLimit,
    this.currentPaymentId,
    this.currentPaymentHasReceipt,
  }) : super._();
  @override
  SubscriptionResponse rebuild(
    void Function(SubscriptionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SubscriptionResponseBuilder toBuilder() =>
      SubscriptionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubscriptionResponse &&
        tier == other.tier &&
        periodEnd == other.periodEnd &&
        activeListingLimit == other.activeListingLimit &&
        currentPaymentId == other.currentPaymentId &&
        currentPaymentHasReceipt == other.currentPaymentHasReceipt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, periodEnd.hashCode);
    _$hash = $jc(_$hash, activeListingLimit.hashCode);
    _$hash = $jc(_$hash, currentPaymentId.hashCode);
    _$hash = $jc(_$hash, currentPaymentHasReceipt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubscriptionResponse')
          ..add('tier', tier)
          ..add('periodEnd', periodEnd)
          ..add('activeListingLimit', activeListingLimit)
          ..add('currentPaymentId', currentPaymentId)
          ..add('currentPaymentHasReceipt', currentPaymentHasReceipt))
        .toString();
  }
}

class SubscriptionResponseBuilder
    implements Builder<SubscriptionResponse, SubscriptionResponseBuilder> {
  _$SubscriptionResponse? _$v;

  SubscriptionResponseTierEnum? _tier;
  SubscriptionResponseTierEnum? get tier => _$this._tier;
  set tier(SubscriptionResponseTierEnum? tier) => _$this._tier = tier;

  DateTime? _periodEnd;
  DateTime? get periodEnd => _$this._periodEnd;
  set periodEnd(DateTime? periodEnd) => _$this._periodEnd = periodEnd;

  int? _activeListingLimit;
  int? get activeListingLimit => _$this._activeListingLimit;
  set activeListingLimit(int? activeListingLimit) =>
      _$this._activeListingLimit = activeListingLimit;

  String? _currentPaymentId;
  String? get currentPaymentId => _$this._currentPaymentId;
  set currentPaymentId(String? currentPaymentId) =>
      _$this._currentPaymentId = currentPaymentId;

  bool? _currentPaymentHasReceipt;
  bool? get currentPaymentHasReceipt => _$this._currentPaymentHasReceipt;
  set currentPaymentHasReceipt(bool? currentPaymentHasReceipt) =>
      _$this._currentPaymentHasReceipt = currentPaymentHasReceipt;

  SubscriptionResponseBuilder() {
    SubscriptionResponse._defaults(this);
  }

  SubscriptionResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tier = $v.tier;
      _periodEnd = $v.periodEnd;
      _activeListingLimit = $v.activeListingLimit;
      _currentPaymentId = $v.currentPaymentId;
      _currentPaymentHasReceipt = $v.currentPaymentHasReceipt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubscriptionResponse other) {
    _$v = other as _$SubscriptionResponse;
  }

  @override
  void update(void Function(SubscriptionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubscriptionResponse build() => _build();

  _$SubscriptionResponse _build() {
    final _$result =
        _$v ??
        _$SubscriptionResponse._(
          tier: tier,
          periodEnd: periodEnd,
          activeListingLimit: activeListingLimit,
          currentPaymentId: currentPaymentId,
          currentPaymentHasReceipt: currentPaymentHasReceipt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
