// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signing_identity_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SigningIdentityRequestIdDocumentTypeEnum
_$signingIdentityRequestIdDocumentTypeEnum_CNI =
    const SigningIdentityRequestIdDocumentTypeEnum._('CNI');
const SigningIdentityRequestIdDocumentTypeEnum
_$signingIdentityRequestIdDocumentTypeEnum_PASSPORT =
    const SigningIdentityRequestIdDocumentTypeEnum._('PASSPORT');
const SigningIdentityRequestIdDocumentTypeEnum
_$signingIdentityRequestIdDocumentTypeEnum_DRIVING_LICENCE =
    const SigningIdentityRequestIdDocumentTypeEnum._('DRIVING_LICENCE');
const SigningIdentityRequestIdDocumentTypeEnum
_$signingIdentityRequestIdDocumentTypeEnum_unknownDefaultOpenApi =
    const SigningIdentityRequestIdDocumentTypeEnum._('unknownDefaultOpenApi');

SigningIdentityRequestIdDocumentTypeEnum
_$signingIdentityRequestIdDocumentTypeEnumValueOf(String name) {
  switch (name) {
    case 'CNI':
      return _$signingIdentityRequestIdDocumentTypeEnum_CNI;
    case 'PASSPORT':
      return _$signingIdentityRequestIdDocumentTypeEnum_PASSPORT;
    case 'DRIVING_LICENCE':
      return _$signingIdentityRequestIdDocumentTypeEnum_DRIVING_LICENCE;
    case 'unknownDefaultOpenApi':
      return _$signingIdentityRequestIdDocumentTypeEnum_unknownDefaultOpenApi;
    default:
      return _$signingIdentityRequestIdDocumentTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<SigningIdentityRequestIdDocumentTypeEnum>
_$signingIdentityRequestIdDocumentTypeEnumValues =
    BuiltSet<SigningIdentityRequestIdDocumentTypeEnum>(
      const <SigningIdentityRequestIdDocumentTypeEnum>[
        _$signingIdentityRequestIdDocumentTypeEnum_CNI,
        _$signingIdentityRequestIdDocumentTypeEnum_PASSPORT,
        _$signingIdentityRequestIdDocumentTypeEnum_DRIVING_LICENCE,
        _$signingIdentityRequestIdDocumentTypeEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<SigningIdentityRequestIdDocumentTypeEnum>
_$signingIdentityRequestIdDocumentTypeEnumSerializer =
    _$SigningIdentityRequestIdDocumentTypeEnumSerializer();

class _$SigningIdentityRequestIdDocumentTypeEnumSerializer
    implements PrimitiveSerializer<SigningIdentityRequestIdDocumentTypeEnum> {
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
    SigningIdentityRequestIdDocumentTypeEnum,
  ];
  @override
  final String wireName = 'SigningIdentityRequestIdDocumentTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    SigningIdentityRequestIdDocumentTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SigningIdentityRequestIdDocumentTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SigningIdentityRequestIdDocumentTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SigningIdentityRequest extends SigningIdentityRequest {
  @override
  final SigningIdentityRequestIdDocumentTypeEnum idDocumentType;
  @override
  final String idNumber;
  @override
  final Date issuedOn;
  @override
  final Date expiresOn;
  @override
  final String issuedAt;

  factory _$SigningIdentityRequest([
    void Function(SigningIdentityRequestBuilder)? updates,
  ]) => (SigningIdentityRequestBuilder()..update(updates))._build();

  _$SigningIdentityRequest._({
    required this.idDocumentType,
    required this.idNumber,
    required this.issuedOn,
    required this.expiresOn,
    required this.issuedAt,
  }) : super._();
  @override
  SigningIdentityRequest rebuild(
    void Function(SigningIdentityRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SigningIdentityRequestBuilder toBuilder() =>
      SigningIdentityRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SigningIdentityRequest &&
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
    return (newBuiltValueToStringHelper(r'SigningIdentityRequest')
          ..add('idDocumentType', idDocumentType)
          ..add('idNumber', idNumber)
          ..add('issuedOn', issuedOn)
          ..add('expiresOn', expiresOn)
          ..add('issuedAt', issuedAt))
        .toString();
  }
}

class SigningIdentityRequestBuilder
    implements Builder<SigningIdentityRequest, SigningIdentityRequestBuilder> {
  _$SigningIdentityRequest? _$v;

  SigningIdentityRequestIdDocumentTypeEnum? _idDocumentType;
  SigningIdentityRequestIdDocumentTypeEnum? get idDocumentType =>
      _$this._idDocumentType;
  set idDocumentType(
    SigningIdentityRequestIdDocumentTypeEnum? idDocumentType,
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

  SigningIdentityRequestBuilder() {
    SigningIdentityRequest._defaults(this);
  }

  SigningIdentityRequestBuilder get _$this {
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
  void replace(SigningIdentityRequest other) {
    _$v = other as _$SigningIdentityRequest;
  }

  @override
  void update(void Function(SigningIdentityRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SigningIdentityRequest build() => _build();

  _$SigningIdentityRequest _build() {
    final _$result =
        _$v ??
        _$SigningIdentityRequest._(
          idDocumentType: BuiltValueNullFieldError.checkNotNull(
            idDocumentType,
            r'SigningIdentityRequest',
            'idDocumentType',
          ),
          idNumber: BuiltValueNullFieldError.checkNotNull(
            idNumber,
            r'SigningIdentityRequest',
            'idNumber',
          ),
          issuedOn: BuiltValueNullFieldError.checkNotNull(
            issuedOn,
            r'SigningIdentityRequest',
            'issuedOn',
          ),
          expiresOn: BuiltValueNullFieldError.checkNotNull(
            expiresOn,
            r'SigningIdentityRequest',
            'expiresOn',
          ),
          issuedAt: BuiltValueNullFieldError.checkNotNull(
            issuedAt,
            r'SigningIdentityRequest',
            'issuedAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
