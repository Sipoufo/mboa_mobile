// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserSettingsResponseLanguageEnum _$userSettingsResponseLanguageEnum_FR =
    const UserSettingsResponseLanguageEnum._('FR');
const UserSettingsResponseLanguageEnum _$userSettingsResponseLanguageEnum_EN =
    const UserSettingsResponseLanguageEnum._('EN');
const UserSettingsResponseLanguageEnum
_$userSettingsResponseLanguageEnum_unknownDefaultOpenApi =
    const UserSettingsResponseLanguageEnum._('unknownDefaultOpenApi');

UserSettingsResponseLanguageEnum _$userSettingsResponseLanguageEnumValueOf(
  String name,
) {
  switch (name) {
    case 'FR':
      return _$userSettingsResponseLanguageEnum_FR;
    case 'EN':
      return _$userSettingsResponseLanguageEnum_EN;
    case 'unknownDefaultOpenApi':
      return _$userSettingsResponseLanguageEnum_unknownDefaultOpenApi;
    default:
      return _$userSettingsResponseLanguageEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<UserSettingsResponseLanguageEnum>
_$userSettingsResponseLanguageEnumValues =
    BuiltSet<UserSettingsResponseLanguageEnum>(
      const <UserSettingsResponseLanguageEnum>[
        _$userSettingsResponseLanguageEnum_FR,
        _$userSettingsResponseLanguageEnum_EN,
        _$userSettingsResponseLanguageEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<UserSettingsResponseLanguageEnum>
_$userSettingsResponseLanguageEnumSerializer =
    _$UserSettingsResponseLanguageEnumSerializer();

class _$UserSettingsResponseLanguageEnumSerializer
    implements PrimitiveSerializer<UserSettingsResponseLanguageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'FR': 'FR',
    'EN': 'EN',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'FR': 'FR',
    'EN': 'EN',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[UserSettingsResponseLanguageEnum];
  @override
  final String wireName = 'UserSettingsResponseLanguageEnum';

  @override
  Object serialize(
    Serializers serializers,
    UserSettingsResponseLanguageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UserSettingsResponseLanguageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UserSettingsResponseLanguageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UserSettingsResponse extends UserSettingsResponse {
  @override
  final UserSettingsResponseLanguageEnum? language;
  @override
  final bool? searchable;
  @override
  final BuiltList<NotificationSetting>? notifications;

  factory _$UserSettingsResponse([
    void Function(UserSettingsResponseBuilder)? updates,
  ]) => (UserSettingsResponseBuilder()..update(updates))._build();

  _$UserSettingsResponse._({this.language, this.searchable, this.notifications})
    : super._();
  @override
  UserSettingsResponse rebuild(
    void Function(UserSettingsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UserSettingsResponseBuilder toBuilder() =>
      UserSettingsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserSettingsResponse &&
        language == other.language &&
        searchable == other.searchable &&
        notifications == other.notifications;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, language.hashCode);
    _$hash = $jc(_$hash, searchable.hashCode);
    _$hash = $jc(_$hash, notifications.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserSettingsResponse')
          ..add('language', language)
          ..add('searchable', searchable)
          ..add('notifications', notifications))
        .toString();
  }
}

class UserSettingsResponseBuilder
    implements Builder<UserSettingsResponse, UserSettingsResponseBuilder> {
  _$UserSettingsResponse? _$v;

  UserSettingsResponseLanguageEnum? _language;
  UserSettingsResponseLanguageEnum? get language => _$this._language;
  set language(UserSettingsResponseLanguageEnum? language) =>
      _$this._language = language;

  bool? _searchable;
  bool? get searchable => _$this._searchable;
  set searchable(bool? searchable) => _$this._searchable = searchable;

  ListBuilder<NotificationSetting>? _notifications;
  ListBuilder<NotificationSetting> get notifications =>
      _$this._notifications ??= ListBuilder<NotificationSetting>();
  set notifications(ListBuilder<NotificationSetting>? notifications) =>
      _$this._notifications = notifications;

  UserSettingsResponseBuilder() {
    UserSettingsResponse._defaults(this);
  }

  UserSettingsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _language = $v.language;
      _searchable = $v.searchable;
      _notifications = $v.notifications?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserSettingsResponse other) {
    _$v = other as _$UserSettingsResponse;
  }

  @override
  void update(void Function(UserSettingsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserSettingsResponse build() => _build();

  _$UserSettingsResponse _build() {
    _$UserSettingsResponse _$result;
    try {
      _$result =
          _$v ??
          _$UserSettingsResponse._(
            language: language,
            searchable: searchable,
            notifications: _notifications?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'notifications';
        _notifications?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UserSettingsResponse',
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
