// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_device_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RegisterDeviceRequestPlatformEnum
_$registerDeviceRequestPlatformEnum_ANDROID =
    const RegisterDeviceRequestPlatformEnum._('ANDROID');
const RegisterDeviceRequestPlatformEnum
_$registerDeviceRequestPlatformEnum_IOS =
    const RegisterDeviceRequestPlatformEnum._('IOS');
const RegisterDeviceRequestPlatformEnum
_$registerDeviceRequestPlatformEnum_WEB =
    const RegisterDeviceRequestPlatformEnum._('WEB');
const RegisterDeviceRequestPlatformEnum
_$registerDeviceRequestPlatformEnum_unknownDefaultOpenApi =
    const RegisterDeviceRequestPlatformEnum._('unknownDefaultOpenApi');

RegisterDeviceRequestPlatformEnum _$registerDeviceRequestPlatformEnumValueOf(
  String name,
) {
  switch (name) {
    case 'ANDROID':
      return _$registerDeviceRequestPlatformEnum_ANDROID;
    case 'IOS':
      return _$registerDeviceRequestPlatformEnum_IOS;
    case 'WEB':
      return _$registerDeviceRequestPlatformEnum_WEB;
    case 'unknownDefaultOpenApi':
      return _$registerDeviceRequestPlatformEnum_unknownDefaultOpenApi;
    default:
      return _$registerDeviceRequestPlatformEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RegisterDeviceRequestPlatformEnum>
_$registerDeviceRequestPlatformEnumValues =
    BuiltSet<RegisterDeviceRequestPlatformEnum>(
      const <RegisterDeviceRequestPlatformEnum>[
        _$registerDeviceRequestPlatformEnum_ANDROID,
        _$registerDeviceRequestPlatformEnum_IOS,
        _$registerDeviceRequestPlatformEnum_WEB,
        _$registerDeviceRequestPlatformEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<RegisterDeviceRequestPlatformEnum>
_$registerDeviceRequestPlatformEnumSerializer =
    _$RegisterDeviceRequestPlatformEnumSerializer();

class _$RegisterDeviceRequestPlatformEnumSerializer
    implements PrimitiveSerializer<RegisterDeviceRequestPlatformEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ANDROID': 'ANDROID',
    'IOS': 'IOS',
    'WEB': 'WEB',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ANDROID': 'ANDROID',
    'IOS': 'IOS',
    'WEB': 'WEB',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RegisterDeviceRequestPlatformEnum];
  @override
  final String wireName = 'RegisterDeviceRequestPlatformEnum';

  @override
  Object serialize(
    Serializers serializers,
    RegisterDeviceRequestPlatformEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  RegisterDeviceRequestPlatformEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => RegisterDeviceRequestPlatformEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$RegisterDeviceRequest extends RegisterDeviceRequest {
  @override
  final String token;
  @override
  final RegisterDeviceRequestPlatformEnum platform;

  factory _$RegisterDeviceRequest([
    void Function(RegisterDeviceRequestBuilder)? updates,
  ]) => (RegisterDeviceRequestBuilder()..update(updates))._build();

  _$RegisterDeviceRequest._({required this.token, required this.platform})
    : super._();
  @override
  RegisterDeviceRequest rebuild(
    void Function(RegisterDeviceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  RegisterDeviceRequestBuilder toBuilder() =>
      RegisterDeviceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterDeviceRequest &&
        token == other.token &&
        platform == other.platform;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RegisterDeviceRequest')
          ..add('token', token)
          ..add('platform', platform))
        .toString();
  }
}

class RegisterDeviceRequestBuilder
    implements Builder<RegisterDeviceRequest, RegisterDeviceRequestBuilder> {
  _$RegisterDeviceRequest? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  RegisterDeviceRequestPlatformEnum? _platform;
  RegisterDeviceRequestPlatformEnum? get platform => _$this._platform;
  set platform(RegisterDeviceRequestPlatformEnum? platform) =>
      _$this._platform = platform;

  RegisterDeviceRequestBuilder() {
    RegisterDeviceRequest._defaults(this);
  }

  RegisterDeviceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _platform = $v.platform;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterDeviceRequest other) {
    _$v = other as _$RegisterDeviceRequest;
  }

  @override
  void update(void Function(RegisterDeviceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegisterDeviceRequest build() => _build();

  _$RegisterDeviceRequest _build() {
    final _$result =
        _$v ??
        _$RegisterDeviceRequest._(
          token: BuiltValueNullFieldError.checkNotNull(
            token,
            r'RegisterDeviceRequest',
            'token',
          ),
          platform: BuiltValueNullFieldError.checkNotNull(
            platform,
            r'RegisterDeviceRequest',
            'platform',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
