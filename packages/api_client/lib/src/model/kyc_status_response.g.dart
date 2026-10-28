// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_status_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const KycStatusResponseIdDocumentTypeEnum
_$kycStatusResponseIdDocumentTypeEnum_CNI =
    const KycStatusResponseIdDocumentTypeEnum._('CNI');
const KycStatusResponseIdDocumentTypeEnum
_$kycStatusResponseIdDocumentTypeEnum_PASSPORT =
    const KycStatusResponseIdDocumentTypeEnum._('PASSPORT');
const KycStatusResponseIdDocumentTypeEnum
_$kycStatusResponseIdDocumentTypeEnum_DRIVING_LICENCE =
    const KycStatusResponseIdDocumentTypeEnum._('DRIVING_LICENCE');
const KycStatusResponseIdDocumentTypeEnum
_$kycStatusResponseIdDocumentTypeEnum_unknownDefaultOpenApi =
    const KycStatusResponseIdDocumentTypeEnum._('unknownDefaultOpenApi');

KycStatusResponseIdDocumentTypeEnum
_$kycStatusResponseIdDocumentTypeEnumValueOf(String name) {
  switch (name) {
    case 'CNI':
      return _$kycStatusResponseIdDocumentTypeEnum_CNI;
    case 'PASSPORT':
      return _$kycStatusResponseIdDocumentTypeEnum_PASSPORT;
    case 'DRIVING_LICENCE':
      return _$kycStatusResponseIdDocumentTypeEnum_DRIVING_LICENCE;
    case 'unknownDefaultOpenApi':
      return _$kycStatusResponseIdDocumentTypeEnum_unknownDefaultOpenApi;
    default:
      return _$kycStatusResponseIdDocumentTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<KycStatusResponseIdDocumentTypeEnum>
_$kycStatusResponseIdDocumentTypeEnumValues =
    BuiltSet<KycStatusResponseIdDocumentTypeEnum>(
      const <KycStatusResponseIdDocumentTypeEnum>[
        _$kycStatusResponseIdDocumentTypeEnum_CNI,
        _$kycStatusResponseIdDocumentTypeEnum_PASSPORT,
        _$kycStatusResponseIdDocumentTypeEnum_DRIVING_LICENCE,
        _$kycStatusResponseIdDocumentTypeEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<KycStatusResponseIdDocumentTypeEnum>
_$kycStatusResponseIdDocumentTypeEnumSerializer =
    _$KycStatusResponseIdDocumentTypeEnumSerializer();

class _$KycStatusResponseIdDocumentTypeEnumSerializer
    implements PrimitiveSerializer<KycStatusResponseIdDocumentTypeEnum> {
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
    KycStatusResponseIdDocumentTypeEnum,
  ];
  @override
  final String wireName = 'KycStatusResponseIdDocumentTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    KycStatusResponseIdDocumentTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  KycStatusResponseIdDocumentTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => KycStatusResponseIdDocumentTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$KycStatusResponse extends KycStatusResponse {
  @override
  final String? status;
  @override
  final DateTime? submittedAt;
  @override
  final DateTime? reviewedAt;
  @override
  final String? rejectionReason;
  @override
  final String? nui;
  @override
  final KycAddress? address;
  @override
  final KycStatusResponseIdDocumentTypeEnum? idDocumentType;
  @override
  final String? idNumber;
  @override
  final Date? issuedOn;
  @override
  final Date? expiresOn;
  @override
  final String? issuedAt;

  factory _$KycStatusResponse([
    void Function(KycStatusResponseBuilder)? updates,
  ]) => (KycStatusResponseBuilder()..update(updates))._build();

  _$KycStatusResponse._({
    this.status,
    this.submittedAt,
    this.reviewedAt,
    this.rejectionReason,
    this.nui,
    this.address,
    this.idDocumentType,
    this.idNumber,
    this.issuedOn,
    this.expiresOn,
    this.issuedAt,
  }) : super._();
  @override
  KycStatusResponse rebuild(void Function(KycStatusResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KycStatusResponseBuilder toBuilder() =>
      KycStatusResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KycStatusResponse &&
        status == other.status &&
        submittedAt == other.submittedAt &&
        reviewedAt == other.reviewedAt &&
        rejectionReason == other.rejectionReason &&
        nui == other.nui &&
        address == other.address &&
        idDocumentType == other.idDocumentType &&
        idNumber == other.idNumber &&
        issuedOn == other.issuedOn &&
        expiresOn == other.expiresOn &&
        issuedAt == other.issuedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, submittedAt.hashCode);
    _$hash = $jc(_$hash, reviewedAt.hashCode);
    _$hash = $jc(_$hash, rejectionReason.hashCode);
    _$hash = $jc(_$hash, nui.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
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
    return (newBuiltValueToStringHelper(r'KycStatusResponse')
          ..add('status', status)
          ..add('submittedAt', submittedAt)
          ..add('reviewedAt', reviewedAt)
          ..add('rejectionReason', rejectionReason)
          ..add('nui', nui)
          ..add('address', address)
          ..add('idDocumentType', idDocumentType)
          ..add('idNumber', idNumber)
          ..add('issuedOn', issuedOn)
          ..add('expiresOn', expiresOn)
          ..add('issuedAt', issuedAt))
        .toString();
  }
}

class KycStatusResponseBuilder
    implements Builder<KycStatusResponse, KycStatusResponseBuilder> {
  _$KycStatusResponse? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  DateTime? _submittedAt;
  DateTime? get submittedAt => _$this._submittedAt;
  set submittedAt(DateTime? submittedAt) => _$this._submittedAt = submittedAt;

  DateTime? _reviewedAt;
  DateTime? get reviewedAt => _$this._reviewedAt;
  set reviewedAt(DateTime? reviewedAt) => _$this._reviewedAt = reviewedAt;

  String? _rejectionReason;
  String? get rejectionReason => _$this._rejectionReason;
  set rejectionReason(String? rejectionReason) =>
      _$this._rejectionReason = rejectionReason;

  String? _nui;
  String? get nui => _$this._nui;
  set nui(String? nui) => _$this._nui = nui;

  KycAddressBuilder? _address;
  KycAddressBuilder get address => _$this._address ??= KycAddressBuilder();
  set address(KycAddressBuilder? address) => _$this._address = address;

  KycStatusResponseIdDocumentTypeEnum? _idDocumentType;
  KycStatusResponseIdDocumentTypeEnum? get idDocumentType =>
      _$this._idDocumentType;
  set idDocumentType(KycStatusResponseIdDocumentTypeEnum? idDocumentType) =>
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

  KycStatusResponseBuilder() {
    KycStatusResponse._defaults(this);
  }

  KycStatusResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _submittedAt = $v.submittedAt;
      _reviewedAt = $v.reviewedAt;
      _rejectionReason = $v.rejectionReason;
      _nui = $v.nui;
      _address = $v.address?.toBuilder();
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
  void replace(KycStatusResponse other) {
    _$v = other as _$KycStatusResponse;
  }

  @override
  void update(void Function(KycStatusResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KycStatusResponse build() => _build();

  _$KycStatusResponse _build() {
    _$KycStatusResponse _$result;
    try {
      _$result =
          _$v ??
          _$KycStatusResponse._(
            status: status,
            submittedAt: submittedAt,
            reviewedAt: reviewedAt,
            rejectionReason: rejectionReason,
            nui: nui,
            address: _address?.build(),
            idDocumentType: idDocumentType,
            idNumber: idNumber,
            issuedOn: issuedOn,
            expiresOn: expiresOn,
            issuedAt: issuedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'address';
        _address?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'KycStatusResponse',
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
