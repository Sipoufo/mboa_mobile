// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_kyc_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SubmitKycRequestIdDocumentTypeEnum
_$submitKycRequestIdDocumentTypeEnum_CNI =
    const SubmitKycRequestIdDocumentTypeEnum._('CNI');
const SubmitKycRequestIdDocumentTypeEnum
_$submitKycRequestIdDocumentTypeEnum_PASSPORT =
    const SubmitKycRequestIdDocumentTypeEnum._('PASSPORT');
const SubmitKycRequestIdDocumentTypeEnum
_$submitKycRequestIdDocumentTypeEnum_DRIVING_LICENCE =
    const SubmitKycRequestIdDocumentTypeEnum._('DRIVING_LICENCE');
const SubmitKycRequestIdDocumentTypeEnum
_$submitKycRequestIdDocumentTypeEnum_unknownDefaultOpenApi =
    const SubmitKycRequestIdDocumentTypeEnum._('unknownDefaultOpenApi');

SubmitKycRequestIdDocumentTypeEnum _$submitKycRequestIdDocumentTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'CNI':
      return _$submitKycRequestIdDocumentTypeEnum_CNI;
    case 'PASSPORT':
      return _$submitKycRequestIdDocumentTypeEnum_PASSPORT;
    case 'DRIVING_LICENCE':
      return _$submitKycRequestIdDocumentTypeEnum_DRIVING_LICENCE;
    case 'unknownDefaultOpenApi':
      return _$submitKycRequestIdDocumentTypeEnum_unknownDefaultOpenApi;
    default:
      return _$submitKycRequestIdDocumentTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<SubmitKycRequestIdDocumentTypeEnum>
