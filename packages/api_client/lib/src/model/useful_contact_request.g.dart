// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'useful_contact_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UsefulContactRequest extends UsefulContactRequest {
  @override
  final String name;
  @override
  final String role;
  @override
  final String phone;
  @override
  final String? serviceProviderId;
  @override
  final bool? shared;
  @override
  final BuiltSet<String>? annonceIds;

  factory _$UsefulContactRequest([
    void Function(UsefulContactRequestBuilder)? updates,
  ]) => (UsefulContactRequestBuilder()..update(updates))._build();

  _$UsefulContactRequest._({
    required this.name,
    required this.role,
    required this.phone,
    this.serviceProviderId,
    this.shared,
    this.annonceIds,
  }) : super._();
  @override
  UsefulContactRequest rebuild(
    void Function(UsefulContactRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UsefulContactRequestBuilder toBuilder() =>
      UsefulContactRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UsefulContactRequest &&
        name == other.name &&
        role == other.role &&
        phone == other.phone &&
        serviceProviderId == other.serviceProviderId &&
        shared == other.shared &&
        annonceIds == other.annonceIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, serviceProviderId.hashCode);
    _$hash = $jc(_$hash, shared.hashCode);
    _$hash = $jc(_$hash, annonceIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UsefulContactRequest')
          ..add('name', name)
          ..add('role', role)
          ..add('phone', phone)
          ..add('serviceProviderId', serviceProviderId)
          ..add('shared', shared)
          ..add('annonceIds', annonceIds))
        .toString();
  }
}

class UsefulContactRequestBuilder
    implements Builder<UsefulContactRequest, UsefulContactRequestBuilder> {
  _$UsefulContactRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _serviceProviderId;
  String? get serviceProviderId => _$this._serviceProviderId;
  set serviceProviderId(String? serviceProviderId) =>
      _$this._serviceProviderId = serviceProviderId;

  bool? _shared;
  bool? get shared => _$this._shared;
  set shared(bool? shared) => _$this._shared = shared;

  SetBuilder<String>? _annonceIds;
  SetBuilder<String> get annonceIds =>
      _$this._annonceIds ??= SetBuilder<String>();
  set annonceIds(SetBuilder<String>? annonceIds) =>
      _$this._annonceIds = annonceIds;

  UsefulContactRequestBuilder() {
    UsefulContactRequest._defaults(this);
  }

  UsefulContactRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _role = $v.role;
      _phone = $v.phone;
      _serviceProviderId = $v.serviceProviderId;
      _shared = $v.shared;
      _annonceIds = $v.annonceIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UsefulContactRequest other) {
    _$v = other as _$UsefulContactRequest;
  }

  @override
  void update(void Function(UsefulContactRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UsefulContactRequest build() => _build();

  _$UsefulContactRequest _build() {
    _$UsefulContactRequest _$result;
    try {
      _$result =
          _$v ??
          _$UsefulContactRequest._(
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'UsefulContactRequest',
              'name',
            ),
            role: BuiltValueNullFieldError.checkNotNull(
              role,
              r'UsefulContactRequest',
              'role',
            ),
            phone: BuiltValueNullFieldError.checkNotNull(
              phone,
              r'UsefulContactRequest',
              'phone',
            ),
            serviceProviderId: serviceProviderId,
            shared: shared,
            annonceIds: _annonceIds?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'annonceIds';
        _annonceIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UsefulContactRequest',
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
