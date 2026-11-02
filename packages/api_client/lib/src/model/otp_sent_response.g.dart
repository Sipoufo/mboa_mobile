// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_sent_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OtpSentResponseChannelEnum _$otpSentResponseChannelEnum_WHATSAPP =
    const OtpSentResponseChannelEnum._('WHATSAPP');
const OtpSentResponseChannelEnum _$otpSentResponseChannelEnum_SMS =
    const OtpSentResponseChannelEnum._('SMS');
const OtpSentResponseChannelEnum _$otpSentResponseChannelEnum_EMAIL =
    const OtpSentResponseChannelEnum._('EMAIL');
const OtpSentResponseChannelEnum
_$otpSentResponseChannelEnum_unknownDefaultOpenApi =
    const OtpSentResponseChannelEnum._('unknownDefaultOpenApi');

OtpSentResponseChannelEnum _$otpSentResponseChannelEnumValueOf(String name) {
  switch (name) {
    case 'WHATSAPP':
      return _$otpSentResponseChannelEnum_WHATSAPP;
    case 'SMS':
      return _$otpSentResponseChannelEnum_SMS;
    case 'EMAIL':
      return _$otpSentResponseChannelEnum_EMAIL;
    case 'unknownDefaultOpenApi':
      return _$otpSentResponseChannelEnum_unknownDefaultOpenApi;
    default:
      return _$otpSentResponseChannelEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OtpSentResponseChannelEnum> _$otpSentResponseChannelEnumValues =
    BuiltSet<OtpSentResponseChannelEnum>(const <OtpSentResponseChannelEnum>[
      _$otpSentResponseChannelEnum_WHATSAPP,
      _$otpSentResponseChannelEnum_SMS,
      _$otpSentResponseChannelEnum_EMAIL,
      _$otpSentResponseChannelEnum_unknownDefaultOpenApi,
    ]);

Serializer<OtpSentResponseChannelEnum> _$otpSentResponseChannelEnumSerializer =
    _$OtpSentResponseChannelEnumSerializer();

class _$OtpSentResponseChannelEnumSerializer
    implements PrimitiveSerializer<OtpSentResponseChannelEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'WHATSAPP': 'WHATSAPP',
    'SMS': 'SMS',
    'EMAIL': 'EMAIL',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'WHATSAPP': 'WHATSAPP',
    'SMS': 'SMS',
    'EMAIL': 'EMAIL',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OtpSentResponseChannelEnum];
  @override
  final String wireName = 'OtpSentResponseChannelEnum';

  @override
  Object serialize(
    Serializers serializers,
    OtpSentResponseChannelEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  OtpSentResponseChannelEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => OtpSentResponseChannelEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$OtpSentResponse extends OtpSentResponse {
  @override
  final OtpSentResponseChannelEnum? channel;

  factory _$OtpSentResponse([void Function(OtpSentResponseBuilder)? updates]) =>
      (OtpSentResponseBuilder()..update(updates))._build();

  _$OtpSentResponse._({this.channel}) : super._();
  @override
  OtpSentResponse rebuild(void Function(OtpSentResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OtpSentResponseBuilder toBuilder() => OtpSentResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OtpSentResponse && channel == other.channel;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, channel.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'OtpSentResponse',
    )..add('channel', channel)).toString();
  }
}

class OtpSentResponseBuilder
    implements Builder<OtpSentResponse, OtpSentResponseBuilder> {
  _$OtpSentResponse? _$v;

  OtpSentResponseChannelEnum? _channel;
  OtpSentResponseChannelEnum? get channel => _$this._channel;
  set channel(OtpSentResponseChannelEnum? channel) => _$this._channel = channel;

  OtpSentResponseBuilder() {
    OtpSentResponse._defaults(this);
  }

  OtpSentResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _channel = $v.channel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OtpSentResponse other) {
    _$v = other as _$OtpSentResponse;
  }

  @override
  void update(void Function(OtpSentResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OtpSentResponse build() => _build();

  _$OtpSentResponse _build() {
    final _$result = _$v ?? _$OtpSentResponse._(channel: channel);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
