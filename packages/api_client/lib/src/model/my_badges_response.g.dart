// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_badges_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MyBadgesResponseBadgesEnum _$myBadgesResponseBadgesEnum_TRUSTED =
    const MyBadgesResponseBadgesEnum._('TRUSTED');
const MyBadgesResponseBadgesEnum _$myBadgesResponseBadgesEnum_RECERTIFIED =
    const MyBadgesResponseBadgesEnum._('RECERTIFIED');
const MyBadgesResponseBadgesEnum
_$myBadgesResponseBadgesEnum_IDENTITY_VERIFIED =
    const MyBadgesResponseBadgesEnum._('IDENTITY_VERIFIED');
const MyBadgesResponseBadgesEnum _$myBadgesResponseBadgesEnum_PHOTOS_VERIFIED =
    const MyBadgesResponseBadgesEnum._('PHOTOS_VERIFIED');
const MyBadgesResponseBadgesEnum
_$myBadgesResponseBadgesEnum_unknownDefaultOpenApi =
    const MyBadgesResponseBadgesEnum._('unknownDefaultOpenApi');

MyBadgesResponseBadgesEnum _$myBadgesResponseBadgesEnumValueOf(String name) {
  switch (name) {
    case 'TRUSTED':
      return _$myBadgesResponseBadgesEnum_TRUSTED;
    case 'RECERTIFIED':
      return _$myBadgesResponseBadgesEnum_RECERTIFIED;
    case 'IDENTITY_VERIFIED':
      return _$myBadgesResponseBadgesEnum_IDENTITY_VERIFIED;
    case 'PHOTOS_VERIFIED':
      return _$myBadgesResponseBadgesEnum_PHOTOS_VERIFIED;
    case 'unknownDefaultOpenApi':
      return _$myBadgesResponseBadgesEnum_unknownDefaultOpenApi;
    default:
      return _$myBadgesResponseBadgesEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MyBadgesResponseBadgesEnum> _$myBadgesResponseBadgesEnumValues =
    BuiltSet<MyBadgesResponseBadgesEnum>(const <MyBadgesResponseBadgesEnum>[
      _$myBadgesResponseBadgesEnum_TRUSTED,
      _$myBadgesResponseBadgesEnum_RECERTIFIED,
      _$myBadgesResponseBadgesEnum_IDENTITY_VERIFIED,
      _$myBadgesResponseBadgesEnum_PHOTOS_VERIFIED,
      _$myBadgesResponseBadgesEnum_unknownDefaultOpenApi,
    ]);

Serializer<MyBadgesResponseBadgesEnum> _$myBadgesResponseBadgesEnumSerializer =
    _$MyBadgesResponseBadgesEnumSerializer();

class _$MyBadgesResponseBadgesEnumSerializer
    implements PrimitiveSerializer<MyBadgesResponseBadgesEnum> {
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
  final Iterable<Type> types = const <Type>[MyBadgesResponseBadgesEnum];
  @override
  final String wireName = 'MyBadgesResponseBadgesEnum';

  @override
  Object serialize(
    Serializers serializers,
    MyBadgesResponseBadgesEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  MyBadgesResponseBadgesEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => MyBadgesResponseBadgesEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$MyBadgesResponse extends MyBadgesResponse {
  @override
  final BuiltList<MyBadgesResponseBadgesEnum>? badges;
  @override
  final BuiltList<PhotoVerificationResponse>? verifications;

  factory _$MyBadgesResponse([
    void Function(MyBadgesResponseBuilder)? updates,
  ]) => (MyBadgesResponseBuilder()..update(updates))._build();

  _$MyBadgesResponse._({this.badges, this.verifications}) : super._();
  @override
  MyBadgesResponse rebuild(void Function(MyBadgesResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MyBadgesResponseBuilder toBuilder() =>
      MyBadgesResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyBadgesResponse &&
        badges == other.badges &&
        verifications == other.verifications;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, badges.hashCode);
    _$hash = $jc(_$hash, verifications.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MyBadgesResponse')
          ..add('badges', badges)
          ..add('verifications', verifications))
        .toString();
  }
}

class MyBadgesResponseBuilder
    implements Builder<MyBadgesResponse, MyBadgesResponseBuilder> {
  _$MyBadgesResponse? _$v;

  ListBuilder<MyBadgesResponseBadgesEnum>? _badges;
  ListBuilder<MyBadgesResponseBadgesEnum> get badges =>
      _$this._badges ??= ListBuilder<MyBadgesResponseBadgesEnum>();
  set badges(ListBuilder<MyBadgesResponseBadgesEnum>? badges) =>
      _$this._badges = badges;

  ListBuilder<PhotoVerificationResponse>? _verifications;
  ListBuilder<PhotoVerificationResponse> get verifications =>
      _$this._verifications ??= ListBuilder<PhotoVerificationResponse>();
  set verifications(ListBuilder<PhotoVerificationResponse>? verifications) =>
      _$this._verifications = verifications;

  MyBadgesResponseBuilder() {
    MyBadgesResponse._defaults(this);
  }

  MyBadgesResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _badges = $v.badges?.toBuilder();
      _verifications = $v.verifications?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MyBadgesResponse other) {
    _$v = other as _$MyBadgesResponse;
  }

  @override
  void update(void Function(MyBadgesResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MyBadgesResponse build() => _build();

  _$MyBadgesResponse _build() {
    _$MyBadgesResponse _$result;
    try {
      _$result =
          _$v ??
          _$MyBadgesResponse._(
            badges: _badges?.build(),
            verifications: _verifications?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'badges';
        _badges?.build();
        _$failedField = 'verifications';
        _verifications?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'MyBadgesResponse',
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
