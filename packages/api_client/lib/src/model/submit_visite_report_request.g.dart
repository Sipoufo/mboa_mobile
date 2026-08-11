// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_visite_report_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SubmitVisiteReportRequestListingConformityEnum
_$submitVisiteReportRequestListingConformityEnum_OUI =
    const SubmitVisiteReportRequestListingConformityEnum._('OUI');
const SubmitVisiteReportRequestListingConformityEnum
_$submitVisiteReportRequestListingConformityEnum_PARTIELLEMENT =
    const SubmitVisiteReportRequestListingConformityEnum._('PARTIELLEMENT');
const SubmitVisiteReportRequestListingConformityEnum
_$submitVisiteReportRequestListingConformityEnum_NON =
    const SubmitVisiteReportRequestListingConformityEnum._('NON');
const SubmitVisiteReportRequestListingConformityEnum
_$submitVisiteReportRequestListingConformityEnum_unknownDefaultOpenApi =
    const SubmitVisiteReportRequestListingConformityEnum._(
      'unknownDefaultOpenApi',
    );

SubmitVisiteReportRequestListingConformityEnum
_$submitVisiteReportRequestListingConformityEnumValueOf(String name) {
  switch (name) {
    case 'OUI':
      return _$submitVisiteReportRequestListingConformityEnum_OUI;
    case 'PARTIELLEMENT':
      return _$submitVisiteReportRequestListingConformityEnum_PARTIELLEMENT;
    case 'NON':
      return _$submitVisiteReportRequestListingConformityEnum_NON;
    case 'unknownDefaultOpenApi':
      return _$submitVisiteReportRequestListingConformityEnum_unknownDefaultOpenApi;
    default:
      return _$submitVisiteReportRequestListingConformityEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<SubmitVisiteReportRequestListingConformityEnum>
_$submitVisiteReportRequestListingConformityEnumValues =
    BuiltSet<SubmitVisiteReportRequestListingConformityEnum>(
      const <SubmitVisiteReportRequestListingConformityEnum>[
        _$submitVisiteReportRequestListingConformityEnum_OUI,
        _$submitVisiteReportRequestListingConformityEnum_PARTIELLEMENT,
        _$submitVisiteReportRequestListingConformityEnum_NON,
        _$submitVisiteReportRequestListingConformityEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<SubmitVisiteReportRequestListingConformityEnum>
_$submitVisiteReportRequestListingConformityEnumSerializer =
    _$SubmitVisiteReportRequestListingConformityEnumSerializer();

class _$SubmitVisiteReportRequestListingConformityEnumSerializer
    implements
        PrimitiveSerializer<SubmitVisiteReportRequestListingConformityEnum> {
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
    SubmitVisiteReportRequestListingConformityEnum,
  ];
  @override
  final String wireName = 'SubmitVisiteReportRequestListingConformityEnum';

  @override
  Object serialize(
    Serializers serializers,
    SubmitVisiteReportRequestListingConformityEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SubmitVisiteReportRequestListingConformityEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SubmitVisiteReportRequestListingConformityEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SubmitVisiteReportRequest extends SubmitVisiteReportRequest {
  @override
  final int overallCondition;
  @override
  final SubmitVisiteReportRequestListingConformityEnum listingConformity;
  @override
  final String? comment;
  @override
  final BuiltList<String> photoKeys;

  factory _$SubmitVisiteReportRequest([
    void Function(SubmitVisiteReportRequestBuilder)? updates,
  ]) => (SubmitVisiteReportRequestBuilder()..update(updates))._build();

  _$SubmitVisiteReportRequest._({
    required this.overallCondition,
    required this.listingConformity,
    this.comment,
    required this.photoKeys,
  }) : super._();
  @override
  SubmitVisiteReportRequest rebuild(
    void Function(SubmitVisiteReportRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SubmitVisiteReportRequestBuilder toBuilder() =>
      SubmitVisiteReportRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubmitVisiteReportRequest &&
        overallCondition == other.overallCondition &&
        listingConformity == other.listingConformity &&
        comment == other.comment &&
        photoKeys == other.photoKeys;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, overallCondition.hashCode);
    _$hash = $jc(_$hash, listingConformity.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, photoKeys.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubmitVisiteReportRequest')
          ..add('overallCondition', overallCondition)
          ..add('listingConformity', listingConformity)
          ..add('comment', comment)
          ..add('photoKeys', photoKeys))
        .toString();
  }
}

class SubmitVisiteReportRequestBuilder
    implements
        Builder<SubmitVisiteReportRequest, SubmitVisiteReportRequestBuilder> {
  _$SubmitVisiteReportRequest? _$v;

  int? _overallCondition;
  int? get overallCondition => _$this._overallCondition;
  set overallCondition(int? overallCondition) =>
      _$this._overallCondition = overallCondition;

  SubmitVisiteReportRequestListingConformityEnum? _listingConformity;
  SubmitVisiteReportRequestListingConformityEnum? get listingConformity =>
      _$this._listingConformity;
  set listingConformity(
    SubmitVisiteReportRequestListingConformityEnum? listingConformity,
  ) => _$this._listingConformity = listingConformity;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  ListBuilder<String>? _photoKeys;
  ListBuilder<String> get photoKeys =>
      _$this._photoKeys ??= ListBuilder<String>();
  set photoKeys(ListBuilder<String>? photoKeys) =>
      _$this._photoKeys = photoKeys;

  SubmitVisiteReportRequestBuilder() {
    SubmitVisiteReportRequest._defaults(this);
  }

  SubmitVisiteReportRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _overallCondition = $v.overallCondition;
      _listingConformity = $v.listingConformity;
      _comment = $v.comment;
      _photoKeys = $v.photoKeys.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubmitVisiteReportRequest other) {
    _$v = other as _$SubmitVisiteReportRequest;
  }

  @override
  void update(void Function(SubmitVisiteReportRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubmitVisiteReportRequest build() => _build();

  _$SubmitVisiteReportRequest _build() {
    _$SubmitVisiteReportRequest _$result;
    try {
      _$result =
          _$v ??
          _$SubmitVisiteReportRequest._(
            overallCondition: BuiltValueNullFieldError.checkNotNull(
              overallCondition,
              r'SubmitVisiteReportRequest',
              'overallCondition',
            ),
            listingConformity: BuiltValueNullFieldError.checkNotNull(
              listingConformity,
              r'SubmitVisiteReportRequest',
              'listingConformity',
            ),
            comment: comment,
            photoKeys: photoKeys.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'photoKeys';
        photoKeys.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SubmitVisiteReportRequest',
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
