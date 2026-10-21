// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'useful_contact_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UsefulContactResponse extends UsefulContactResponse {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? role;
  @override
  final String? phone;
  @override
  final String? serviceProviderId;
  @override
  final bool? shared;
  @override
  final BuiltSet<String>? annonceIds;

  factory _$UsefulContactResponse([
    void Function(UsefulContactResponseBuilder)? updates,
  ]) => (UsefulContactResponseBuilder()..update(updates))._build();

  _$UsefulContactResponse._({
    this.id,
    this.name,
    this.role,
    this.phone,
    this.serviceProviderId,
    this.shared,
    this.annonceIds,
  }) : super._();
  @override
  UsefulContactResponse rebuild(
    void Function(UsefulContactResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UsefulContactResponseBuilder toBuilder() =>
      UsefulContactResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UsefulContactResponse &&
        id == other.id &&
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
    _$hash = $jc(_$hash, id.hashCode);
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
    return (newBuiltValueToStringHelper(r'UsefulContactResponse')
          ..add('id', id)
          ..add('name', name)
          ..add('role', role)
          ..add('phone', phone)
          ..add('serviceProviderId', serviceProviderId)
          ..add('shared', shared)
          ..add('annonceIds', annonceIds))
        .toString();
  }
}

class UsefulContactResponseBuilder
    implements Builder<UsefulContactResponse, UsefulContactResponseBuilder> {
  _$UsefulContactResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

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

  UsefulContactResponseBuilder() {
    UsefulContactResponse._defaults(this);
  }

  UsefulContactResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
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
  void replace(UsefulContactResponse other) {
    _$v = other as _$UsefulContactResponse;
  }

  @override
  void update(void Function(UsefulContactResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UsefulContactResponse build() => _build();

  _$UsefulContactResponse _build() {
    _$UsefulContactResponse _$result;
    try {
      _$result =
          _$v ??
          _$UsefulContactResponse._(
            id: id,
            name: name,
            role: role,
            phone: phone,
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
          r'UsefulContactResponse',
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
