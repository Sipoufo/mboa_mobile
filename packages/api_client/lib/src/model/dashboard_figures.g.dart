// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_figures.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashboardFigures extends DashboardFigures {
  @override
  final DashboardMetric? views;
  @override
  final DashboardMetric? viewsLast7Days;
  @override
  final DashboardMetric? contacts;
  @override
  final DashboardMetric? conversionRate;
  @override
  final DashboardMetric? agentVisits;
  @override
  final DashboardMetric? signedContracts;

  factory _$DashboardFigures([
    void Function(DashboardFiguresBuilder)? updates,
  ]) => (DashboardFiguresBuilder()..update(updates))._build();

  _$DashboardFigures._({
    this.views,
    this.viewsLast7Days,
    this.contacts,
    this.conversionRate,
    this.agentVisits,
    this.signedContracts,
  }) : super._();
  @override
  DashboardFigures rebuild(void Function(DashboardFiguresBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardFiguresBuilder toBuilder() =>
      DashboardFiguresBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardFigures &&
        views == other.views &&
        viewsLast7Days == other.viewsLast7Days &&
        contacts == other.contacts &&
        conversionRate == other.conversionRate &&
        agentVisits == other.agentVisits &&
        signedContracts == other.signedContracts;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, views.hashCode);
    _$hash = $jc(_$hash, viewsLast7Days.hashCode);
    _$hash = $jc(_$hash, contacts.hashCode);
    _$hash = $jc(_$hash, conversionRate.hashCode);
    _$hash = $jc(_$hash, agentVisits.hashCode);
    _$hash = $jc(_$hash, signedContracts.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardFigures')
          ..add('views', views)
          ..add('viewsLast7Days', viewsLast7Days)
          ..add('contacts', contacts)
          ..add('conversionRate', conversionRate)
          ..add('agentVisits', agentVisits)
          ..add('signedContracts', signedContracts))
        .toString();
  }
}

class DashboardFiguresBuilder
    implements Builder<DashboardFigures, DashboardFiguresBuilder> {
  _$DashboardFigures? _$v;

  DashboardMetricBuilder? _views;
  DashboardMetricBuilder get views =>
      _$this._views ??= DashboardMetricBuilder();
  set views(DashboardMetricBuilder? views) => _$this._views = views;

  DashboardMetricBuilder? _viewsLast7Days;
  DashboardMetricBuilder get viewsLast7Days =>
      _$this._viewsLast7Days ??= DashboardMetricBuilder();
  set viewsLast7Days(DashboardMetricBuilder? viewsLast7Days) =>
      _$this._viewsLast7Days = viewsLast7Days;

  DashboardMetricBuilder? _contacts;
  DashboardMetricBuilder get contacts =>
      _$this._contacts ??= DashboardMetricBuilder();
  set contacts(DashboardMetricBuilder? contacts) => _$this._contacts = contacts;

  DashboardMetricBuilder? _conversionRate;
  DashboardMetricBuilder get conversionRate =>
      _$this._conversionRate ??= DashboardMetricBuilder();
  set conversionRate(DashboardMetricBuilder? conversionRate) =>
      _$this._conversionRate = conversionRate;

  DashboardMetricBuilder? _agentVisits;
  DashboardMetricBuilder get agentVisits =>
      _$this._agentVisits ??= DashboardMetricBuilder();
  set agentVisits(DashboardMetricBuilder? agentVisits) =>
      _$this._agentVisits = agentVisits;

  DashboardMetricBuilder? _signedContracts;
  DashboardMetricBuilder get signedContracts =>
      _$this._signedContracts ??= DashboardMetricBuilder();
  set signedContracts(DashboardMetricBuilder? signedContracts) =>
      _$this._signedContracts = signedContracts;

  DashboardFiguresBuilder() {
    DashboardFigures._defaults(this);
  }

  DashboardFiguresBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _views = $v.views?.toBuilder();
      _viewsLast7Days = $v.viewsLast7Days?.toBuilder();
      _contacts = $v.contacts?.toBuilder();
      _conversionRate = $v.conversionRate?.toBuilder();
      _agentVisits = $v.agentVisits?.toBuilder();
      _signedContracts = $v.signedContracts?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardFigures other) {
    _$v = other as _$DashboardFigures;
  }

  @override
  void update(void Function(DashboardFiguresBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardFigures build() => _build();

  _$DashboardFigures _build() {
    _$DashboardFigures _$result;
    try {
      _$result =
          _$v ??
          _$DashboardFigures._(
            views: _views?.build(),
            viewsLast7Days: _viewsLast7Days?.build(),
            contacts: _contacts?.build(),
            conversionRate: _conversionRate?.build(),
            agentVisits: _agentVisits?.build(),
            signedContracts: _signedContracts?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'views';
        _views?.build();
        _$failedField = 'viewsLast7Days';
        _viewsLast7Days?.build();
        _$failedField = 'contacts';
        _contacts?.build();
        _$failedField = 'conversionRate';
        _conversionRate?.build();
        _$failedField = 'agentVisits';
        _agentVisits?.build();
        _$failedField = 'signedContracts';
        _signedContracts?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DashboardFigures',
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
