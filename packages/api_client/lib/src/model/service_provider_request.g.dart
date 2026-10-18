// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_provider_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ServiceProviderRequestKindEnum _$serviceProviderRequestKindEnum_CLEANING =
    const ServiceProviderRequestKindEnum._('CLEANING');
const ServiceProviderRequestKindEnum _$serviceProviderRequestKindEnum_PLUMBING =
    const ServiceProviderRequestKindEnum._('PLUMBING');
const ServiceProviderRequestKindEnum
_$serviceProviderRequestKindEnum_ELECTRICAL =
    const ServiceProviderRequestKindEnum._('ELECTRICAL');
const ServiceProviderRequestKindEnum _$serviceProviderRequestKindEnum_OTHER =
    const ServiceProviderRequestKindEnum._('OTHER');
const ServiceProviderRequestKindEnum
_$serviceProviderRequestKindEnum_unknownDefaultOpenApi =
    const ServiceProviderRequestKindEnum._('unknownDefaultOpenApi');

ServiceProviderRequestKindEnum _$serviceProviderRequestKindEnumValueOf(
  String name,
) {
  switch (name) {
    case 'CLEANING':
      return _$serviceProviderRequestKindEnum_CLEANING;
    case 'PLUMBING':
      return _$serviceProviderRequestKindEnum_PLUMBING;
    case 'ELECTRICAL':
      return _$serviceProviderRequestKindEnum_ELECTRICAL;
    case 'OTHER':
      return _$serviceProviderRequestKindEnum_OTHER;
    case 'unknownDefaultOpenApi':
      return _$serviceProviderRequestKindEnum_unknownDefaultOpenApi;
    default:
      return _$serviceProviderRequestKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ServiceProviderRequestKindEnum>
_$serviceProviderRequestKindEnumValues =
    BuiltSet<ServiceProviderRequestKindEnum>(
      const <ServiceProviderRequestKindEnum>[
        _$serviceProviderRequestKindEnum_CLEANING,
        _$serviceProviderRequestKindEnum_PLUMBING,
        _$serviceProviderRequestKindEnum_ELECTRICAL,
        _$serviceProviderRequestKindEnum_OTHER,
        _$serviceProviderRequestKindEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<ServiceProviderRequestKindEnum>
_$serviceProviderRequestKindEnumSerializer =
    _$ServiceProviderRequestKindEnumSerializer();

class _$ServiceProviderRequestKindEnumSerializer
    implements PrimitiveSerializer<ServiceProviderRequestKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CLEANING': 'CLEANING',
    'PLUMBING': 'PLUMBING',
    'ELECTRICAL': 'ELECTRICAL',
    'OTHER': 'OTHER',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CLEANING': 'CLEANING',
    'PLUMBING': 'PLUMBING',
    'ELECTRICAL': 'ELECTRICAL',
    'OTHER': 'OTHER',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ServiceProviderRequestKindEnum];
  @override
  final String wireName = 'ServiceProviderRequestKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    ServiceProviderRequestKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ServiceProviderRequestKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ServiceProviderRequestKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ServiceProviderRequest extends ServiceProviderRequest {
  @override
  final String? name;
  @override
  final ServiceProviderRequestKindEnum kind;
  @override
  final String? kindLabel;
  @override
  final String? note;
  @override
  final String? linkedAccountId;

  factory _$ServiceProviderRequest([
    void Function(ServiceProviderRequestBuilder)? updates,
  ]) => (ServiceProviderRequestBuilder()..update(updates))._build();

  _$ServiceProviderRequest._({
    this.name,
    required this.kind,
    this.kindLabel,
    this.note,
    this.linkedAccountId,
  }) : super._();
  @override
  ServiceProviderRequest rebuild(
    void Function(ServiceProviderRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ServiceProviderRequestBuilder toBuilder() =>
      ServiceProviderRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ServiceProviderRequest &&
        name == other.name &&
        kind == other.kind &&
        kindLabel == other.kindLabel &&
        note == other.note &&
        linkedAccountId == other.linkedAccountId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, kindLabel.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, linkedAccountId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ServiceProviderRequest')
          ..add('name', name)
          ..add('kind', kind)
          ..add('kindLabel', kindLabel)
          ..add('note', note)
          ..add('linkedAccountId', linkedAccountId))
        .toString();
  }
}

class ServiceProviderRequestBuilder
    implements Builder<ServiceProviderRequest, ServiceProviderRequestBuilder> {
  _$ServiceProviderRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ServiceProviderRequestKindEnum? _kind;
  ServiceProviderRequestKindEnum? get kind => _$this._kind;
  set kind(ServiceProviderRequestKindEnum? kind) => _$this._kind = kind;

  String? _kindLabel;
  String? get kindLabel => _$this._kindLabel;
  set kindLabel(String? kindLabel) => _$this._kindLabel = kindLabel;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  String? _linkedAccountId;
  String? get linkedAccountId => _$this._linkedAccountId;
  set linkedAccountId(String? linkedAccountId) =>
      _$this._linkedAccountId = linkedAccountId;

  ServiceProviderRequestBuilder() {
    ServiceProviderRequest._defaults(this);
  }

  ServiceProviderRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _kind = $v.kind;
      _kindLabel = $v.kindLabel;
      _note = $v.note;
      _linkedAccountId = $v.linkedAccountId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ServiceProviderRequest other) {
    _$v = other as _$ServiceProviderRequest;
  }

  @override
  void update(void Function(ServiceProviderRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ServiceProviderRequest build() => _build();

  _$ServiceProviderRequest _build() {
    final _$result =
        _$v ??
        _$ServiceProviderRequest._(
          name: name,
          kind: BuiltValueNullFieldError.checkNotNull(
            kind,
            r'ServiceProviderRequest',
            'kind',
          ),
          kindLabel: kindLabel,
          note: note,
          linkedAccountId: linkedAccountId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
