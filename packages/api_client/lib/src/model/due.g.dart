// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'due.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DueStatusEnum _$dueStatusEnum_UPCOMING = const DueStatusEnum._(
  'UPCOMING',
);
const DueStatusEnum _$dueStatusEnum_DUE = const DueStatusEnum._('DUE');
const DueStatusEnum _$dueStatusEnum_LATE = const DueStatusEnum._('LATE');
const DueStatusEnum _$dueStatusEnum_DECLARED = const DueStatusEnum._(
  'DECLARED',
);
const DueStatusEnum _$dueStatusEnum_UNCONFIRMED = const DueStatusEnum._(
  'UNCONFIRMED',
);
const DueStatusEnum _$dueStatusEnum_CONFIRMED = const DueStatusEnum._(
  'CONFIRMED',
);
const DueStatusEnum _$dueStatusEnum_CONTESTED = const DueStatusEnum._(
  'CONTESTED',
);
const DueStatusEnum _$dueStatusEnum_UNTRACKED = const DueStatusEnum._(
  'UNTRACKED',
);
const DueStatusEnum _$dueStatusEnum_unknownDefaultOpenApi =
    const DueStatusEnum._('unknownDefaultOpenApi');

DueStatusEnum _$dueStatusEnumValueOf(String name) {
  switch (name) {
    case 'UPCOMING':
      return _$dueStatusEnum_UPCOMING;
    case 'DUE':
      return _$dueStatusEnum_DUE;
    case 'LATE':
      return _$dueStatusEnum_LATE;
    case 'DECLARED':
      return _$dueStatusEnum_DECLARED;
    case 'UNCONFIRMED':
      return _$dueStatusEnum_UNCONFIRMED;
    case 'CONFIRMED':
      return _$dueStatusEnum_CONFIRMED;
    case 'CONTESTED':
      return _$dueStatusEnum_CONTESTED;
    case 'UNTRACKED':
      return _$dueStatusEnum_UNTRACKED;
    case 'unknownDefaultOpenApi':
      return _$dueStatusEnum_unknownDefaultOpenApi;
    default:
      return _$dueStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DueStatusEnum> _$dueStatusEnumValues =
    BuiltSet<DueStatusEnum>(const <DueStatusEnum>[
      _$dueStatusEnum_UPCOMING,
      _$dueStatusEnum_DUE,
      _$dueStatusEnum_LATE,
      _$dueStatusEnum_DECLARED,
      _$dueStatusEnum_UNCONFIRMED,
      _$dueStatusEnum_CONFIRMED,
      _$dueStatusEnum_CONTESTED,
      _$dueStatusEnum_UNTRACKED,
      _$dueStatusEnum_unknownDefaultOpenApi,
    ]);

Serializer<DueStatusEnum> _$dueStatusEnumSerializer =
    _$DueStatusEnumSerializer();

class _$DueStatusEnumSerializer implements PrimitiveSerializer<DueStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'UPCOMING': 'UPCOMING',
    'DUE': 'DUE',
    'LATE': 'LATE',
    'DECLARED': 'DECLARED',
    'UNCONFIRMED': 'UNCONFIRMED',
    'CONFIRMED': 'CONFIRMED',
    'CONTESTED': 'CONTESTED',
    'UNTRACKED': 'UNTRACKED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'UPCOMING': 'UPCOMING',
    'DUE': 'DUE',
    'LATE': 'LATE',
    'DECLARED': 'DECLARED',
    'UNCONFIRMED': 'UNCONFIRMED',
    'CONFIRMED': 'CONFIRMED',
    'CONTESTED': 'CONTESTED',
    'UNTRACKED': 'UNTRACKED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DueStatusEnum];
  @override
  final String wireName = 'DueStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    DueStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DueStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DueStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$Due extends Due {
  @override
  final int? index;
  @override
  final Date? periodStart;
  @override
  final Date? periodEnd;
  @override
  final Date? dueDate;
  @override
  final int? amount;
  @override
  final int? confirmedTotal;
  @override
  final DueStatusEnum? status;
  @override
  final bool? late_;
  @override
  final BuiltList<String>? declarationIds;

  factory _$Due([void Function(DueBuilder)? updates]) =>
      (DueBuilder()..update(updates))._build();

  _$Due._({
    this.index,
    this.periodStart,
    this.periodEnd,
    this.dueDate,
    this.amount,
    this.confirmedTotal,
    this.status,
    this.late_,
    this.declarationIds,
  }) : super._();
  @override
  Due rebuild(void Function(DueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DueBuilder toBuilder() => DueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Due &&
        index == other.index &&
        periodStart == other.periodStart &&
        periodEnd == other.periodEnd &&
        dueDate == other.dueDate &&
        amount == other.amount &&
        confirmedTotal == other.confirmedTotal &&
        status == other.status &&
        late_ == other.late_ &&
        declarationIds == other.declarationIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, index.hashCode);
    _$hash = $jc(_$hash, periodStart.hashCode);
    _$hash = $jc(_$hash, periodEnd.hashCode);
    _$hash = $jc(_$hash, dueDate.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, confirmedTotal.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, late_.hashCode);
    _$hash = $jc(_$hash, declarationIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Due')
          ..add('index', index)
          ..add('periodStart', periodStart)
          ..add('periodEnd', periodEnd)
          ..add('dueDate', dueDate)
          ..add('amount', amount)
          ..add('confirmedTotal', confirmedTotal)
          ..add('status', status)
          ..add('late_', late_)
          ..add('declarationIds', declarationIds))
        .toString();
  }
}

class DueBuilder implements Builder<Due, DueBuilder> {
  _$Due? _$v;

  int? _index;
  int? get index => _$this._index;
  set index(int? index) => _$this._index = index;

  Date? _periodStart;
  Date? get periodStart => _$this._periodStart;
  set periodStart(Date? periodStart) => _$this._periodStart = periodStart;

  Date? _periodEnd;
  Date? get periodEnd => _$this._periodEnd;
  set periodEnd(Date? periodEnd) => _$this._periodEnd = periodEnd;

  Date? _dueDate;
  Date? get dueDate => _$this._dueDate;
  set dueDate(Date? dueDate) => _$this._dueDate = dueDate;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  int? _confirmedTotal;
  int? get confirmedTotal => _$this._confirmedTotal;
  set confirmedTotal(int? confirmedTotal) =>
      _$this._confirmedTotal = confirmedTotal;

  DueStatusEnum? _status;
  DueStatusEnum? get status => _$this._status;
  set status(DueStatusEnum? status) => _$this._status = status;

  bool? _late_;
  bool? get late_ => _$this._late_;
  set late_(bool? late_) => _$this._late_ = late_;

  ListBuilder<String>? _declarationIds;
  ListBuilder<String> get declarationIds =>
      _$this._declarationIds ??= ListBuilder<String>();
  set declarationIds(ListBuilder<String>? declarationIds) =>
      _$this._declarationIds = declarationIds;

  DueBuilder() {
    Due._defaults(this);
  }

  DueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _index = $v.index;
      _periodStart = $v.periodStart;
      _periodEnd = $v.periodEnd;
      _dueDate = $v.dueDate;
      _amount = $v.amount;
      _confirmedTotal = $v.confirmedTotal;
      _status = $v.status;
      _late_ = $v.late_;
      _declarationIds = $v.declarationIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Due other) {
    _$v = other as _$Due;
  }

  @override
  void update(void Function(DueBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Due build() => _build();

  _$Due _build() {
    _$Due _$result;
    try {
      _$result =
          _$v ??
          _$Due._(
            index: index,
            periodStart: periodStart,
            periodEnd: periodEnd,
            dueDate: dueDate,
            amount: amount,
            confirmedTotal: confirmedTotal,
            status: status,
            late_: late_,
            declarationIds: _declarationIds?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'declarationIds';
        _declarationIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(r'Due', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
