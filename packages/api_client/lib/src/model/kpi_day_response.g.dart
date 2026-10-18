// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kpi_day_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$KpiDayResponse extends KpiDayResponse {
  @override
  final Date? day;
  @override
  final bool? provisional;
  @override
  final int? newPrestataires;
  @override
  final int? converted;
  @override
  final int? agentVisitsCompleted;
  @override
  final int? contractsSigned;
  @override
  final int? paidLost;
  @override
  final int? activeListings;
  @override
  final int? prestatairesFree;
  @override
  final int? basicPlusPaid;
  @override
  final int? basicPlusUnpaid;
  @override
  final int? proPaid;
  @override
  final int? proUnpaid;
  @override
  final int? proPlusPaid;
  @override
  final int? proPlusUnpaid;
  @override
  final int? mrr;
  @override
  final DateTime? snapshotTakenAt;

  factory _$KpiDayResponse([void Function(KpiDayResponseBuilder)? updates]) =>
      (KpiDayResponseBuilder()..update(updates))._build();

  _$KpiDayResponse._({
    this.day,
    this.provisional,
    this.newPrestataires,
    this.converted,
    this.agentVisitsCompleted,
    this.contractsSigned,
    this.paidLost,
    this.activeListings,
    this.prestatairesFree,
    this.basicPlusPaid,
    this.basicPlusUnpaid,
    this.proPaid,
    this.proUnpaid,
    this.proPlusPaid,
    this.proPlusUnpaid,
    this.mrr,
    this.snapshotTakenAt,
  }) : super._();
  @override
  KpiDayResponse rebuild(void Function(KpiDayResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KpiDayResponseBuilder toBuilder() => KpiDayResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KpiDayResponse &&
        day == other.day &&
        provisional == other.provisional &&
        newPrestataires == other.newPrestataires &&
        converted == other.converted &&
        agentVisitsCompleted == other.agentVisitsCompleted &&
        contractsSigned == other.contractsSigned &&
        paidLost == other.paidLost &&
        activeListings == other.activeListings &&
        prestatairesFree == other.prestatairesFree &&
        basicPlusPaid == other.basicPlusPaid &&
        basicPlusUnpaid == other.basicPlusUnpaid &&
        proPaid == other.proPaid &&
        proUnpaid == other.proUnpaid &&
        proPlusPaid == other.proPlusPaid &&
        proPlusUnpaid == other.proPlusUnpaid &&
        mrr == other.mrr &&
        snapshotTakenAt == other.snapshotTakenAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, day.hashCode);
    _$hash = $jc(_$hash, provisional.hashCode);
    _$hash = $jc(_$hash, newPrestataires.hashCode);
    _$hash = $jc(_$hash, converted.hashCode);
    _$hash = $jc(_$hash, agentVisitsCompleted.hashCode);
    _$hash = $jc(_$hash, contractsSigned.hashCode);
    _$hash = $jc(_$hash, paidLost.hashCode);
    _$hash = $jc(_$hash, activeListings.hashCode);
    _$hash = $jc(_$hash, prestatairesFree.hashCode);
    _$hash = $jc(_$hash, basicPlusPaid.hashCode);
    _$hash = $jc(_$hash, basicPlusUnpaid.hashCode);
    _$hash = $jc(_$hash, proPaid.hashCode);
    _$hash = $jc(_$hash, proUnpaid.hashCode);
    _$hash = $jc(_$hash, proPlusPaid.hashCode);
    _$hash = $jc(_$hash, proPlusUnpaid.hashCode);
    _$hash = $jc(_$hash, mrr.hashCode);
    _$hash = $jc(_$hash, snapshotTakenAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KpiDayResponse')
          ..add('day', day)
          ..add('provisional', provisional)
          ..add('newPrestataires', newPrestataires)
          ..add('converted', converted)
          ..add('agentVisitsCompleted', agentVisitsCompleted)
          ..add('contractsSigned', contractsSigned)
          ..add('paidLost', paidLost)
          ..add('activeListings', activeListings)
          ..add('prestatairesFree', prestatairesFree)
          ..add('basicPlusPaid', basicPlusPaid)
          ..add('basicPlusUnpaid', basicPlusUnpaid)
          ..add('proPaid', proPaid)
          ..add('proUnpaid', proUnpaid)
          ..add('proPlusPaid', proPlusPaid)
          ..add('proPlusUnpaid', proPlusUnpaid)
          ..add('mrr', mrr)
          ..add('snapshotTakenAt', snapshotTakenAt))
        .toString();
  }
}

