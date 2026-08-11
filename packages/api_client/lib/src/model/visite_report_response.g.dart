// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visite_report_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const VisiteReportResponseListingConformityEnum
_$visiteReportResponseListingConformityEnum_OUI =
    const VisiteReportResponseListingConformityEnum._('OUI');
const VisiteReportResponseListingConformityEnum
_$visiteReportResponseListingConformityEnum_PARTIELLEMENT =
    const VisiteReportResponseListingConformityEnum._('PARTIELLEMENT');
const VisiteReportResponseListingConformityEnum
_$visiteReportResponseListingConformityEnum_NON =
    const VisiteReportResponseListingConformityEnum._('NON');
const VisiteReportResponseListingConformityEnum
_$visiteReportResponseListingConformityEnum_unknownDefaultOpenApi =
    const VisiteReportResponseListingConformityEnum._('unknownDefaultOpenApi');

VisiteReportResponseListingConformityEnum
_$visiteReportResponseListingConformityEnumValueOf(String name) {
  switch (name) {
    case 'OUI':
      return _$visiteReportResponseListingConformityEnum_OUI;
    case 'PARTIELLEMENT':
      return _$visiteReportResponseListingConformityEnum_PARTIELLEMENT;
    case 'NON':
      return _$visiteReportResponseListingConformityEnum_NON;
    case 'unknownDefaultOpenApi':
      return _$visiteReportResponseListingConformityEnum_unknownDefaultOpenApi;
    default:
      return _$visiteReportResponseListingConformityEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<VisiteReportResponseListingConformityEnum>
_$visiteReportResponseListingConformityEnumValues =
    BuiltSet<VisiteReportResponseListingConformityEnum>(
      const <VisiteReportResponseListingConformityEnum>[
        _$visiteReportResponseListingConformityEnum_OUI,
        _$visiteReportResponseListingConformityEnum_PARTIELLEMENT,
        _$visiteReportResponseListingConformityEnum_NON,
        _$visiteReportResponseListingConformityEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<VisiteReportResponseListingConformityEnum>
_$visiteReportResponseListingConformityEnumSerializer =
    _$VisiteReportResponseListingConformityEnumSerializer();

class _$VisiteReportResponseListingConformityEnumSerializer
    implements PrimitiveSerializer<VisiteReportResponseListingConformityEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'OUI': 'OUI',
    'PARTIELLEMENT': 'PARTIELLEMENT',
    'NON': 'NON',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'OUI': 'OUI',
    'PARTIELLEMENT': 'PARTIELLEMENT',
    'NON': 'NON',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    VisiteReportResponseListingConformityEnum,
  ];
  @override
  final String wireName = 'VisiteReportResponseListingConformityEnum';

  @override
  Object serialize(
    Serializers serializers,
    VisiteReportResponseListingConformityEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  VisiteReportResponseListingConformityEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => VisiteReportResponseListingConformityEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$VisiteReportResponse extends VisiteReportResponse {
  @override
  final String? visiteId;
  @override
  final String? annonceId;
  @override
  final String? agentAccountId;
  @override
  final int? overallCondition;
  @override
  final VisiteReportResponseListingConformityEnum? listingConformity;
  @override
  final String? comment;
  @override
  final BuiltList<String>? photoKeys;
  @override
  final DateTime? submittedAt;

  factory _$VisiteReportResponse([
    void Function(VisiteReportResponseBuilder)? updates,
  ]) => (VisiteReportResponseBuilder()..update(updates))._build();

  _$VisiteReportResponse._({
    this.visiteId,
    this.annonceId,
    this.agentAccountId,
    this.overallCondition,
    this.listingConformity,
    this.comment,
    this.photoKeys,
    this.submittedAt,
  }) : super._();
  @override
  VisiteReportResponse rebuild(
    void Function(VisiteReportResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  VisiteReportResponseBuilder toBuilder() =>
      VisiteReportResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VisiteReportResponse &&
        visiteId == other.visiteId &&
        annonceId == other.annonceId &&
        agentAccountId == other.agentAccountId &&
        overallCondition == other.overallCondition &&
        listingConformity == other.listingConformity &&
        comment == other.comment &&
        photoKeys == other.photoKeys &&
        submittedAt == other.submittedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, visiteId.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, agentAccountId.hashCode);
    _$hash = $jc(_$hash, overallCondition.hashCode);
    _$hash = $jc(_$hash, listingConformity.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, photoKeys.hashCode);
    _$hash = $jc(_$hash, submittedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VisiteReportResponse')
          ..add('visiteId', visiteId)
          ..add('annonceId', annonceId)
          ..add('agentAccountId', agentAccountId)
          ..add('overallCondition', overallCondition)
          ..add('listingConformity', listingConformity)
          ..add('comment', comment)
          ..add('photoKeys', photoKeys)
          ..add('submittedAt', submittedAt))
        .toString();
  }
}

class VisiteReportResponseBuilder
    implements Builder<VisiteReportResponse, VisiteReportResponseBuilder> {
  _$VisiteReportResponse? _$v;

  String? _visiteId;
  String? get visiteId => _$this._visiteId;
  set visiteId(String? visiteId) => _$this._visiteId = visiteId;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _agentAccountId;
  String? get agentAccountId => _$this._agentAccountId;
  set agentAccountId(String? agentAccountId) =>
      _$this._agentAccountId = agentAccountId;

  int? _overallCondition;
  int? get overallCondition => _$this._overallCondition;
  set overallCondition(int? overallCondition) =>
      _$this._overallCondition = overallCondition;

  VisiteReportResponseListingConformityEnum? _listingConformity;
  VisiteReportResponseListingConformityEnum? get listingConformity =>
      _$this._listingConformity;
  set listingConformity(
    VisiteReportResponseListingConformityEnum? listingConformity,
  ) => _$this._listingConformity = listingConformity;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  ListBuilder<String>? _photoKeys;
  ListBuilder<String> get photoKeys =>
      _$this._photoKeys ??= ListBuilder<String>();
  set photoKeys(ListBuilder<String>? photoKeys) =>
      _$this._photoKeys = photoKeys;

  DateTime? _submittedAt;
  DateTime? get submittedAt => _$this._submittedAt;
  set submittedAt(DateTime? submittedAt) => _$this._submittedAt = submittedAt;

  VisiteReportResponseBuilder() {
    VisiteReportResponse._defaults(this);
  }

  VisiteReportResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _visiteId = $v.visiteId;
      _annonceId = $v.annonceId;
      _agentAccountId = $v.agentAccountId;
      _overallCondition = $v.overallCondition;
      _listingConformity = $v.listingConformity;
      _comment = $v.comment;
      _photoKeys = $v.photoKeys?.toBuilder();
      _submittedAt = $v.submittedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VisiteReportResponse other) {
    _$v = other as _$VisiteReportResponse;
  }

  @override
  void update(void Function(VisiteReportResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VisiteReportResponse build() => _build();

  _$VisiteReportResponse _build() {
    _$VisiteReportResponse _$result;
    try {
      _$result =
          _$v ??
          _$VisiteReportResponse._(
            visiteId: visiteId,
            annonceId: annonceId,
            agentAccountId: agentAccountId,
            overallCondition: overallCondition,
            listingConformity: listingConformity,
            comment: comment,
            photoKeys: _photoKeys?.build(),
            submittedAt: submittedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'photoKeys';
        _photoKeys?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'VisiteReportResponse',
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
