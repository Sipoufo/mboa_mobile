// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dispute_dossier.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DisputeDossierRaisedByEnum _$disputeDossierRaisedByEnum_TENANT =
    const DisputeDossierRaisedByEnum._('TENANT');
const DisputeDossierRaisedByEnum _$disputeDossierRaisedByEnum_LANDLORD =
    const DisputeDossierRaisedByEnum._('LANDLORD');
const DisputeDossierRaisedByEnum
_$disputeDossierRaisedByEnum_unknownDefaultOpenApi =
    const DisputeDossierRaisedByEnum._('unknownDefaultOpenApi');

DisputeDossierRaisedByEnum _$disputeDossierRaisedByEnumValueOf(String name) {
  switch (name) {
    case 'TENANT':
      return _$disputeDossierRaisedByEnum_TENANT;
    case 'LANDLORD':
      return _$disputeDossierRaisedByEnum_LANDLORD;
    case 'unknownDefaultOpenApi':
      return _$disputeDossierRaisedByEnum_unknownDefaultOpenApi;
    default:
      return _$disputeDossierRaisedByEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DisputeDossierRaisedByEnum> _$disputeDossierRaisedByEnumValues =
    BuiltSet<DisputeDossierRaisedByEnum>(const <DisputeDossierRaisedByEnum>[
      _$disputeDossierRaisedByEnum_TENANT,
      _$disputeDossierRaisedByEnum_LANDLORD,
      _$disputeDossierRaisedByEnum_unknownDefaultOpenApi,
    ]);

Serializer<DisputeDossierRaisedByEnum> _$disputeDossierRaisedByEnumSerializer =
    _$DisputeDossierRaisedByEnumSerializer();

class _$DisputeDossierRaisedByEnumSerializer
    implements PrimitiveSerializer<DisputeDossierRaisedByEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'TENANT': 'TENANT',
    'LANDLORD': 'LANDLORD',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'TENANT': 'TENANT',
    'LANDLORD': 'LANDLORD',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DisputeDossierRaisedByEnum];
  @override
  final String wireName = 'DisputeDossierRaisedByEnum';

  @override
  Object serialize(
    Serializers serializers,
    DisputeDossierRaisedByEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DisputeDossierRaisedByEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DisputeDossierRaisedByEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DisputeDossier extends DisputeDossier {
  @override
  final SignalementResponse? report;
  @override
  final DisputeDossierRaisedByEnum? raisedBy;
  @override
  final HomeSummary? home;
  @override
  final DeclarationResponse? declaration;
  @override
  final BuiltList<PresignedDownload>? declarationProofs;
  @override
  final EvidenceBatchResponse? evidence;
  @override
  final BuiltList<DeclarationResponse>? declarations;
  @override
  final BuiltList<EvidenceBatchResponse>? evidenceSendings;

  factory _$DisputeDossier([void Function(DisputeDossierBuilder)? updates]) =>
      (DisputeDossierBuilder()..update(updates))._build();

  _$DisputeDossier._({
    this.report,
    this.raisedBy,
    this.home,
    this.declaration,
    this.declarationProofs,
    this.evidence,
    this.declarations,
    this.evidenceSendings,
  }) : super._();
  @override
  DisputeDossier rebuild(void Function(DisputeDossierBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DisputeDossierBuilder toBuilder() => DisputeDossierBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DisputeDossier &&
        report == other.report &&
        raisedBy == other.raisedBy &&
        home == other.home &&
        declaration == other.declaration &&
        declarationProofs == other.declarationProofs &&
        evidence == other.evidence &&
        declarations == other.declarations &&
        evidenceSendings == other.evidenceSendings;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, report.hashCode);
    _$hash = $jc(_$hash, raisedBy.hashCode);
    _$hash = $jc(_$hash, home.hashCode);
    _$hash = $jc(_$hash, declaration.hashCode);
    _$hash = $jc(_$hash, declarationProofs.hashCode);
    _$hash = $jc(_$hash, evidence.hashCode);
    _$hash = $jc(_$hash, declarations.hashCode);
    _$hash = $jc(_$hash, evidenceSendings.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DisputeDossier')
          ..add('report', report)
          ..add('raisedBy', raisedBy)
          ..add('home', home)
          ..add('declaration', declaration)
          ..add('declarationProofs', declarationProofs)
          ..add('evidence', evidence)
          ..add('declarations', declarations)
          ..add('evidenceSendings', evidenceSendings))
        .toString();
  }
}

class DisputeDossierBuilder
    implements Builder<DisputeDossier, DisputeDossierBuilder> {
  _$DisputeDossier? _$v;

  SignalementResponseBuilder? _report;
  SignalementResponseBuilder get report =>
      _$this._report ??= SignalementResponseBuilder();
  set report(SignalementResponseBuilder? report) => _$this._report = report;

  DisputeDossierRaisedByEnum? _raisedBy;
  DisputeDossierRaisedByEnum? get raisedBy => _$this._raisedBy;
  set raisedBy(DisputeDossierRaisedByEnum? raisedBy) =>
      _$this._raisedBy = raisedBy;

  HomeSummaryBuilder? _home;
  HomeSummaryBuilder get home => _$this._home ??= HomeSummaryBuilder();
  set home(HomeSummaryBuilder? home) => _$this._home = home;

  DeclarationResponseBuilder? _declaration;
  DeclarationResponseBuilder get declaration =>
      _$this._declaration ??= DeclarationResponseBuilder();
  set declaration(DeclarationResponseBuilder? declaration) =>
      _$this._declaration = declaration;

  ListBuilder<PresignedDownload>? _declarationProofs;
  ListBuilder<PresignedDownload> get declarationProofs =>
      _$this._declarationProofs ??= ListBuilder<PresignedDownload>();
  set declarationProofs(ListBuilder<PresignedDownload>? declarationProofs) =>
      _$this._declarationProofs = declarationProofs;

  EvidenceBatchResponseBuilder? _evidence;
  EvidenceBatchResponseBuilder get evidence =>
      _$this._evidence ??= EvidenceBatchResponseBuilder();
  set evidence(EvidenceBatchResponseBuilder? evidence) =>
      _$this._evidence = evidence;

  ListBuilder<DeclarationResponse>? _declarations;
  ListBuilder<DeclarationResponse> get declarations =>
      _$this._declarations ??= ListBuilder<DeclarationResponse>();
  set declarations(ListBuilder<DeclarationResponse>? declarations) =>
      _$this._declarations = declarations;

  ListBuilder<EvidenceBatchResponse>? _evidenceSendings;
  ListBuilder<EvidenceBatchResponse> get evidenceSendings =>
      _$this._evidenceSendings ??= ListBuilder<EvidenceBatchResponse>();
  set evidenceSendings(ListBuilder<EvidenceBatchResponse>? evidenceSendings) =>
      _$this._evidenceSendings = evidenceSendings;

  DisputeDossierBuilder() {
    DisputeDossier._defaults(this);
  }

  DisputeDossierBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _report = $v.report?.toBuilder();
      _raisedBy = $v.raisedBy;
      _home = $v.home?.toBuilder();
      _declaration = $v.declaration?.toBuilder();
      _declarationProofs = $v.declarationProofs?.toBuilder();
      _evidence = $v.evidence?.toBuilder();
      _declarations = $v.declarations?.toBuilder();
      _evidenceSendings = $v.evidenceSendings?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DisputeDossier other) {
    _$v = other as _$DisputeDossier;
  }

  @override
  void update(void Function(DisputeDossierBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DisputeDossier build() => _build();

  _$DisputeDossier _build() {
    _$DisputeDossier _$result;
    try {
      _$result =
          _$v ??
          _$DisputeDossier._(
            report: _report?.build(),
            raisedBy: raisedBy,
            home: _home?.build(),
            declaration: _declaration?.build(),
            declarationProofs: _declarationProofs?.build(),
            evidence: _evidence?.build(),
            declarations: _declarations?.build(),
            evidenceSendings: _evidenceSendings?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'report';
        _report?.build();

        _$failedField = 'home';
        _home?.build();
        _$failedField = 'declaration';
        _declaration?.build();
        _$failedField = 'declarationProofs';
        _declarationProofs?.build();
        _$failedField = 'evidence';
        _evidence?.build();
        _$failedField = 'declarations';
        _declarations?.build();
        _$failedField = 'evidenceSendings';
        _evidenceSendings?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DisputeDossier',
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
