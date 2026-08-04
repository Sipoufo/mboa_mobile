// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserProfileResponse extends UserProfileResponse {
  @override
  final String? id;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? searchCityId;
  @override
  final String? searchCity;
  @override
  final String? photoObjectKey;
  @override
  final String? cniNumber;
  @override
  final bool? profileComplete;
  @override
  final DateTime? createdAt;

  factory _$UserProfileResponse([
    void Function(UserProfileResponseBuilder)? updates,
  ]) => (UserProfileResponseBuilder()..update(updates))._build();

  _$UserProfileResponse._({
    this.id,
    this.firstName,
    this.lastName,
    this.searchCityId,
    this.searchCity,
    this.photoObjectKey,
    this.cniNumber,
    this.profileComplete,
    this.createdAt,
  }) : super._();
  @override
  UserProfileResponse rebuild(
    void Function(UserProfileResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UserProfileResponseBuilder toBuilder() =>
      UserProfileResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserProfileResponse &&
        id == other.id &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        searchCityId == other.searchCityId &&
        searchCity == other.searchCity &&
        photoObjectKey == other.photoObjectKey &&
        cniNumber == other.cniNumber &&
        profileComplete == other.profileComplete &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, searchCityId.hashCode);
    _$hash = $jc(_$hash, searchCity.hashCode);
    _$hash = $jc(_$hash, photoObjectKey.hashCode);
    _$hash = $jc(_$hash, cniNumber.hashCode);
    _$hash = $jc(_$hash, profileComplete.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserProfileResponse')
          ..add('id', id)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('searchCityId', searchCityId)
          ..add('searchCity', searchCity)
          ..add('photoObjectKey', photoObjectKey)
          ..add('cniNumber', cniNumber)
          ..add('profileComplete', profileComplete)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class UserProfileResponseBuilder
    implements Builder<UserProfileResponse, UserProfileResponseBuilder> {
  _$UserProfileResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _searchCityId;
  String? get searchCityId => _$this._searchCityId;
  set searchCityId(String? searchCityId) => _$this._searchCityId = searchCityId;

  String? _searchCity;
  String? get searchCity => _$this._searchCity;
  set searchCity(String? searchCity) => _$this._searchCity = searchCity;

  String? _photoObjectKey;
  String? get photoObjectKey => _$this._photoObjectKey;
  set photoObjectKey(String? photoObjectKey) =>
      _$this._photoObjectKey = photoObjectKey;

  String? _cniNumber;
  String? get cniNumber => _$this._cniNumber;
  set cniNumber(String? cniNumber) => _$this._cniNumber = cniNumber;

  bool? _profileComplete;
  bool? get profileComplete => _$this._profileComplete;
  set profileComplete(bool? profileComplete) =>
      _$this._profileComplete = profileComplete;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  UserProfileResponseBuilder() {
    UserProfileResponse._defaults(this);
  }

  UserProfileResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _searchCityId = $v.searchCityId;
      _searchCity = $v.searchCity;
      _photoObjectKey = $v.photoObjectKey;
      _cniNumber = $v.cniNumber;
      _profileComplete = $v.profileComplete;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserProfileResponse other) {
    _$v = other as _$UserProfileResponse;
  }

  @override
  void update(void Function(UserProfileResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserProfileResponse build() => _build();

  _$UserProfileResponse _build() {
    final _$result =
        _$v ??
        _$UserProfileResponse._(
          id: id,
          firstName: firstName,
          lastName: lastName,
          searchCityId: searchCityId,
          searchCity: searchCity,
          photoObjectKey: photoObjectKey,
          cniNumber: cniNumber,
          profileComplete: profileComplete,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
