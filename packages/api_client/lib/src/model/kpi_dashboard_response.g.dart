// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kpi_dashboard_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$KpiDashboardResponse extends KpiDashboardResponse {
  @override
  final DateTime? asOf;
  @override
  final int? activeListings;
  @override
  final BuiltList<TierCount>? prestatairesByTier;
  @override
  final int? paidPrestataires;
  @override
  final int? mrr;
  @override
  final int? addonSubscribers;
  @override
  final int? addonMrr;
  @override
  final Window? newPrestataires;
  @override
  final Window? agentVisitsCompleted;
  @override
  final Window? contractsSigned;
  @override
  final Conversion? conversion;
  @override
  final Churn? churnThisMonth;
  @override
  final Churn? churnLastMonth;
  @override
  final Targets? targets;

  factory _$KpiDashboardResponse([
    void Function(KpiDashboardResponseBuilder)? updates,
  ]) => (KpiDashboardResponseBuilder()..update(updates))._build();

  _$KpiDashboardResponse._({
    this.asOf,
    this.activeListings,
    this.prestatairesByTier,
    this.paidPrestataires,
    this.mrr,
    this.addonSubscribers,
    this.addonMrr,
    this.newPrestataires,
    this.agentVisitsCompleted,
    this.contractsSigned,
    this.conversion,
    this.churnThisMonth,
    this.churnLastMonth,
    this.targets,
  }) : super._();
  @override
  KpiDashboardResponse rebuild(
    void Function(KpiDashboardResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  KpiDashboardResponseBuilder toBuilder() =>
      KpiDashboardResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KpiDashboardResponse &&
        asOf == other.asOf &&
        activeListings == other.activeListings &&
        prestatairesByTier == other.prestatairesByTier &&
        paidPrestataires == other.paidPrestataires &&
        mrr == other.mrr &&
        addonSubscribers == other.addonSubscribers &&
        addonMrr == other.addonMrr &&
        newPrestataires == other.newPrestataires &&
        agentVisitsCompleted == other.agentVisitsCompleted &&
        contractsSigned == other.contractsSigned &&
        conversion == other.conversion &&
        churnThisMonth == other.churnThisMonth &&
        churnLastMonth == other.churnLastMonth &&
        targets == other.targets;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, asOf.hashCode);
    _$hash = $jc(_$hash, activeListings.hashCode);
    _$hash = $jc(_$hash, prestatairesByTier.hashCode);
    _$hash = $jc(_$hash, paidPrestataires.hashCode);
    _$hash = $jc(_$hash, mrr.hashCode);
    _$hash = $jc(_$hash, addonSubscribers.hashCode);
    _$hash = $jc(_$hash, addonMrr.hashCode);
    _$hash = $jc(_$hash, newPrestataires.hashCode);
    _$hash = $jc(_$hash, agentVisitsCompleted.hashCode);
    _$hash = $jc(_$hash, contractsSigned.hashCode);
    _$hash = $jc(_$hash, conversion.hashCode);
    _$hash = $jc(_$hash, churnThisMonth.hashCode);
    _$hash = $jc(_$hash, churnLastMonth.hashCode);
    _$hash = $jc(_$hash, targets.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KpiDashboardResponse')
          ..add('asOf', asOf)
          ..add('activeListings', activeListings)
          ..add('prestatairesByTier', prestatairesByTier)
          ..add('paidPrestataires', paidPrestataires)
          ..add('mrr', mrr)
          ..add('addonSubscribers', addonSubscribers)
          ..add('addonMrr', addonMrr)
          ..add('newPrestataires', newPrestataires)
          ..add('agentVisitsCompleted', agentVisitsCompleted)
          ..add('contractsSigned', contractsSigned)
          ..add('conversion', conversion)
          ..add('churnThisMonth', churnThisMonth)
          ..add('churnLastMonth', churnLastMonth)
          ..add('targets', targets))
        .toString();
  }
}

