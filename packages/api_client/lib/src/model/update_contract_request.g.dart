// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_contract_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateContractRequestRentalPeriodEnum
_$updateContractRequestRentalPeriodEnum_DAY =
    const UpdateContractRequestRentalPeriodEnum._('DAY');
const UpdateContractRequestRentalPeriodEnum
_$updateContractRequestRentalPeriodEnum_WEEK =
    const UpdateContractRequestRentalPeriodEnum._('WEEK');
const UpdateContractRequestRentalPeriodEnum
_$updateContractRequestRentalPeriodEnum_MONTH =
    const UpdateContractRequestRentalPeriodEnum._('MONTH');
const UpdateContractRequestRentalPeriodEnum
_$updateContractRequestRentalPeriodEnum_QUARTER =
    const UpdateContractRequestRentalPeriodEnum._('QUARTER');
const UpdateContractRequestRentalPeriodEnum
_$updateContractRequestRentalPeriodEnum_YEAR =
    const UpdateContractRequestRentalPeriodEnum._('YEAR');
const UpdateContractRequestRentalPeriodEnum
_$updateContractRequestRentalPeriodEnum_unknownDefaultOpenApi =
    const UpdateContractRequestRentalPeriodEnum._('unknownDefaultOpenApi');

UpdateContractRequestRentalPeriodEnum
_$updateContractRequestRentalPeriodEnumValueOf(String name) {
  switch (name) {
    case 'DAY':
      return _$updateContractRequestRentalPeriodEnum_DAY;
    case 'WEEK':
      return _$updateContractRequestRentalPeriodEnum_WEEK;
    case 'MONTH':
      return _$updateContractRequestRentalPeriodEnum_MONTH;
    case 'QUARTER':
      return _$updateContractRequestRentalPeriodEnum_QUARTER;
    case 'YEAR':
      return _$updateContractRequestRentalPeriodEnum_YEAR;
    case 'unknownDefaultOpenApi':
      return _$updateContractRequestRentalPeriodEnum_unknownDefaultOpenApi;
    default:
      return _$updateContractRequestRentalPeriodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<UpdateContractRequestRentalPeriodEnum>
_$updateContractRequestRentalPeriodEnumValues =
    BuiltSet<UpdateContractRequestRentalPeriodEnum>(
      const <UpdateContractRequestRentalPeriodEnum>[
        _$updateContractRequestRentalPeriodEnum_DAY,
        _$updateContractRequestRentalPeriodEnum_WEEK,
        _$updateContractRequestRentalPeriodEnum_MONTH,
        _$updateContractRequestRentalPeriodEnum_QUARTER,
        _$updateContractRequestRentalPeriodEnum_YEAR,
        _$updateContractRequestRentalPeriodEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<UpdateContractRequestRentalPeriodEnum>
_$updateContractRequestRentalPeriodEnumSerializer =
    _$UpdateContractRequestRentalPeriodEnumSerializer();

class _$UpdateContractRequestRentalPeriodEnumSerializer
    implements PrimitiveSerializer<UpdateContractRequestRentalPeriodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'DAY': 'DAY',
    'WEEK': 'WEEK',
    'MONTH': 'MONTH',
    'QUARTER': 'QUARTER',
    'YEAR': 'YEAR',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'DAY': 'DAY',
    'WEEK': 'WEEK',
    'MONTH': 'MONTH',
    'QUARTER': 'QUARTER',
    'YEAR': 'YEAR',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UpdateContractRequestRentalPeriodEnum,
  ];
  @override
  final String wireName = 'UpdateContractRequestRentalPeriodEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdateContractRequestRentalPeriodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdateContractRequestRentalPeriodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdateContractRequestRentalPeriodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdateContractRequest extends UpdateContractRequest {
  @override
  final int? price;
  @override
  final UpdateContractRequestRentalPeriodEnum? rentalPeriod;
  @override
  final int? depositAmount;
  @override
  final bool? chargesIncluded;
  @override
  final Date? startDate;
  @override
  final int? durationUnits;
  @override
  final bool? tacitRenewal;

  factory _$UpdateContractRequest([
    void Function(UpdateContractRequestBuilder)? updates,
  ]) => (UpdateContractRequestBuilder()..update(updates))._build();

  _$UpdateContractRequest._({
    this.price,
    this.rentalPeriod,
    this.depositAmount,
    this.chargesIncluded,
    this.startDate,
    this.durationUnits,
    this.tacitRenewal,
  }) : super._();
  @override
  UpdateContractRequest rebuild(
    void Function(UpdateContractRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateContractRequestBuilder toBuilder() =>
      UpdateContractRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateContractRequest &&
        price == other.price &&
        rentalPeriod == other.rentalPeriod &&
        depositAmount == other.depositAmount &&
        chargesIncluded == other.chargesIncluded &&
        startDate == other.startDate &&
        durationUnits == other.durationUnits &&
        tacitRenewal == other.tacitRenewal;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, rentalPeriod.hashCode);
    _$hash = $jc(_$hash, depositAmount.hashCode);
    _$hash = $jc(_$hash, chargesIncluded.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, durationUnits.hashCode);
    _$hash = $jc(_$hash, tacitRenewal.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateContractRequest')
          ..add('price', price)
          ..add('rentalPeriod', rentalPeriod)
          ..add('depositAmount', depositAmount)
          ..add('chargesIncluded', chargesIncluded)
          ..add('startDate', startDate)
          ..add('durationUnits', durationUnits)
          ..add('tacitRenewal', tacitRenewal))
        .toString();
  }
}

class UpdateContractRequestBuilder
    implements Builder<UpdateContractRequest, UpdateContractRequestBuilder> {
  _$UpdateContractRequest? _$v;

  int? _price;
  int? get price => _$this._price;
  set price(int? price) => _$this._price = price;

  UpdateContractRequestRentalPeriodEnum? _rentalPeriod;
  UpdateContractRequestRentalPeriodEnum? get rentalPeriod =>
      _$this._rentalPeriod;
  set rentalPeriod(UpdateContractRequestRentalPeriodEnum? rentalPeriod) =>
      _$this._rentalPeriod = rentalPeriod;

  int? _depositAmount;
  int? get depositAmount => _$this._depositAmount;
  set depositAmount(int? depositAmount) =>
      _$this._depositAmount = depositAmount;

  bool? _chargesIncluded;
  bool? get chargesIncluded => _$this._chargesIncluded;
  set chargesIncluded(bool? chargesIncluded) =>
      _$this._chargesIncluded = chargesIncluded;

  Date? _startDate;
  Date? get startDate => _$this._startDate;
  set startDate(Date? startDate) => _$this._startDate = startDate;

  int? _durationUnits;
  int? get durationUnits => _$this._durationUnits;
  set durationUnits(int? durationUnits) =>
      _$this._durationUnits = durationUnits;

  bool? _tacitRenewal;
  bool? get tacitRenewal => _$this._tacitRenewal;
  set tacitRenewal(bool? tacitRenewal) => _$this._tacitRenewal = tacitRenewal;

  UpdateContractRequestBuilder() {
    UpdateContractRequest._defaults(this);
  }

  UpdateContractRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _price = $v.price;
      _rentalPeriod = $v.rentalPeriod;
      _depositAmount = $v.depositAmount;
      _chargesIncluded = $v.chargesIncluded;
      _startDate = $v.startDate;
      _durationUnits = $v.durationUnits;
      _tacitRenewal = $v.tacitRenewal;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateContractRequest other) {
    _$v = other as _$UpdateContractRequest;
  }

  @override
  void update(void Function(UpdateContractRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateContractRequest build() => _build();

  _$UpdateContractRequest _build() {
    final _$result =
        _$v ??
        _$UpdateContractRequest._(
          price: price,
          rentalPeriod: rentalPeriod,
          depositAmount: depositAmount,
          chargesIncluded: chargesIncluded,
          startDate: startDate,
          durationUnits: durationUnits,
          tacitRenewal: tacitRenewal,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
