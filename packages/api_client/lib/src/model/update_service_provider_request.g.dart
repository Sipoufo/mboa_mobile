// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_service_provider_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateServiceProviderRequestKindEnum
_$updateServiceProviderRequestKindEnum_CLEANING =
    const UpdateServiceProviderRequestKindEnum._('CLEANING');
const UpdateServiceProviderRequestKindEnum
_$updateServiceProviderRequestKindEnum_PLUMBING =
    const UpdateServiceProviderRequestKindEnum._('PLUMBING');
const UpdateServiceProviderRequestKindEnum
_$updateServiceProviderRequestKindEnum_ELECTRICAL =
    const UpdateServiceProviderRequestKindEnum._('ELECTRICAL');
const UpdateServiceProviderRequestKindEnum
_$updateServiceProviderRequestKindEnum_OTHER =
    const UpdateServiceProviderRequestKindEnum._('OTHER');
const UpdateServiceProviderRequestKindEnum
_$updateServiceProviderRequestKindEnum_unknownDefaultOpenApi =
    const UpdateServiceProviderRequestKindEnum._('unknownDefaultOpenApi');

UpdateServiceProviderRequestKindEnum
_$updateServiceProviderRequestKindEnumValueOf(String name) {
  switch (name) {
    case 'CLEANING':
      return _$updateServiceProviderRequestKindEnum_CLEANING;
    case 'PLUMBING':
      return _$updateServiceProviderRequestKindEnum_PLUMBING;
    case 'ELECTRICAL':
      return _$updateServiceProviderRequestKindEnum_ELECTRICAL;
    case 'OTHER':
      return _$updateServiceProviderRequestKindEnum_OTHER;
    case 'unknownDefaultOpenApi':
      return _$updateServiceProviderRequestKindEnum_unknownDefaultOpenApi;
    default:
      return _$updateServiceProviderRequestKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<UpdateServiceProviderRequestKindEnum>
_$updateServiceProviderRequestKindEnumValues =
    BuiltSet<UpdateServiceProviderRequestKindEnum>(
      const <UpdateServiceProviderRequestKindEnum>[
        _$updateServiceProviderRequestKindEnum_CLEANING,
        _$updateServiceProviderRequestKindEnum_PLUMBING,
        _$updateServiceProviderRequestKindEnum_ELECTRICAL,
        _$updateServiceProviderRequestKindEnum_OTHER,
        _$updateServiceProviderRequestKindEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<UpdateServiceProviderRequestKindEnum>
_$updateServiceProviderRequestKindEnumSerializer =
    _$UpdateServiceProviderRequestKindEnumSerializer();

class _$UpdateServiceProviderRequestKindEnumSerializer
    implements PrimitiveSerializer<UpdateServiceProviderRequestKindEnum> {
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
  final Iterable<Type> types = const <Type>[
    UpdateServiceProviderRequestKindEnum,
  ];
  @override
  final String wireName = 'UpdateServiceProviderRequestKindEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdateServiceProviderRequestKindEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdateServiceProviderRequestKindEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdateServiceProviderRequestKindEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdateServiceProviderRequest extends UpdateServiceProviderRequest {
  @override
  final String? name;
  @override
  final UpdateServiceProviderRequestKindEnum? kind;
  @override
  final String? kindLabel;
  @override
  final String? note;

  factory _$UpdateServiceProviderRequest([
    void Function(UpdateServiceProviderRequestBuilder)? updates,
  ]) => (UpdateServiceProviderRequestBuilder()..update(updates))._build();

  _$UpdateServiceProviderRequest._({
    this.name,
    this.kind,
    this.kindLabel,
    this.note,
  }) : super._();
  @override
  UpdateServiceProviderRequest rebuild(
    void Function(UpdateServiceProviderRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateServiceProviderRequestBuilder toBuilder() =>
      UpdateServiceProviderRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateServiceProviderRequest &&
        name == other.name &&
        kind == other.kind &&
        kindLabel == other.kindLabel &&
        note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, kindLabel.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateServiceProviderRequest')
          ..add('name', name)
          ..add('kind', kind)
          ..add('kindLabel', kindLabel)
          ..add('note', note))
        .toString();
  }
}

class UpdateServiceProviderRequestBuilder
    implements
        Builder<
          UpdateServiceProviderRequest,
          UpdateServiceProviderRequestBuilder
        > {
  _$UpdateServiceProviderRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  UpdateServiceProviderRequestKindEnum? _kind;
  UpdateServiceProviderRequestKindEnum? get kind => _$this._kind;
  set kind(UpdateServiceProviderRequestKindEnum? kind) => _$this._kind = kind;

  String? _kindLabel;
  String? get kindLabel => _$this._kindLabel;
  set kindLabel(String? kindLabel) => _$this._kindLabel = kindLabel;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  UpdateServiceProviderRequestBuilder() {
    UpdateServiceProviderRequest._defaults(this);
  }

  UpdateServiceProviderRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _kind = $v.kind;
      _kindLabel = $v.kindLabel;
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateServiceProviderRequest other) {
    _$v = other as _$UpdateServiceProviderRequest;
  }

  @override
  void update(void Function(UpdateServiceProviderRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateServiceProviderRequest build() => _build();

  _$UpdateServiceProviderRequest _build() {
    final _$result =
        _$v ??
        _$UpdateServiceProviderRequest._(
          name: name,
          kind: kind,
          kindLabel: kindLabel,
          note: note,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
