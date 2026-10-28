// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_identity_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SignatureIdentityResponseIdDocumentTypeEnum
_$signatureIdentityResponseIdDocumentTypeEnum_CNI =
    const SignatureIdentityResponseIdDocumentTypeEnum._('CNI');
const SignatureIdentityResponseIdDocumentTypeEnum
_$signatureIdentityResponseIdDocumentTypeEnum_PASSPORT =
    const SignatureIdentityResponseIdDocumentTypeEnum._('PASSPORT');
const SignatureIdentityResponseIdDocumentTypeEnum
_$signatureIdentityResponseIdDocumentTypeEnum_DRIVING_LICENCE =
    const SignatureIdentityResponseIdDocumentTypeEnum._('DRIVING_LICENCE');
const SignatureIdentityResponseIdDocumentTypeEnum
_$signatureIdentityResponseIdDocumentTypeEnum_unknownDefaultOpenApi =
    const SignatureIdentityResponseIdDocumentTypeEnum._(
      'unknownDefaultOpenApi',
    );

SignatureIdentityResponseIdDocumentTypeEnum
_$signatureIdentityResponseIdDocumentTypeEnumValueOf(String name) {
  switch (name) {
    case 'CNI':
      return _$signatureIdentityResponseIdDocumentTypeEnum_CNI;
    case 'PASSPORT':
      return _$signatureIdentityResponseIdDocumentTypeEnum_PASSPORT;
    case 'DRIVING_LICENCE':
      return _$signatureIdentityResponseIdDocumentTypeEnum_DRIVING_LICENCE;
    case 'unknownDefaultOpenApi':
      return _$signatureIdentityResponseIdDocumentTypeEnum_unknownDefaultOpenApi;
    default:
      return _$signatureIdentityResponseIdDocumentTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<SignatureIdentityResponseIdDocumentTypeEnum>
_$signatureIdentityResponseIdDocumentTypeEnumValues =
    BuiltSet<SignatureIdentityResponseIdDocumentTypeEnum>(
      const <SignatureIdentityResponseIdDocumentTypeEnum>[
        _$signatureIdentityResponseIdDocumentTypeEnum_CNI,
        _$signatureIdentityResponseIdDocumentTypeEnum_PASSPORT,
        _$signatureIdentityResponseIdDocumentTypeEnum_DRIVING_LICENCE,
        _$signatureIdentityResponseIdDocumentTypeEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<SignatureIdentityResponseIdDocumentTypeEnum>
_$signatureIdentityResponseIdDocumentTypeEnumSerializer =
    _$SignatureIdentityResponseIdDocumentTypeEnumSerializer();

class _$SignatureIdentityResponseIdDocumentTypeEnumSerializer
    implements
        PrimitiveSerializer<SignatureIdentityResponseIdDocumentTypeEnum> {
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
    SignatureIdentityResponseIdDocumentTypeEnum,
  ];
  @override
  final String wireName = 'SignatureIdentityResponseIdDocumentTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    SignatureIdentityResponseIdDocumentTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SignatureIdentityResponseIdDocumentTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SignatureIdentityResponseIdDocumentTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SignatureIdentityResponse extends SignatureIdentityResponse {
  @override
  final SignatureIdentityResponseIdDocumentTypeEnum? idDocumentType;
  @override
  final String? idNumber;
  @override
  final Date? issuedOn;
  @override
  final Date? expiresOn;
  @override
  final String? issuedAt;
  @override
  final bool? verified;

  factory _$SignatureIdentityResponse([
    void Function(SignatureIdentityResponseBuilder)? updates,
  ]) => (SignatureIdentityResponseBuilder()..update(updates))._build();

  _$SignatureIdentityResponse._({
    this.idDocumentType,
    this.idNumber,
    this.issuedOn,
    this.expiresOn,
    this.issuedAt,
    this.verified,
  }) : super._();
  @override
  SignatureIdentityResponse rebuild(
    void Function(SignatureIdentityResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SignatureIdentityResponseBuilder toBuilder() =>
      SignatureIdentityResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignatureIdentityResponse &&
        idDocumentType == other.idDocumentType &&
        idNumber == other.idNumber &&
        issuedOn == other.issuedOn &&
        expiresOn == other.expiresOn &&
        issuedAt == other.issuedAt &&
        verified == other.verified;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, idDocumentType.hashCode);
    _$hash = $jc(_$hash, idNumber.hashCode);
    _$hash = $jc(_$hash, issuedOn.hashCode);
    _$hash = $jc(_$hash, expiresOn.hashCode);
    _$hash = $jc(_$hash, issuedAt.hashCode);
    _$hash = $jc(_$hash, verified.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignatureIdentityResponse')
          ..add('idDocumentType', idDocumentType)
          ..add('idNumber', idNumber)
          ..add('issuedOn', issuedOn)
          ..add('expiresOn', expiresOn)
          ..add('issuedAt', issuedAt)
          ..add('verified', verified))
        .toString();
  }
}

class SignatureIdentityResponseBuilder
    implements
        Builder<SignatureIdentityResponse, SignatureIdentityResponseBuilder> {
  _$SignatureIdentityResponse? _$v;

  SignatureIdentityResponseIdDocumentTypeEnum? _idDocumentType;
  SignatureIdentityResponseIdDocumentTypeEnum? get idDocumentType =>
      _$this._idDocumentType;
  set idDocumentType(
    SignatureIdentityResponseIdDocumentTypeEnum? idDocumentType,
  ) => _$this._idDocumentType = idDocumentType;

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

  bool? _verified;
  bool? get verified => _$this._verified;
  set verified(bool? verified) => _$this._verified = verified;

  SignatureIdentityResponseBuilder() {
    SignatureIdentityResponse._defaults(this);
  }

  SignatureIdentityResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _idDocumentType = $v.idDocumentType;
      _idNumber = $v.idNumber;
      _issuedOn = $v.issuedOn;
      _expiresOn = $v.expiresOn;
      _issuedAt = $v.issuedAt;
      _verified = $v.verified;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignatureIdentityResponse other) {
    _$v = other as _$SignatureIdentityResponse;
  }

  @override
  void update(void Function(SignatureIdentityResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignatureIdentityResponse build() => _build();

  _$SignatureIdentityResponse _build() {
    final _$result =
        _$v ??
        _$SignatureIdentityResponse._(
          idDocumentType: idDocumentType,
          idNumber: idNumber,
          issuedOn: issuedOn,
          expiresOn: expiresOn,
          issuedAt: issuedAt,
          verified: verified,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
