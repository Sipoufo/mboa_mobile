// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_prestataire_badges_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdminPrestataireBadgesResponseBadgesEnum
_$adminPrestataireBadgesResponseBadgesEnum_TRUSTED =
    const AdminPrestataireBadgesResponseBadgesEnum._('TRUSTED');
const AdminPrestataireBadgesResponseBadgesEnum
_$adminPrestataireBadgesResponseBadgesEnum_RECERTIFIED =
    const AdminPrestataireBadgesResponseBadgesEnum._('RECERTIFIED');
const AdminPrestataireBadgesResponseBadgesEnum
_$adminPrestataireBadgesResponseBadgesEnum_IDENTITY_VERIFIED =
    const AdminPrestataireBadgesResponseBadgesEnum._('IDENTITY_VERIFIED');
const AdminPrestataireBadgesResponseBadgesEnum
_$adminPrestataireBadgesResponseBadgesEnum_PHOTOS_VERIFIED =
    const AdminPrestataireBadgesResponseBadgesEnum._('PHOTOS_VERIFIED');
const AdminPrestataireBadgesResponseBadgesEnum
_$adminPrestataireBadgesResponseBadgesEnum_unknownDefaultOpenApi =
    const AdminPrestataireBadgesResponseBadgesEnum._('unknownDefaultOpenApi');

