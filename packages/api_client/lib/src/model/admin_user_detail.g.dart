// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_detail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminUserDetail extends AdminUserDetail {
  @override
  final AdminUserSummary? account;
  @override
  final DateTime? firstSignInAt;
  @override
  final KycStatusResponse? kyc;
  @override
  final BuiltList<AccountModerationEntry>? moderation;
  @override
  final AccountVisitHistory? visits;
  @override
  final AccountContractHistory? contracts;
  @override
  final AccountReportHistory? reports;
  @override
  final AdminMboaScoreResponse? mboaScore;

  factory _$AdminUserDetail([void Function(AdminUserDetailBuilder)? updates]) =>
      (AdminUserDetailBuilder()..update(updates))._build();

  _$AdminUserDetail._({
    this.account,
    this.firstSignInAt,
    this.kyc,
    this.moderation,
    this.visits,
    this.contracts,
    this.reports,
    this.mboaScore,
  }) : super._();
  @override
  AdminUserDetail rebuild(void Function(AdminUserDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdminUserDetailBuilder toBuilder() => AdminUserDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminUserDetail &&
        account == other.account &&
        firstSignInAt == other.firstSignInAt &&
        kyc == other.kyc &&
        moderation == other.moderation &&
        visits == other.visits &&
        contracts == other.contracts &&
        reports == other.reports &&
        mboaScore == other.mboaScore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, account.hashCode);
    _$hash = $jc(_$hash, firstSignInAt.hashCode);
    _$hash = $jc(_$hash, kyc.hashCode);
    _$hash = $jc(_$hash, moderation.hashCode);
    _$hash = $jc(_$hash, visits.hashCode);
    _$hash = $jc(_$hash, contracts.hashCode);
    _$hash = $jc(_$hash, reports.hashCode);
    _$hash = $jc(_$hash, mboaScore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminUserDetail')
          ..add('account', account)
          ..add('firstSignInAt', firstSignInAt)
          ..add('kyc', kyc)
          ..add('moderation', moderation)
          ..add('visits', visits)
          ..add('contracts', contracts)
          ..add('reports', reports)
          ..add('mboaScore', mboaScore))
        .toString();
  }
}

class AdminUserDetailBuilder
    implements Builder<AdminUserDetail, AdminUserDetailBuilder> {
  _$AdminUserDetail? _$v;

  AdminUserSummaryBuilder? _account;
  AdminUserSummaryBuilder get account =>
      _$this._account ??= AdminUserSummaryBuilder();
  set account(AdminUserSummaryBuilder? account) => _$this._account = account;

  DateTime? _firstSignInAt;
  DateTime? get firstSignInAt => _$this._firstSignInAt;
  set firstSignInAt(DateTime? firstSignInAt) =>
      _$this._firstSignInAt = firstSignInAt;

  KycStatusResponseBuilder? _kyc;
  KycStatusResponseBuilder get kyc =>
      _$this._kyc ??= KycStatusResponseBuilder();
  set kyc(KycStatusResponseBuilder? kyc) => _$this._kyc = kyc;

  ListBuilder<AccountModerationEntry>? _moderation;
  ListBuilder<AccountModerationEntry> get moderation =>
      _$this._moderation ??= ListBuilder<AccountModerationEntry>();
  set moderation(ListBuilder<AccountModerationEntry>? moderation) =>
      _$this._moderation = moderation;

  AccountVisitHistoryBuilder? _visits;
  AccountVisitHistoryBuilder get visits =>
      _$this._visits ??= AccountVisitHistoryBuilder();
  set visits(AccountVisitHistoryBuilder? visits) => _$this._visits = visits;

  AccountContractHistoryBuilder? _contracts;
  AccountContractHistoryBuilder get contracts =>
      _$this._contracts ??= AccountContractHistoryBuilder();
  set contracts(AccountContractHistoryBuilder? contracts) =>
      _$this._contracts = contracts;

  AccountReportHistoryBuilder? _reports;
  AccountReportHistoryBuilder get reports =>
      _$this._reports ??= AccountReportHistoryBuilder();
  set reports(AccountReportHistoryBuilder? reports) =>
      _$this._reports = reports;

  AdminMboaScoreResponseBuilder? _mboaScore;
  AdminMboaScoreResponseBuilder get mboaScore =>
      _$this._mboaScore ??= AdminMboaScoreResponseBuilder();
  set mboaScore(AdminMboaScoreResponseBuilder? mboaScore) =>
      _$this._mboaScore = mboaScore;

  AdminUserDetailBuilder() {
    AdminUserDetail._defaults(this);
  }

  AdminUserDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _account = $v.account?.toBuilder();
      _firstSignInAt = $v.firstSignInAt;
      _kyc = $v.kyc?.toBuilder();
      _moderation = $v.moderation?.toBuilder();
      _visits = $v.visits?.toBuilder();
      _contracts = $v.contracts?.toBuilder();
      _reports = $v.reports?.toBuilder();
      _mboaScore = $v.mboaScore?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminUserDetail other) {
    _$v = other as _$AdminUserDetail;
  }

  @override
  void update(void Function(AdminUserDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminUserDetail build() => _build();

  _$AdminUserDetail _build() {
    _$AdminUserDetail _$result;
    try {
      _$result =
          _$v ??
          _$AdminUserDetail._(
            account: _account?.build(),
            firstSignInAt: firstSignInAt,
            kyc: _kyc?.build(),
            moderation: _moderation?.build(),
            visits: _visits?.build(),
            contracts: _contracts?.build(),
            reports: _reports?.build(),
            mboaScore: _mboaScore?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'account';
        _account?.build();

        _$failedField = 'kyc';
        _kyc?.build();
        _$failedField = 'moderation';
        _moderation?.build();
        _$failedField = 'visits';
        _visits?.build();
        _$failedField = 'contracts';
        _contracts?.build();
        _$failedField = 'reports';
        _reports?.build();
        _$failedField = 'mboaScore';
        _mboaScore?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminUserDetail',
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
