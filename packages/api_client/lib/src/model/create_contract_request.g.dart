// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_contract_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateContractRequestRentalPeriodEnum
_$createContractRequestRentalPeriodEnum_DAY =
    const CreateContractRequestRentalPeriodEnum._('DAY');
const CreateContractRequestRentalPeriodEnum
_$createContractRequestRentalPeriodEnum_WEEK =
    const CreateContractRequestRentalPeriodEnum._('WEEK');
const CreateContractRequestRentalPeriodEnum
_$createContractRequestRentalPeriodEnum_MONTH =
    const CreateContractRequestRentalPeriodEnum._('MONTH');
const CreateContractRequestRentalPeriodEnum
_$createContractRequestRentalPeriodEnum_QUARTER =
    const CreateContractRequestRentalPeriodEnum._('QUARTER');
const CreateContractRequestRentalPeriodEnum
_$createContractRequestRentalPeriodEnum_YEAR =
    const CreateContractRequestRentalPeriodEnum._('YEAR');
const CreateContractRequestRentalPeriodEnum
_$createContractRequestRentalPeriodEnum_unknownDefaultOpenApi =
    const CreateContractRequestRentalPeriodEnum._('unknownDefaultOpenApi');

CreateContractRequestRentalPeriodEnum
_$createContractRequestRentalPeriodEnumValueOf(String name) {
  switch (name) {
    case 'DAY':
      return _$createContractRequestRentalPeriodEnum_DAY;
    case 'WEEK':
      return _$createContractRequestRentalPeriodEnum_WEEK;
    case 'MONTH':
      return _$createContractRequestRentalPeriodEnum_MONTH;
    case 'QUARTER':
      return _$createContractRequestRentalPeriodEnum_QUARTER;
    case 'YEAR':
      return _$createContractRequestRentalPeriodEnum_YEAR;
    case 'unknownDefaultOpenApi':
      return _$createContractRequestRentalPeriodEnum_unknownDefaultOpenApi;
    default:
      return _$createContractRequestRentalPeriodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CreateContractRequestRentalPeriodEnum>
_$createContractRequestRentalPeriodEnumValues =
    BuiltSet<CreateContractRequestRentalPeriodEnum>(
      const <CreateContractRequestRentalPeriodEnum>[
        _$createContractRequestRentalPeriodEnum_DAY,
        _$createContractRequestRentalPeriodEnum_WEEK,
        _$createContractRequestRentalPeriodEnum_MONTH,
        _$createContractRequestRentalPeriodEnum_QUARTER,
        _$createContractRequestRentalPeriodEnum_YEAR,
        _$createContractRequestRentalPeriodEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<CreateContractRequestRentalPeriodEnum>
_$createContractRequestRentalPeriodEnumSerializer =
    _$CreateContractRequestRentalPeriodEnumSerializer();

class _$CreateContractRequestRentalPeriodEnumSerializer
    implements PrimitiveSerializer<CreateContractRequestRentalPeriodEnum> {
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
    CreateContractRequestRentalPeriodEnum,
  ];
  @override
  final String wireName = 'CreateContractRequestRentalPeriodEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateContractRequestRentalPeriodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateContractRequestRentalPeriodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateContractRequestRentalPeriodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateContractRequest extends CreateContractRequest {
  @override
  final String annonceId;
  @override
  final String? tenantAccountId;
  @override
  final String? tenantPhone;
  @override
  final int price;
  @override
  final CreateContractRequestRentalPeriodEnum rentalPeriod;
  @override
  final int depositAmount;
  @override
  final bool? chargesIncluded;
  @override
  final Date startDate;
  @override
  final int durationUnits;
  @override
  final bool? tacitRenewal;

  factory _$CreateContractRequest([
    void Function(CreateContractRequestBuilder)? updates,
  ]) => (CreateContractRequestBuilder()..update(updates))._build();

  _$CreateContractRequest._({
    required this.annonceId,
    this.tenantAccountId,
    this.tenantPhone,
    required this.price,
    required this.rentalPeriod,
    required this.depositAmount,
    this.chargesIncluded,
    required this.startDate,
    required this.durationUnits,
    this.tacitRenewal,
  }) : super._();
  @override
  CreateContractRequest rebuild(
    void Function(CreateContractRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateContractRequestBuilder toBuilder() =>
      CreateContractRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateContractRequest &&
        annonceId == other.annonceId &&
        tenantAccountId == other.tenantAccountId &&
        tenantPhone == other.tenantPhone &&
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
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, tenantAccountId.hashCode);
    _$hash = $jc(_$hash, tenantPhone.hashCode);
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
    return (newBuiltValueToStringHelper(r'CreateContractRequest')
          ..add('annonceId', annonceId)
          ..add('tenantAccountId', tenantAccountId)
          ..add('tenantPhone', tenantPhone)
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

class CreateContractRequestBuilder
    implements Builder<CreateContractRequest, CreateContractRequestBuilder> {
  _$CreateContractRequest? _$v;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _tenantAccountId;
  String? get tenantAccountId => _$this._tenantAccountId;
  set tenantAccountId(String? tenantAccountId) =>
      _$this._tenantAccountId = tenantAccountId;

  String? _tenantPhone;
  String? get tenantPhone => _$this._tenantPhone;
  set tenantPhone(String? tenantPhone) => _$this._tenantPhone = tenantPhone;

  int? _price;
  int? get price => _$this._price;
  set price(int? price) => _$this._price = price;

  CreateContractRequestRentalPeriodEnum? _rentalPeriod;
  CreateContractRequestRentalPeriodEnum? get rentalPeriod =>
      _$this._rentalPeriod;
  set rentalPeriod(CreateContractRequestRentalPeriodEnum? rentalPeriod) =>
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

  CreateContractRequestBuilder() {
    CreateContractRequest._defaults(this);
  }

  CreateContractRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _annonceId = $v.annonceId;
      _tenantAccountId = $v.tenantAccountId;
      _tenantPhone = $v.tenantPhone;
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
  void replace(CreateContractRequest other) {
    _$v = other as _$CreateContractRequest;
  }

  @override
  void update(void Function(CreateContractRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateContractRequest build() => _build();

  _$CreateContractRequest _build() {
    final _$result =
        _$v ??
        _$CreateContractRequest._(
          annonceId: BuiltValueNullFieldError.checkNotNull(
            annonceId,
            r'CreateContractRequest',
            'annonceId',
          ),
          tenantAccountId: tenantAccountId,
          tenantPhone: tenantPhone,
          price: BuiltValueNullFieldError.checkNotNull(
            price,
            r'CreateContractRequest',
            'price',
          ),
          rentalPeriod: BuiltValueNullFieldError.checkNotNull(
            rentalPeriod,
            r'CreateContractRequest',
            'rentalPeriod',
          ),
          depositAmount: BuiltValueNullFieldError.checkNotNull(
            depositAmount,
            r'CreateContractRequest',
            'depositAmount',
          ),
          chargesIncluded: chargesIncluded,
          startDate: BuiltValueNullFieldError.checkNotNull(
            startDate,
            r'CreateContractRequest',
            'startDate',
          ),
          durationUnits: BuiltValueNullFieldError.checkNotNull(
            durationUnits,
            r'CreateContractRequest',
            'durationUnits',
          ),
          tacitRenewal: tacitRenewal,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
