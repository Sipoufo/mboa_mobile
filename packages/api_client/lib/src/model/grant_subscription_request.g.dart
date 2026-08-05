// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grant_subscription_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GrantSubscriptionRequestTierEnum _$grantSubscriptionRequestTierEnum_FREE =
    const GrantSubscriptionRequestTierEnum._('FREE');
const GrantSubscriptionRequestTierEnum
_$grantSubscriptionRequestTierEnum_BASIC_PLUS =
    const GrantSubscriptionRequestTierEnum._('BASIC_PLUS');
const GrantSubscriptionRequestTierEnum _$grantSubscriptionRequestTierEnum_PRO =
    const GrantSubscriptionRequestTierEnum._('PRO');
const GrantSubscriptionRequestTierEnum
_$grantSubscriptionRequestTierEnum_PRO_PLUS =
    const GrantSubscriptionRequestTierEnum._('PRO_PLUS');
const GrantSubscriptionRequestTierEnum
_$grantSubscriptionRequestTierEnum_unknownDefaultOpenApi =
    const GrantSubscriptionRequestTierEnum._('unknownDefaultOpenApi');

GrantSubscriptionRequestTierEnum _$grantSubscriptionRequestTierEnumValueOf(
  String name,
) {
  switch (name) {
    case 'FREE':
      return _$grantSubscriptionRequestTierEnum_FREE;
    case 'BASIC_PLUS':
      return _$grantSubscriptionRequestTierEnum_BASIC_PLUS;
    case 'PRO':
      return _$grantSubscriptionRequestTierEnum_PRO;
    case 'PRO_PLUS':
      return _$grantSubscriptionRequestTierEnum_PRO_PLUS;
    case 'unknownDefaultOpenApi':
      return _$grantSubscriptionRequestTierEnum_unknownDefaultOpenApi;
    default:
      return _$grantSubscriptionRequestTierEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<GrantSubscriptionRequestTierEnum>
_$grantSubscriptionRequestTierEnumValues =
    BuiltSet<GrantSubscriptionRequestTierEnum>(
      const <GrantSubscriptionRequestTierEnum>[
        _$grantSubscriptionRequestTierEnum_FREE,
        _$grantSubscriptionRequestTierEnum_BASIC_PLUS,
        _$grantSubscriptionRequestTierEnum_PRO,
        _$grantSubscriptionRequestTierEnum_PRO_PLUS,
        _$grantSubscriptionRequestTierEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<GrantSubscriptionRequestTierEnum>
_$grantSubscriptionRequestTierEnumSerializer =
    _$GrantSubscriptionRequestTierEnumSerializer();

class _$GrantSubscriptionRequestTierEnumSerializer
    implements PrimitiveSerializer<GrantSubscriptionRequestTierEnum> {
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
  final Iterable<Type> types = const <Type>[GrantSubscriptionRequestTierEnum];
  @override
  final String wireName = 'GrantSubscriptionRequestTierEnum';

  @override
  Object serialize(
    Serializers serializers,
    GrantSubscriptionRequestTierEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  GrantSubscriptionRequestTierEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => GrantSubscriptionRequestTierEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$GrantSubscriptionRequest extends GrantSubscriptionRequest {
  @override
  final String accountId;
  @override
  final GrantSubscriptionRequestTierEnum tier;
  @override
  final int days;

  factory _$GrantSubscriptionRequest([
    void Function(GrantSubscriptionRequestBuilder)? updates,
  ]) => (GrantSubscriptionRequestBuilder()..update(updates))._build();

  _$GrantSubscriptionRequest._({
    required this.accountId,
    required this.tier,
    required this.days,
  }) : super._();
  @override
  GrantSubscriptionRequest rebuild(
    void Function(GrantSubscriptionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GrantSubscriptionRequestBuilder toBuilder() =>
      GrantSubscriptionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GrantSubscriptionRequest &&
        accountId == other.accountId &&
        tier == other.tier &&
        days == other.days;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, days.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GrantSubscriptionRequest')
          ..add('accountId', accountId)
          ..add('tier', tier)
          ..add('days', days))
        .toString();
  }
}

class GrantSubscriptionRequestBuilder
    implements
        Builder<GrantSubscriptionRequest, GrantSubscriptionRequestBuilder> {
  _$GrantSubscriptionRequest? _$v;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  GrantSubscriptionRequestTierEnum? _tier;
  GrantSubscriptionRequestTierEnum? get tier => _$this._tier;
  set tier(GrantSubscriptionRequestTierEnum? tier) => _$this._tier = tier;

  int? _days;
  int? get days => _$this._days;
  set days(int? days) => _$this._days = days;

  GrantSubscriptionRequestBuilder() {
    GrantSubscriptionRequest._defaults(this);
  }

  GrantSubscriptionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountId = $v.accountId;
      _tier = $v.tier;
      _days = $v.days;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GrantSubscriptionRequest other) {
    _$v = other as _$GrantSubscriptionRequest;
  }

  @override
  void update(void Function(GrantSubscriptionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GrantSubscriptionRequest build() => _build();

  _$GrantSubscriptionRequest _build() {
    final _$result =
        _$v ??
        _$GrantSubscriptionRequest._(
          accountId: BuiltValueNullFieldError.checkNotNull(
            accountId,
            r'GrantSubscriptionRequest',
            'accountId',
          ),
          tier: BuiltValueNullFieldError.checkNotNull(
            tier,
            r'GrantSubscriptionRequest',
            'tier',
          ),
          days: BuiltValueNullFieldError.checkNotNull(
            days,
            r'GrantSubscriptionRequest',
            'days',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
