// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_section_admin_report_line.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HistorySectionAdminReportLine extends HistorySectionAdminReportLine {
  @override
  final int? total;
  @override
  final BuiltMap<String, int>? byStatus;
  @override
  final BuiltList<AdminReportLine>? recent;

  factory _$HistorySectionAdminReportLine([
    void Function(HistorySectionAdminReportLineBuilder)? updates,
  ]) => (HistorySectionAdminReportLineBuilder()..update(updates))._build();

  _$HistorySectionAdminReportLine._({this.total, this.byStatus, this.recent})
    : super._();
  @override
  HistorySectionAdminReportLine rebuild(
    void Function(HistorySectionAdminReportLineBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HistorySectionAdminReportLineBuilder toBuilder() =>
      HistorySectionAdminReportLineBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HistorySectionAdminReportLine &&
        total == other.total &&
        byStatus == other.byStatus &&
        recent == other.recent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, byStatus.hashCode);
    _$hash = $jc(_$hash, recent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HistorySectionAdminReportLine')
          ..add('total', total)
          ..add('byStatus', byStatus)
          ..add('recent', recent))
        .toString();
  }
}

class HistorySectionAdminReportLineBuilder
    implements
        Builder<
          HistorySectionAdminReportLine,
          HistorySectionAdminReportLineBuilder
        > {
  _$HistorySectionAdminReportLine? _$v;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  MapBuilder<String, int>? _byStatus;
  MapBuilder<String, int> get byStatus =>
      _$this._byStatus ??= MapBuilder<String, int>();
  set byStatus(MapBuilder<String, int>? byStatus) =>
      _$this._byStatus = byStatus;

  ListBuilder<AdminReportLine>? _recent;
  ListBuilder<AdminReportLine> get recent =>
      _$this._recent ??= ListBuilder<AdminReportLine>();
  set recent(ListBuilder<AdminReportLine>? recent) => _$this._recent = recent;

  HistorySectionAdminReportLineBuilder() {
    HistorySectionAdminReportLine._defaults(this);
  }

  HistorySectionAdminReportLineBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _total = $v.total;
      _byStatus = $v.byStatus?.toBuilder();
      _recent = $v.recent?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HistorySectionAdminReportLine other) {
    _$v = other as _$HistorySectionAdminReportLine;
  }

  @override
  void update(void Function(HistorySectionAdminReportLineBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HistorySectionAdminReportLine build() => _build();

  _$HistorySectionAdminReportLine _build() {
    _$HistorySectionAdminReportLine _$result;
    try {
      _$result =
          _$v ??
          _$HistorySectionAdminReportLine._(
            total: total,
            byStatus: _byStatus?.build(),
            recent: _recent?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'byStatus';
        _byStatus?.build();
        _$failedField = 'recent';
        _recent?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HistorySectionAdminReportLine',
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
