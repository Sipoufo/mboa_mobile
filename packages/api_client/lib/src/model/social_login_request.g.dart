// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_login_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SocialLoginRequestProviderEnum _$socialLoginRequestProviderEnum_PHONE =
    const SocialLoginRequestProviderEnum._('PHONE');
const SocialLoginRequestProviderEnum _$socialLoginRequestProviderEnum_GOOGLE =
    const SocialLoginRequestProviderEnum._('GOOGLE');
const SocialLoginRequestProviderEnum _$socialLoginRequestProviderEnum_APPLE =
    const SocialLoginRequestProviderEnum._('APPLE');
const SocialLoginRequestProviderEnum
_$socialLoginRequestProviderEnum_unknownDefaultOpenApi =
    const SocialLoginRequestProviderEnum._('unknownDefaultOpenApi');

SocialLoginRequestProviderEnum _$socialLoginRequestProviderEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PHONE':
      return _$socialLoginRequestProviderEnum_PHONE;
    case 'GOOGLE':
      return _$socialLoginRequestProviderEnum_GOOGLE;
    case 'APPLE':
      return _$socialLoginRequestProviderEnum_APPLE;
    case 'unknownDefaultOpenApi':
      return _$socialLoginRequestProviderEnum_unknownDefaultOpenApi;
    default:
      return _$socialLoginRequestProviderEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<SocialLoginRequestProviderEnum>
_$socialLoginRequestProviderEnumValues =
    BuiltSet<SocialLoginRequestProviderEnum>(
      const <SocialLoginRequestProviderEnum>[
        _$socialLoginRequestProviderEnum_PHONE,
        _$socialLoginRequestProviderEnum_GOOGLE,
        _$socialLoginRequestProviderEnum_APPLE,
        _$socialLoginRequestProviderEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<SocialLoginRequestProviderEnum>
_$socialLoginRequestProviderEnumSerializer =
    _$SocialLoginRequestProviderEnumSerializer();

class _$SocialLoginRequestProviderEnumSerializer
    implements PrimitiveSerializer<SocialLoginRequestProviderEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PHONE': 'PHONE',
    'GOOGLE': 'GOOGLE',
    'APPLE': 'APPLE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PHONE': 'PHONE',
    'GOOGLE': 'GOOGLE',
    'APPLE': 'APPLE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[SocialLoginRequestProviderEnum];
  @override
  final String wireName = 'SocialLoginRequestProviderEnum';

  @override
  Object serialize(
    Serializers serializers,
    SocialLoginRequestProviderEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SocialLoginRequestProviderEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SocialLoginRequestProviderEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SocialLoginRequest extends SocialLoginRequest {
  @override
  final SocialLoginRequestProviderEnum provider;
  @override
  final String idToken;

  factory _$SocialLoginRequest([
    void Function(SocialLoginRequestBuilder)? updates,
  ]) => (SocialLoginRequestBuilder()..update(updates))._build();

  _$SocialLoginRequest._({required this.provider, required this.idToken})
    : super._();
  @override
  SocialLoginRequest rebuild(
    void Function(SocialLoginRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SocialLoginRequestBuilder toBuilder() =>
      SocialLoginRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SocialLoginRequest &&
        provider == other.provider &&
        idToken == other.idToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, provider.hashCode);
    _$hash = $jc(_$hash, idToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SocialLoginRequest')
          ..add('provider', provider)
          ..add('idToken', idToken))
        .toString();
  }
}

class SocialLoginRequestBuilder
    implements Builder<SocialLoginRequest, SocialLoginRequestBuilder> {
  _$SocialLoginRequest? _$v;

  SocialLoginRequestProviderEnum? _provider;
  SocialLoginRequestProviderEnum? get provider => _$this._provider;
  set provider(SocialLoginRequestProviderEnum? provider) =>
      _$this._provider = provider;

  String? _idToken;
  String? get idToken => _$this._idToken;
  set idToken(String? idToken) => _$this._idToken = idToken;

  SocialLoginRequestBuilder() {
    SocialLoginRequest._defaults(this);
  }

  SocialLoginRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _provider = $v.provider;
      _idToken = $v.idToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SocialLoginRequest other) {
    _$v = other as _$SocialLoginRequest;
  }

  @override
  void update(void Function(SocialLoginRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SocialLoginRequest build() => _build();

  _$SocialLoginRequest _build() {
    final _$result =
        _$v ??
        _$SocialLoginRequest._(
          provider: BuiltValueNullFieldError.checkNotNull(
            provider,
            r'SocialLoginRequest',
            'provider',
          ),
          idToken: BuiltValueNullFieldError.checkNotNull(
            idToken,
            r'SocialLoginRequest',
            'idToken',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
