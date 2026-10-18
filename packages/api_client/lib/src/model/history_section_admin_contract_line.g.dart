// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_section_admin_contract_line.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HistorySectionAdminContractLine
    extends HistorySectionAdminContractLine {
  @override
  final int? total;
  @override
  final BuiltMap<String, int>? byStatus;
  @override
  final BuiltList<AdminContractLine>? recent;

  factory _$HistorySectionAdminContractLine([
    void Function(HistorySectionAdminContractLineBuilder)? updates,
  ]) => (HistorySectionAdminContractLineBuilder()..update(updates))._build();

  _$HistorySectionAdminContractLine._({this.total, this.byStatus, this.recent})
    : super._();
  @override
  HistorySectionAdminContractLine rebuild(
    void Function(HistorySectionAdminContractLineBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HistorySectionAdminContractLineBuilder toBuilder() =>
      HistorySectionAdminContractLineBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HistorySectionAdminContractLine &&
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
    return (newBuiltValueToStringHelper(r'HistorySectionAdminContractLine')
          ..add('total', total)
          ..add('byStatus', byStatus)
          ..add('recent', recent))
        .toString();
  }
}

class HistorySectionAdminContractLineBuilder
    implements
        Builder<
          HistorySectionAdminContractLine,
          HistorySectionAdminContractLineBuilder
        > {
  _$HistorySectionAdminContractLine? _$v;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  MapBuilder<String, int>? _byStatus;
  MapBuilder<String, int> get byStatus =>
      _$this._byStatus ??= MapBuilder<String, int>();
  set byStatus(MapBuilder<String, int>? byStatus) =>
      _$this._byStatus = byStatus;

  ListBuilder<AdminContractLine>? _recent;
  ListBuilder<AdminContractLine> get recent =>
      _$this._recent ??= ListBuilder<AdminContractLine>();
  set recent(ListBuilder<AdminContractLine>? recent) => _$this._recent = recent;

  HistorySectionAdminContractLineBuilder() {
    HistorySectionAdminContractLine._defaults(this);
  }

  HistorySectionAdminContractLineBuilder get _$this {
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
  void replace(HistorySectionAdminContractLine other) {
    _$v = other as _$HistorySectionAdminContractLine;
  }

  @override
  void update(void Function(HistorySectionAdminContractLineBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HistorySectionAdminContractLine build() => _build();

  _$HistorySectionAdminContractLine _build() {
    _$HistorySectionAdminContractLine _$result;
    try {
      _$result =
          _$v ??
          _$HistorySectionAdminContractLine._(
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
          r'HistorySectionAdminContractLine',
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
