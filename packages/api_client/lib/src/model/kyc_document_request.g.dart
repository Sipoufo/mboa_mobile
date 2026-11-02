// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_document_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const KycDocumentRequestIdDocumentTypeEnum
_$kycDocumentRequestIdDocumentTypeEnum_CNI =
    const KycDocumentRequestIdDocumentTypeEnum._('CNI');
const KycDocumentRequestIdDocumentTypeEnum
_$kycDocumentRequestIdDocumentTypeEnum_PASSPORT =
    const KycDocumentRequestIdDocumentTypeEnum._('PASSPORT');
const KycDocumentRequestIdDocumentTypeEnum
_$kycDocumentRequestIdDocumentTypeEnum_DRIVING_LICENCE =
    const KycDocumentRequestIdDocumentTypeEnum._('DRIVING_LICENCE');
const KycDocumentRequestIdDocumentTypeEnum
_$kycDocumentRequestIdDocumentTypeEnum_unknownDefaultOpenApi =
    const KycDocumentRequestIdDocumentTypeEnum._('unknownDefaultOpenApi');

KycDocumentRequestIdDocumentTypeEnum
_$kycDocumentRequestIdDocumentTypeEnumValueOf(String name) {
  switch (name) {
    case 'CNI':
      return _$kycDocumentRequestIdDocumentTypeEnum_CNI;
    case 'PASSPORT':
      return _$kycDocumentRequestIdDocumentTypeEnum_PASSPORT;
    case 'DRIVING_LICENCE':
      return _$kycDocumentRequestIdDocumentTypeEnum_DRIVING_LICENCE;
    case 'unknownDefaultOpenApi':
      return _$kycDocumentRequestIdDocumentTypeEnum_unknownDefaultOpenApi;
    default:
      return _$kycDocumentRequestIdDocumentTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<KycDocumentRequestIdDocumentTypeEnum>
_$kycDocumentRequestIdDocumentTypeEnumValues =
    BuiltSet<KycDocumentRequestIdDocumentTypeEnum>(
      const <KycDocumentRequestIdDocumentTypeEnum>[
        _$kycDocumentRequestIdDocumentTypeEnum_CNI,
        _$kycDocumentRequestIdDocumentTypeEnum_PASSPORT,
        _$kycDocumentRequestIdDocumentTypeEnum_DRIVING_LICENCE,
        _$kycDocumentRequestIdDocumentTypeEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<KycDocumentRequestIdDocumentTypeEnum>
_$kycDocumentRequestIdDocumentTypeEnumSerializer =
    _$KycDocumentRequestIdDocumentTypeEnumSerializer();

class _$KycDocumentRequestIdDocumentTypeEnumSerializer
    implements PrimitiveSerializer<KycDocumentRequestIdDocumentTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CNI': 'CNI',
    'PASSPORT': 'PASSPORT',
    'DRIVING_LICENCE': 'DRIVING_LICENCE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CNI': 'CNI',
    'PASSPORT': 'PASSPORT',
    'DRIVING_LICENCE': 'DRIVING_LICENCE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    KycDocumentRequestIdDocumentTypeEnum,
  ];
  @override
  final String wireName = 'KycDocumentRequestIdDocumentTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    KycDocumentRequestIdDocumentTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  KycDocumentRequestIdDocumentTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => KycDocumentRequestIdDocumentTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$KycDocumentRequest extends KycDocumentRequest {
  @override
  final KycDocumentRequestIdDocumentTypeEnum idDocumentType;
  @override
  final String idNumber;
  @override
  final Date issuedOn;
  @override
  final Date expiresOn;
  @override
  final String issuedAt;

  factory _$KycDocumentRequest([
    void Function(KycDocumentRequestBuilder)? updates,
  ]) => (KycDocumentRequestBuilder()..update(updates))._build();

  _$KycDocumentRequest._({
    required this.idDocumentType,
    required this.idNumber,
    required this.issuedOn,
    required this.expiresOn,
    required this.issuedAt,
  }) : super._();
  @override
  KycDocumentRequest rebuild(
    void Function(KycDocumentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  KycDocumentRequestBuilder toBuilder() =>
      KycDocumentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KycDocumentRequest &&
        idDocumentType == other.idDocumentType &&
        idNumber == other.idNumber &&
        issuedOn == other.issuedOn &&
        expiresOn == other.expiresOn &&
        issuedAt == other.issuedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, idDocumentType.hashCode);
    _$hash = $jc(_$hash, idNumber.hashCode);
    _$hash = $jc(_$hash, issuedOn.hashCode);
    _$hash = $jc(_$hash, expiresOn.hashCode);
    _$hash = $jc(_$hash, issuedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KycDocumentRequest')
          ..add('idDocumentType', idDocumentType)
          ..add('idNumber', idNumber)
          ..add('issuedOn', issuedOn)
          ..add('expiresOn', expiresOn)
          ..add('issuedAt', issuedAt))
        .toString();
  }
}

class KycDocumentRequestBuilder
    implements Builder<KycDocumentRequest, KycDocumentRequestBuilder> {
  _$KycDocumentRequest? _$v;

  KycDocumentRequestIdDocumentTypeEnum? _idDocumentType;
  KycDocumentRequestIdDocumentTypeEnum? get idDocumentType =>
      _$this._idDocumentType;
  set idDocumentType(KycDocumentRequestIdDocumentTypeEnum? idDocumentType) =>
      _$this._idDocumentType = idDocumentType;

  String? _idNumber;
  String? get idNumber => _$this._idNumber;
  set idNumber(String? idNumber) => _$this._idNumber = idNumber;

  Date? _issuedOn;
  Date? get issuedOn => _$this._issuedOn;
  set issuedOn(Date? issuedOn) => _$this._issuedOn = issuedOn;

  Date? _expiresOn;
  Date? get expiresOn => _$this._expiresOn;
  set expiresOn(Date? expiresOn) => _$this._expiresOn = expiresOn;

  String? _issuedAt;
  String? get issuedAt => _$this._issuedAt;
  set issuedAt(String? issuedAt) => _$this._issuedAt = issuedAt;

  KycDocumentRequestBuilder() {
    KycDocumentRequest._defaults(this);
  }

  KycDocumentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _idDocumentType = $v.idDocumentType;
      _idNumber = $v.idNumber;
      _issuedOn = $v.issuedOn;
      _expiresOn = $v.expiresOn;
      _issuedAt = $v.issuedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KycDocumentRequest other) {
    _$v = other as _$KycDocumentRequest;
  }

  @override
  void update(void Function(KycDocumentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KycDocumentRequest build() => _build();

  _$KycDocumentRequest _build() {
    final _$result =
        _$v ??
        _$KycDocumentRequest._(
          idDocumentType: BuiltValueNullFieldError.checkNotNull(
            idDocumentType,
            r'KycDocumentRequest',
            'idDocumentType',
          ),
          idNumber: BuiltValueNullFieldError.checkNotNull(
            idNumber,
            r'KycDocumentRequest',
            'idNumber',
          ),
          issuedOn: BuiltValueNullFieldError.checkNotNull(
            issuedOn,
            r'KycDocumentRequest',
            'issuedOn',
          ),
          expiresOn: BuiltValueNullFieldError.checkNotNull(
            expiresOn,
            r'KycDocumentRequest',
            'expiresOn',
          ),
          issuedAt: BuiltValueNullFieldError.checkNotNull(
            issuedAt,
            r'KycDocumentRequest',
            'issuedAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
