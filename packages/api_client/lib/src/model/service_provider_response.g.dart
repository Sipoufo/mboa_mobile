// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_provider_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ServiceProviderResponseKindEnum
_$serviceProviderResponseKindEnum_CLEANING =
    const ServiceProviderResponseKindEnum._('CLEANING');
const ServiceProviderResponseKindEnum
_$serviceProviderResponseKindEnum_PLUMBING =
    const ServiceProviderResponseKindEnum._('PLUMBING');
const ServiceProviderResponseKindEnum
_$serviceProviderResponseKindEnum_ELECTRICAL =
    const ServiceProviderResponseKindEnum._('ELECTRICAL');
const ServiceProviderResponseKindEnum _$serviceProviderResponseKindEnum_OTHER =
    const ServiceProviderResponseKindEnum._('OTHER');
const ServiceProviderResponseKindEnum
_$serviceProviderResponseKindEnum_unknownDefaultOpenApi =
    const ServiceProviderResponseKindEnum._('unknownDefaultOpenApi');

ServiceProviderResponseKindEnum _$serviceProviderResponseKindEnumValueOf(
  String name,
) {
  switch (name) {
    case 'CLEANING':
      return _$serviceProviderResponseKindEnum_CLEANING;
    case 'PLUMBING':
      return _$serviceProviderResponseKindEnum_PLUMBING;
    case 'ELECTRICAL':
      return _$serviceProviderResponseKindEnum_ELECTRICAL;
    case 'OTHER':
      return _$serviceProviderResponseKindEnum_OTHER;
    case 'unknownDefaultOpenApi':
      return _$serviceProviderResponseKindEnum_unknownDefaultOpenApi;
    default:
      return _$serviceProviderResponseKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ServiceProviderResponseKindEnum>
_$serviceProviderResponseKindEnumValues =
    BuiltSet<ServiceProviderResponseKindEnum>(
      const <ServiceProviderResponseKindEnum>[
        _$serviceProviderResponseKindEnum_CLEANING,
        _$serviceProviderResponseKindEnum_PLUMBING,
        _$serviceProviderResponseKindEnum_ELECTRICAL,
        _$serviceProviderResponseKindEnum_OTHER,
        _$serviceProviderResponseKindEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<ServiceProviderResponseKindEnum>
_$serviceProviderResponseKindEnumSerializer =
    _$ServiceProviderResponseKindEnumSerializer();

class _$ServiceProviderResponseKindEnumSerializer
    implements PrimitiveSerializer<ServiceProviderResponseKindEnum> {
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
  final Iterable<Type> types = const <Type>[ServiceProviderResponseKindEnum];
  @override
  final String wireName = 'ServiceProviderResponseKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    ServiceProviderResponseKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ServiceProviderResponseKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ServiceProviderResponseKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ServiceProviderResponse extends ServiceProviderResponse {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final ServiceProviderResponseKindEnum? kind;
  @override
  final String? kindLabel;
  @override
  final String? note;
  @override
  final String? linkedAccountId;
  @override
  final bool? archived;
  @override
  final int? totalPaid;
  @override
  final int? paymentCount;
  @override
  final Date? lastPaidOn;
  @override
  final DateTime? createdAt;

  factory _$ServiceProviderResponse([
    void Function(ServiceProviderResponseBuilder)? updates,
  ]) => (ServiceProviderResponseBuilder()..update(updates))._build();

  _$ServiceProviderResponse._({
    this.id,
    this.name,
    this.kind,
    this.kindLabel,
    this.note,
    this.linkedAccountId,
    this.archived,
    this.totalPaid,
    this.paymentCount,
    this.lastPaidOn,
    this.createdAt,
  }) : super._();
  @override
  ServiceProviderResponse rebuild(
    void Function(ServiceProviderResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ServiceProviderResponseBuilder toBuilder() =>
      ServiceProviderResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ServiceProviderResponse &&
        id == other.id &&
        name == other.name &&
        kind == other.kind &&
        kindLabel == other.kindLabel &&
        note == other.note &&
        linkedAccountId == other.linkedAccountId &&
        archived == other.archived &&
        totalPaid == other.totalPaid &&
        paymentCount == other.paymentCount &&
        lastPaidOn == other.lastPaidOn &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, kindLabel.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, linkedAccountId.hashCode);
    _$hash = $jc(_$hash, archived.hashCode);
    _$hash = $jc(_$hash, totalPaid.hashCode);
    _$hash = $jc(_$hash, paymentCount.hashCode);
    _$hash = $jc(_$hash, lastPaidOn.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ServiceProviderResponse')
          ..add('id', id)
          ..add('name', name)
          ..add('kind', kind)
          ..add('kindLabel', kindLabel)
          ..add('note', note)
          ..add('linkedAccountId', linkedAccountId)
          ..add('archived', archived)
          ..add('totalPaid', totalPaid)
          ..add('paymentCount', paymentCount)
          ..add('lastPaidOn', lastPaidOn)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ServiceProviderResponseBuilder
    implements
        Builder<ServiceProviderResponse, ServiceProviderResponseBuilder> {
  _$ServiceProviderResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ServiceProviderResponseKindEnum? _kind;
  ServiceProviderResponseKindEnum? get kind => _$this._kind;
  set kind(ServiceProviderResponseKindEnum? kind) => _$this._kind = kind;

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

  bool? _archived;
  bool? get archived => _$this._archived;
  set archived(bool? archived) => _$this._archived = archived;

  int? _totalPaid;
  int? get totalPaid => _$this._totalPaid;
  set totalPaid(int? totalPaid) => _$this._totalPaid = totalPaid;

  int? _paymentCount;
  int? get paymentCount => _$this._paymentCount;
  set paymentCount(int? paymentCount) => _$this._paymentCount = paymentCount;

  Date? _lastPaidOn;
  Date? get lastPaidOn => _$this._lastPaidOn;
  set lastPaidOn(Date? lastPaidOn) => _$this._lastPaidOn = lastPaidOn;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ServiceProviderResponseBuilder() {
    ServiceProviderResponse._defaults(this);
  }

  ServiceProviderResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _kind = $v.kind;
      _kindLabel = $v.kindLabel;
      _note = $v.note;
      _linkedAccountId = $v.linkedAccountId;
      _archived = $v.archived;
      _totalPaid = $v.totalPaid;
      _paymentCount = $v.paymentCount;
      _lastPaidOn = $v.lastPaidOn;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ServiceProviderResponse other) {
    _$v = other as _$ServiceProviderResponse;
  }

  @override
  void update(void Function(ServiceProviderResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ServiceProviderResponse build() => _build();

  _$ServiceProviderResponse _build() {
    final _$result =
        _$v ??
        _$ServiceProviderResponse._(
          id: id,
          name: name,
          kind: kind,
          kindLabel: kindLabel,
          note: note,
          linkedAccountId: linkedAccountId,
          archived: archived,
          totalPaid: totalPaid,
          paymentCount: paymentCount,
          lastPaidOn: lastPaidOn,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
