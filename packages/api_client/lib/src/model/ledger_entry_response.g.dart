// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_entry_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LedgerEntryResponseDirectionEnum
_$ledgerEntryResponseDirectionEnum_INCOME =
    const LedgerEntryResponseDirectionEnum._('INCOME');
const LedgerEntryResponseDirectionEnum
_$ledgerEntryResponseDirectionEnum_EXPENSE =
    const LedgerEntryResponseDirectionEnum._('EXPENSE');
const LedgerEntryResponseDirectionEnum
_$ledgerEntryResponseDirectionEnum_unknownDefaultOpenApi =
    const LedgerEntryResponseDirectionEnum._('unknownDefaultOpenApi');

LedgerEntryResponseDirectionEnum _$ledgerEntryResponseDirectionEnumValueOf(
  String name,
) {
  switch (name) {
    case 'INCOME':
      return _$ledgerEntryResponseDirectionEnum_INCOME;
    case 'EXPENSE':
      return _$ledgerEntryResponseDirectionEnum_EXPENSE;
    case 'unknownDefaultOpenApi':
      return _$ledgerEntryResponseDirectionEnum_unknownDefaultOpenApi;
    default:
      return _$ledgerEntryResponseDirectionEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LedgerEntryResponseDirectionEnum>
_$ledgerEntryResponseDirectionEnumValues =
    BuiltSet<LedgerEntryResponseDirectionEnum>(
      const <LedgerEntryResponseDirectionEnum>[
        _$ledgerEntryResponseDirectionEnum_INCOME,
        _$ledgerEntryResponseDirectionEnum_EXPENSE,
        _$ledgerEntryResponseDirectionEnum_unknownDefaultOpenApi,
      ],
    );

const LedgerEntryResponseCategoryEnum _$ledgerEntryResponseCategoryEnum_RENT =
    const LedgerEntryResponseCategoryEnum._('RENT');
const LedgerEntryResponseCategoryEnum
_$ledgerEntryResponseCategoryEnum_CHARGES =
    const LedgerEntryResponseCategoryEnum._('CHARGES');
const LedgerEntryResponseCategoryEnum _$ledgerEntryResponseCategoryEnum_WORKS =
    const LedgerEntryResponseCategoryEnum._('WORKS');
const LedgerEntryResponseCategoryEnum
_$ledgerEntryResponseCategoryEnum_PROPERTY_TAX =
    const LedgerEntryResponseCategoryEnum._('PROPERTY_TAX');
const LedgerEntryResponseCategoryEnum
_$ledgerEntryResponseCategoryEnum_SERVICE_PROVIDERS =
    const LedgerEntryResponseCategoryEnum._('SERVICE_PROVIDERS');
const LedgerEntryResponseCategoryEnum _$ledgerEntryResponseCategoryEnum_OTHER =
    const LedgerEntryResponseCategoryEnum._('OTHER');
const LedgerEntryResponseCategoryEnum
_$ledgerEntryResponseCategoryEnum_unknownDefaultOpenApi =
    const LedgerEntryResponseCategoryEnum._('unknownDefaultOpenApi');

LedgerEntryResponseCategoryEnum _$ledgerEntryResponseCategoryEnumValueOf(
  String name,
) {
  switch (name) {
    case 'RENT':
      return _$ledgerEntryResponseCategoryEnum_RENT;
    case 'CHARGES':
      return _$ledgerEntryResponseCategoryEnum_CHARGES;
    case 'WORKS':
      return _$ledgerEntryResponseCategoryEnum_WORKS;
    case 'PROPERTY_TAX':
      return _$ledgerEntryResponseCategoryEnum_PROPERTY_TAX;
    case 'SERVICE_PROVIDERS':
      return _$ledgerEntryResponseCategoryEnum_SERVICE_PROVIDERS;
    case 'OTHER':
      return _$ledgerEntryResponseCategoryEnum_OTHER;
    case 'unknownDefaultOpenApi':
      return _$ledgerEntryResponseCategoryEnum_unknownDefaultOpenApi;
    default:
      return _$ledgerEntryResponseCategoryEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LedgerEntryResponseCategoryEnum>
_$ledgerEntryResponseCategoryEnumValues =
    BuiltSet<LedgerEntryResponseCategoryEnum>(
      const <LedgerEntryResponseCategoryEnum>[
        _$ledgerEntryResponseCategoryEnum_RENT,
        _$ledgerEntryResponseCategoryEnum_CHARGES,
        _$ledgerEntryResponseCategoryEnum_WORKS,
        _$ledgerEntryResponseCategoryEnum_PROPERTY_TAX,
        _$ledgerEntryResponseCategoryEnum_SERVICE_PROVIDERS,
        _$ledgerEntryResponseCategoryEnum_OTHER,
        _$ledgerEntryResponseCategoryEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<LedgerEntryResponseDirectionEnum>
_$ledgerEntryResponseDirectionEnumSerializer =
    _$LedgerEntryResponseDirectionEnumSerializer();
Serializer<LedgerEntryResponseCategoryEnum>
_$ledgerEntryResponseCategoryEnumSerializer =
    _$LedgerEntryResponseCategoryEnumSerializer();

class _$LedgerEntryResponseDirectionEnumSerializer
    implements PrimitiveSerializer<LedgerEntryResponseDirectionEnum> {
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
  final Iterable<Type> types = const <Type>[LedgerEntryResponseDirectionEnum];
  @override
  final String wireName = 'LedgerEntryResponseDirectionEnum';

  @override
  Object serialize(
    Serializers serializers,
    LedgerEntryResponseDirectionEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  LedgerEntryResponseDirectionEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => LedgerEntryResponseDirectionEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$LedgerEntryResponseCategoryEnumSerializer
    implements PrimitiveSerializer<LedgerEntryResponseCategoryEnum> {
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
  final Iterable<Type> types = const <Type>[LedgerEntryResponseCategoryEnum];
  @override
  final String wireName = 'LedgerEntryResponseCategoryEnum';

  @override
  Object serialize(
    Serializers serializers,
    LedgerEntryResponseCategoryEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  LedgerEntryResponseCategoryEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => LedgerEntryResponseCategoryEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$LedgerEntryResponse extends LedgerEntryResponse {
  @override
  final String? id;
  @override
  final LedgerEntryResponseDirectionEnum? direction;
  @override
  final LedgerEntryResponseCategoryEnum? category;
  @override
  final int? amount;
  @override
  final Date? date;
  @override
  final String? annonceId;
  @override
  final String? residenceId;
  @override
  final String? propertyLabel;
  @override
  final String? note;
  @override
  final bool? hasAttachment;
  @override
  final DateTime? createdAt;

  factory _$LedgerEntryResponse([
    void Function(LedgerEntryResponseBuilder)? updates,
  ]) => (LedgerEntryResponseBuilder()..update(updates))._build();

  _$LedgerEntryResponse._({
    this.id,
    this.direction,
    this.category,
    this.amount,
    this.date,
    this.annonceId,
    this.residenceId,
    this.propertyLabel,
    this.note,
    this.hasAttachment,
    this.createdAt,
  }) : super._();
  @override
  LedgerEntryResponse rebuild(
    void Function(LedgerEntryResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LedgerEntryResponseBuilder toBuilder() =>
      LedgerEntryResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LedgerEntryResponse &&
        id == other.id &&
        direction == other.direction &&
        category == other.category &&
        amount == other.amount &&
        date == other.date &&
        annonceId == other.annonceId &&
        residenceId == other.residenceId &&
        propertyLabel == other.propertyLabel &&
        note == other.note &&
        hasAttachment == other.hasAttachment &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, direction.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, residenceId.hashCode);
    _$hash = $jc(_$hash, propertyLabel.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, hasAttachment.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LedgerEntryResponse')
          ..add('id', id)
          ..add('direction', direction)
          ..add('category', category)
          ..add('amount', amount)
          ..add('date', date)
          ..add('annonceId', annonceId)
          ..add('residenceId', residenceId)
          ..add('propertyLabel', propertyLabel)
          ..add('note', note)
          ..add('hasAttachment', hasAttachment)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class LedgerEntryResponseBuilder
    implements Builder<LedgerEntryResponse, LedgerEntryResponseBuilder> {
  _$LedgerEntryResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  LedgerEntryResponseDirectionEnum? _direction;
  LedgerEntryResponseDirectionEnum? get direction => _$this._direction;
  set direction(LedgerEntryResponseDirectionEnum? direction) =>
      _$this._direction = direction;

  LedgerEntryResponseCategoryEnum? _category;
  LedgerEntryResponseCategoryEnum? get category => _$this._category;
  set category(LedgerEntryResponseCategoryEnum? category) =>
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

  String? _propertyLabel;
  String? get propertyLabel => _$this._propertyLabel;
  set propertyLabel(String? propertyLabel) =>
      _$this._propertyLabel = propertyLabel;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  bool? _hasAttachment;
  bool? get hasAttachment => _$this._hasAttachment;
  set hasAttachment(bool? hasAttachment) =>
      _$this._hasAttachment = hasAttachment;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  LedgerEntryResponseBuilder() {
    LedgerEntryResponse._defaults(this);
  }

  LedgerEntryResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _direction = $v.direction;
      _category = $v.category;
      _amount = $v.amount;
      _date = $v.date;
      _annonceId = $v.annonceId;
      _residenceId = $v.residenceId;
      _propertyLabel = $v.propertyLabel;
      _note = $v.note;
      _hasAttachment = $v.hasAttachment;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LedgerEntryResponse other) {
    _$v = other as _$LedgerEntryResponse;
  }

  @override
  void update(void Function(LedgerEntryResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LedgerEntryResponse build() => _build();

  _$LedgerEntryResponse _build() {
    final _$result =
        _$v ??
        _$LedgerEntryResponse._(
          id: id,
          direction: direction,
          category: category,
          amount: amount,
          date: date,
          annonceId: annonceId,
          residenceId: residenceId,
          propertyLabel: propertyLabel,
          note: note,
          hasAttachment: hasAttachment,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