_$submitKycRequestIdDocumentTypeEnumValues =
    BuiltSet<SubmitKycRequestIdDocumentTypeEnum>(
      const <SubmitKycRequestIdDocumentTypeEnum>[
        _$submitKycRequestIdDocumentTypeEnum_CNI,
        _$submitKycRequestIdDocumentTypeEnum_PASSPORT,
        _$submitKycRequestIdDocumentTypeEnum_DRIVING_LICENCE,
        _$submitKycRequestIdDocumentTypeEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<SubmitKycRequestIdDocumentTypeEnum>
_$submitKycRequestIdDocumentTypeEnumSerializer =
    _$SubmitKycRequestIdDocumentTypeEnumSerializer();

class _$SubmitKycRequestIdDocumentTypeEnumSerializer
    implements PrimitiveSerializer<SubmitKycRequestIdDocumentTypeEnum> {
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
  final Iterable<Type> types = const <Type>[SubmitKycRequestIdDocumentTypeEnum];
  @override
  final String wireName = 'SubmitKycRequestIdDocumentTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    SubmitKycRequestIdDocumentTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SubmitKycRequestIdDocumentTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SubmitKycRequestIdDocumentTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SubmitKycRequest extends SubmitKycRequest {
  @override
  final String idDocumentFrontKey;
  @override
  final String? idDocumentBackKey;
  @override
  final String selfieKey;
  @override
  final String? nui;
  @override
  final KycAddressRequest? address;
  @override
  final SubmitKycRequestIdDocumentTypeEnum idDocumentType;
  @override
  final String idNumber;
  @override
  final Date issuedOn;
  @override
  final Date expiresOn;
  @override
  final String issuedAt;

  factory _$SubmitKycRequest([
    void Function(SubmitKycRequestBuilder)? updates,
  ]) => (SubmitKycRequestBuilder()..update(updates))._build();

  _$SubmitKycRequest._({
    required this.idDocumentFrontKey,
    this.idDocumentBackKey,
    required this.selfieKey,
    this.nui,
    this.address,
    required this.idDocumentType,
    required this.idNumber,
    required this.issuedOn,
    required this.expiresOn,
    required this.issuedAt,
  }) : super._();
  @override
  SubmitKycRequest rebuild(void Function(SubmitKycRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubmitKycRequestBuilder toBuilder() =>
      SubmitKycRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubmitKycRequest &&
        idDocumentFrontKey == other.idDocumentFrontKey &&
        idDocumentBackKey == other.idDocumentBackKey &&
        selfieKey == other.selfieKey &&
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
    _$hash = $jc(_$hash, idDocumentFrontKey.hashCode);
    _$hash = $jc(_$hash, idDocumentBackKey.hashCode);
    _$hash = $jc(_$hash, selfieKey.hashCode);
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
    return (newBuiltValueToStringHelper(r'SubmitKycRequest')
          ..add('idDocumentFrontKey', idDocumentFrontKey)
          ..add('idDocumentBackKey', idDocumentBackKey)
          ..add('selfieKey', selfieKey)
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

class SubmitKycRequestBuilder
    implements Builder<SubmitKycRequest, SubmitKycRequestBuilder> {
  _$SubmitKycRequest? _$v;

  String? _idDocumentFrontKey;
  String? get idDocumentFrontKey => _$this._idDocumentFrontKey;
  set idDocumentFrontKey(String? idDocumentFrontKey) =>
      _$this._idDocumentFrontKey = idDocumentFrontKey;

  String? _idDocumentBackKey;
  String? get idDocumentBackKey => _$this._idDocumentBackKey;
  set idDocumentBackKey(String? idDocumentBackKey) =>
      _$this._idDocumentBackKey = idDocumentBackKey;

  String? _selfieKey;
  String? get selfieKey => _$this._selfieKey;
  set selfieKey(String? selfieKey) => _$this._selfieKey = selfieKey;

  String? _nui;
  String? get nui => _$this._nui;
  set nui(String? nui) => _$this._nui = nui;

  KycAddressRequestBuilder? _address;
  KycAddressRequestBuilder get address =>
      _$this._address ??= KycAddressRequestBuilder();
  set address(KycAddressRequestBuilder? address) => _$this._address = address;

  SubmitKycRequestIdDocumentTypeEnum? _idDocumentType;
  SubmitKycRequestIdDocumentTypeEnum? get idDocumentType =>
      _$this._idDocumentType;
  set idDocumentType(SubmitKycRequestIdDocumentTypeEnum? idDocumentType) =>
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

  SubmitKycRequestBuilder() {
    SubmitKycRequest._defaults(this);
  }

  SubmitKycRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _idDocumentFrontKey = $v.idDocumentFrontKey;
      _idDocumentBackKey = $v.idDocumentBackKey;
      _selfieKey = $v.selfieKey;
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
  void replace(SubmitKycRequest other) {
    _$v = other as _$SubmitKycRequest;
  }

  @override
  void update(void Function(SubmitKycRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubmitKycRequest build() => _build();

  _$SubmitKycRequest _build() {
    _$SubmitKycRequest _$result;
    try {
      _$result =
          _$v ??
          _$SubmitKycRequest._(
            idDocumentFrontKey: BuiltValueNullFieldError.checkNotNull(
              idDocumentFrontKey,
              r'SubmitKycRequest',
              'idDocumentFrontKey',
            ),
            idDocumentBackKey: idDocumentBackKey,
            selfieKey: BuiltValueNullFieldError.checkNotNull(
              selfieKey,
              r'SubmitKycRequest',
              'selfieKey',
            ),
            nui: nui,
            address: _address?.build(),
            idDocumentType: BuiltValueNullFieldError.checkNotNull(
              idDocumentType,
              r'SubmitKycRequest',
              'idDocumentType',
            ),
            idNumber: BuiltValueNullFieldError.checkNotNull(
              idNumber,
              r'SubmitKycRequest',
              'idNumber',
            ),
            issuedOn: BuiltValueNullFieldError.checkNotNull(
              issuedOn,
              r'SubmitKycRequest',
              'issuedOn',
            ),
            expiresOn: BuiltValueNullFieldError.checkNotNull(
              expiresOn,
              r'SubmitKycRequest',
              'expiresOn',
            ),
            issuedAt: BuiltValueNullFieldError.checkNotNull(
              issuedAt,
              r'SubmitKycRequest',
              'issuedAt',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'address';
        _address?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SubmitKycRequest',
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
