// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_request_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChangeRequestResponseContestedTermsEnum
_$changeRequestResponseContestedTermsEnum_PRICE =
    const ChangeRequestResponseContestedTermsEnum._('PRICE');
const ChangeRequestResponseContestedTermsEnum
_$changeRequestResponseContestedTermsEnum_RENTAL_PERIOD =
    const ChangeRequestResponseContestedTermsEnum._('RENTAL_PERIOD');
const ChangeRequestResponseContestedTermsEnum
_$changeRequestResponseContestedTermsEnum_DEPOSIT_AMOUNT =
    const ChangeRequestResponseContestedTermsEnum._('DEPOSIT_AMOUNT');
const ChangeRequestResponseContestedTermsEnum
_$changeRequestResponseContestedTermsEnum_CHARGES_INCLUDED =
    const ChangeRequestResponseContestedTermsEnum._('CHARGES_INCLUDED');
const ChangeRequestResponseContestedTermsEnum
_$changeRequestResponseContestedTermsEnum_START_DATE =
    const ChangeRequestResponseContestedTermsEnum._('START_DATE');
const ChangeRequestResponseContestedTermsEnum
_$changeRequestResponseContestedTermsEnum_DURATION_UNITS =
    const ChangeRequestResponseContestedTermsEnum._('DURATION_UNITS');
const ChangeRequestResponseContestedTermsEnum
_$changeRequestResponseContestedTermsEnum_TACIT_RENEWAL =
    const ChangeRequestResponseContestedTermsEnum._('TACIT_RENEWAL');
const ChangeRequestResponseContestedTermsEnum
_$changeRequestResponseContestedTermsEnum_unknownDefaultOpenApi =
    const ChangeRequestResponseContestedTermsEnum._('unknownDefaultOpenApi');

