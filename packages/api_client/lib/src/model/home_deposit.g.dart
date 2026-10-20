// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_deposit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HomeDepositStatusEnum _$homeDepositStatusEnum_NONE =
    const HomeDepositStatusEnum._('NONE');
const HomeDepositStatusEnum _$homeDepositStatusEnum_DECLARED =
    const HomeDepositStatusEnum._('DECLARED');
const HomeDepositStatusEnum _$homeDepositStatusEnum_UNCONFIRMED =
    const HomeDepositStatusEnum._('UNCONFIRMED');
const HomeDepositStatusEnum _$homeDepositStatusEnum_CONFIRMED =
    const HomeDepositStatusEnum._('CONFIRMED');
const HomeDepositStatusEnum _$homeDepositStatusEnum_CONTESTED =
    const HomeDepositStatusEnum._('CONTESTED');
const HomeDepositStatusEnum _$homeDepositStatusEnum_unknownDefaultOpenApi =
    const HomeDepositStatusEnum._('unknownDefaultOpenApi');

HomeDepositStatusEnum _$homeDepositStatusEnumValueOf(String name) {
  switch (name) {
    case 'NONE':
      return _$homeDepositStatusEnum_NONE;
    case 'DECLARED':
      return _$homeDepositStatusEnum_DECLARED;
    case 'UNCONFIRMED':
      return _$homeDepositStatusEnum_UNCONFIRMED;
    case 'CONFIRMED':
      return _$homeDepositStatusEnum_CONFIRMED;
    case 'CONTESTED':
      return _$homeDepositStatusEnum_CONTESTED;
    case 'unknownDefaultOpenApi':
      return _$homeDepositStatusEnum_unknownDefaultOpenApi;
    default:
      return _$homeDepositStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<HomeDepositStatusEnum> _$homeDepositStatusEnumValues =
    BuiltSet<HomeDepositStatusEnum>(const <HomeDepositStatusEnum>[
      _$homeDepositStatusEnum_NONE,
      _$homeDepositStatusEnum_DECLARED,
      _$homeDepositStatusEnum_UNCONFIRMED,
      _$homeDepositStatusEnum_CONFIRMED,
      _$homeDepositStatusEnum_CONTESTED,
      _$homeDepositStatusEnum_unknownDefaultOpenApi,
    ]);

Serializer<HomeDepositStatusEnum> _$homeDepositStatusEnumSerializer =
    _$HomeDepositStatusEnumSerializer();

class _$HomeDepositStatusEnumSerializer
    implements PrimitiveSerializer<HomeDepositStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'NONE': 'NONE',
    'DECLARED': 'DECLARED',
    'UNCONFIRMED': 'UNCONFIRMED',
    'CONFIRMED': 'CONFIRMED',
    'CONTESTED': 'CONTESTED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'NONE': 'NONE',
    'DECLARED': 'DECLARED',
    'UNCONFIRMED': 'UNCONFIRMED',
    'CONFIRMED': 'CONFIRMED',
    'CONTESTED': 'CONTESTED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[HomeDepositStatusEnum];
  @override
  final String wireName = 'HomeDepositStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HomeDepositStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HomeDepositStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HomeDepositStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HomeDeposit extends HomeDeposit {
  @override
  final int? amount;
  @override
  final int? confirmedTotal;
  @override
  final HomeDepositStatusEnum? status;

  factory _$HomeDeposit([void Function(HomeDepositBuilder)? updates]) =>
      (HomeDepositBuilder()..update(updates))._build();

  _$HomeDeposit._({this.amount, this.confirmedTotal, this.status}) : super._();
  @override
  HomeDeposit rebuild(void Function(HomeDepositBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeDepositBuilder toBuilder() => HomeDepositBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeDeposit &&
        amount == other.amount &&
        confirmedTotal == other.confirmedTotal &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, confirmedTotal.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HomeDeposit')
          ..add('amount', amount)
          ..add('confirmedTotal', confirmedTotal)
          ..add('status', status))
        .toString();
  }
}

class HomeDepositBuilder implements Builder<HomeDeposit, HomeDepositBuilder> {
  _$HomeDeposit? _$v;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  int? _confirmedTotal;
  int? get confirmedTotal => _$this._confirmedTotal;
  set confirmedTotal(int? confirmedTotal) =>
      _$this._confirmedTotal = confirmedTotal;

  HomeDepositStatusEnum? _status;
  HomeDepositStatusEnum? get status => _$this._status;
  set status(HomeDepositStatusEnum? status) => _$this._status = status;

  HomeDepositBuilder() {
    HomeDeposit._defaults(this);
  }

  HomeDepositBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _confirmedTotal = $v.confirmedTotal;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeDeposit other) {
    _$v = other as _$HomeDeposit;
  }

  @override
  void update(void Function(HomeDepositBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HomeDeposit build() => _build();

  _$HomeDeposit _build() {
    final _$result =
        _$v ??
        _$HomeDeposit._(
          amount: amount,
          confirmedTotal: confirmedTotal,
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
