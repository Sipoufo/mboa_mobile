// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_webhook_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PaymentWebhookRequestStatusEnum
_$paymentWebhookRequestStatusEnum_PENDING =
    const PaymentWebhookRequestStatusEnum._('PENDING');
const PaymentWebhookRequestStatusEnum
_$paymentWebhookRequestStatusEnum_CONFIRMED =
    const PaymentWebhookRequestStatusEnum._('CONFIRMED');
const PaymentWebhookRequestStatusEnum _$paymentWebhookRequestStatusEnum_FAILED =
    const PaymentWebhookRequestStatusEnum._('FAILED');
const PaymentWebhookRequestStatusEnum
_$paymentWebhookRequestStatusEnum_CANCELLED =
    const PaymentWebhookRequestStatusEnum._('CANCELLED');
const PaymentWebhookRequestStatusEnum
_$paymentWebhookRequestStatusEnum_unknownDefaultOpenApi =
    const PaymentWebhookRequestStatusEnum._('unknownDefaultOpenApi');

PaymentWebhookRequestStatusEnum _$paymentWebhookRequestStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PENDING':
      return _$paymentWebhookRequestStatusEnum_PENDING;
    case 'CONFIRMED':
      return _$paymentWebhookRequestStatusEnum_CONFIRMED;
    case 'FAILED':
      return _$paymentWebhookRequestStatusEnum_FAILED;
    case 'CANCELLED':
      return _$paymentWebhookRequestStatusEnum_CANCELLED;
    case 'unknownDefaultOpenApi':
      return _$paymentWebhookRequestStatusEnum_unknownDefaultOpenApi;
    default:
      return _$paymentWebhookRequestStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PaymentWebhookRequestStatusEnum>
_$paymentWebhookRequestStatusEnumValues =
    BuiltSet<PaymentWebhookRequestStatusEnum>(
      const <PaymentWebhookRequestStatusEnum>[
        _$paymentWebhookRequestStatusEnum_PENDING,
        _$paymentWebhookRequestStatusEnum_CONFIRMED,
        _$paymentWebhookRequestStatusEnum_FAILED,
        _$paymentWebhookRequestStatusEnum_CANCELLED,
        _$paymentWebhookRequestStatusEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<PaymentWebhookRequestStatusEnum>
_$paymentWebhookRequestStatusEnumSerializer =
    _$PaymentWebhookRequestStatusEnumSerializer();

class _$PaymentWebhookRequestStatusEnumSerializer
    implements PrimitiveSerializer<PaymentWebhookRequestStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
    'CONFIRMED': 'CONFIRMED',
    'FAILED': 'FAILED',
    'CANCELLED': 'CANCELLED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
    'CONFIRMED': 'CONFIRMED',
    'FAILED': 'FAILED',
    'CANCELLED': 'CANCELLED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PaymentWebhookRequestStatusEnum];
  @override
  final String wireName = 'PaymentWebhookRequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    PaymentWebhookRequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PaymentWebhookRequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PaymentWebhookRequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PaymentWebhookRequest extends PaymentWebhookRequest {
  @override
  final String providerRef;
  @override
  final PaymentWebhookRequestStatusEnum status;
  @override
  final String signature;

  factory _$PaymentWebhookRequest([
    void Function(PaymentWebhookRequestBuilder)? updates,
  ]) => (PaymentWebhookRequestBuilder()..update(updates))._build();

  _$PaymentWebhookRequest._({
    required this.providerRef,
    required this.status,
    required this.signature,
  }) : super._();
  @override
  PaymentWebhookRequest rebuild(
    void Function(PaymentWebhookRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaymentWebhookRequestBuilder toBuilder() =>
      PaymentWebhookRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentWebhookRequest &&
        providerRef == other.providerRef &&
        status == other.status &&
        signature == other.signature;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, providerRef.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, signature.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaymentWebhookRequest')
          ..add('providerRef', providerRef)
          ..add('status', status)
          ..add('signature', signature))
        .toString();
  }
}

class PaymentWebhookRequestBuilder
    implements Builder<PaymentWebhookRequest, PaymentWebhookRequestBuilder> {
  _$PaymentWebhookRequest? _$v;

  String? _providerRef;
  String? get providerRef => _$this._providerRef;
  set providerRef(String? providerRef) => _$this._providerRef = providerRef;

  PaymentWebhookRequestStatusEnum? _status;
  PaymentWebhookRequestStatusEnum? get status => _$this._status;
  set status(PaymentWebhookRequestStatusEnum? status) =>
      _$this._status = status;

  String? _signature;
  String? get signature => _$this._signature;
  set signature(String? signature) => _$this._signature = signature;

  PaymentWebhookRequestBuilder() {
    PaymentWebhookRequest._defaults(this);
  }

  PaymentWebhookRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _providerRef = $v.providerRef;
      _status = $v.status;
      _signature = $v.signature;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentWebhookRequest other) {
    _$v = other as _$PaymentWebhookRequest;
  }

  @override
  void update(void Function(PaymentWebhookRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentWebhookRequest build() => _build();

  _$PaymentWebhookRequest _build() {
    final _$result =
        _$v ??
        _$PaymentWebhookRequest._(
          providerRef: BuiltValueNullFieldError.checkNotNull(
            providerRef,
            r'PaymentWebhookRequest',
            'providerRef',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'PaymentWebhookRequest',
            'status',
          ),
          signature: BuiltValueNullFieldError.checkNotNull(
            signature,
            r'PaymentWebhookRequest',
            'signature',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
