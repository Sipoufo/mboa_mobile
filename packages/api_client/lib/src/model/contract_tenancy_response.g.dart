// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_tenancy_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ContractTenancyResponseStateEnum
_$contractTenancyResponseStateEnum_UPCOMING =
    const ContractTenancyResponseStateEnum._('UPCOMING');
const ContractTenancyResponseStateEnum
_$contractTenancyResponseStateEnum_RUNNING =
    const ContractTenancyResponseStateEnum._('RUNNING');
const ContractTenancyResponseStateEnum
_$contractTenancyResponseStateEnum_ENDED =
    const ContractTenancyResponseStateEnum._('ENDED');
const ContractTenancyResponseStateEnum
_$contractTenancyResponseStateEnum_unknownDefaultOpenApi =
    const ContractTenancyResponseStateEnum._('unknownDefaultOpenApi');

ContractTenancyResponseStateEnum _$contractTenancyResponseStateEnumValueOf(
  String name,
) {
  switch (name) {
    case 'UPCOMING':
      return _$contractTenancyResponseStateEnum_UPCOMING;
    case 'RUNNING':
      return _$contractTenancyResponseStateEnum_RUNNING;
    case 'ENDED':
      return _$contractTenancyResponseStateEnum_ENDED;
    case 'unknownDefaultOpenApi':
      return _$contractTenancyResponseStateEnum_unknownDefaultOpenApi;
    default:
      return _$contractTenancyResponseStateEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ContractTenancyResponseStateEnum>
_$contractTenancyResponseStateEnumValues =
    BuiltSet<ContractTenancyResponseStateEnum>(
      const <ContractTenancyResponseStateEnum>[
        _$contractTenancyResponseStateEnum_UPCOMING,
        _$contractTenancyResponseStateEnum_RUNNING,
        _$contractTenancyResponseStateEnum_ENDED,
        _$contractTenancyResponseStateEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<ContractTenancyResponseStateEnum>
_$contractTenancyResponseStateEnumSerializer =
    _$ContractTenancyResponseStateEnumSerializer();

class _$ContractTenancyResponseStateEnumSerializer
    implements PrimitiveSerializer<ContractTenancyResponseStateEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'UPCOMING': 'UPCOMING',
    'RUNNING': 'RUNNING',
    'ENDED': 'ENDED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'UPCOMING': 'UPCOMING',
    'RUNNING': 'RUNNING',
    'ENDED': 'ENDED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ContractTenancyResponseStateEnum];
  @override
  final String wireName = 'ContractTenancyResponseStateEnum';

  @override
  Object serialize(
    Serializers serializers,
    ContractTenancyResponseStateEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ContractTenancyResponseStateEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ContractTenancyResponseStateEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ContractTenancyResponse extends ContractTenancyResponse {
  @override
  final ContractTenancyResponseStateEnum? state;
  @override
  final Date? endsOn;
  @override
  final bool? canTerminate;
  @override
  final Date? earliestNoticeDate;
  @override
  final TerminationResponse? termination;

  factory _$ContractTenancyResponse([
    void Function(ContractTenancyResponseBuilder)? updates,
  ]) => (ContractTenancyResponseBuilder()..update(updates))._build();

  _$ContractTenancyResponse._({
    this.state,
    this.endsOn,
    this.canTerminate,
    this.earliestNoticeDate,
    this.termination,
  }) : super._();
  @override
  ContractTenancyResponse rebuild(
    void Function(ContractTenancyResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ContractTenancyResponseBuilder toBuilder() =>
      ContractTenancyResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContractTenancyResponse &&
        state == other.state &&
        endsOn == other.endsOn &&
        canTerminate == other.canTerminate &&
        earliestNoticeDate == other.earliestNoticeDate &&
        termination == other.termination;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, endsOn.hashCode);
    _$hash = $jc(_$hash, canTerminate.hashCode);
    _$hash = $jc(_$hash, earliestNoticeDate.hashCode);
    _$hash = $jc(_$hash, termination.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ContractTenancyResponse')
          ..add('state', state)
          ..add('endsOn', endsOn)
          ..add('canTerminate', canTerminate)
          ..add('earliestNoticeDate', earliestNoticeDate)
          ..add('termination', termination))
        .toString();
  }
}

class ContractTenancyResponseBuilder
    implements
        Builder<ContractTenancyResponse, ContractTenancyResponseBuilder> {
  _$ContractTenancyResponse? _$v;

  ContractTenancyResponseStateEnum? _state;
  ContractTenancyResponseStateEnum? get state => _$this._state;
  set state(ContractTenancyResponseStateEnum? state) => _$this._state = state;

  Date? _endsOn;
  Date? get endsOn => _$this._endsOn;
  set endsOn(Date? endsOn) => _$this._endsOn = endsOn;

  bool? _canTerminate;
  bool? get canTerminate => _$this._canTerminate;
  set canTerminate(bool? canTerminate) => _$this._canTerminate = canTerminate;

  Date? _earliestNoticeDate;
  Date? get earliestNoticeDate => _$this._earliestNoticeDate;
  set earliestNoticeDate(Date? earliestNoticeDate) =>
      _$this._earliestNoticeDate = earliestNoticeDate;

  TerminationResponseBuilder? _termination;
  TerminationResponseBuilder get termination =>
      _$this._termination ??= TerminationResponseBuilder();
  set termination(TerminationResponseBuilder? termination) =>
      _$this._termination = termination;

  ContractTenancyResponseBuilder() {
    ContractTenancyResponse._defaults(this);
  }

  ContractTenancyResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _state = $v.state;
      _endsOn = $v.endsOn;
      _canTerminate = $v.canTerminate;
      _earliestNoticeDate = $v.earliestNoticeDate;
      _termination = $v.termination?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ContractTenancyResponse other) {
    _$v = other as _$ContractTenancyResponse;
  }

  @override
  void update(void Function(ContractTenancyResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ContractTenancyResponse build() => _build();

  _$ContractTenancyResponse _build() {
    _$ContractTenancyResponse _$result;
    try {
      _$result =
          _$v ??
          _$ContractTenancyResponse._(
            state: state,
            endsOn: endsOn,
            canTerminate: canTerminate,
            earliestNoticeDate: earliestNoticeDate,
            termination: _termination?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'termination';
        _termination?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ContractTenancyResponse',
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