ChangeRequestResponseContestedTermsEnum
_$changeRequestResponseContestedTermsEnumValueOf(String name) {
  switch (name) {
    case 'PRICE':
      return _$changeRequestResponseContestedTermsEnum_PRICE;
    case 'RENTAL_PERIOD':
      return _$changeRequestResponseContestedTermsEnum_RENTAL_PERIOD;
    case 'DEPOSIT_AMOUNT':
      return _$changeRequestResponseContestedTermsEnum_DEPOSIT_AMOUNT;
    case 'CHARGES_INCLUDED':
      return _$changeRequestResponseContestedTermsEnum_CHARGES_INCLUDED;
    case 'START_DATE':
      return _$changeRequestResponseContestedTermsEnum_START_DATE;
    case 'DURATION_UNITS':
      return _$changeRequestResponseContestedTermsEnum_DURATION_UNITS;
    case 'TACIT_RENEWAL':
      return _$changeRequestResponseContestedTermsEnum_TACIT_RENEWAL;
    case 'unknownDefaultOpenApi':
      return _$changeRequestResponseContestedTermsEnum_unknownDefaultOpenApi;
    default:
      return _$changeRequestResponseContestedTermsEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ChangeRequestResponseContestedTermsEnum>
_$changeRequestResponseContestedTermsEnumValues =
    BuiltSet<ChangeRequestResponseContestedTermsEnum>(
      const <ChangeRequestResponseContestedTermsEnum>[
        _$changeRequestResponseContestedTermsEnum_PRICE,
        _$changeRequestResponseContestedTermsEnum_RENTAL_PERIOD,
        _$changeRequestResponseContestedTermsEnum_DEPOSIT_AMOUNT,
        _$changeRequestResponseContestedTermsEnum_CHARGES_INCLUDED,
        _$changeRequestResponseContestedTermsEnum_START_DATE,
        _$changeRequestResponseContestedTermsEnum_DURATION_UNITS,
        _$changeRequestResponseContestedTermsEnum_TACIT_RENEWAL,
        _$changeRequestResponseContestedTermsEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<ChangeRequestResponseContestedTermsEnum>
_$changeRequestResponseContestedTermsEnumSerializer =
    _$ChangeRequestResponseContestedTermsEnumSerializer();

class _$ChangeRequestResponseContestedTermsEnumSerializer
    implements PrimitiveSerializer<ChangeRequestResponseContestedTermsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PRICE': 'PRICE',
    'RENTAL_PERIOD': 'RENTAL_PERIOD',
    'DEPOSIT_AMOUNT': 'DEPOSIT_AMOUNT',
    'CHARGES_INCLUDED': 'CHARGES_INCLUDED',
    'START_DATE': 'START_DATE',
    'DURATION_UNITS': 'DURATION_UNITS',
    'TACIT_RENEWAL': 'TACIT_RENEWAL',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PRICE': 'PRICE',
    'RENTAL_PERIOD': 'RENTAL_PERIOD',
    'DEPOSIT_AMOUNT': 'DEPOSIT_AMOUNT',
    'CHARGES_INCLUDED': 'CHARGES_INCLUDED',
    'START_DATE': 'START_DATE',
    'DURATION_UNITS': 'DURATION_UNITS',
    'TACIT_RENEWAL': 'TACIT_RENEWAL',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ChangeRequestResponseContestedTermsEnum,
  ];
  @override
  final String wireName = 'ChangeRequestResponseContestedTermsEnum';

  @override
  Object serialize(
    Serializers serializers,
    ChangeRequestResponseContestedTermsEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ChangeRequestResponseContestedTermsEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ChangeRequestResponseContestedTermsEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ChangeRequestResponse extends ChangeRequestResponse {
  @override
  final String? id;
  @override
  final String? comment;
  @override
  final BuiltList<ChangeRequestResponseContestedTermsEnum>? contestedTerms;
  @override
  final DateTime? createdAt;
  @override
  final String? response;
  @override
  final DateTime? respondedAt;
  @override
  final DateTime? withdrawnAt;
  @override
  final bool? pending;

  factory _$ChangeRequestResponse([
    void Function(ChangeRequestResponseBuilder)? updates,
  ]) => (ChangeRequestResponseBuilder()..update(updates))._build();

  _$ChangeRequestResponse._({
    this.id,
    this.comment,
    this.contestedTerms,
    this.createdAt,
    this.response,
    this.respondedAt,
    this.withdrawnAt,
    this.pending,
  }) : super._();
  @override
  ChangeRequestResponse rebuild(
    void Function(ChangeRequestResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ChangeRequestResponseBuilder toBuilder() =>
      ChangeRequestResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangeRequestResponse &&
        id == other.id &&
        comment == other.comment &&
        contestedTerms == other.contestedTerms &&
        createdAt == other.createdAt &&
        response == other.response &&
        respondedAt == other.respondedAt &&
        withdrawnAt == other.withdrawnAt &&
        pending == other.pending;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, contestedTerms.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, response.hashCode);
    _$hash = $jc(_$hash, respondedAt.hashCode);
    _$hash = $jc(_$hash, withdrawnAt.hashCode);
    _$hash = $jc(_$hash, pending.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChangeRequestResponse')
          ..add('id', id)
          ..add('comment', comment)
          ..add('contestedTerms', contestedTerms)
          ..add('createdAt', createdAt)
          ..add('response', response)
          ..add('respondedAt', respondedAt)
          ..add('withdrawnAt', withdrawnAt)
          ..add('pending', pending))
        .toString();
  }
}

class ChangeRequestResponseBuilder
    implements Builder<ChangeRequestResponse, ChangeRequestResponseBuilder> {
  _$ChangeRequestResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  ListBuilder<ChangeRequestResponseContestedTermsEnum>? _contestedTerms;
  ListBuilder<ChangeRequestResponseContestedTermsEnum> get contestedTerms =>
      _$this._contestedTerms ??=
          ListBuilder<ChangeRequestResponseContestedTermsEnum>();
  set contestedTerms(
    ListBuilder<ChangeRequestResponseContestedTermsEnum>? contestedTerms,
  ) => _$this._contestedTerms = contestedTerms;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  String? _response;
  String? get response => _$this._response;
  set response(String? response) => _$this._response = response;

  DateTime? _respondedAt;
  DateTime? get respondedAt => _$this._respondedAt;
  set respondedAt(DateTime? respondedAt) => _$this._respondedAt = respondedAt;

  DateTime? _withdrawnAt;
  DateTime? get withdrawnAt => _$this._withdrawnAt;
  set withdrawnAt(DateTime? withdrawnAt) => _$this._withdrawnAt = withdrawnAt;

  bool? _pending;
  bool? get pending => _$this._pending;
  set pending(bool? pending) => _$this._pending = pending;

  ChangeRequestResponseBuilder() {
    ChangeRequestResponse._defaults(this);
  }

  ChangeRequestResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _comment = $v.comment;
      _contestedTerms = $v.contestedTerms?.toBuilder();
      _createdAt = $v.createdAt;
      _response = $v.response;
      _respondedAt = $v.respondedAt;
      _withdrawnAt = $v.withdrawnAt;
      _pending = $v.pending;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangeRequestResponse other) {
    _$v = other as _$ChangeRequestResponse;
  }

  @override
  void update(void Function(ChangeRequestResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangeRequestResponse build() => _build();

  _$ChangeRequestResponse _build() {
    _$ChangeRequestResponse _$result;
    try {
      _$result =
          _$v ??
          _$ChangeRequestResponse._(
            id: id,
            comment: comment,
            contestedTerms: _contestedTerms?.build(),
            createdAt: createdAt,
            response: response,
            respondedAt: respondedAt,
            withdrawnAt: withdrawnAt,
            pending: pending,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'contestedTerms';
        _contestedTerms?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ChangeRequestResponse',
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
