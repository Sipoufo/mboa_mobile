// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_section_admin_visit_line.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HistorySectionAdminVisitLine extends HistorySectionAdminVisitLine {
  @override
  final int? total;
  @override
  final BuiltMap<String, int>? byStatus;
  @override
  final BuiltList<AdminVisitLine>? recent;

  factory _$HistorySectionAdminVisitLine([
    void Function(HistorySectionAdminVisitLineBuilder)? updates,
  ]) => (HistorySectionAdminVisitLineBuilder()..update(updates))._build();

  _$HistorySectionAdminVisitLine._({this.total, this.byStatus, this.recent})
    : super._();
  @override
  HistorySectionAdminVisitLine rebuild(
    void Function(HistorySectionAdminVisitLineBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HistorySectionAdminVisitLineBuilder toBuilder() =>
      HistorySectionAdminVisitLineBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HistorySectionAdminVisitLine &&
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
    return (newBuiltValueToStringHelper(r'HistorySectionAdminVisitLine')
          ..add('total', total)
          ..add('byStatus', byStatus)
          ..add('recent', recent))
        .toString();
  }
}

class HistorySectionAdminVisitLineBuilder
    implements
        Builder<
          HistorySectionAdminVisitLine,
          HistorySectionAdminVisitLineBuilder
        > {
  _$HistorySectionAdminVisitLine? _$v;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  MapBuilder<String, int>? _byStatus;
  MapBuilder<String, int> get byStatus =>
      _$this._byStatus ??= MapBuilder<String, int>();
  set byStatus(MapBuilder<String, int>? byStatus) =>
      _$this._byStatus = byStatus;

  ListBuilder<AdminVisitLine>? _recent;
  ListBuilder<AdminVisitLine> get recent =>
      _$this._recent ??= ListBuilder<AdminVisitLine>();
  set recent(ListBuilder<AdminVisitLine>? recent) => _$this._recent = recent;

  HistorySectionAdminVisitLineBuilder() {
    HistorySectionAdminVisitLine._defaults(this);
  }

  HistorySectionAdminVisitLineBuilder get _$this {
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
  void replace(HistorySectionAdminVisitLine other) {
    _$v = other as _$HistorySectionAdminVisitLine;
  }

  @override
  void update(void Function(HistorySectionAdminVisitLineBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HistorySectionAdminVisitLine build() => _build();

  _$HistorySectionAdminVisitLine _build() {
    _$HistorySectionAdminVisitLine _$result;
    try {
      _$result =
          _$v ??
          _$HistorySectionAdminVisitLine._(
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
          r'HistorySectionAdminVisitLine',
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
