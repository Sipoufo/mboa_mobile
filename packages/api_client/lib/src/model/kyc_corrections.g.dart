// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_corrections.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const KycCorrectionsIdDocumentTypeEnum _$kycCorrectionsIdDocumentTypeEnum_CNI =
    const KycCorrectionsIdDocumentTypeEnum._('CNI');
const KycCorrectionsIdDocumentTypeEnum
_$kycCorrectionsIdDocumentTypeEnum_PASSPORT =
    const KycCorrectionsIdDocumentTypeEnum._('PASSPORT');
const KycCorrectionsIdDocumentTypeEnum
_$kycCorrectionsIdDocumentTypeEnum_DRIVING_LICENCE =
    const KycCorrectionsIdDocumentTypeEnum._('DRIVING_LICENCE');
const KycCorrectionsIdDocumentTypeEnum
_$kycCorrectionsIdDocumentTypeEnum_unknownDefaultOpenApi =
    const KycCorrectionsIdDocumentTypeEnum._('unknownDefaultOpenApi');

KycCorrectionsIdDocumentTypeEnum _$kycCorrectionsIdDocumentTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'CNI':
      return _$kycCorrectionsIdDocumentTypeEnum_CNI;
    case 'PASSPORT':
      return _$kycCorrectionsIdDocumentTypeEnum_PASSPORT;
    case 'DRIVING_LICENCE':
      return _$kycCorrectionsIdDocumentTypeEnum_DRIVING_LICENCE;
    case 'unknownDefaultOpenApi':
      return _$kycCorrectionsIdDocumentTypeEnum_unknownDefaultOpenApi;
    default:
      return _$kycCorrectionsIdDocumentTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<KycCorrectionsIdDocumentTypeEnum>
_$kycCorrectionsIdDocumentTypeEnumValues =
    BuiltSet<KycCorrectionsIdDocumentTypeEnum>(
      const <KycCorrectionsIdDocumentTypeEnum>[
        _$kycCorrectionsIdDocumentTypeEnum_CNI,
        _$kycCorrectionsIdDocumentTypeEnum_PASSPORT,
        _$kycCorrectionsIdDocumentTypeEnum_DRIVING_LICENCE,
        _$kycCorrectionsIdDocumentTypeEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<KycCorrectionsIdDocumentTypeEnum>
_$kycCorrectionsIdDocumentTypeEnumSerializer =
    _$KycCorrectionsIdDocumentTypeEnumSerializer();

class _$KycCorrectionsIdDocumentTypeEnumSerializer
    implements PrimitiveSerializer<KycCorrectionsIdDocumentTypeEnum> {
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
  final Iterable<Type> types = const <Type>[KycCorrectionsIdDocumentTypeEnum];
  @override
  final String wireName = 'KycCorrectionsIdDocumentTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    KycCorrectionsIdDocumentTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  KycCorrectionsIdDocumentTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => KycCorrectionsIdDocumentTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$KycCorrections extends KycCorrections {
  @override
  final KycCorrectionsIdDocumentTypeEnum? idDocumentType;
  @override
  final String? idNumber;
  @override
  final Date? issuedOn;
  @override
  final Date? expiresOn;
  @override
  final String? issuedAt;

  factory _$KycCorrections([void Function(KycCorrectionsBuilder)? updates]) =>
      (KycCorrectionsBuilder()..update(updates))._build();

  _$KycCorrections._({
    this.idDocumentType,
    this.idNumber,
    this.issuedOn,
    this.expiresOn,
    this.issuedAt,
  }) : super._();
  @override
  KycCorrections rebuild(void Function(KycCorrectionsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KycCorrectionsBuilder toBuilder() => KycCorrectionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KycCorrections &&
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
    return (newBuiltValueToStringHelper(r'KycCorrections')
          ..add('idDocumentType', idDocumentType)
          ..add('idNumber', idNumber)
          ..add('issuedOn', issuedOn)
          ..add('expiresOn', expiresOn)
          ..add('issuedAt', issuedAt))
        .toString();
  }
}

class KycCorrectionsBuilder
    implements Builder<KycCorrections, KycCorrectionsBuilder> {
  _$KycCorrections? _$v;

  KycCorrectionsIdDocumentTypeEnum? _idDocumentType;
  KycCorrectionsIdDocumentTypeEnum? get idDocumentType =>
      _$this._idDocumentType;
  set idDocumentType(KycCorrectionsIdDocumentTypeEnum? idDocumentType) =>
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

  KycCorrectionsBuilder() {
    KycCorrections._defaults(this);
  }

  KycCorrectionsBuilder get _$this {
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
  void replace(KycCorrections other) {
    _$v = other as _$KycCorrections;
  }

  @override
  void update(void Function(KycCorrectionsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KycCorrections build() => _build();

  _$KycCorrections _build() {
    final _$result =
        _$v ??
        _$KycCorrections._(
          idDocumentType: idDocumentType,
          idNumber: idNumber,
          issuedOn: issuedOn,
          expiresOn: expiresOn,
          issuedAt: issuedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