class KpiDayResponseBuilder
    implements Builder<KpiDayResponse, KpiDayResponseBuilder> {
  _$KpiDayResponse? _$v;

  Date? _day;
  Date? get day => _$this._day;
  set day(Date? day) => _$this._day = day;

  bool? _provisional;
  bool? get provisional => _$this._provisional;
  set provisional(bool? provisional) => _$this._provisional = provisional;

  int? _newPrestataires;
  int? get newPrestataires => _$this._newPrestataires;
  set newPrestataires(int? newPrestataires) =>
      _$this._newPrestataires = newPrestataires;

  int? _converted;
  int? get converted => _$this._converted;
  set converted(int? converted) => _$this._converted = converted;

  int? _agentVisitsCompleted;
  int? get agentVisitsCompleted => _$this._agentVisitsCompleted;
  set agentVisitsCompleted(int? agentVisitsCompleted) =>
      _$this._agentVisitsCompleted = agentVisitsCompleted;

  int? _contractsSigned;
  int? get contractsSigned => _$this._contractsSigned;
  set contractsSigned(int? contractsSigned) =>
      _$this._contractsSigned = contractsSigned;

  int? _paidLost;
  int? get paidLost => _$this._paidLost;
  set paidLost(int? paidLost) => _$this._paidLost = paidLost;

  int? _activeListings;
  int? get activeListings => _$this._activeListings;
  set activeListings(int? activeListings) =>
      _$this._activeListings = activeListings;

  int? _prestatairesFree;
  int? get prestatairesFree => _$this._prestatairesFree;
  set prestatairesFree(int? prestatairesFree) =>
      _$this._prestatairesFree = prestatairesFree;

  int? _basicPlusPaid;
  int? get basicPlusPaid => _$this._basicPlusPaid;
  set basicPlusPaid(int? basicPlusPaid) =>
      _$this._basicPlusPaid = basicPlusPaid;

  int? _basicPlusUnpaid;
  int? get basicPlusUnpaid => _$this._basicPlusUnpaid;
  set basicPlusUnpaid(int? basicPlusUnpaid) =>
      _$this._basicPlusUnpaid = basicPlusUnpaid;

  int? _proPaid;
  int? get proPaid => _$this._proPaid;
  set proPaid(int? proPaid) => _$this._proPaid = proPaid;

  int? _proUnpaid;
  int? get proUnpaid => _$this._proUnpaid;
  set proUnpaid(int? proUnpaid) => _$this._proUnpaid = proUnpaid;

  int? _proPlusPaid;
  int? get proPlusPaid => _$this._proPlusPaid;
  set proPlusPaid(int? proPlusPaid) => _$this._proPlusPaid = proPlusPaid;

  int? _proPlusUnpaid;
  int? get proPlusUnpaid => _$this._proPlusUnpaid;
  set proPlusUnpaid(int? proPlusUnpaid) =>
      _$this._proPlusUnpaid = proPlusUnpaid;

  int? _mrr;
  int? get mrr => _$this._mrr;
  set mrr(int? mrr) => _$this._mrr = mrr;

  DateTime? _snapshotTakenAt;
  DateTime? get snapshotTakenAt => _$this._snapshotTakenAt;
  set snapshotTakenAt(DateTime? snapshotTakenAt) =>
      _$this._snapshotTakenAt = snapshotTakenAt;

  KpiDayResponseBuilder() {
    KpiDayResponse._defaults(this);
  }

  KpiDayResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _day = $v.day;
      _provisional = $v.provisional;
      _newPrestataires = $v.newPrestataires;
      _converted = $v.converted;
      _agentVisitsCompleted = $v.agentVisitsCompleted;
      _contractsSigned = $v.contractsSigned;
      _paidLost = $v.paidLost;
      _activeListings = $v.activeListings;
      _prestatairesFree = $v.prestatairesFree;
      _basicPlusPaid = $v.basicPlusPaid;
      _basicPlusUnpaid = $v.basicPlusUnpaid;
      _proPaid = $v.proPaid;
      _proUnpaid = $v.proUnpaid;
      _proPlusPaid = $v.proPlusPaid;
      _proPlusUnpaid = $v.proPlusUnpaid;
      _mrr = $v.mrr;
      _snapshotTakenAt = $v.snapshotTakenAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KpiDayResponse other) {
    _$v = other as _$KpiDayResponse;
  }

  @override
  void update(void Function(KpiDayResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KpiDayResponse build() => _build();

  _$KpiDayResponse _build() {
    final _$result =
        _$v ??
        _$KpiDayResponse._(
          day: day,
          provisional: provisional,
          newPrestataires: newPrestataires,
          converted: converted,
          agentVisitsCompleted: agentVisitsCompleted,
          contractsSigned: contractsSigned,
          paidLost: paidLost,
          activeListings: activeListings,
          prestatairesFree: prestatairesFree,
          basicPlusPaid: basicPlusPaid,
          basicPlusUnpaid: basicPlusUnpaid,
          proPaid: proPaid,
          proUnpaid: proUnpaid,
          proPlusPaid: proPlusPaid,
          proPlusUnpaid: proPlusUnpaid,
          mrr: mrr,
          snapshotTakenAt: snapshotTakenAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
