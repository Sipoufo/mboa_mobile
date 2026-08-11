// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_agent_profile_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateAgentProfileRequest extends UpdateAgentProfileRequest {
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? photoObjectKey;
  @override
  final bool? acceptingAssignments;

  factory _$UpdateAgentProfileRequest([
    void Function(UpdateAgentProfileRequestBuilder)? updates,
  ]) => (UpdateAgentProfileRequestBuilder()..update(updates))._build();

  _$UpdateAgentProfileRequest._({
    this.firstName,
    this.lastName,
    this.photoObjectKey,
    this.acceptingAssignments,
  }) : super._();
  @override
  UpdateAgentProfileRequest rebuild(
    void Function(UpdateAgentProfileRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateAgentProfileRequestBuilder toBuilder() =>
      UpdateAgentProfileRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateAgentProfileRequest &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        photoObjectKey == other.photoObjectKey &&
        acceptingAssignments == other.acceptingAssignments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, photoObjectKey.hashCode);
    _$hash = $jc(_$hash, acceptingAssignments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateAgentProfileRequest')
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('photoObjectKey', photoObjectKey)
          ..add('acceptingAssignments', acceptingAssignments))
        .toString();
  }
}

class UpdateAgentProfileRequestBuilder
    implements
        Builder<UpdateAgentProfileRequest, UpdateAgentProfileRequestBuilder> {
  _$UpdateAgentProfileRequest? _$v;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _photoObjectKey;
  String? get photoObjectKey => _$this._photoObjectKey;
  set photoObjectKey(String? photoObjectKey) =>
      _$this._photoObjectKey = photoObjectKey;

  bool? _acceptingAssignments;
  bool? get acceptingAssignments => _$this._acceptingAssignments;
  set acceptingAssignments(bool? acceptingAssignments) =>
      _$this._acceptingAssignments = acceptingAssignments;

  UpdateAgentProfileRequestBuilder() {
    UpdateAgentProfileRequest._defaults(this);
  }

  UpdateAgentProfileRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _photoObjectKey = $v.photoObjectKey;
      _acceptingAssignments = $v.acceptingAssignments;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateAgentProfileRequest other) {
    _$v = other as _$UpdateAgentProfileRequest;
  }

  @override
  void update(void Function(UpdateAgentProfileRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateAgentProfileRequest build() => _build();

  _$UpdateAgentProfileRequest _build() {
    final _$result =
        _$v ??
        _$UpdateAgentProfileRequest._(
          firstName: firstName,
          lastName: lastName,
          photoObjectKey: photoObjectKey,
          acceptingAssignments: acceptingAssignments,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
