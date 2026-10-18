// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_entry_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LedgerEntryRequestDirectionEnum _$ledgerEntryRequestDirectionEnum_INCOME =
    const LedgerEntryRequestDirectionEnum._('INCOME');
const LedgerEntryRequestDirectionEnum
_$ledgerEntryRequestDirectionEnum_EXPENSE =
    const LedgerEntryRequestDirectionEnum._('EXPENSE');
const LedgerEntryRequestDirectionEnum
_$ledgerEntryRequestDirectionEnum_unknownDefaultOpenApi =
    const LedgerEntryRequestDirectionEnum._('unknownDefaultOpenApi');

LedgerEntryRequestDirectionEnum _$ledgerEntryRequestDirectionEnumValueOf(
  String name,
) {
  switch (name) {
    case 'INCOME':
      return _$ledgerEntryRequestDirectionEnum_INCOME;
    case 'EXPENSE':
      return _$ledgerEntryRequestDirectionEnum_EXPENSE;
    case 'unknownDefaultOpenApi':
      return _$ledgerEntryRequestDirectionEnum_unknownDefaultOpenApi;
    default:
      return _$ledgerEntryRequestDirectionEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LedgerEntryRequestDirectionEnum>
_$ledgerEntryRequestDirectionEnumValues =
    BuiltSet<LedgerEntryRequestDirectionEnum>(
      const <LedgerEntryRequestDirectionEnum>[
        _$ledgerEntryRequestDirectionEnum_INCOME,
        _$ledgerEntryRequestDirectionEnum_EXPENSE,
        _$ledgerEntryRequestDirectionEnum_unknownDefaultOpenApi,
      ],
    );

const LedgerEntryRequestCategoryEnum _$ledgerEntryRequestCategoryEnum_RENT =
    const LedgerEntryRequestCategoryEnum._('RENT');
const LedgerEntryRequestCategoryEnum _$ledgerEntryRequestCategoryEnum_CHARGES =
    const LedgerEntryRequestCategoryEnum._('CHARGES');
const LedgerEntryRequestCategoryEnum _$ledgerEntryRequestCategoryEnum_WORKS =
    const LedgerEntryRequestCategoryEnum._('WORKS');
const LedgerEntryRequestCategoryEnum
_$ledgerEntryRequestCategoryEnum_PROPERTY_TAX =
    const LedgerEntryRequestCategoryEnum._('PROPERTY_TAX');
const LedgerEntryRequestCategoryEnum
_$ledgerEntryRequestCategoryEnum_SERVICE_PROVIDERS =
    const LedgerEntryRequestCategoryEnum._('SERVICE_PROVIDERS');
const LedgerEntryRequestCategoryEnum _$ledgerEntryRequestCategoryEnum_OTHER =
    const LedgerEntryRequestCategoryEnum._('OTHER');
const LedgerEntryRequestCategoryEnum
_$ledgerEntryRequestCategoryEnum_unknownDefaultOpenApi =
    const LedgerEntryRequestCategoryEnum._('unknownDefaultOpenApi');

LedgerEntryRequestCategoryEnum _$ledgerEntryRequestCategoryEnumValueOf(
  String name,
) {
  switch (name) {
    case 'RENT':
      return _$ledgerEntryRequestCategoryEnum_RENT;
    case 'CHARGES':
      return _$ledgerEntryRequestCategoryEnum_CHARGES;
    case 'WORKS':
      return _$ledgerEntryRequestCategoryEnum_WORKS;
    case 'PROPERTY_TAX':
      return _$ledgerEntryRequestCategoryEnum_PROPERTY_TAX;
    case 'SERVICE_PROVIDERS':
      return _$ledgerEntryRequestCategoryEnum_SERVICE_PROVIDERS;
    case 'OTHER':
      return _$ledgerEntryRequestCategoryEnum_OTHER;
    case 'unknownDefaultOpenApi':
      return _$ledgerEntryRequestCategoryEnum_unknownDefaultOpenApi;
    default:
      return _$ledgerEntryRequestCategoryEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LedgerEntryRequestCategoryEnum>
_$ledgerEntryRequestCategoryEnumValues =
    BuiltSet<LedgerEntryRequestCategoryEnum>(
      const <LedgerEntryRequestCategoryEnum>[
        _$ledgerEntryRequestCategoryEnum_RENT,
        _$ledgerEntryRequestCategoryEnum_CHARGES,
        _$ledgerEntryRequestCategoryEnum_WORKS,
        _$ledgerEntryRequestCategoryEnum_PROPERTY_TAX,
        _$ledgerEntryRequestCategoryEnum_SERVICE_PROVIDERS,
        _$ledgerEntryRequestCategoryEnum_OTHER,
        _$ledgerEntryRequestCategoryEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<LedgerEntryRequestDirectionEnum>
_$ledgerEntryRequestDirectionEnumSerializer =
    _$LedgerEntryRequestDirectionEnumSerializer();
Serializer<LedgerEntryRequestCategoryEnum>
_$ledgerEntryRequestCategoryEnumSerializer =
    _$LedgerEntryRequestCategoryEnumSerializer();

class _$LedgerEntryRequestDirectionEnumSerializer
    implements PrimitiveSerializer<LedgerEntryRequestDirectionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'INCOME': 'INCOME',
    'EXPENSE': 'EXPENSE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'INCOME': 'INCOME',
    'EXPENSE': 'EXPENSE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[LedgerEntryRequestDirectionEnum];
  @override
  final String wireName = 'LedgerEntryRequestDirectionEnum';

  @override
  Object serialize(
    Serializers serializers,
    LedgerEntryRequestDirectionEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  LedgerEntryRequestDirectionEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => LedgerEntryRequestDirectionEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$LedgerEntryRequestCategoryEnumSerializer
    implements PrimitiveSerializer<LedgerEntryRequestCategoryEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'RENT': 'RENT',
    'CHARGES': 'CHARGES',
    'WORKS': 'WORKS',
    'PROPERTY_TAX': 'PROPERTY_TAX',
    'SERVICE_PROVIDERS': 'SERVICE_PROVIDERS',
    'OTHER': 'OTHER',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'RENT': 'RENT',
    'CHARGES': 'CHARGES',
    'WORKS': 'WORKS',
    'PROPERTY_TAX': 'PROPERTY_TAX',
    'SERVICE_PROVIDERS': 'SERVICE_PROVIDERS',
    'OTHER': 'OTHER',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[LedgerEntryRequestCategoryEnum];
  @override
  final String wireName = 'LedgerEntryRequestCategoryEnum';

  @override
  Object serialize(
    Serializers serializers,
    LedgerEntryRequestCategoryEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  LedgerEntryRequestCategoryEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => LedgerEntryRequestCategoryEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$LedgerEntryRequest extends LedgerEntryRequest {
  @override
  final LedgerEntryRequestDirectionEnum direction;
  @override
  final LedgerEntryRequestCategoryEnum category;
  @override
  final int amount;
  @override
  final Date date;
  @override
  final String? annonceId;
  @override
  final String? residenceId;
  @override
  final String? note;
  @override
  final String? attachmentKey;

  factory _$LedgerEntryRequest([
    void Function(LedgerEntryRequestBuilder)? updates,
  ]) => (LedgerEntryRequestBuilder()..update(updates))._build();

  _$LedgerEntryRequest._({
    required this.direction,
    required this.category,
    required this.amount,
    required this.date,
    this.annonceId,
    this.residenceId,
    this.note,
    this.attachmentKey,
  }) : super._();
  @override
  LedgerEntryRequest rebuild(
    void Function(LedgerEntryRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LedgerEntryRequestBuilder toBuilder() =>
      LedgerEntryRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LedgerEntryRequest &&
        direction == other.direction &&
        category == other.category &&
        amount == other.amount &&
        date == other.date &&
        annonceId == other.annonceId &&
        residenceId == other.residenceId &&
        note == other.note &&
        attachmentKey == other.attachmentKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, direction.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, residenceId.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, attachmentKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LedgerEntryRequest')
          ..add('direction', direction)
          ..add('category', category)
          ..add('amount', amount)
          ..add('date', date)
          ..add('annonceId', annonceId)
          ..add('residenceId', residenceId)
          ..add('note', note)
          ..add('attachmentKey', attachmentKey))
        .toString();
  }
}

class LedgerEntryRequestBuilder
    implements Builder<LedgerEntryRequest, LedgerEntryRequestBuilder> {
  _$LedgerEntryRequest? _$v;

  LedgerEntryRequestDirectionEnum? _direction;
  LedgerEntryRequestDirectionEnum? get direction => _$this._direction;
  set direction(LedgerEntryRequestDirectionEnum? direction) =>
      _$this._direction = direction;

  LedgerEntryRequestCategoryEnum? _category;
  LedgerEntryRequestCategoryEnum? get category => _$this._category;
  set category(LedgerEntryRequestCategoryEnum? category) =>
      _$this._category = category;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _residenceId;
  String? get residenceId => _$this._residenceId;
  set residenceId(String? residenceId) => _$this._residenceId = residenceId;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  String? _attachmentKey;
  String? get attachmentKey => _$this._attachmentKey;
  set attachmentKey(String? attachmentKey) =>
      _$this._attachmentKey = attachmentKey;

  LedgerEntryRequestBuilder() {
    LedgerEntryRequest._defaults(this);
  }

  LedgerEntryRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _direction = $v.direction;
      _category = $v.category;
      _amount = $v.amount;
      _date = $v.date;
      _annonceId = $v.annonceId;
      _residenceId = $v.residenceId;
      _note = $v.note;
      _attachmentKey = $v.attachmentKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LedgerEntryRequest other) {
    _$v = other as _$LedgerEntryRequest;
  }

  @override
  void update(void Function(LedgerEntryRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LedgerEntryRequest build() => _build();

  _$LedgerEntryRequest _build() {
    final _$result =
        _$v ??
        _$LedgerEntryRequest._(
          direction: BuiltValueNullFieldError.checkNotNull(
            direction,
            r'LedgerEntryRequest',
            'direction',
          ),
          category: BuiltValueNullFieldError.checkNotNull(
            category,
            r'LedgerEntryRequest',
            'category',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'LedgerEntryRequest',
            'amount',
          ),
          date: BuiltValueNullFieldError.checkNotNull(
            date,
            r'LedgerEntryRequest',
            'date',
          ),
          annonceId: annonceId,
          residenceId: residenceId,
          note: note,
          attachmentKey: attachmentKey,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