class KpiDashboardResponseBuilder
    implements Builder<KpiDashboardResponse, KpiDashboardResponseBuilder> {
  _$KpiDashboardResponse? _$v;

  DateTime? _asOf;
  DateTime? get asOf => _$this._asOf;
  set asOf(DateTime? asOf) => _$this._asOf = asOf;

  int? _activeListings;
  int? get activeListings => _$this._activeListings;
  set activeListings(int? activeListings) =>
      _$this._activeListings = activeListings;

  ListBuilder<TierCount>? _prestatairesByTier;
  ListBuilder<TierCount> get prestatairesByTier =>
      _$this._prestatairesByTier ??= ListBuilder<TierCount>();
  set prestatairesByTier(ListBuilder<TierCount>? prestatairesByTier) =>
      _$this._prestatairesByTier = prestatairesByTier;

  int? _paidPrestataires;
  int? get paidPrestataires => _$this._paidPrestataires;
  set paidPrestataires(int? paidPrestataires) =>
      _$this._paidPrestataires = paidPrestataires;

  int? _mrr;
  int? get mrr => _$this._mrr;
  set mrr(int? mrr) => _$this._mrr = mrr;

  int? _addonSubscribers;
  int? get addonSubscribers => _$this._addonSubscribers;
  set addonSubscribers(int? addonSubscribers) =>
      _$this._addonSubscribers = addonSubscribers;

  int? _addonMrr;
  int? get addonMrr => _$this._addonMrr;
  set addonMrr(int? addonMrr) => _$this._addonMrr = addonMrr;

  WindowBuilder? _newPrestataires;
  WindowBuilder get newPrestataires =>
      _$this._newPrestataires ??= WindowBuilder();
  set newPrestataires(WindowBuilder? newPrestataires) =>
      _$this._newPrestataires = newPrestataires;

  WindowBuilder? _agentVisitsCompleted;
  WindowBuilder get agentVisitsCompleted =>
      _$this._agentVisitsCompleted ??= WindowBuilder();
  set agentVisitsCompleted(WindowBuilder? agentVisitsCompleted) =>
      _$this._agentVisitsCompleted = agentVisitsCompleted;

  WindowBuilder? _contractsSigned;
  WindowBuilder get contractsSigned =>
      _$this._contractsSigned ??= WindowBuilder();
  set contractsSigned(WindowBuilder? contractsSigned) =>
      _$this._contractsSigned = contractsSigned;

  ConversionBuilder? _conversion;
  ConversionBuilder get conversion =>
      _$this._conversion ??= ConversionBuilder();
  set conversion(ConversionBuilder? conversion) =>
      _$this._conversion = conversion;

  ChurnBuilder? _churnThisMonth;
  ChurnBuilder get churnThisMonth => _$this._churnThisMonth ??= ChurnBuilder();
  set churnThisMonth(ChurnBuilder? churnThisMonth) =>
      _$this._churnThisMonth = churnThisMonth;

  ChurnBuilder? _churnLastMonth;
  ChurnBuilder get churnLastMonth => _$this._churnLastMonth ??= ChurnBuilder();
  set churnLastMonth(ChurnBuilder? churnLastMonth) =>
      _$this._churnLastMonth = churnLastMonth;

  TargetsBuilder? _targets;
  TargetsBuilder get targets => _$this._targets ??= TargetsBuilder();
  set targets(TargetsBuilder? targets) => _$this._targets = targets;

  KpiDashboardResponseBuilder() {
    KpiDashboardResponse._defaults(this);
  }

  KpiDashboardResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _asOf = $v.asOf;
      _activeListings = $v.activeListings;
      _prestatairesByTier = $v.prestatairesByTier?.toBuilder();
      _paidPrestataires = $v.paidPrestataires;
      _mrr = $v.mrr;
      _addonSubscribers = $v.addonSubscribers;
      _addonMrr = $v.addonMrr;
      _newPrestataires = $v.newPrestataires?.toBuilder();
      _agentVisitsCompleted = $v.agentVisitsCompleted?.toBuilder();
      _contractsSigned = $v.contractsSigned?.toBuilder();
      _conversion = $v.conversion?.toBuilder();
      _churnThisMonth = $v.churnThisMonth?.toBuilder();
      _churnLastMonth = $v.churnLastMonth?.toBuilder();
      _targets = $v.targets?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KpiDashboardResponse other) {
    _$v = other as _$KpiDashboardResponse;
  }

  @override
  void update(void Function(KpiDashboardResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KpiDashboardResponse build() => _build();

  _$KpiDashboardResponse _build() {
    _$KpiDashboardResponse _$result;
    try {
      _$result =
          _$v ??
          _$KpiDashboardResponse._(
            asOf: asOf,
            activeListings: activeListings,
            prestatairesByTier: _prestatairesByTier?.build(),
            paidPrestataires: paidPrestataires,
            mrr: mrr,
            addonSubscribers: addonSubscribers,
            addonMrr: addonMrr,
            newPrestataires: _newPrestataires?.build(),
            agentVisitsCompleted: _agentVisitsCompleted?.build(),
            contractsSigned: _contractsSigned?.build(),
            conversion: _conversion?.build(),
            churnThisMonth: _churnThisMonth?.build(),
            churnLastMonth: _churnLastMonth?.build(),
            targets: _targets?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'prestatairesByTier';
        _prestatairesByTier?.build();

        _$failedField = 'newPrestataires';
        _newPrestataires?.build();
        _$failedField = 'agentVisitsCompleted';
        _agentVisitsCompleted?.build();
        _$failedField = 'contractsSigned';
        _contractsSigned?.build();
        _$failedField = 'conversion';
        _conversion?.build();
        _$failedField = 'churnThisMonth';
        _churnThisMonth?.build();
        _$failedField = 'churnLastMonth';
        _churnLastMonth?.build();
        _$failedField = 'targets';
        _targets?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'KpiDashboardResponse',
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
