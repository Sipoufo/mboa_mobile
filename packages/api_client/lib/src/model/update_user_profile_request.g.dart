// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_profile_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateUserProfileRequest extends UpdateUserProfileRequest {
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? searchCityId;
  @override
  final String? photoObjectKey;
  @override
  final String? cniNumber;

  factory _$UpdateUserProfileRequest([
    void Function(UpdateUserProfileRequestBuilder)? updates,
  ]) => (UpdateUserProfileRequestBuilder()..update(updates))._build();

  _$UpdateUserProfileRequest._({
    this.firstName,
    this.lastName,
    this.searchCityId,
    this.photoObjectKey,
    this.cniNumber,
  }) : super._();
  @override
  UpdateUserProfileRequest rebuild(
    void Function(UpdateUserProfileRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateUserProfileRequestBuilder toBuilder() =>
      UpdateUserProfileRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateUserProfileRequest &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        searchCityId == other.searchCityId &&
        photoObjectKey == other.photoObjectKey &&
        cniNumber == other.cniNumber;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, searchCityId.hashCode);
    _$hash = $jc(_$hash, photoObjectKey.hashCode);
    _$hash = $jc(_$hash, cniNumber.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateUserProfileRequest')
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('searchCityId', searchCityId)
          ..add('photoObjectKey', photoObjectKey)
          ..add('cniNumber', cniNumber))
        .toString();
  }
}

class UpdateUserProfileRequestBuilder
    implements
        Builder<UpdateUserProfileRequest, UpdateUserProfileRequestBuilder> {
  _$UpdateUserProfileRequest? _$v;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _searchCityId;
  String? get searchCityId => _$this._searchCityId;
  set searchCityId(String? searchCityId) => _$this._searchCityId = searchCityId;

  String? _photoObjectKey;
  String? get photoObjectKey => _$this._photoObjectKey;
  set photoObjectKey(String? photoObjectKey) =>
      _$this._photoObjectKey = photoObjectKey;

  String? _cniNumber;
  String? get cniNumber => _$this._cniNumber;
  set cniNumber(String? cniNumber) => _$this._cniNumber = cniNumber;

  UpdateUserProfileRequestBuilder() {
    UpdateUserProfileRequest._defaults(this);
  }

  UpdateUserProfileRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _searchCityId = $v.searchCityId;
      _photoObjectKey = $v.photoObjectKey;
      _cniNumber = $v.cniNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateUserProfileRequest other) {
    _$v = other as _$UpdateUserProfileRequest;
  }

  @override
  void update(void Function(UpdateUserProfileRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateUserProfileRequest build() => _build();

  _$UpdateUserProfileRequest _build() {
    final _$result =
        _$v ??
        _$UpdateUserProfileRequest._(
          firstName: firstName,
          lastName: lastName,
          searchCityId: searchCityId,
          photoObjectKey: photoObjectKey,
          cniNumber: cniNumber,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