AdminPrestataireBadgesResponseBadgesEnum
_$adminPrestataireBadgesResponseBadgesEnumValueOf(String name) {
  switch (name) {
    case 'TRUSTED':
      return _$adminPrestataireBadgesResponseBadgesEnum_TRUSTED;
    case 'RECERTIFIED':
      return _$adminPrestataireBadgesResponseBadgesEnum_RECERTIFIED;
    case 'IDENTITY_VERIFIED':
      return _$adminPrestataireBadgesResponseBadgesEnum_IDENTITY_VERIFIED;
    case 'PHOTOS_VERIFIED':
      return _$adminPrestataireBadgesResponseBadgesEnum_PHOTOS_VERIFIED;
    case 'unknownDefaultOpenApi':
      return _$adminPrestataireBadgesResponseBadgesEnum_unknownDefaultOpenApi;
    default:
      return _$adminPrestataireBadgesResponseBadgesEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AdminPrestataireBadgesResponseBadgesEnum>
_$adminPrestataireBadgesResponseBadgesEnumValues =
    BuiltSet<AdminPrestataireBadgesResponseBadgesEnum>(
      const <AdminPrestataireBadgesResponseBadgesEnum>[
        _$adminPrestataireBadgesResponseBadgesEnum_TRUSTED,
        _$adminPrestataireBadgesResponseBadgesEnum_RECERTIFIED,
        _$adminPrestataireBadgesResponseBadgesEnum_IDENTITY_VERIFIED,
        _$adminPrestataireBadgesResponseBadgesEnum_PHOTOS_VERIFIED,
        _$adminPrestataireBadgesResponseBadgesEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<AdminPrestataireBadgesResponseBadgesEnum>
_$adminPrestataireBadgesResponseBadgesEnumSerializer =
    _$AdminPrestataireBadgesResponseBadgesEnumSerializer();

class _$AdminPrestataireBadgesResponseBadgesEnumSerializer
    implements PrimitiveSerializer<AdminPrestataireBadgesResponseBadgesEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'TRUSTED': 'TRUSTED',
    'RECERTIFIED': 'RECERTIFIED',
    'IDENTITY_VERIFIED': 'IDENTITY_VERIFIED',
    'PHOTOS_VERIFIED': 'PHOTOS_VERIFIED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'TRUSTED': 'TRUSTED',
    'RECERTIFIED': 'RECERTIFIED',
    'IDENTITY_VERIFIED': 'IDENTITY_VERIFIED',
    'PHOTOS_VERIFIED': 'PHOTOS_VERIFIED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AdminPrestataireBadgesResponseBadgesEnum,
  ];
  @override
  final String wireName = 'AdminPrestataireBadgesResponseBadgesEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminPrestataireBadgesResponseBadgesEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminPrestataireBadgesResponseBadgesEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminPrestataireBadgesResponseBadgesEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminPrestataireBadgesResponse extends AdminPrestataireBadgesResponse {
  @override
  final String? accountId;
  @override
  final BuiltList<AdminPrestataireBadgesResponseBadgesEnum>? badges;
  @override
  final BuiltList<BadgeAwardResponse>? awards;
  @override
  final BuiltList<PhotoVerificationResponse>? verifications;

  factory _$AdminPrestataireBadgesResponse([
    void Function(AdminPrestataireBadgesResponseBuilder)? updates,
  ]) => (AdminPrestataireBadgesResponseBuilder()..update(updates))._build();

  _$AdminPrestataireBadgesResponse._({
    this.accountId,
    this.badges,
    this.awards,
    this.verifications,
  }) : super._();
  @override
  AdminPrestataireBadgesResponse rebuild(
    void Function(AdminPrestataireBadgesResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminPrestataireBadgesResponseBuilder toBuilder() =>
      AdminPrestataireBadgesResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminPrestataireBadgesResponse &&
        accountId == other.accountId &&
        badges == other.badges &&
        awards == other.awards &&
        verifications == other.verifications;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, badges.hashCode);
    _$hash = $jc(_$hash, awards.hashCode);
    _$hash = $jc(_$hash, verifications.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminPrestataireBadgesResponse')
          ..add('accountId', accountId)
          ..add('badges', badges)
          ..add('awards', awards)
          ..add('verifications', verifications))
        .toString();
  }
}

class AdminPrestataireBadgesResponseBuilder
    implements
        Builder<
          AdminPrestataireBadgesResponse,
          AdminPrestataireBadgesResponseBuilder
        > {
  _$AdminPrestataireBadgesResponse? _$v;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  ListBuilder<AdminPrestataireBadgesResponseBadgesEnum>? _badges;
  ListBuilder<AdminPrestataireBadgesResponseBadgesEnum> get badges =>
      _$this._badges ??=
          ListBuilder<AdminPrestataireBadgesResponseBadgesEnum>();
  set badges(ListBuilder<AdminPrestataireBadgesResponseBadgesEnum>? badges) =>
      _$this._badges = badges;

  ListBuilder<BadgeAwardResponse>? _awards;
  ListBuilder<BadgeAwardResponse> get awards =>
      _$this._awards ??= ListBuilder<BadgeAwardResponse>();
  set awards(ListBuilder<BadgeAwardResponse>? awards) =>
      _$this._awards = awards;

  ListBuilder<PhotoVerificationResponse>? _verifications;
  ListBuilder<PhotoVerificationResponse> get verifications =>
      _$this._verifications ??= ListBuilder<PhotoVerificationResponse>();
  set verifications(ListBuilder<PhotoVerificationResponse>? verifications) =>
      _$this._verifications = verifications;

  AdminPrestataireBadgesResponseBuilder() {
    AdminPrestataireBadgesResponse._defaults(this);
  }

  AdminPrestataireBadgesResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountId = $v.accountId;
      _badges = $v.badges?.toBuilder();
      _awards = $v.awards?.toBuilder();
      _verifications = $v.verifications?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminPrestataireBadgesResponse other) {
    _$v = other as _$AdminPrestataireBadgesResponse;
  }

  @override
  void update(void Function(AdminPrestataireBadgesResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminPrestataireBadgesResponse build() => _build();

  _$AdminPrestataireBadgesResponse _build() {
    _$AdminPrestataireBadgesResponse _$result;
    try {
      _$result =
          _$v ??
          _$AdminPrestataireBadgesResponse._(
            accountId: accountId,
            badges: _badges?.build(),
            awards: _awards?.build(),
            verifications: _verifications?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'badges';
        _badges?.build();
        _$failedField = 'awards';
        _awards?.build();
        _$failedField = 'verifications';
        _verifications?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminPrestataireBadgesResponse',
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
