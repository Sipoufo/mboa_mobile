// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_address_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$KycAddressRequest extends KycAddressRequest {
  @override
  final String districtId;
  @override
  final String? details;

  factory _$KycAddressRequest([
    void Function(KycAddressRequestBuilder)? updates,
  ]) => (KycAddressRequestBuilder()..update(updates))._build();

  _$KycAddressRequest._({required this.districtId, this.details}) : super._();
  @override
  KycAddressRequest rebuild(void Function(KycAddressRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KycAddressRequestBuilder toBuilder() =>
      KycAddressRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KycAddressRequest &&
        districtId == other.districtId &&
        details == other.details;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, districtId.hashCode);
    _$hash = $jc(_$hash, details.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KycAddressRequest')
          ..add('districtId', districtId)
          ..add('details', details))
        .toString();
  }
}

class KycAddressRequestBuilder
    implements Builder<KycAddressRequest, KycAddressRequestBuilder> {
  _$KycAddressRequest? _$v;

  String? _districtId;
  String? get districtId => _$this._districtId;
  set districtId(String? districtId) => _$this._districtId = districtId;

  String? _details;
  String? get details => _$this._details;
  set details(String? details) => _$this._details = details;

  KycAddressRequestBuilder() {
    KycAddressRequest._defaults(this);
  }

  KycAddressRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _districtId = $v.districtId;
      _details = $v.details;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KycAddressRequest other) {
    _$v = other as _$KycAddressRequest;
  }

  @override
  void update(void Function(KycAddressRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KycAddressRequest build() => _build();

  _$KycAddressRequest _build() {
    final _$result =
        _$v ??
        _$KycAddressRequest._(
          districtId: BuiltValueNullFieldError.checkNotNull(
            districtId,
            r'KycAddressRequest',
            'districtId',
          ),
          details: details,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
