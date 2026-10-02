// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_award_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BadgeAwardResponseBadgeEnum _$badgeAwardResponseBadgeEnum_TRUSTED =
    const BadgeAwardResponseBadgeEnum._('TRUSTED');
const BadgeAwardResponseBadgeEnum _$badgeAwardResponseBadgeEnum_RECERTIFIED =
    const BadgeAwardResponseBadgeEnum._('RECERTIFIED');
const BadgeAwardResponseBadgeEnum
_$badgeAwardResponseBadgeEnum_IDENTITY_VERIFIED =
    const BadgeAwardResponseBadgeEnum._('IDENTITY_VERIFIED');
const BadgeAwardResponseBadgeEnum
_$badgeAwardResponseBadgeEnum_PHOTOS_VERIFIED =
    const BadgeAwardResponseBadgeEnum._('PHOTOS_VERIFIED');
const BadgeAwardResponseBadgeEnum
_$badgeAwardResponseBadgeEnum_unknownDefaultOpenApi =
    const BadgeAwardResponseBadgeEnum._('unknownDefaultOpenApi');

BadgeAwardResponseBadgeEnum _$badgeAwardResponseBadgeEnumValueOf(String name) {
  switch (name) {
    case 'TRUSTED':
      return _$badgeAwardResponseBadgeEnum_TRUSTED;
    case 'RECERTIFIED':
      return _$badgeAwardResponseBadgeEnum_RECERTIFIED;
    case 'IDENTITY_VERIFIED':
      return _$badgeAwardResponseBadgeEnum_IDENTITY_VERIFIED;
    case 'PHOTOS_VERIFIED':
      return _$badgeAwardResponseBadgeEnum_PHOTOS_VERIFIED;
    case 'unknownDefaultOpenApi':
      return _$badgeAwardResponseBadgeEnum_unknownDefaultOpenApi;
    default:
      return _$badgeAwardResponseBadgeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BadgeAwardResponseBadgeEnum>
_$badgeAwardResponseBadgeEnumValues =
    BuiltSet<BadgeAwardResponseBadgeEnum>(const <BadgeAwardResponseBadgeEnum>[
      _$badgeAwardResponseBadgeEnum_TRUSTED,
      _$badgeAwardResponseBadgeEnum_RECERTIFIED,
      _$badgeAwardResponseBadgeEnum_IDENTITY_VERIFIED,
      _$badgeAwardResponseBadgeEnum_PHOTOS_VERIFIED,
      _$badgeAwardResponseBadgeEnum_unknownDefaultOpenApi,
    ]);

Serializer<BadgeAwardResponseBadgeEnum>
_$badgeAwardResponseBadgeEnumSerializer =
    _$BadgeAwardResponseBadgeEnumSerializer();

class _$BadgeAwardResponseBadgeEnumSerializer
    implements PrimitiveSerializer<BadgeAwardResponseBadgeEnum> {
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
  final Iterable<Type> types = const <Type>[BadgeAwardResponseBadgeEnum];
  @override
  final String wireName = 'BadgeAwardResponseBadgeEnum';

  @override
  Object serialize(
    Serializers serializers,
    BadgeAwardResponseBadgeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  BadgeAwardResponseBadgeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => BadgeAwardResponseBadgeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$BadgeAwardResponse extends BadgeAwardResponse {
  @override
  final BadgeAwardResponseBadgeEnum? badge;
  @override
  final DateTime? grantedAt;
  @override
  final DateTime? revokedAt;
  @override
  final String? revokedBy;
  @override
  final String? reason;

  factory _$BadgeAwardResponse([
    void Function(BadgeAwardResponseBuilder)? updates,
  ]) => (BadgeAwardResponseBuilder()..update(updates))._build();

  _$BadgeAwardResponse._({
    this.badge,
    this.grantedAt,
    this.revokedAt,
    this.revokedBy,
    this.reason,
  }) : super._();
  @override
  BadgeAwardResponse rebuild(
    void Function(BadgeAwardResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BadgeAwardResponseBuilder toBuilder() =>
      BadgeAwardResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BadgeAwardResponse &&
        badge == other.badge &&
        grantedAt == other.grantedAt &&
        revokedAt == other.revokedAt &&
        revokedBy == other.revokedBy &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, badge.hashCode);
    _$hash = $jc(_$hash, grantedAt.hashCode);
    _$hash = $jc(_$hash, revokedAt.hashCode);
    _$hash = $jc(_$hash, revokedBy.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BadgeAwardResponse')
          ..add('badge', badge)
          ..add('grantedAt', grantedAt)
          ..add('revokedAt', revokedAt)
          ..add('revokedBy', revokedBy)
          ..add('reason', reason))
        .toString();
  }
}

class BadgeAwardResponseBuilder
    implements Builder<BadgeAwardResponse, BadgeAwardResponseBuilder> {
  _$BadgeAwardResponse? _$v;

  BadgeAwardResponseBadgeEnum? _badge;
  BadgeAwardResponseBadgeEnum? get badge => _$this._badge;
  set badge(BadgeAwardResponseBadgeEnum? badge) => _$this._badge = badge;

  DateTime? _grantedAt;
  DateTime? get grantedAt => _$this._grantedAt;
  set grantedAt(DateTime? grantedAt) => _$this._grantedAt = grantedAt;

  DateTime? _revokedAt;
  DateTime? get revokedAt => _$this._revokedAt;
  set revokedAt(DateTime? revokedAt) => _$this._revokedAt = revokedAt;

  String? _revokedBy;
  String? get revokedBy => _$this._revokedBy;
  set revokedBy(String? revokedBy) => _$this._revokedBy = revokedBy;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  BadgeAwardResponseBuilder() {
    BadgeAwardResponse._defaults(this);
  }

  BadgeAwardResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _badge = $v.badge;
      _grantedAt = $v.grantedAt;
      _revokedAt = $v.revokedAt;
      _revokedBy = $v.revokedBy;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BadgeAwardResponse other) {
    _$v = other as _$BadgeAwardResponse;
  }

  @override
  void update(void Function(BadgeAwardResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BadgeAwardResponse build() => _build();

  _$BadgeAwardResponse _build() {
    final _$result =
        _$v ??
        _$BadgeAwardResponse._(
          badge: badge,
          grantedAt: grantedAt,
          revokedAt: revokedAt,
          revokedBy: revokedBy,
          reason: reason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
